<?php

require_once 'class1.php';

class Class1Cest
{
    public function _before(AcceptanceTester $I)
    {
    }

    public function _after(AcceptanceTester $I)
    {
    }

    // tests
    public function tryToTest(AcceptanceTester $I)
    {
        $obj = new Class1();
        $obj->var1 = 2;
    }
}
