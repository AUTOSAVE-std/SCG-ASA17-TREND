import processing.pdf.*;
import java.io.InputStreamReader;
 
PGraphics pdf = createGraphics(300, 300, PDF, "output.pdf");
pdf.beginDraw();
pdf.background(255, 255, 255);
pdf.stroke(0);
pdf.rect(50,50,200,200);
pdf.line(50, 50, 250, 250);
pdf.dispose();
pdf.endDraw();

//String params[] = { "\"C:/Program Files (x86)/Foxit Software/Foxit Reader/FoxitReader.exe\"" , "/p", "C:/Users/SCG/Documents/Processing/SCG-ASA17-TREND/printing/output.pdf"};
// C:\Program Files (x86)\Foxit Software\Foxit Reader
// C:\\Program Files (x86)\\Foxit Software\\Foxit Reader\\FoxitReader.exe
// C:\Users\SCG\Documents\Processing\SCG-ASA17-TREND\printing
// , "/t", "C:/Users/SCG/Documents/Processing/SCG-ASA17-TREND/printing/output.pdf" 
// FUCK
// THIS
// SHIT
// Two metohod using params and word concat
// same thing but different result
// my guess : params did not work on lunch() but open()
//launch("params");
launch  ("\""+ "C:/Program Files (x86)/Foxit Software/Foxit Reader/FoxitReader.exe"+"\"" +" /p "+ "C:/Users/SCG/Documents/Processing/SCG-ASA17-TREND/printing/output.pdf");
//println("\""+ "C:/Program Files (x86)/Foxit Software/Foxit Reader/FoxitReader.exe"+"\"" +" /p "+ "C:/Users/SCG/Documents/Processing/SCG-ASA17-TREND/printing/output.pdf");
//println(params);
println("end");
exit();