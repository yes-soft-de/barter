<?php


namespace App\Request;


class CommentCreateRequest
{
    private $createdBy;

    private $text;

    private $serviceID;

    private $entityID;

    public function setCreatedBy($createdBy)
    {
        $this->createdBy = $createdBy;
    }

    public function setEntityID($entityID)
    {
        $this->entityID = $entityID;
    }

    public function getServiceID()
    {
        return $this->serviceID;
    }
}