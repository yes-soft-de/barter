<?php


namespace App\Response;

class ServicesGetResponse
{
    public $id;
    
    public $serviceTitle;

    public $description;

    public $duration;

    public $categoryID;

    public $activeUntil;

    public $enabled;

    public $tags = [];

    public $userName;

    public $userImage;
}