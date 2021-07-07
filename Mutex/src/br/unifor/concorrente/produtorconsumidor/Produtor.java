package br.unifor.concorrente.produtorconsumidor;

public class Produtor extends Thread {
	@Override
	public void run() {
		produz();
		super.run();
	}
	private void produz() {
		long prox = 0l;
		while(prox < Armazem.MAX) {
			while (Armazem.c == Armazem.N);
			
			Armazem.f = (Armazem.f+1) % Armazem.N;
			prox = prox + 1;
			Armazem.buffer[Armazem.f] = prox;
			Armazem.c++;
			System.out.print("produtor "+prox+": ");

			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("\nFinalizando produtor...");
	}
}
