<?php

namespace App\Repository;

use App\Entity\FavouriteEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method FavouriteEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method FavouriteEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method FavouriteEntity[]    findAll()
 * @method FavouriteEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class FavouriteEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, FavouriteEntity::class);
    }

    public function getFavouriteByCategoryIDAndUserID($categoryID, $userID): ?FavouriteEntity
    {
        return $this->createQueryBuilder('favourite')

            ->andWhere('favourite.userID = :userID')
            ->andWhere('favourite.categoryID = :categoryID')

            ->setParameter('userID', $userID)
            ->setParameter('categoryID', $categoryID)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
