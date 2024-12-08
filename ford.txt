import java.util.*; 
public class BellmanFord { 
public static void bellmanFord(int[][] A, int src, int n) { 
int distances[] = new int[n]; 
Arrays.fill(distances, Integer.MAX_VALUE); 
distances[src - 1] = 0; 
for (int i = 0; i < n; i++) { 
for (int st = 0; st < n; st++) { 
for (int ed = 0; ed < n; ed++) { 
// A[st][ed] != 0 is for taking only valid edges 
// distances[st] != Integer.MAX_VALUE ensures 'st' vertex 
is reached before relaxing 
if (A[st][ed] != 0 && distances[st] != Integer.MAX_VALUE 
&& distances[ed] > distances[st] + A[st][ed]) { 
if (i != n - 1) 
distances[ed] = distances[st] + A[st][ed]; 
else { 
System.out.println("Graph has a negative cycle"); 
return; 
} 
} 
} 
} 
} 
for (int i = 0; i < n; i++) 
System.out.println(src + " <--> " + (i + 1) + " : " + 
distances[i]); 
} 
public static void main(String args[]) { 
Scanner in = new Scanner(System.in); 
System.out.print("Enter no. of vertices: "); 
int n = in.nextInt(); 
int A[][] = new int[n][n]; 
System.out.println("Enter adjaceny matrix: "); 
for (int i = 0; i < n; i++) { 
for (int j = 0; j < n; j++) 
A[i][j] = in.nextInt(); 
} 
System.out.print("Enter source: "); 
int src = in.nextInt(); 
in.close(); 
bellmanFord(A, src, n); 
} 
} 