import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key});

  @override
  Widget build(context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0.67),
      child: Container(
        width: 367,
        height: 90,
        decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.only(left:0, right: 3.5),
              width: 180,
              height: 90,
              decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0x8053917E)
              ),
              child: const Center (
                child: Text(
          'Description',
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 221),
            fontFamily: 'Inter',
            fontSize: 12,
          )
          ),
            ) 
            ),
            Container(
              margin: const EdgeInsets.only(left:3.5, right: 0),
              width: 180,
              height: 90,
              decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0x8053917E)
              ),
              child: const Center (
                child: Text(
          'Information',
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 221),
            fontFamily: 'Inter',
            fontSize: 12,
          )
          ),
            ),
            )
          ],
        ),
      ),
      );
     }
}
    
    /* Row(
       mainAxisSize: MainAxisSize.max,
  children: [
    Container(
      width: 175,
      height: 90,
      decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0x8053917E)
      ),
    ),
    Container(
      width: 175,
      height: 90,
      decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0x8053917E)
      ),
    ),
  ],
    );
  }
}


   children:  [   
      Positioned(
      left: 20,
      top: 21, 
      child: Container(decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0x8053917E)),
   height: 90,
   width: 175,),
 ),
 Positioned(
      left: 203,
      bottom: 251, 
      child: Container(decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0x8053917E)),
   height: 90,
   width: 175,)
      
 )
 ],) 
    ;
}
} */