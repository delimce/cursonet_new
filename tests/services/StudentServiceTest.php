<?php

namespace Tests\Services;

use Tests\TestCase;
use App\Services\StudentService;

class StudentServiceTest extends TestCase
{

    protected $studentService;

    public function setUp(): void
    {
        parent::setUp();
        $this->studentService = new StudentService();
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

}

