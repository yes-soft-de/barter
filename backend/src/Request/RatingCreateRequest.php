<?php

namespace App\Request;

class RatingCreateRequest
{
    private $createdBy;

    private $entityType;
    
    private $entityID;      // Char 'A' refers to Account. Char 'S' refers to Service.
    
    private $rateValue;

    public function getCreatedBy()
    {
        return $this->createdBy;
    }

    public function setCreatedBy($createdBy)
    {
        $this->createdBy = $createdBy;

        return $this;
    }

    public function getEntityType()
    {
        return $this->entityType;
    }

    public function getEntityID()
    {
        return $this->entityID;
    }

    public function setEntityID($entityID)
    {
        $this->entityID = $entityID;

        return $this;
    }

}