<?php


namespace App\Request;


use DateTime;

class SwapCreateRequest
{
    private $date;

    private $userIdOne;

    private $userIdTwo;

    private $swapItemsOne = [];

    private $swapItemsTwo = [];

    private $cost;

    private $roomID;

    private $status;

    /**
     * @return mixed
     */
    public function getDate():?\DateTimeInterface
    {
        try
        {
            return new DateTime((string)$this->date);
        }
        catch (\Exception $e)
        {
        }
    }

    /**
     * @param mixed $date
     */
    public function setDate($date): void
    {
        $this->date = $date;
    }

    /**
     * @return mixed
     */
    public function getUserIdOne()
    {
        return $this->userIdOne;
    }

    /**
     * @param mixed $userIdOne
     */
    public function setUserIdOne($userIdOne): void
    {
        $this->userIdOne = $userIdOne;
    }

    /**
     * @return mixed
     */
    public function getUserIdTwo()
    {
        return $this->userIdTwo;
    }

    /**
     * @param mixed $userIdTwo
     */
    public function setUserIdTwo($userIdTwo): void
    {
        $this->userIdTwo = $userIdTwo;
    }

    /**
     * @return array
     */
    public function getSwapItemsOne()
    {
        return $this->swapItemsOne;
    }

    /**
     * @param array $swapItemsOne
     */
    public function setSwapItemsOne(array $swapItemsOne): void
    {
        $this->swapItemsOne = $swapItemsOne;
    }

    /**
     * @return array
     */
    public function getSwapItemsTwo()
    {
        return $this->swapItemsTwo;
    }

    /**
     * @param array $swapItemsTwo
     */
    public function setSwapItemsTwo(array $swapItemsTwo): void
    {
        $this->swapItemsTwo = $swapItemsTwo;
    }

    /**
     * @return mixed
     */
    public function getCost()
    {
        return $this->cost;
    }

    /**
     * @param mixed $cost
     */
    public function setCost($cost): void
    {
        $this->cost = $cost;
    }

    /**
     * @return mixed
     */
    public function getRoomID()
    {
        return $this->roomID;
    }

    /**
     * @param mixed $roomID
     */
    public function setRoomID($roomID): void
    {
        $this->roomID = $roomID;
    }

    /**
     * @return mixed
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * @param mixed $status
     */
    public function setStatus($status): void
    {
        $this->status = $status;
    }
}