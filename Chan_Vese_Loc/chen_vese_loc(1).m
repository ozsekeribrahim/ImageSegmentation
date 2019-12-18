clear all
close all
clc

%% Maske ve G�r�nt� Belirleme
% 
% <<coins.png>>
% 
%[mnc,inf]=loadminc('br5.mnc');
im=imread('coins.png');
%im=mnc(:,:,160);
im=uint8((im*255)/max(max(im)));
% im=rgb2gray(im);
% im = imnoise(im,'gaussian', 0.01);
% im = imresize(im,.5);
% [m_im,n_im]=size(im);
% mask=zeros(m_im,n_im);
% mask(5:750,5:440)=1;
figure(1);
mask=getmask(im,4);
close Figure 1;
mask=logical(mask);
num_ite=2000; %�terasyon Say�s�

mu=0.5; % �arpan Sabiti
count=0;
%% D�n���mler
I=double(im);
phi= bwdist(mask)- bwdist(1-mask)+ im2double(mask); %Level Set
segments=phi<0;%phi'nin ilk halinden �rnek saklama

%% �nizleme
figure(3);
% figure('Name','Segmentasyon','NumberTitle','off');
subplot(2,2,1);imshow(im,'InitialMagnification','fit'); title('Orjinal G�r�nt�');
subplot(2,2,2);contour(flipud(phi), [0 0], 'g','LineWidth',2); title('Maske');


%% Ana D�ng�
% 
% <<phi.png>>
% 

for m=1:num_ite
%     tic
    %Maskenin i� ve d�� bolgerinin yerini ve say�s� belirle
    out_phi=find(phi>=0);
    in_phi=find(phi<0);
    num_out=length(out_phi);
    num_in=length(in_phi);
    % 6 ve 7 numaral� denlemler ile i� ve d�� alan�n ortalamalar�n� belirle
    %% 
    % 
    % <<c1.png>>
    % 
    c1=sum(sum(I.*(1-H2(phi))))/(num_in+eps);
    c2=sum(sum(I.*H2(phi)))/(num_out+eps); % eps=2.2204e-16 0'a b�l�nme hatas�n� �nlemek i�in
    %%
    % 
    % <<c2.png>>
    % 

   
    
%     Uin=I.*H2(phi);
%     Uin=Uin(find(Uin ~=0));
%     Uout=I.*(1-H2(phi));
%     Uout=Uout(find(Uout ~=0));
%     f1=sum(Uin-c1)
%     f2=sum(Uout-c2)
%     f=f1+f2
    %%
    % 
    % <<dphi.png>>
    % 

    %9 numaral� denklemin 1. par�as�
    [grax, gray]=gradient(phi);
    grax=grax./sqrt(grax.^2+gray.^2);
    gray=gray./sqrt(grax.^2+gray.^2);
    div=divergence(grax,gray);
    nandiv=find(isnan(div));
    div(nandiv)=1;
    udiv=mu.*div;
    
    %9 numaral� denklemin 2. par�as�
    
    p2=(I-c2).^2;
    p3=(I-c1).^2;
    
    % Dirac fonksiyonu H'�n t�revi olarak tan�mlanm��t�r.
    hphi=H2(phi);
    [grax, gray]=gradient(hphi);
    grax=grax./sqrt(grax.^2+gray.^2);
    gray=gray./sqrt(grax.^2+gray.^2);
    dirac=divergence(grax,gray);
    nandiv=find(isnan(dirac));
    dirac(nandiv)=1;%Dirac(phi)
    
    dphi_div_dt=dirac.*(udiv-p2+p3);
    dphi_div_dt = dphi_div_dt./max(max(abs(dphi_div_dt)));
    dt=0.5;
    dphi=dphi_div_dt.*dt;
    
    phi=phi+dphi;
%     figure(7),mesh(phi);
    
%     islemsuresi=toc
    %Her iterasyondaki ��kt�
    if(mod(m,20) == 0)
%         tic
        segments=phi<0;  %phi den binary segmente edilmi� g�r�nt� elde etme;
        figure(3);
        tit=['Segmentasyon: ' num2str(m),'/',num2str(num_ite)];
        subplot(2,2,3);
        imshow(im,'InitialMagnification','fit'); hold on;
        contour(phi, [0 0], 'g','LineWidth',2); hold off
        title(tit);
        subplot(2,2,4);imshow(segments);hold on;
        
        title('��kt�');
        drawnow;
%         cizim=toc
    end
    
    
    
end

filled=marksegments(segments);
figure,mesh(filled);

% 
% %% Kullan�lan Fonksyonlar
% %% 
% %% Heaviside Fonksiyonu
% % 
% %   % Makaleye verilen Heaviside fonksiyonunun d�zle�tirilmi� versiyonu;
% function output= H(z)
% 
% [m,n]=size(z);
% h=ones(m,n);
% 
% low_z=find(z<-eps);
% high_z=find(z>eps);
% mid_z=find((z<=eps) & (z>=-eps));
% 
% h(high_z)=1;
% 
% h(low_z)=0;
% 
% for i=mid_z
%    h(i)=(1/2)*(1+(z(i)/eps)+(1/pi)*sin((pi*z(i))/eps)); 
% end
% output=h;
% end
% % 
% 
% %% Maske S�n�rlar�n� Belirleme
% % 
% %   
% function mask=getmask(image,point_num)
% 
% 
% [my, mx]=size(image);
% n=point_num;
% line=[];
% figure(1),imshow(image); hold on;
% for i=1:n
% [mask_x,mask_y] = ginput(1);
% line(1,i)=mask_x;
% line(2,i)=mask_y;
% if i>1
%   plot(line(1,:),line(2,:));  
% end
% 
% end
% line(1,end+1)=line(1,1);
% line(2,end)=line(2,1);
% plot(line(1,:),line(2,:));hold off;
% lx=1:mx;
% ly=1:my;
% [lx, ly]=meshgrid(lx,ly);
% 
% [in]= inpolygon(lx,ly,line(1,:),line(2,:));
% mask=in;
% end
% % 




