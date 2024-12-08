import java.io.*;
import java.util.Scanner;
class CRC {
public static void main(String[] args) throws IOException {
Scanner scan = new Scanner(System.in);
int[] data;
int[] div;
int[] divisor;
int[] rem;
int[] crc;
int dataBits, divisorBits, totalLength;
// Input data bits
System.out.println("Enter number of data bits: ");
dataBits = scan.nextInt();
data = new int[dataBits];
System.out.println("Enter data bits: ");
for (int i = 0; i < dataBits; i++) {
data[i] = scan.nextInt();
}
// Input divisor bits
System.out.println("Enter number of bits in divisor: ");
divisorBits = scan.nextInt();
divisor = new int[divisorBits];
System.out.println("Enter Divisor bits: ");
for (int i = 0; i < divisorBits; i++) {
divisor[i] = scan.nextInt();
}
// Display input
System.out.print("Data bits are: ");
for (int bit : data) {
System.out.print(bit);
}
System.out.println();
System.out.print("Divisor bits are: ");
for (int bit : divisor) {
System.out.print(bit);
}
System.out.println();
// Append 0's to dividend
totalLength = dataBits + divisorBits - 1;
div = new int[totalLength];
rem = new int[totalLength];
crc = new int[totalLength];
for (int i = 0; i < data.length; i++) {
div[i] = data[i];
}
System.out.print("Dividend (after appending 0's) is: ");
for (int bit : div) {
System.out.print(bit);
}
System.out.println();
// Copy dividend to remainder
System.arraycopy(div, 0, rem, 0, div.length);
// Perform division
rem = divide(div, divisor, rem);

// Calculate CRC
for (int i = 0; i < div.length; i++) {
crc[i] = div[i] ^ rem[i];
}
System.out.println("CRC code: ");
for (int bit : crc) {
System.out.print(bit);
}
System.out.println();
// Check for errors
System.out.println("Enter CRC code of " + totalLength + " bits: ");
for (int i = 0; i < crc.length; i++) {
crc[i] = scan.nextInt();
}
// Copy CRC to remainder and perform division
System.arraycopy(crc, 0, rem, 0, crc.length);
rem = divide(crc, divisor, rem);
// Check if there is an error
boolean error = false;
for (int i = 0; i < rem.length; i++) {
if (rem[i] != 0) {
System.out.println("Error");
error = true;
break;
}
}
if (!error) {
System.out.println("No Error");
}
System.out.println("THANK YOU.... :)");
}
static int[] divide(int[] div, int[] divisor, int[] rem) {
int cur = 0;
while (true) {
for (int i = 0; i < divisor.length; i++) {
rem[cur + i] = rem[cur + i] ^ divisor[i];
}
// Find the next 1 in the remainder
while (cur < rem.length && rem[cur] == 0 && cur != rem.length - 1) {
cur++;
}
// If remaining bits are fewer than divisor length, stop
if ((rem.length - cur) < divisor.length) {
break;
}
}
return rem;
}
}