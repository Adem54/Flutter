class Vehicle{
   String brand;//marka genel
   int year; //Mode yili
   double maxSpeed;

   Vehicle({required this.brand, required this.year, required this.maxSpeed}); //Maks hiz

  void start()
  {
    print("The vehicle of $brand is started");
  }
}