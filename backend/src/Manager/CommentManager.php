<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\CommentEntity;
use App\Repository\CommentEntityRepository;
use App\Request\CommentCreateRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use Doctrine\ORM\EntityManagerInterface;

class CommentManager
{
    private $entityManager;
    private $commentEntityRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface, CommentEntityRepository $commentEntityRepository, AutoMapping $autoMapping) 
    {
        $this->entityManager = $entityManagerInterface;
        $this->commentEntityRepository = $commentEntityRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(CommentCreateRequest $request)
    {
        $commentEntity = $this->autoMapping->map(CommentCreateRequest::class, CommentEntity::class, $request);

        $this->entityManager->persist($commentEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $commentEntity;
    }

    public function delete(DeleteRequest $request)
    {
        $comment = $this->commentEntityRepository->find($request->getId());

        if (!$comment) 
        {

        } 
        else 
        {
            $this->entityManager->remove($comment);
            $this->entityManager->flush();
        }
        
        return $comment;
    }

    public function getAll($userID)
    {
        return $this->commentEntityRepository->getCommentsOfAccount($userID);
    }

}
