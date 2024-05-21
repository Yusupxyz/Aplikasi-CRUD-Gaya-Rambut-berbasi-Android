<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wajah extends Model
{
    use HasFactory;
    protected $fillable = ['nama','wajah'];
}
