<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\CommentEntity;
use App\Manager\CommentManager;
use App\Response\CommentCreateResponse;
use App\Response\CommentsGetResponse;
use App\Response\GetcommentsNumberResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class CommentService
{
    private $commentManager;
    private $autoMapping;
    private $servicesService;
    private $params;

    public function __construct(CommentManager $commentManager, AutoMapping $autoMapping, ServicesService $servicesService, 
    ParameterBagInterface $params)
    {
        $this->commentManager = $commentManager;
        $this->autoMapping = $autoMapping;
        $this->servicesService = $servicesService;

        $this->params = $params->get('upload_base_url').'/';
    }

    public function create($request)
    {
        // first, we have to get the userID of the account

        $userID = $this->servicesService->getUserByServiceID($request->getServiceID())['createdBy'];

        $request->setEntityID($userID);

        // second, we create the comment

        $commentManager = $this->commentManager->create($request);

        $response = $this->autoMapping->map(CommentEntity::class, CommentCreateResponse::class, $commentManager);

        return $response;
    }

    public function delete($request)
    {
        $result = $this->commentManager->delete($request);

        return $this->autoMapping->map(CommentEntity::class, CommentCreateResponse::class, $result);
    }

    public function getAll($serviceID)
    {
        $response = [];

        // first, we have to get the userID of the account

        $userID = $this->servicesService->getUserByServiceID($serviceID)['createdBy'];

        $result = $this->commentManager->getAll($userID);

        foreach ($result as $row) 
        {
            $row['image'] = $this->params . $row['image'];

            $response[] = $this->autoMapping->map('array', CommentsGetResponse::class, $row);
        }

        return $response;
    }

}
