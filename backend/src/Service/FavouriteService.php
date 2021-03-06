<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\FavouriteEntity;
use App\Manager\FavouriteManager;
use App\Response\FavouriteCreateResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class FavouriteService
{
    private $favouriteManager;
    private $autoMapping;
    private $params;
    private $categoryService;

    public function __construct(FavouriteManager $favouriteManager, AutoMapping $autoMapping, CategoryService $categoryService, 
    ParameterBagInterface $params)
    {
        $this->favouriteManager = $favouriteManager;
        $this->autoMapping = $autoMapping;
        $this->categoryService = $categoryService;

        $this->params = $params->get('upload_base_url') . '/';
    }
  
    public function create($request)
    {  
        $favouriteManager = $this->favouriteManager->create($request);

        return $this->autoMapping->map(FavouriteEntity::class, FavouriteCreateResponse::class, $favouriteManager);
    }

    public function delete($categoryID, $userID)
    {
        $favouriteResult = $this->favouriteManager->delete($categoryID, $userID);

        if ($favouriteResult == null)
        {
            return null;
        }

        return $this->autoMapping->map(FavouriteEntity::class, FavouriteCreateResponse::class, $favouriteResult);
    }

    public function specialLinkCheck($bool)
    {
        if (!$bool) {
            return $this->params;
        }
    }

}