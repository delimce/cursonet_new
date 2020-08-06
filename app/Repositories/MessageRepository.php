<?php

namespace App\Repositories;

use Illuminate\Database\Eloquent\Collection;

class MessageRepository
{
    
    /**
     * getTotalUnread
     *
     * @param  Collection $messages
     * @return int
     */
    public function getTotalUnread(Collection $messages)
    {
        return $messages->filter(function($msg){
           return !$msg->leido;
         })->count();
    }

    
}