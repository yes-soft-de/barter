<?php


namespace App\Controller;


use App\AutoMapping;
use App\Entity\CategoryEntity;
use App\Entity\CommentEntity;
use App\Entity\FavouriteEntity;
use App\Entity\GradeEntity;
use App\Entity\RatingEntity;
use App\Entity\ResetPasswordRequestEntity;
use App\Entity\ServicesEntity;
use App\Entity\SettingEntity;
use App\Entity\SwapEntity;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Service\MainService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class MainController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $mainService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator,
                                MainService $mainService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->mainService = $mainService;
    }

    /**
     * @Route("members", name="searchByBrand", methods={"GET"})
     */
    public function getAllMembers()
    {
        $result = $this->mainService->getAllMembers();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("eraseall", name="deleteAllData", methods={"DELETE"})
     */
    public function eraseAllData()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $usersProfiles = $em->getRepository(UserProfileEntity::class)->createQueryBuilder('profile')
                ->delete()
                ->getQuery()
                ->execute();

            $users = $em->getRepository(UserEntity::class)->createQueryBuilder('user')
                ->delete()
                ->getQuery()
                ->execute();

            $setting = $em->getRepository(SettingEntity::class)->createQueryBuilder('setting')
                ->delete()
                ->getQuery()
                ->execute();

            $services = $em->getRepository(ServicesEntity::class)->createQueryBuilder('services')
                ->delete()
                ->getQuery()
                ->execute();
            
            $comment = $em->getRepository(CommentEntity::class)->createQueryBuilder('comment')
                ->delete()
                ->getQuery()
                ->execute();

            $swap = $em->getRepository(SwapEntity::class)->createQueryBuilder('swap')
                ->delete()
                ->getQuery()
                ->execute();

            $resetPasswordRequest = $em->getRepository(ResetPasswordRequestEntity::class)->createQueryBuilder('resetPasswordRequest')
                ->delete()
                ->getQuery()
                ->execute();

            $rating = $em->getRepository(RatingEntity::class)->createQueryBuilder('rating')
                ->delete()
                ->getQuery()
                ->execute();

            $favourite = $em->getRepository(FavouriteEntity::class)->createQueryBuilder('favourite')
                ->delete()
                ->getQuery()
                ->execute();

            $grade = $em->getRepository(GradeEntity::class)->createQueryBuilder('grade')
                ->delete()
                ->getQuery()
                ->execute();

            $category = $em->getRepository(CategoryEntity::class)->createQueryBuilder('category')
                ->delete()
                ->getQuery()
                ->execute();
            
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return new Response("All Database information were being deleted");
    }

}