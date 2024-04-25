<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gaya extends Model
{
    use HasFactory;
    protected $fillable = ['gaya','jenis'];
}
