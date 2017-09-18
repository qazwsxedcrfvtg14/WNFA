function s = snr(TxP, d, ploss)
    d0 = 1;
    d0_loss = 1e-7;
    nf = 3.1622776602e-8;
    RxP = TxP*d0_loss*((d0/d)^ploss);
    s = RxP/nf;
end
