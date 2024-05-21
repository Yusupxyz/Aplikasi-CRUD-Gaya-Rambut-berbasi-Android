<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterGayaRambutAi extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('gaya_rambuts', function (Blueprint $table) {
            $table->dropForeign(['id_gaya']);
            $table->dropColumn('id_gaya');

            $table->bigInteger('id_wajah')->after('id_warna');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('gaya_rambuts', function (Blueprint $table) {
            $table->bigInteger('id_gaya')->unsigned()->change();
            $table->foreign('id_gaya')->references('id')->on('warnas');

            $table->dropForeign('id_wajah');
            $table->dropColumn('id_wajah');
        });
    }
}
