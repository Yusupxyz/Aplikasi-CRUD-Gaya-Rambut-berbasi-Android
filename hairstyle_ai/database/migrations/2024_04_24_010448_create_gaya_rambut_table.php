<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGayaRambutTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('gaya_rambuts', function (Blueprint $table) {
            $table->id();
            $table->integer('panjang');
            $table->integer('id_warna');
            $table->enum('tekstur', ['kasar','sedang','halus']);
            $table->integer('id_gaya');
            $table->enum('sumber',['katalog','pelanggan']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('gaya_rambut');
    }
}
