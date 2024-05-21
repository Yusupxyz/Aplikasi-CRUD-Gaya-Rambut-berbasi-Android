<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GayaRambut extends Model
{
    use HasFactory;
    protected $fillable = ['panjang','id_warna','tekstur','id_wajah'];

    public function warna()
    {
        return $this->belongsTo(Warna::class, 'id_warna', 'id');
    }

    public function wajah()
    {
        return $this->belongsTo(Wajah::class, 'id_wajah', 'id');
    }
}
