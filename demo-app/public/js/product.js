

document.getElementById('fabriccout').onfocusout= function() {
    var fabriccout=0,fabricprice=0,fabrictotal=0;
     fabriccout = document.getElementById('fabriccout').value;
     fabricprice = document.getElementById('fabricprice').value;  
     fabrictotal = fabriccout * fabricprice;
     document.getElementById('fabrictotal').value=fabrictotal;
};
document.getElementById('fabricprice').onfocusout= function() {
    var fabriccout=0,fabricprice=0,fabrictotal=0;
     fabriccout = document.getElementById('fabriccout').value;
     fabricprice = document.getElementById('fabricprice').value;  
     fabrictotal = fabriccout * fabricprice;
     document.getElementById('fabrictotal').value=fabrictotal;
};


document.getElementById('numberofworkinghours').onfocusout= function() {
    var numberofworkinghours=0,costofonehour=0,totoalworkinghours=0;
    numberofworkinghours = document.getElementById('numberofworkinghours').value;
    costofonehour = document.getElementById('costofonehour').value;  
    totoalworkinghours = numberofworkinghours * costofonehour;
     document.getElementById('totoalworkinghours').value=totoalworkinghours;
};
document.getElementById('costofonehour').onfocusout= function() {
    var numberofworkinghours=0,costofonehour=0,totoalworkinghours=0;
    numberofworkinghours = document.getElementById('numberofworkinghours').value;
    costofonehour = document.getElementById('costofonehour').value;  
    totoalworkinghours = numberofworkinghours * costofonehour;
     document.getElementById('totoalworkinghours').value=totoalworkinghours;
};