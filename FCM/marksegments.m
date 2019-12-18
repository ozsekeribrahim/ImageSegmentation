function filled=marksegments(segments)

% clear all
% close all
% clc
% 
% segments=load('segm.mat');
segments=segments*(-1);
segments = padarray(segments,[1 1],-1,'both');
pixs=find(segments==0);
segno=1;
new_wave=[];
while ~isempty(pixs)
    wave=pixs(1);
    while ~isempty(wave)
        n=1;
        for j=wave
            [point_row, point_clmn]=ind2sub(size(segments),j);
            segments(point_row,point_clmn)=segno;
            n1=[0 0 -1 1];
            n2=[-1 1 0 0];
            nb_row=point_row+n1;
            nb_clmn=point_clmn+n2;
            nbs=sub2ind(size(segments),nb_row,nb_clmn);

            for i=nbs
                if segments(i)==0
                    segments(i)=segno;
                    new_wave(n)=i;
                    n=n+1;
                end
            end
        end
        wave=new_wave;
        new_wave=[];
    end
    segno=segno+1;
    pixs=find(segments==0);
end
filled=segments;
end