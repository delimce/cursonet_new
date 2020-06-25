<?php

namespace Tests\Services;

use Tests\TestCase;
use App\Services\CourseService;

class CourseServiceTest extends TestCase
{

    protected $courseService;

    public function setUp(): void
    {
        parent::setUp();
        $this->courseService = new CourseService();
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
}
