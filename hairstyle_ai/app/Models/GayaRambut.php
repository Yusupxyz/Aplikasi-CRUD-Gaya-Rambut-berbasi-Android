<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GayaRambut extends Model
{
    use HasFactory;
    protected $fillable = ['panjang','id_warna','tekstur','id_gaya','sumber'];

    public function gaya()
    {
        return $this->belongsTo(Gaya::class, 'id_gaya', 'id');
    }

    public function warna()
    {
        return $this->belongsTo(Warna::class, 'id_warna', 'id');
    }
}
