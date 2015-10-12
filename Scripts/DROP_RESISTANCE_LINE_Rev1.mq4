#include <stdlib.mqh>   



//+------ CHANGE HERE THE COLOR AND WIDTH OF RESISTANCE LINE --------+

color Resistance_Color = Magenta;   
int   Resistance_Width = 2;         // From 1 (thin) to 5 (thick) 

//+------------------------------------------------------------------+   






//+-----------------------------SCRIPT CODE--------------------------+
int start()
  { 
   double Resistance = WindowPriceOnDropped();
   datetime time = WindowTimeOnDropped();
   int TimeNow = TimeCurrent();
   
   if(IsConnected()) {TimeNow = TimeCurrent();} else {TimeNow = time;}
   
         ObjectCreate("Resistance_Line" + TimeNow + Resistance,OBJ_HLINE,0,0,Resistance);
         ObjectSet("Resistance_Line" + TimeNow + Resistance,OBJPROP_COLOR,Resistance_Color);
         ObjectSet("Resistance_Line" + TimeNow + Resistance,OBJPROP_WIDTH,Resistance_Width);
         
   return(0);
  }
//+------------------------------------------------------------------+
