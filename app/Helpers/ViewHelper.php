<?php

namespace App\Helpers;

class ViewHelper
{

    
    /**
     * msgNotification
     *
     * @param  int $total
     * @return void
     */
    public static function msgNotification($total)
    {
       $pref = (($total/10)>=1)?"&nbsp;":"&nbsp;&nbsp;";
       print($pref.$total);
    }
}