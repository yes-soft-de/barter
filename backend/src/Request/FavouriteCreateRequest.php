<?php


namespace App\Request;


class FavouriteCreateRequest
{
    private $userID;

    private $categoryID;

    public function setUserID($userID)
    {
        $this->userID = $userID;
    }
}