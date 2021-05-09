<?php


namespace App\Response;


class UserProfileResponse
{
    public $userName;

    public $city;

    public $story;

    public $image;

    public $servicesNumber;
    
    public $services;

    public $role;

    public $completedSwapsNumber;

    public function getUserName()
    {
        return $this->userName;
    }

    public function getImage()
    {
        return $this->image;
    }

    public function setRoles($role)
    {
        $this->role = $role;
    }
}