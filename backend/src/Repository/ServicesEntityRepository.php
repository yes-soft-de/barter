<?php

namespace App\Repository;

use App\Entity\ServicesEntity;
use App\Entity\UserProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ServicesEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ServicesEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ServicesEntity[]    findAll()
 * @method ServicesEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ServicesEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ServicesEntity::class);
    }

    public function getServicesByCategoryID($categoryID)
    {
        return $this->createQueryBuilder('service')
            ->select('service.id', 'service.serviceTitle', 'service.description', 'service.duration', 'service.createdBy', 'service.categoryID',
             'service.activeUntil', 'service.enabled', 'service.tags', 'userProfile.userName', 'userProfile.image as userImage')

            ->leftJoin(
                UserProfileEntity::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = service.createdBy'
            )

            ->andWhere('service.categoryID = :categoryID')
            ->setParameter('categoryID', $categoryID)

            ->getQuery()
            ->getResult();
    }
    
    public function getServicesOfUser($userID)
    {
        return $this->createQueryBuilder('service')
            ->select('service.id', 'service.serviceTitle', 'service.description', 'service.duration', 'service.createdBy', 'service.categoryID',
             'service.activeUntil', 'service.enabled', 'service.tags')

            ->andWhere('service.createdBy = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }
}
