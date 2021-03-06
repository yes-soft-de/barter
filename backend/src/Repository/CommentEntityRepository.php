<?php

namespace App\Repository;

use App\Entity\CommentEntity;
use App\Entity\UserProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CommentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CommentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CommentEntity[]    findAll()
 * @method CommentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CommentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CommentEntity::class);
    }

    public function getCommentsOfAccount($userID)
    {
        return $this->createQueryBuilder('comment')
            ->select('comment.id', 'comment.createdBy', 'comment.text', 'comment.createdAt', 'userProfile.userName',
             'userProfile.image')

            ->leftJoin(
                UserProfileEntity::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = comment.createdBy'
            )

            ->andWhere('comment.entityID = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }
}
