function Bmal1_protein_trunc=Bmal1_protein_processing(trunc_hrs,Bmal1_protein)


% load('Bmal1_protein')

x=Bmal1_protein(:,1); x=x-min(x);
y=Bmal1_protein(:,2);

Bmal1_protein_interp=interp1(x,y,linspace(0,max(x),72*60));

start_ind=1+floor(trunc_hrs*60);
Bmal1_protein_trunc=Bmal1_protein_interp(start_ind:end);


end
