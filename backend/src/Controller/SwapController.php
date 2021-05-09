<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\SwapCreateRequest;
use App\Request\SwapUpdateRequest;
use App\Service\SwapService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class SwapController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $swapService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, SwapService $swapService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->swapService = $swapService;
    }

    /**
     * @Route("swap", name="swapCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function swapCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SwapCreateRequest::class, (object)$data);

        $request->setUserIdOne($this->getUserId());
        
        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->swapService->swapCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("swap", name="swap", methods={"GET"})
     * @return JsonResponse
     */
    public function getSwapItems()
    {
        $response = $this->swapService->getSwaps();

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("swapbyid/{id}", name="swapById", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function swapById(Request $request)
    {
        $response = $this->swapService->getSwapByID($request->get('id'));

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("swap/{id}", name="deleteSwap",methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function deleteSwap(Request $request)
    {
        $result = $this->swapService->deleteSwap($request->get('id'));

        return $this->response($result, self::DELETE);
    }

    /**
     * @Route("swap", name="updateSwap", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateSwap(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SwapUpdateRequest::class, (object)$data);
        
        // $request->setUserIdOne($this->getUserId());
        
        $response = $this->swapService->updateSwap($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("swapbyuserid", name="getSwapItemsByUserID", methods={"GET"})
     * @return JsonResponse
     */
    public function getSwapItemsByUserID()
    {
        $response = $this->swapService->getSwapsByUserID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("completedswapsbyuserid", name="getcompletedSwapsByUserID", methods={"GET"})
     * @return JsonResponse
     */
    public function getCompletedSwapsByUserID()
    {
        $response = $this->swapService->getCompletedSwapsByUserID($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("allswaps", name="getAllSwaps", methods={"GET"})
     * @return JsonResponse
     * For debugging
     */
    public function getAll()
    {
        $response = $this->swapService->getAll();

        return $this->response($response, self::FETCH);
    }

}
