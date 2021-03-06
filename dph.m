%https://github.com/flyingwolfz/double-phase-hologram-matlab
clc
clear
p=im2double(rgb2gray(imread('triss1024.png')));
figure(1)
imshow(p);
pitch=8*10^(-3);
lambda=638*10^(-6);
B=rand(1024,1024);
quan1=p.*exp(1i*2*pi*B);
z=400;
%quan1=ASM('nocut','forward','limit',quan1,1,z,pitch,lambda);
%quan2=ASM('nocut','forward','limit',p,1,z,pitch,lambda);
quan1=ASMshift('shift','cut','forward','limit',quan1,2,z,pitch,lambda);
quan2=ASMshift('shift','cut','forward','limit',p,2,z,pitch,lambda);
ang=angle(quan2);
ang=mod(ang,2*pi);
amp=abs(quan2);
amp=amp./max(max(amp));
coss=acos(amp);
quana=ang+coss;
quanb=ang-coss;

qipan=zeros(1024,1024);
for i=1:1024
    for j=1:1024
       if(mod(i+j,2)==0)
           qipan(i,j)=1;
       end
    end
end
qipan2=1-qipan;

quan2=quana.*qipan+quanb.*qipan2;
quan2=mod(quan2,2*pi);
quan2=quan2/2/pi;

ang=angle(quan1);
ang=mod(ang,2*pi);
quan1=ang/2/pi;

figure(2)
subplot(1,2,1)
imshow(quan1);

subplot(1,2,2)
imshow(quan2);

%imwrite(quan1,'1.png');
%imwrite(quan2,'2.png');

quan1=exp(1i*2*pi*quan1);
quan2=exp(1i*2*pi*quan2);
%image1=ASM('nocut','backward','limit',quan1,1,z,pitch,lambda);
%image2=ASM('nocut','backward','limit',quan2,1,z,pitch,lambda);
image1=ASMshift('noshift','cut','backward','limit',quan1,2,z,pitch,lambda);
image2=ASMshift('noshift','cut','backward','limit',quan2,2,z,pitch,lambda);
image1=abs(image1);
image2=abs(image2);

image1=image1./max(max(image1));
image2=image2./max(max(image2));

figure(3)
subplot(1,2,1)
imshow(image1);

subplot(1,2,2)
imshow(image2);

