#include <stdlib.mqh>   



//+------ CHANGE HERE THE COLOR AND WIDTH OF SUPPORT LINE --------+

color Support_Color = DodgerBlue;   
int   Support_Width = 2;         // From 1 (thin) to 5 (thick) 

//+------------------------------------------------------------------+   






//+-----------------------------SCRIPT CODE--------------------------+
int start()
  { 
   double Support = WindowPriceOnDropped();
   datetime time = WindowTimeOnDropped();
   int TimeNow = TimeCurrent();
   
   if(IsConnected()) {TimeNow = TimeCurrent();} else {TimeNow = time;}
   
         ObjectCreate("Support_Line" + TimeNow + Support,OBJ_HLINE,0,0,Support);
         ObjectSet("Support_Line" + TimeNow + Support,OBJPROP_COLOR,Support_Color);
         ObjectSet("Support_Line" + TimeNow + Support,OBJPROP_WIDTH,Support_Width);
         
   return(0);
  }
//+------------------------------------------------------------------+
