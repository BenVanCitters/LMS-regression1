MyData data;
Hypothesis hyp;
Hypothesis hyp2;

void setup()
{
  size(displayWidth-50, 500);
  
  //make a default new data class
  data = new MyData();
  //make two hypothesis classes one for batch regression
  hyp = new Hypothesis();
  //and the other for 
  hyp2 = new Hypothesis();
  
  background(0);
  data.draw();
  hyp.draw();
  
  double cost = hyp.costFunc(data.get1DTrainingData());
  println("cost: " + cost);
}


void draw()
{
  if(mousePressed) //update if the mouse is held down
  {
    background(0);
    double alpha = .00001; // Alpha, aka the learning rate of the algorithm
    
    //do 100 iterations each draw tick (if mouse is held down)
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


