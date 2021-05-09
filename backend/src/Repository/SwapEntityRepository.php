<?php

namespace App\Repository;

use App\Entity\SwapEntity;
use App\Entity\UserProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SwapEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SwapEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SwapEntity[]    findAll()
 * @method SwapEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SwapEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SwapEntity::class);
    }

    public function getItems()
    {
        return $this->createQueryBuilder('swap')

            ->select('swap.id', 'swap.date', 'swap.userIdOne', 'swap.userIdTwo', 'swap.swapItemsOne', 'swap.swapItemsTwo', 
            'swap.cost', 'swap.roomID', 'swap.status')

            ->orderBy('swap.id', 'ASC')
            ->groupBy('swap.id')

            ->getQuery()
            ->getResult();
    }

    public function getItemByID($id)
    {
        return  $this->createQueryBuilder('swap')

            ->andWhere('swap.id=:id')
            ->setParameter('id', $id)
            ->groupBy('swap.id')

            ->getQuery()
            ->getResult();
    }

    public function getItemByUserID($userID)
    {
        return $this->createQueryBuilder('swap')

            ->select('swap.id', 'swap.date', 'swap.userIdOne', 'userOne.userName as userOneName','userTwo.userName as userTwoName',
                'swap.userIdTwo', 'swap.swapItemsOne', 'userOne.image as userOneImage', 'userTwo.image as userTwoImage',
                'swap.swapItemsTwo', 'swap.cost', 'swap.roomID', 'swap.status')

            ->leftJoin(
                UserProfileEntity::class,              //Entity
                'userOne',                        //Alias
                Join::WITH,              //Join Type
                'userOne.userID = swap.userIdOne'  //Join Column
            )
            ->leftJoin(
                UserProfileEntity::class,              //Entity
                'userTwo',                        //Alias
                Join::WITH,              //Join Type
                'userTwo.userID = swap.userIdTwo'  //Join Column
            )

            ->andWhere('swap.userIdOne=:userID')
            ->setParameter('userID', $userID)
            ->orWhere('swap.userIdTwo=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }

    public function getSwapByItemAndUserID($userID, $itemID)
    {
        return $this->createQueryBuilder('swap')

            ->andWhere('swap.swapItemsOne LIKE :itemID')
            ->andWhere('swap.userIdOne=:userID')
            ->setParameter('itemID', '%'.$itemID.'%')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }

    public function getCompletedSwapsByUserID($userID)
    {
        return $this->createQueryBuilder('swap')

            ->select('swap.id', 'swap.date', 'swap.userIdOne', 'userOne.userName as userOneName','userTwo.userName as userTwoName',
                'swap.userIdTwo', 'swap.swapItemsOne', 'userOne.image as userOneImage', 'userTwo.image as userTwoImage',
                'swap.swapItemsTwo', 'swap.cost', 'swap.roomID', 'swap.status')

            ->leftJoin(
                UserProfileEntity::class,               //Entity
                'userOne',                              //Alias
                Join::WITH,                             //Join Type
                'userOne.userID = swap.userIdOne'       //Join Column
            )
            ->leftJoin(
                UserProfileEntity::class,               //Entity
                'userTwo',                              //Alias
                Join::WITH,                             //Join Type
                'userTwo.userID = swap.userIdTwo'       //Join Column
            )

            ->andWhere('swap.userIdOne=:userID')
            ->setParameter('userID', $userID)

            ->orWhere('swap.userIdTwo=:userID')
            ->setParameter('userID', $userID)
            
            ->andWhere("swap.status = 'completed'")

            ->getQuery()
            ->getResult();
    }
}
