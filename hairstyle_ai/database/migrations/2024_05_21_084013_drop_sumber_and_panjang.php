<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class DropSumberAndPanjang extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('gaya_rambuts', function (Blueprint $table) {
            $table->dropColumn('sumber');
            $table->dropColumn('panjang');
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
            $table->enum('sumber',['katalog','pelanggan'])->after('tekstur');
            $table->integer('panjang')->after('tekstur');
        });
    }
}
