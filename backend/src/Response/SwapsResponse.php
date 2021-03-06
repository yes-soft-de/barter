<?php


namespace App\Response;


class SwapsResponse
{
    public $id;

    public $date;

    public $userIdOne;

    public $userOneName;

    public $userOneImage;

    public $userTwoName;

    public $userTwoImage;

    public $userIdTwo;

    public $swapItemsOne;

    public $swapItemsTwo;

    public $cost;

    public $roomID;

    public $status;

    public function getUserIdOne()
    {
        return $this->userIdOne;
    }

    public function getUserIdTwo()
    {
        return $this->userIdTwo;
    }

    public function getSwapItemsOne()
    {
        return $this->swapItemsOne;
    }

    public function getSwapItemsTwo()
    {
        return $this->swapItemsTwo;
    }

    /**
     * @param mixed $userOneName
     */
    public function setUserOneName($userOneName): void
    {
        $this->userOneName = $userOneName;
    }

    /**
     * @param mixed $userOneImage
     */
    public function setUserOneImage($userOneImage): void
    {
        $this->userOneImage = $userOneImage;
    }

    /**
     * @param mixed $userTwoName
     */
    public function setUserTwoName($userTwoName): void
    {
        $this->userTwoName = $userTwoName;
    }

    /**
     * @param mixed $userTwoImage
     */
    public function setUserTwoImage($userTwoImage): void
    {
        $this->userTwoImage = $userTwoImage;
    }

    /**
     * @param mixed $userIdTwo
     */
    public function setUserIdTwo($userIdTwo): void
    {
        $this->userIdTwo = $userIdTwo;
    }

    /**
     * @param array $swapItemsOne
     */
    public function setSwapItemsOne(array $swapItemsOne): void
    {
        $this->swapItemsOne = $swapItemsOne;
    }

    /**
     * @param array $swapItemsTwo
     */
    public function setSwapItemsTwo(array $swapItemsTwo): void
    {
        $this->swapItemsTwo = $swapItemsTwo;
    }
    
}