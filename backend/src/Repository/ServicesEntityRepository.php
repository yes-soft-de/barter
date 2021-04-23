<?php

namespace App\Repository;

use App\Entity\CategoryEntity;
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

            ->andWhere('service.enabled = 1')
            ->andWhere('service.categoryID = :categoryID')
            ->setParameter('categoryID', $categoryID)

            ->getQuery()
            ->getResult();
    }
    
    public function getServicesOfUser($userID)
    {
        return $this->createQueryBuilder('service')
            ->select('service.id', 'service.serviceTitle', 'service.description', 'service.duration', 'service.createdBy', 'service.categoryID',
             'category.name as categoryName', 'service.activeUntil', 'service.enabled', 'service.tags')

            ->leftJoin(
                CategoryEntity::class,
                'category',
                Join::WITH,
                'category.id = service.categoryID'
            ) 

            ->andWhere('service.createdBy = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }

    public function getCountOfEnabledServicesOfUser($userID)
    {
        return $this->createQueryBuilder('service')
            ->select('count(service.id)', 'service.enabled') 

            ->andWhere('service.enabled = 1')
            ->andWhere('service.createdBy = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getServicesBySpecificAccount($serviceID)
    {
        $userID = $this->createQueryBuilder('service')
        ->select('service.id', 'service.createdBy')

        ->andWhere('service.id = :serviceID')
        ->setParameter('serviceID', $serviceID)

        ->getQuery()
        ->getOneOrNullResult();

        return $this->createQueryBuilder('service')
            ->select('service.id', 'service.serviceTitle', 'service.description', 'service.duration', 'service.createdBy', 'service.categoryID',
            'category.name as categoryName', 'service.activeUntil', 'service.enabled', 'service.tags', 'userProfile.userName', 'userProfile.image as userImage')

            ->leftJoin(
                UserProfileEntity::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = service.createdBy'
            )

            ->leftJoin(
                CategoryEntity::class,
                'category',
                Join::WITH,
                'category.id = service.categoryID'
            ) 

            ->andWhere('service.enabled = 1')
            ->andWhere('service.createdBy = :userID')
            ->setParameter('userID', $userID['createdBy'])

            ->getQuery()
            ->getResult();
    }

    public function getServiceByID($id)
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

            // ->andWhere('service.enabled = 1')
            ->andWhere('service.id = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserByServiceID($serviceID)
    {
        return $this->createQueryBuilder('service')
        ->select('service.id', 'service.createdBy')

        ->andWhere('service.id = :serviceID')
        ->setParameter('serviceID', $serviceID)

        ->getQuery()
        ->getOneOrNullResult();
    }

    public function getServicesByCategoryAndName($categoryID, $name)
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

            ->andWhere('service.enabled = 1')
            ->andWhere('service.categoryID = :categoryID')
            ->andWhere('service.serviceTitle LIKE :name')

            ->setParameter('categoryID', $categoryID)
            ->setParameter('name', '%'.$name.'%')

            ->getQuery()
            ->getResult();
    }

    public function getServicesByName($name)
    {
        return $this->createQueryBuilder('service')
            ->select('service.id', 'service.serviceTitle', 'service.description', 'service.duration', 'service.createdBy', 'service.categoryID',
            'category.name as categoryName', 'service.activeUntil', 'service.enabled', 'service.tags', 'userProfile.userName', 'userProfile.image as userImage')

            ->leftJoin(
                UserProfileEntity::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = service.createdBy'
            )

            ->leftJoin(
                CategoryEntity::class,
                'category',
                Join::WITH,
                'category.id = service.categoryID'
            ) 

            ->andWhere('service.enabled = 1')
            ->andWhere('service.serviceTitle LIKE :name')
            
            ->setParameter('name', '%'.$name.'%')

            ->getQuery()
            ->getResult();
    }

    public function getServicesByIDsArray($services)
    {
        return $this->createQueryBuilder('service')
            ->select('service.id', 'service.serviceTitle')

            ->andWhere('service.id IN (:IDs)')
            
            ->setParameter('IDs', $services)

            ->getQuery()
            ->getArrayResult();
    }
}
