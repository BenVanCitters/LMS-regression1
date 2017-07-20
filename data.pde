//double array holder with convenience functions
class MyData
{
  double[][] trainingData;
  double[][] testingData;
  public MyData()
  {
    initData(15900);
  }
  
  private void initData(int sz)
  {
    //can play with the ratio here
    int trainingSz = (int)(sz*.99);
    
    //init data
    trainingData = new double[trainingSz][2];
    testingData = new double[sz-trainingSz][2];
    fillData(trainingData);
    fillData(testingData);
  }
  
  private void fillData(double[][] array)
  {
    for(int i = 0; i < array.length; i++)
    {
      double d = i/(array.length*1.0); // <- this is what h1 depends on
      double sinMult = 1;//.9+.2*(1+Math.sin(3*d*TWO_PI))/2;
      //h1 represents the dependant variable of the function
//      double h1 = 100+600*d - 250.0*d*d + sinMult*(random(20) - 350*random((float)(d*d)));
      double h1 = 100+200*d + d*Math.sin(d*TWO_PI*3)*random(-150,150);
      double[] rndOffset = {0,//random(-10,10),
                            0};//random(-10,10),};
      array[i] = new double[]{d, 
                              h1+rndOffset[1]};
    }    
  }
  
  void draw()
  {
    noFill();
//    stroke(255,0,0);
//    drawArray(testingData);
    stroke(0,128,0);
    drawArray(trainingData);
  }
  
  void drawArray(double[][] array)
  {
//    println("startingdraw! @ " + millis() + " millis.");
    beginShape(POINTS);
    for(int i = 0; i < array.length; i++)
    {
      vertex((float)(array[i][0]*width),
             (float)(array[i][1]));
    }
//    println("verts done! @ " + millis() + " millis.");
    endShape();
//    println("DONE drawing!! @ " + millis() + " millis.");
  }
  
  public double[] get1DTrainingData()
  {
    return get1DData(trainingData);
  }
  
  
  private double[] get1DData(double[][] array)
  {
    double[] result = new double[array.length];
    for(int i = 0; i < array.length; i++)
    {
      result[i] = array[i][1]; 
    }
    return result;
  }
  
}
