MyData data;
Hypothesis hyp;
Hypothesis hyp2;



void setup()
{
  size(displayWidth-50, 500);
  data = new MyData();
  hyp = new Hypothesis();
  hyp2 = new Hypothesis();
  
  background(0);
  data.draw();
  hyp.draw();
  
  double cost = hyp.costFunc(data.get1DTrainingData());
  println("cost: " + cost);
}


void draw()
{
  if(mousePressed)
  {
    background(0);
    double alpha = .00001;
    for(int i = 0; i < 100; i ++)
    {
      hyp.updateLMSBatchThetas(alpha,data.trainingData);
      double cost = hyp.costFunc(data.get1DTrainingData());
  //    println("cost hyp1: " + cost);
      hyp.costs.add(cost);
      
      hyp2.updateLMSStoThetas(alpha,data.trainingData);
      cost = hyp2.costFunc(data.get1DTrainingData());
  //    println("cost hyp2: " + cost);
      println("iterations: " + hyp2.iterations);
      hyp2.costs.add(cost);
    }
    stroke(255,255,0);
    hyp.draw();
    hyp.drawCosts();
    
    stroke(255,0,0);
    hyp2.draw();
    hyp2.drawCosts();
    
    data.draw();
  }
}


