class CartUserModel{
  int  productId ;
  int  quantity;

 CartUserModel({required this.productId, required this.quantity});

 factory CartUserModel.fromJson(Map<String, dynamic> json) {
    return CartUserModel(
     productId: json["productId"],
      quantity:json["quantity"],
    );
  }
}