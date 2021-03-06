<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\DeleteRequest;
use App\Request\FavouriteCreateRequest;
use App\Service\FavouriteService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class FavouriteController extends BaseController
{
    private $favouriteService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, FavouriteService $favouriteService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->favouriteService = $favouriteService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("favourite", name="createFavouriteCategory", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, FavouriteCreateRequest::class, (object) $data);

        $request->setUserID($this->getUserId());
        
        $violations = $this->validator->validate($request);
        
        if (\count($violations) > 0) 
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->favouriteService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("favourite/{categoryID}", name="deleteFavouriteCategory", methods={"DELETE"})
     * @param $categoryID
     * @return JsonResponse
     */
    public function delete($categoryID)
    {
        $result = $this->favouriteService->delete($categoryID, $this->getUserId());

        return $this->response($result, self::DELETE);
    }
}
