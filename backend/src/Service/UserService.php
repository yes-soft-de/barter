<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Manager\UserManager;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\MembersGetResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class UserService
{
    private $autoMapping;
    private $userManager;
    private $params;
    private $servicesService;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, ParameterBagInterface $params, 
    ServicesService $servicesService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->servicesService = $servicesService;

        $this->params = $params->get('upload_base_url').'/';
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->userManager->userRegister($request);

        if ($userRegister instanceof UserEntity) 
        {
            return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
        }
        elseif ($userRegister == true) 
        {  
            $user = $this->userManager->getUserByUserID($request->getUserID());

            $user['found']="yes";

            return $user;
        }


    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->userManager->userProfileUpdate($request);

        return $this->autoMapping->map(UserProfileEntity::class, UserProfileResponse::class, $item);
    }

    public function getUserProfileByUserID($userID)
    {
        $item = $this->userManager->getProfileByUserID($userID);

        $servicesNumber = $this->servicesService->getCountOfEnabledServicesOfUser($userID)['1'];

        if(isset($item['image']))
        {
            $item['image'] = $this->params . $item['image'];

            $item['servicesNumber'] = $servicesNumber;

            $item['services'] = $this->servicesService->getServicesOfUser($userID);
            
            $item['role'] = $this->userManager->findUserByUserID($userID)->getRoles()[0];
        }

        return $this->autoMapping->map('array', UserProfileResponse::class, $item);

    }

    public function getUserProfileByServiceID($serviceID)
    {
        // First, we will get the userID

        $userID = $this->servicesService->getUserByServiceID($serviceID)['createdBy'];
        
        $item = $this->userManager->getProfileByUserID($userID);

        $servicesNumber = $this->servicesService->getCountOfEnabledServicesOfUser($userID)['1'];
        
        if(isset($item['image']))
        {
            $item['image'] = $this->params . $item['image'];
        }

        $item['servicesNumber'] = $servicesNumber;

        $item['services'] = $this->servicesService->getServicesOfUser($userID);
            
        $item['role'] = $this->userManager->findUserByUserID($userID)->getRoles()[0];

        return $this->autoMapping->map('array', UserProfileResponse::class, $item);

    }

    public function getUsersByRole($role)
    {
        $response = [];

        $results = $this->userManager->getUsersByRole($role);
    
        foreach($results as $result)
        {
            $result['image'] = $this->params . $result['image'];

            $result['servicesNumber'] = $this->servicesService->getCountOfEnabledServicesOfUser($result['userID'])[1];

            $response[] = $this->autoMapping->map('array', MembersGetResponse::class, $result);
        }

        return $response;
    }

    public function deleteUser($userID)
    {
        $userResult = $this->userManager->deleteUser($userID);

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userResult);
    }
}