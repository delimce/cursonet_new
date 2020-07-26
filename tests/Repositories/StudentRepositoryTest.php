<?php

namespace Tests\Repositories;

use Tests\TestCase;
use App\Repositories\StudentRepository;

class StudentRepositoryTest extends TestCase
{

    protected $studentRepository;

    public function setUp(): void
    {
        parent::setUp();
        $this->studentRepository = new StudentRepository();
    }

    public function testStudentDoLogin()
    {
        $email = 'ldelima@zoho.com';
        $pass = '1234';
        $resp = $this->studentRepository->doLogin($email,$pass);
        $this->assertFalse($resp["ok"]);
        $pass = '12345';
        $resp = $this->studentRepository->doLogin($email,$pass);
        $this->assertTrue($resp["ok"]);

    }

    public function testStudentActivateUser()
    {
        $fakeToken = '12345';
        $result = $this->studentRepository->isTokenActive($fakeToken);
        $this->assertFalse($result);
    }

    
    public function testGetStudentById()
    {
        $studentId =4000;
        $result = $this->studentRepository->getStudentById($studentId);
        $this->assertNull($result);

        $studentId =490;
        $result = collect($this->studentRepository->getStudentById($studentId));
        $this->assertIsObject($result);

        $this->assertTrue($result->has("id"));
        $this->assertFalse($result->has("token"));
        $this->assertFalse($result->has("foto"));

    }

}

