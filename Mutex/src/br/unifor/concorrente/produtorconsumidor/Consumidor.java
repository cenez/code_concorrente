package br.unifor.concorrente.produtorconsumidor;

public class Consumidor extends Thread {
	@Override
	public void run() {
		consome();
		super.run();
	}
	private void consome() {
		long prox = 0;
		do{
			while (Armazem.c == 0);

			Armazem.i = (Armazem.i+1) % Armazem.N;
			prox = Armazem.buffer[Armazem.i];
			System.out.println("Consome: "+prox);
			Armazem.c--;
			
			try {
				Thread.sleep(50);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
		} while(prox < Armazem.MAX);
		System.out.println("\nFinalizando consumidor...");
	}
}
