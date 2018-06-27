<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AdjustCursoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        //
        Schema::table('tbl_curso', function (Blueprint $table) {


            $table->integer('resp')->default(null)->change();
            $table->integer('resp', 11)->change();
            $table->unsignedInteger('resp')->change();

            $table->foreign('resp')
                ->references('id')->on('tbl_admin')
                ->onDelete('set null');
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

        Schema::table('tbl_curso', function (Blueprint $table) {

            $table->integer('resp')->unsigned()->change();
            $table->dropForeign('tbl_curso_resp_foreign');
            $table->dropIndex('tbl_curso_resp_foreign');

        });
    }
}
