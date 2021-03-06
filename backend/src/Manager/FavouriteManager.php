<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\FavouriteEntity;
use App\Repository\FavouriteEntityRepository;
use App\Request\FavouriteCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class FavouriteManager
{
    private $entityManager;
    private $favouriteEntityRepository;
    private $autoMapping;   

    public function __construct(EntityManagerInterface $entityManagerInterface, FavouriteEntityRepository $favouriteEntityRepository, AutoMapping $autoMapping )
    {
        $this->entityManager = $entityManagerInterface;
        $this->favouriteEntityRepository = $favouriteEntityRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(FavouriteCreateRequest $request)
    {
        $favouriteEntity = $this->autoMapping->map(FavouriteCreateRequest::class, FavouriteEntity::class, $request);

        $this->entityManager->persist($favouriteEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $favouriteEntity;
    }

    public function delete($categoryID, $userID)
    {
        $favourite = $this->favouriteEntityRepository->getFavouriteByCategoryIDAndUserID($categoryID, $userID);

        if(!$favourite)
        {
            return $favourite;
        }
        else
        {
            $this->entityManager->remove($favourite);
            $this->entityManager->flush();
        }

        return $favourite;
    }

}