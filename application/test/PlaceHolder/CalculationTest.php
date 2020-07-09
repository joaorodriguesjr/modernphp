<?php

namespace PlaceHolder;

use PHPUnit\Framework as PHPUnit;

class CalculationTest extends PHPUnit\TestCase
{
    public function testPlaceholder()
    {
        $calculation = new Calculation();
        $this->assertEquals(5, $calculation->sum(1, 4));
    }
}
