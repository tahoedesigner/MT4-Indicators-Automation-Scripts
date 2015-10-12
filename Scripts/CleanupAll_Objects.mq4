//+------------------------------------------------------------------+
//|                                           CleanupAll_Objects.mq4 |
//|                               Copyright © 2011, Patrick M. White |
//|                     https://sites.google.com/site/marketformula/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, Patrick M. White"
#property link      "https://sites.google.com/site/marketformula/"

/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
    
    If you need a commercial license, please send me an email:
    market4mula@gmail.com
*/


//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//----
    
   for(int i=ObjectsTotal()-1; i>-1; i--) {
      ObjectDelete(ObjectName(i));
   }
   Comment("");
 
//----
   return(0);
  }
//+------------------------------------------------------------------+