<?php

require '../vendor/autoload.php';

$calculation = new PlaceHolder\Calculation();
echo '1 + 4 = ' . $calculation->sum(1, 4);
