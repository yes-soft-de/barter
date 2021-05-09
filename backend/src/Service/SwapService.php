<?php


namespace App\Service;


use App\AutoMapping;
use App\Service\ServicesService;
use App\Entity\SwapEntity;
use App\Manager\SwapManager;
use App\Request\SwapCreateRequest;
use App\Request\SwapUpdateRequest;
use App\Response\SwapCreateResponse;
use App\Response\SwapsResponse;
use App\Service\UserService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class SwapService
{
    private $autoMapping;
    private $swapManager;
    private $params;
    private $userService;
    private $servicesService;

    public function __construct(AutoMapping $autoMapping, SwapManager $swapManager, ParameterBagInterface $params,
     UserService $userService, ServicesService $servicesService)
    {
        $this->autoMapping = $autoMapping;
        $this->swapManager = $swapManager;
        $this->userService = $userService;
        $this->servicesService = $servicesService;

        $this->params = $params->get('upload_base_url').'/';
    }

    public function swapCreate(SwapCreateRequest $request)
    {
        /* First, we have to get the userID of the service in order 
           to store it the userIdTwo field */
        
        $userID = $this->servicesService->getUserByServiceID($request->getSwapItemsTwo()[0])['createdBy'];
        
        $request->setUserIdTwo($userID);

        // Now, we can continue with the creating request

        $item = $this->swapManager->swapCreate($request);

        // $this->sendNotification($request, 'new');

        return $this->autoMapping->map(SwapEntity::class, SwapCreateResponse::class, $item);
    }

    // public function sendNotification($request, $type)
    // {
    //     if ($type == 'new')
    //     {
    //         $request = $this->autoMapping->map(SwapCreateRequest::class,SendNotificationRequest::class, $request);
    //         $request->setMessage('لقد وصلك طلب مبادلة جديد!');

    //         $this->notificationService->sendMessage($request);
    //     }
    //     elseif ($type == 'update')
    //     {
    //         $request = $this->autoMapping->map(SwapUpdateRequest::class,SendNotificationRequest::class, $request);
    //         $request->setMessage('هناك تحديث في قائمة المبادلة لديك!');

    //         $this->notificationService->sendMessage($request);
    //     }
    // }

    public function getSwaps()
    {
        $itemsResponse = [];

        $items = $this->swapManager->getSwaps();

        foreach ($items as $item)
        {
            //GET INFO
            //get users' info
            $userOne = $this->userService->getUserProfileByUserID($item['userIdOne']);
            $userTwo = $this->userService->getUserProfileByUserID($item['userIdTwo']);
            
            //SET INFO
            //set first user info
            $item['userOneName'] = $userOne->getUserName();
            $item['userOneImage'] = $userOne->getImage();

            //set second user info
            $item['userTwoName'] = $userTwo->getUserName();
            $item['userTwoImage'] = $userTwo->getImage();

            //get and set swap services' titles
            $item['swapItemsOne'] = $this->servicesService->getServicesByIDsArray($item['swapItemsOne']);
            $item['swapItemsTwo'] = $this->servicesService->getServicesByIDsArray($item['swapItemsTwo']);

            $itemsResponse[] = $this->autoMapping->map('array', SwapsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function getSwapByID($id)
    {
        $itemsResponse = [];

        $result = $this->swapManager->getSwapByID($id);

        foreach ($result as $item) 
        {
            // get users info
            $userOne = $this->userService->getUserProfileByUserID($item->getUserIdOne());
            $userTwo = $this->userService->getUserProfileByUserID($item->getUserIdTwo());

            // get and set swapped services titles 
            $item->setSwapItemsOne($this->servicesService->getServicesByIDsArray($item->getSwapItemsOne()));
            $item->setSwapItemsTwo($this->servicesService->getServicesByIDsArray($item->getSwapItemsTwo()));
           
            $itemsResponse[] = $this->autoMapping->map(SwapEntity::class, SwapsResponse::class, $item);

            //set first user info
            $itemsResponse[0]->setUserOneName($userOne->getUserName());
            $itemsResponse[0]->setUserOneImage($userOne->getImage());

            //set second user info
            $itemsResponse[0]->setUserTwoName($userTwo->getUserName());
            $itemsResponse[0]->setUserTwoImage($userTwo->getImage());
        }

        return $itemsResponse;
    }

    public function deleteSwap($id)
    {
        return $this->swapManager->deleteSwap($id);
    }

    public function updateSwap(SwapUpdateRequest $request)
    {
        /* First, we have to get the userID of the service in order 
           to store it the userIdTwo field */
        
        // $userID = $this->servicesService->getUserByServiceID($request->getSwapItemsTwo()[0])['createdBy'];
        
        // $request->setUserIdTwo($userID);
   
        // Now, we can continue with the creating request

        $item = $this->swapManager->updateSwap($request);

        // $this->sendNotification($request, 'update');

        return $this->autoMapping->map(SwapEntity::class, SwapsResponse::class, $item);
    }

    public function getSwapsByUserID($userID)
    {
        $itemsResponse = [];

        $items = $this->swapManager->getSwapsByUserID($userID);

        foreach ($items as $item)
        {
            $item['userOneImage'] = $this->params.$item['userOneImage'];
            $item['userTwoImage'] = $this->params.$item['userTwoImage'];

            $item['swapItemsOne'] = $this->servicesService->getServicesByIDsArray($item['swapItemsOne']);
            $item['swapItemsTwo'] = $this->servicesService->getServicesByIDsArray($item['swapItemsTwo']);

            $itemsResponse[] = $this->autoMapping->map('array', SwapsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function specialLinkCheck($bool)
    {
        if ($bool == false)
        {
            return $this->params;
        }
    }

    public function getSwapByItemAndUserID($userID, $itemID)
    {
        return $this->swapManager->getSwapByItemAndUserID($userID, $itemID);
    }
}