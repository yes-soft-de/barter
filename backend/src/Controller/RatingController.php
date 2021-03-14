<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\RatingCreateRequest;
use App\Service\RatingService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class RatingController extends BaseController
{
    private $ratingService;
    private $autoMapping;
    private $validator;

    /**
     * RatingController constructor.
     * @param RatingService $ratingService
     * @param AutoMapping $autoMapping
     */
    public function __construct(ValidatorInterface $validator, RatingService $ratingService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->ratingService = $ratingService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("rating", name="createRating", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, RatingCreateRequest::class, (object) $data);

        $request->setCreatedBy($this->getUserId());
        
        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) 
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->ratingService->create($request);

        return $this->response($result, self::CREATE);
    }

    // /**
    //  * @Route("/rating", name="updateRating", methods={"PUT"})
    //  * @param Request $request
    //  * @return JsonResponse|Response
    //  */
    // public function update(Request $request)
    // {
    //     $data = json_decode($request->getContent(), true);
    //     $request = $this->autoMapping->map(\stdClass::class, UpdateRatingRequest::class, (object) $data);

    //     $violations = $this->validator->validate($request);
    //     if (\count($violations) > 0) {
    //         $violationsString = (string) $violations;

    //         return new JsonResponse($violationsString, Response::HTTP_OK);
    //     }
        
    //     $result = $this->ratingService->update($request);
    //     return $this->response($result, self::UPDATE);
    // }

    /**
     * @Route("rating/{entityID}", name="getAvgRatingByEntityID", methods={"GET"})
     * @param $entityID
     * @return JsonResponse
     */
    public function getAverageRatings($entityID)
    {
        $result = $this->ratingService->getAvgRating($entityID);

        return $this->response($result, self::FETCH);
    }

}
