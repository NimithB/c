import java.util.Scanner;

class Queue {
    int[] q;
    int front = 0, rear = 0, size;

    public Queue(int size) {
        this.size = size;
        q = new int[size];
    }

    void insert(int n) {
        Scanner in = new Scanner(System.in);
        for (int i = 0; i < n; i++) {
            System.out.print("\nEnter packet " + (i + 1) + ": ");
            int ele = in.nextInt();
            if (rear == size) {
                System.out.println("Queue full. Lost Packet: " + ele);
            } else {
                q[rear++] = ele;
            }
        }
    }

    void delete() {
        if (front == rear) {
            System.out.println("Queue is empty.");
            return;
        }
        System.out.println("Processing packets:");
        while (front < rear) {
            try {
                Thread.sleep(1000); // Simulate packet processing delay
            } catch (InterruptedException e) {
                System.out.println("Error: " + e.getMessage());
            }
            System.out.println("Leaked Packet: " + q[front++]);
        }
    }
}

public class leak {
    public static void main(String[] args) {
        Scanner src = new Scanner(System.in);
        System.out.print("Enter queue size: ");
        int size = src.nextInt();
        System.out.print("Enter number of packets: ");
        int numPackets = src.nextInt();
        Queue queue = new Queue(size);
        queue.insert(numPackets);
        queue.delete();
    }
}
