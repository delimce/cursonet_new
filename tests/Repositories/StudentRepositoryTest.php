<?php

namespace Tests\Repositories;

use Tests\TestCase;
use App\Repositories\StudentRepository;

class StudentRepositoryTest extends TestCase
{

    protected $studentService;

    public function setUp(): void
    {
        parent::setUp();
        $this->studentService = new StudentRepository();
    }

    public function testStudentDoLogin()
    {
        $email = 'ldelima@zoho.com';
        $pass = '1234';
        $resp = $this->studentService->doLogin($email,$pass);
        $this->assertFalse($resp["ok"]);
        $pass = '12345';
        $resp = $this->studentService->doLogin($email,$pass);
        $this->assertTrue($resp["ok"]);

    }

    public function testStudentActivateUser()
    {
        $fakeToken = '12345';
        $result = $this->studentService->isTokenActive($fakeToken);
        $this->assertFalse($result);
    }

    
    public function testStudentGetById()
    {
        $studentId =4000;
        $result = $this->studentService->getStudentById($studentId);
        $this->assertNull($result);

        $studentId =490;
        $result = $this->studentService->getStudentById($studentId);
        $this->assertIsObject($result);

    }

}

