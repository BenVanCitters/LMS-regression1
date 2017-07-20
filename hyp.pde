class Hypothesis
{
  long iterations = 0;
  double[] thetas;
  ArrayList<Double> costs = new ArrayList<Double>();

  public Hypothesis()
  {
    thetas = new double[2];
//    thetas[0] = random(-1000,1000);
//    thetas[1] = random(-1000,1000);
  }
  
  void draw()
  {
    line(0,(float)hypoth(0),width,(float)hypoth(1));
  } 
  
  double hypoth(double x)
  {
    return thetas[0]+thetas[1]*x;
  }
  
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
  
  void updateLMSBatchThetas(double alpha, double[][] data)
  {
    for(int j = 0; j < thetas.length; j++)
    {
      double sum = 0;
      for(int i = 0; i < data.length; i++)
      {
        double t = (j==0) ? 1.0 : data[i][0];
        sum += ( data[i][1] - hypoth( data[i][0] ) ) * t;
      }
      thetas[j] += alpha*sum;
//      println("thetas[" + j+"]: " + thetas[j]);
    }
    iterations++;
  }


  
  //stochastic
  void updateLMSStoThetas(double alpha, double[][] data)
  {
//    double sum = 0;
    for(int i = 0; i < data.length; i++)
    {
      for(int j = 0; j < thetas.length; j++)
      {
        // t = x superscript i subscript j
        double t = (j==0) ? 1.0 : data[i][0];
        thetas[j] += alpha * ( data[i][1] - hypoth( data[i][0]) ) * t;
      }

//      println("thetas[" + j+"]: " + thetas[j]);
    }
    iterations++;
  }
  
  
  void drawCosts()
  {
    double[] minMax = {Double.MAX_VALUE,-Double.MIN_VALUE};
    for(Double cost : costs)
    {
      minMax[0] = Math.min(minMax[0], cost);
      minMax[1] = Math.max(minMax[1], cost); 
    }
    double diff = minMax[1]-minMax[0];
    
    pushMatrix();
      float h = 100;
      float topY = height-h-5;
      translate(0,topY);
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
          hVal = 1 - hVal;
          hVal *= h;
          vertex((float)(divSize*i++),hVal);
        }      
      endShape();
    popMatrix();
    
  //  println("minMax: " + minMax[0] + ", " + minMax[1]);
  }
}
