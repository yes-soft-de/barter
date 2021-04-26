<?php

namespace App\Repository;

use App\Entity\RatingEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RatingEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RatingEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RatingEntity[]    findAll()
 * @method RatingEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RatingEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RatingEntity::class);
    }

    public function getAvgRating($entityID, $entityType)
    {
        //AVG Rating
        return $this->createQueryBuilder('rating')

            ->select('AVG(rating.rateValue) as avgRating')

            ->andWhere('rating.entityID = :entityID')
            ->setParameter('entityID', $entityID)
            
            ->andWhere('rating.entityType = :entityType')
            ->setParameter('entityType', $entityType)

            ->getQuery()
            ->getOneOrNullResult();
    }

}
