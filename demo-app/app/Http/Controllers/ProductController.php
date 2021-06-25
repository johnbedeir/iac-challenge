<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\StoreProduct;
use App\Product;
class ProductController extends Controller
{

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('products.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('products.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreProduct $request)
    {
        $validated = $request->validated();
        if($validated){
        $product = new Product();
        $product->product_name = $request->productname;
        $product->img_path = $request->image;
        $product->stock =$request->Stock;
        $product->fabric_type =$request->fabrictype;
        $product->fabric_count =$request->fabriccout;
        $product->fabric_price =$request->fabricprice;
        $product->fabric_total_price =$request->fabrictotal;
        $product->other_materials =$request->othermaterials;
        $product->other_materials_price =$request->othermaterialsprice;
        $product->numberof_working_hours =$request->numberofworkinghours;
        $product->price_of_one_hour_work =$request->costofonehour;
        $product->total_working_hours_price =$request->totoalworkinghours;	
        $product->transportation_price =$request->transportcost;
        $product->total_cost =$request->totalcost;
        $product->profet =$request->profet;
        $product->total_price =$request->totalprice;
        $product->save();
        return view('products.index');
        }
        return redirect()->back();
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
