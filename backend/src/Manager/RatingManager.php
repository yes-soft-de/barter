<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\RatingEntity;
use App\Repository\RatingEntityRepository;
use App\Request\RatingCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RatingManager
{
    private $entityManager;
    private $ratingRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface, RatingEntityRepository $ratingEntityRepository, 
    AutoMapping $autoMapping )
    {
        $this->entityManager = $entityManagerInterface;
        $this->ratingRepository = $ratingEntityRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(RatingCreateRequest $request)
    {
        $ratingEntity = $this->autoMapping->map(RatingCreateRequest::class, RatingEntity::class, $request);

        $this->entityManager->persist($ratingEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        
        return $ratingEntity;
    }

    // public function update(UpdateRatingRequest $request)
    // {
    //     $ratingEntity = $this->ratingRepository->find($request->getId());
        
    //     if (!$ratingEntity) {

    //     } else {
    //         $ratingEntity = $this->autoMapping->mapToObject(UpdateRatingRequest::class, Rating::class, $request, $ratingEntity);
    //         $this->entityManager->flush();
    //     }
    //     return $ratingEntity;
    // }

    public function getAvgRating($entityID)
    {
        return $this->ratingRepository->getAvgRating($entityID);
    }

}