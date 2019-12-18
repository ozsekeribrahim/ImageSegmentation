clear all
close all
clc
tic
clusno=2;
im=double(imread('rice.png'));
% [k,l,m]=size(ims);
% stor=zeros(k,l);
% for i=1:3
% im=double(imread('kartal.jpg'));
%[mnc,inf]=loadminc('br5.mnc');
%im=mnc(:,:,165);
% im=(im*255)/max(max(im));
% im=im(:,:,i)
% 26-50 yýldýz
% 302003-76 100 
% 135069 -101/125 kartal
% 118035-126-150 klise
% 
[row,clmn]=size(im);

im=reshape(im,(row*clmn),1);

im=im./max(im);

[center,U,obj_fcn] = fcm(im,clusno); 

maxU = max(U);

% for i=1:clusno
%     index(i,:) = find(U(clusno,:) == maxU);
% end
index1 = find( U(1,:)== maxU);
index2 = find(U(2,:) == maxU);
% index3 = find(U(3,:) == maxU);
% index4 = find(U(4,:) == maxU);
% index5 = find(U(5,:) == maxU);
% index6 = find(U(6,:) == maxU);
% index7 = find(U(7,:) == maxU);


% fcmImage(1:length(im))=0;
% start=1;
% per=start/clusno;
% for i=clusno
%     fcmImage(index(i,:))= i*per;
% end


fcmImage(1:length(im))=0;       
fcmImage(index1)= 1;
fcmImage(index2)= 0.8;
% fcmImage(index3)= 0.6;
% fcmImage(index4)= 0.4;
% fcmImage(index5)= 0.2;
% fcmImage(index6)= 0.1;
% fcmImage(index7)= 0.0;


imagNew = reshape(fcmImage,row,clmn);
figure;imshow((imagNew),[]);impixelinfo;
sobelim=edge(imagNew,'canny');
% stor=stor+sobelim;
figure;imshow(sobelim,[],'InitialMagnification','fit')
a=toc
% % end
% lastseg=stor>0;
% figure;imshow(lastseg,[])
% contourf(sobelim,3)
% a=marksegments(sobelim);
% figure,mesh(a);
% colormap colorcube;
% view(0,-90)