<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeyIdWajahGayarambuts extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('gaya_rambuts', function (Blueprint $table) {
  
            $table->bigInteger('id_wajah')->unsigned()->change();
            $table->foreign('id_wajah')->references('id')->on('warnas');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        $table->dropForeign(['id_wajah']);
    }
}
