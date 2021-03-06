<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CommentCreateRequest;
use App\Request\DeleteRequest;
use App\Service\CommentService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class CommentController extends BaseController
{
    private $commentService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, CommentService $commentService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->commentService = $commentService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("/comment", name="comment", name="createComment", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, CommentCreateRequest::class, (object) $data);

        $request->setCreatedBy($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) 
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->commentService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/comment/{ID}", name="deleteComment", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('ID'));

        $result = $this->commentService->delete($request);

        return $this->response("", self::DELETE);
    }

    /**
     * @Route("/comments/{serviceID}", name="getCommentsOfAccount", methods={"GET"})
     * @param $serviceID
     * @return JsonResponse
     */
    public function getCommentsOfAccount($serviceID)
    {
        $result = $this->commentService->getAll($serviceID);

        return $this->response($result, self::FETCH);
    }
}
