@extends('layouts.app')

@section('content')
    
<div class="container">

    <h2>Add Product</h2>
    @if ($errors->any())
    <div class="alert alert-danger">
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
    @endif
  <div class="panel panel-default">
    <div class="panel-body">
        <form method="POST" action="{{ route('product.store') }}">
            @csrf
            <div class="form-row">
              <div class="form-group col-md-3">
                <label for="productname">Product Name</label>
                <input type="text" class="form-control" id="productname" placeholder="Enter Product Name" name="productname" required>
              </div>
              <div class="form-group col-md-3">
                <label for="stock">Stock</label>
                <input type="number" class="form-control" id="stock" placeholder="Stock Number" name="Stock" required>
              </div>
              <div class="form-group col-md-3">
                <label for="fabrictype">Fabric Type</label>
                <input type="text" class="form-control" id="fabrictype" placeholder="Fabric Type" name="fabrictype" required>
              </div> 
              <div class="form-group col-md-3">
                <label for="fabriccout">Fabric Count</label>
                <input type="number" class="form-control" id="fabriccout" placeholder="Fabric Count" name="fabriccout" required> 
              </div>                          
            </div>
            <div class="form-row">
                <div class="form-group col-md-3">
                    <label for="fabricprice">Fabric Price</label>
                    <input type="number" class="form-control" id="fabricprice" placeholder="Fabric Price" name="fabricprice" required>
                  </div>
                  <div class="form-group col-md-3">
                    <label for="fabrictotal">Fabric Total Price</label>
                    <input type="number" class="form-control" id="fabrictotal" placeholder="Fabric Total" name="fabrictotal" readonly>
                  </div>  
                  <div class="form-group col-md-3">
                    <label for="othermaterials">Other Materials</label>
                    <input type="text" class="form-control" id="othermaterials" name="othermaterials" placeholder="Other Materials" required>
                  </div>
                  <div class="form-group col-md-3">
                    <label for="othermaterialsprice">Other Materials Price</label>
                    <input type="number" class="form-control" id="othermaterialsprice" name="othermaterialsprice" placeholder="Other Materials Price" required>
                  </div>                                 
            </div>
            <div class="form-row">
              <div class="form-group col-md-3">
                <label for="numberofworkinghours">Number Of Working Hours</label>
                <input type="number" class="form-control" id="numberofworkinghours" name="numberofworkinghours" placeholder="Number Of Working Hours" required>
              </div>
              <div class="form-group col-md-3">
                <label for="costofonehour">Cost Of one Hour</label>
                <input type="number" class="form-control" id="costofonehour" name="costofonehour" placeholder="Cost Of one Hour" required>
              </div>
              <div class="form-group col-md-3">
                <label for="totoalworkinghours">Total Working Hours</label>
                <input type="number" class="form-control" id="totoalworkinghours" name="totoalworkinghours" placeholder="Total Working Hours" readonly>
              </div>
              <div class="form-group col-md-3">
                <label for="transportcost">Transportation Cost</label>
                <input type="number" class="form-control" id="transportcost" name="transportcost" placeholder="Transportation Cost" required>
              </div>             
            </div>
            <div class="form-row">
                <div class="form-group col-md-3">
                    <label for="totalcost">Total Cost</label>
                    <input type="number" class="form-control" id="totalcost" name="totalcost" placeholder="Total Cost" required>
                  </div> 
                  <div class="form-group col-md-3">
                    <label for="profet">Profet</label>
                    <input type="number" class="form-control" id="profet" name="profet" placeholder="Profet" required>
                  </div> 
                  <div class="form-group col-md-3">
                    <label for="totalprice">Total Price</label>
                    <input type="number" class="form-control" id="totalprice" name="totalprice" placeholder="Total Price" required>
                  </div> 
                  <div class="form-group col-md-3">
                    <label for="image">Product Image</label>
                    <input type="file" class="form-control" id="image" name="image">
                  </div>                                                                       
            </div>    
            <button type="submit" class="btn btn-primary">Submit</button>
          </form>       
    </div>
  </div>  
    
</div>

<script src="{{ asset('js/product.js') }}" ></script>
@endsection