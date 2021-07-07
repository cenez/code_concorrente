package br.unifor.concorrente.sync;

public class Semaforo {
    private int counter;
    public Semaforo() {
        this(0);
    }
    public Semaforo(int i) {
        if (i < 0) throw new IllegalArgumentException(i + " < 0");
        counter = i;
    }
    public synchronized void release() {
        if (counter == 0) {
            this.notify();
        }
        counter++;
    }
    public synchronized void acquire() throws InterruptedException {
        while (counter == 0) {
            this.wait();
        }
        counter--;
    }
}
