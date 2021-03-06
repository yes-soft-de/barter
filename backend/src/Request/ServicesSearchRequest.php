<?php


namespace App\Request;


class ServicesSearchRequest
{
    private $name;

    private $categoryID;

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @return mixed
     */
    public function getCategoryID()
    {
        return $this->categoryID;
    }

}