//this class is meant to store and illustrate a hypthesis function
class Hypothesis
{
  long iterations = 0;
  double[] thetas; //theta vector
  ArrayList<Double> costs = new ArrayList<Double>(); //storage for our cost as we improve the theta vector

  public Hypothesis()
  {
    thetas = new double[2];
//    thetas[0] = random(-1000,1000);
//    thetas[1] = random(-1000,1000);
  }
  
  //drawing right now is only in 2d and just uses a line with points at 0 and one evaluated and illustrated
  void draw()
  {
    line(0,(float)hypoth(0),width,(float)hypoth(1));
  } 
  
  //hypothesis function - only support a 1-D x vector right now
  double hypoth(double x)
  {
    return thetas[0]+thetas[1]*x;
  }
  
  // Cost function of the given hypothesis
  double costFunc(double[] data)
  {
    double sum = 0;
    for(int i = 0; i < data.length; i++)
    {
      double t = i*1.0/data.length;
      double val = hypoth(t) - data[i];
      sum += Math.pow(val, 2);
    }
    return 0.5 * sum;
  }
  
  //batch style - "slower"
  void updateLMSBatchThetas(double alpha, double[][] data)
  {
    for(int j = 0; j < thetas.length; j++)
    {
      double sum = 0;
      for(int i = 0; i < data.length; i++)
      {
        // gradient descent
        double t = (j==0) ? 1.0 : data[i][0];
        sum += ( data[i][1] - hypoth( data[i][0] ) ) * t;
      }
      thetas[j] += alpha*sum;
//      println("thetas[" + j+"]: " + thetas[j]);
    }
    iterations++;
  }

  //stochastic style - "faster" but less convergant
  void updateLMSStoThetas(double alpha, double[][] data)
  {
    for(int i = 0; i < data.length; i++)
    {
      for(int j = 0; j < thetas.length; j++)
      {
        // gradient descent
        double t = (j==0) ? 1.0 : data[i][0];
        thetas[j] += alpha * ( data[i][1] - hypoth( data[i][0]) ) * t;
      }
//      println("thetas[" + j+"]: " + thetas[j]);
    }
    iterations++;
  }
  
  //this function draws the cost(essentially as a function of iterations) as a line across the window
  void drawCosts()
  {
    //calculate min and max for scaling purposes
    double[] minMax = {Double.MAX_VALUE,-Double.MIN_VALUE};
    for(Double cost : costs)
    {
      minMax[0] = Math.min(minMax[0], cost);
      minMax[1] = Math.max(minMax[1], cost); 
    }
    double diff = minMax[1]-minMax[0];
    
    pushMatrix();
      float h = 100; //height of diagram
      float topY = height-h-5; //offset just a little from the bottom of the window
      translate(0,topY);
      //clear a small portion of background
  //    noStroke();
  //    fill(0);
  //    rect(0,0,width,height);
      
      beginShape();
        double divSize = width*1.0/costs.size();
        int i = 0;
        for(Double cost : costs)
        {
          float hVal = (float)((cost-minMax[0])/diff);
          hVal = pow(hVal,1/6.0);
  //        hVal = sqrt(hVal);
  //         hVal = sqrt(hVal);
          hVal = 1 - hVal; // turn the data upside down
          hVal *= h; // scale the data by the height of the rectangle it is in
          vertex((float)(divSize*i++),hVal);
        }      
      endShape();
    popMatrix();
    
  //  println("minMax: " + minMax[0] + ", " + minMax[1]);
  }
}
