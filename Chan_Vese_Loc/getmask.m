function mask=getmask(image,point_num)


[my, mx]=size(image);
n=point_num;
line=[];
figure(1),imshow(image); hold on;
for i=1:n
[mask_x,mask_y] = ginput(1);
line(1,i)=mask_x;
line(2,i)=mask_y;
if i>1
  plot(line(1,:),line(2,:));  
end

end
line(1,end+1)=line(1,1);
line(2,end)=line(2,1);
plot(line(1,:),line(2,:));hold off;
lx=1:mx;
ly=1:my;
[lx, ly]=meshgrid(lx,ly);

[in]= inpolygon(lx,ly,line(1,:),line(2,:));
mask=in;
end


