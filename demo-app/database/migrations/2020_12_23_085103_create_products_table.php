<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('product_name');
            $table->string('img_path');
            $table->integer('stock');
            $table->string('fabric_type');
            $table->float('fabric_count');
            $table->float('fabric_price');
            $table->float('fabric_total_price');
            $table->string('other_materials');
            $table->float('other_materials_price');
            $table->float('numberof_working_hours');
            $table->float('price_of_one_hour_work');
            $table->float('total_working_hours_price');
            $table->float('transportation_price');
            $table->float('total_cost');
            $table->float('profet');
            $table->float('total_price');
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
        Schema::dropIfExists('products');
    }
}
