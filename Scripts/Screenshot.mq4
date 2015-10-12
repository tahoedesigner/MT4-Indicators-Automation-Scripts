//+------------------------------------------------------------------+
//|                                                   Screenshot.mq4 |
//|                                         Copyright © 2014, TrueTL |
//|                                            http://www.truetl.com |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2014, TrueTL"
#property link      "http://www.truetl.com"

#import "user32.dll"
   int GetClientRect(int hwnd, int rect[4]);
   int GetDC(int hwnd);
   int ReleaseDC(int hwnd, int hdc);
#import

//+------------------------------------------------------------------+
//| EXTERNAL SETTINGS                                                |
//+------------------------------------------------------------------+

//#property show_inputs

extern bool    Show_Top_Label    = false;
extern bool    Show_Bottom_Label = true;
extern color   Label_Color       = Black;
extern color   Background_Color  = Orange;
extern string  Directory         = "Chart";
extern string  Filename          = "Screen";
extern bool    Play_Sound        = true;
extern string  Sound_File        = "ok.wav";

//+------------------------------------------------------------------+
//| SCRIPT FUNCTION                                                  |
//+------------------------------------------------------------------+

int start() {

   int i, o;
   
   int pos[4];
   int hwnd = WindowHandle(Symbol(), Period());
   int hwnd2 = GetDC(hwnd);
   GetClientRect(hwnd, pos);
   ReleaseDC(hwnd, hwnd2);
   
   int x = MathMax(0,WindowFirstVisibleBar()-WindowBarsPerChart());
   
   if (x == 0) {
      x = -1;
   } else {
      x = 0;
   }
   
   string per;
   
   switch (Period()) {
      case 1     : per = "M1";   break;
      case 5     : per = "M5";   break;
      case 15    : per = "M15";  break;
      case 30    : per = "M30";  break;
      case 60    : per = "H1";   break;
      case 240   : per = "H4";   break;
      case 1440  : per = "D1";   break;
      case 10080 : per = "W1";   break;
      case 43200 : per = "MN1";  break;
      default    : per = "M"+Period(); break; 
   }
      
   string sym = Symbol();
   int symlen = StringLen(sym);
   
   if (Show_Top_Label) {
      for (i = 0; i <= symlen; i++) {
         for (o = 0; o <= 2; o++) {
            CreateText ("zbacka_"+i+"_"+o, 0, 1+i*13.5, 10+o*14, CharToStr(110), 24, "Wingdings", Background_Color);
         }
      }
      CreateText ("zlabel1", 0, 10, 20, sym, 16, "Arial", Label_Color);
      CreateText ("zlabel2", 0, 10, 45, per, 12, "Arial", Label_Color);
   }
   
   if (Show_Bottom_Label) {
      for (i = 0; i <= symlen; i++) {
         for (o = 0; o <= 2; o++) {
            CreateText ("zbackb_"+i+"_"+o, 2, 1+i*13.5, 10+o*14, CharToStr(110), 24, "Wingdings", Background_Color);
         }
      }
      CreateText ("zlabel3", 2, 10, 20, sym, 16, "Arial", Label_Color);
      CreateText ("zlabel4", 2, 10, 45, per, 12, "Arial", Label_Color);
   }
   
   string hou = TimeHour(TimeLocal());
   string min = TimeMinute(TimeLocal());
   string sec = TimeSeconds(TimeLocal());
   
   WindowScreenShot (Directory+"\\"+Filename+"_"+sym+"_"+per+"_"+hou+"-"+min+"-"+sec+".gif", pos[2], pos[3], x, -1, -1);

   if (Show_Top_Label) {
      for (i = 0; i <= symlen; i++) {
         for (o = 0; o <= 2; o++) {
            ObjectDelete("zbacka_"+i+"_"+o);
         }
      }
      ObjectDelete("zlabel1"); 
      ObjectDelete("zlabel2"); 
   }
   
   if (Show_Bottom_Label) {
      for (i = 0; i <= symlen; i++) {
         for (o = 0; o <= 2; o++) {
            ObjectDelete("zbackb_"+i+"_"+o);
         }
      }
      ObjectDelete("zlabel3"); 
      ObjectDelete("zlabel4");
   }
   
   if (Play_Sound) 
      PlaySound(Sound_File);
   
   return(0);
}

void CreateText (string label, int corner, int x, int y, string text, int fontsize, string font, color fontcolor) {
   ObjectCreate(label,OBJ_LABEL, 0, 0, 0);
   ObjectSet(label, OBJPROP_CORNER, corner); 
   ObjectSet(label, OBJPROP_XDISTANCE, x);
   ObjectSet(label, OBJPROP_YDISTANCE, y);
   ObjectSet(label, OBJPROP_BACK,false);
   ObjectSetText(label, text, fontsize, font, fontcolor);
}

