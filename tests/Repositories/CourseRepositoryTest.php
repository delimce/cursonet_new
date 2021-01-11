<?php

namespace Tests\Repositories;

use Tests\TestCase;
use App\Repositories\CourseRepository;

class CourseRepositoryTest extends TestCase
{

    protected $courseService;

    public function setUp(): void
    {
        parent::setUp();
        $this->courseService = new CourseRepository();
    }

    public function testGetCoursesByStudent()
    {
        $fakeId = 100;
        $courses = $this->courseService->getCoursesByStudent($fakeId);
        $this->assertCount(0, $courses);
    }

    public function testGetPublicCoursesByStudent()
    {

        $fakeId = 0;
        $courses = $this->courseService->getPublicCoursesByStudent($fakeId);
        $this->assertCount(1, $courses);

        $fakeId = 476;
        $courses = $this->courseService->getPublicCoursesByStudent($fakeId);
        $this->assertCount(0, $courses);
    }

    public function testEnrollInCourse()
    {
        $courseId = 1;
        $studentId = 1;
        $result = $this->courseService->enrollInCourse($courseId, $studentId);
        $this->assertFalse($result);
    }

        
    /**
     * testGetMainDataCourseByStudent
     *
     * @return void
     */
    public function testGetMainDataCourseByStudent()
    {
        $courseId = 24;
        $studentId = 476;
        $data = $this->courseService->getMainDataByStudent($courseId,$studentId);
        $this->assertArrayHasKey("id",$data);
        $this->assertArrayHasKey("nombre",$data);
        $this->assertArrayHasKey("group",$data);
    }
}
