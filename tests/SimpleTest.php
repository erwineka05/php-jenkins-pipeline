<?php
use PHPUnit\Framework\TestCase;

class SimpleTest extends TestCase
{
    public function testAppOutput()
    {
        $this->expectOutputString('Hello from Jenkins Pipeline!');
        include 'src/index.php';
    }
}