<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\RatingEntity;
use App\Manager\RatingManager;
use App\Response\AverageRatingGetResponse;
use App\Response\RatingCreateResponse;

class RatingService
{
    private $ratingManager;
    private $autoMapping;
    private $servicesService;

    public function __construct(RatingManager $ratingManager, AutoMapping $autoMapping, ServicesService $servicesService)
    {
        $this->ratingManager = $ratingManager;
        $this->autoMapping = $autoMapping;
        $this->servicesService = $servicesService;
    }
  
    public function create($request)
    {  
        // First, we have to check if the rating is for Account
        // If it is, then we have to gain the userID
        
        if ($request->getEntityType() == "A")
        {
            $userID = $this->servicesService->getUserByServiceID($request->getEntityID())['createdBy'];

            $request->setEntityID($userID);
        }

        $ratingManager = $this->ratingManager->create($request);

        return $this->autoMapping->map(RatingEntity::class, RatingCreateResponse::class, $ratingManager);
    }

    // public function update($request)
    // {
    //     $ratingResult = $this->ratingManager->update($request);
     
    //     return $this->autoMapping->map(Rating::class, UpdateRatingResponse::class, $ratingResult);   
    // }

    public function getAvgRating($entityID)
    {
        $result = $this->ratingManager->getAvgRating($entityID);
        
        return $this->autoMapping->map('array', AverageRatingGetResponse::class, $result[0]);
    }

}