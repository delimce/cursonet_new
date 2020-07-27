<?php

namespace Tests\Repositories;

use Tests\TestCase;
use App\Repositories\ClassroomRepository;

class ClassroomRepositoryTest extends TestCase
{

    protected $classroomRepository;

    public function setUp(): void
    {
        parent::setUp();
        $this->classroomRepository = new ClassroomRepository();
    }


    /**
     * @test
     */
    public function testGetTopicsByCourseId()
    {
        $fakeCourseId = 0;
        $this->assertFalse(count($this->classroomRepository->getTopicsByCourseId($fakeCourseId)) > 0);
        $fakeCourseId = 20;
        $result = $this->classroomRepository->getTopicsByCourseId($fakeCourseId);
        if (count($result) > 0) {
            $topic = collect($result->first());
            $this->assertTrue($topic->has("contenido"));
        }
    }

    public function testGetTopicElementsByIdAndStudentId()
    {
        
        $fakeTopicId = 75;
        $fakeStudentId =476;
        $result = $this->classroomRepository->getTopicElementsByIdAndStudentId($fakeTopicId,$fakeStudentId);
        $this->assertArrayHasKey("title",$result);
        $this->assertArrayHasKey("content",$result);
        $this->assertArrayHasKey("files",$result);
        $this->assertArrayHasKey("forums",$result);
        $this->assertArrayHasKey("projects",$result);
    }


}
