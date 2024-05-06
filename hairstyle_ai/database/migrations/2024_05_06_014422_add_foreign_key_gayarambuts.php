<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeyGayarambuts extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('gaya_rambuts', function (Blueprint $table) {
  
            $table->bigInteger('id_warna')->unsigned()->change();
            $table->bigInteger('id_gaya')->unsigned()->change();
  
            $table->foreign('id_warna')->references('id')->on('warnas');
            $table->foreign('id_gaya')->references('id')->on('gayas');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
