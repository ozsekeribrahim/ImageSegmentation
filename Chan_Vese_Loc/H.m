%% Heaviside Fonksyonu
% Makaleye verilen Heaviside fonksiyonunun düzleþtirilmiþ versiyonu;
function output= H(z)

[m,n]=size(z);
h=ones(m,n);

low_z=find(z<-eps);
high_z=find(z>eps);
mid_z=find((z<=eps) & (z>=-eps));

h(high_z)=1;

h(low_z)=0;

for i=mid_z
   h(i)=(1/2)*(1+(z(i)/eps)+(1/pi)*sin((pi*z(i))/eps)); 
end
output=h;
end

%%