%%Outermost convex polygon

[num]=xlsread('D:\test2边界点.xlsx',1) ;
path='D:\test2高德.xlsx';
%x=num(:,1)
%y=num(:,2)
z=num(:,3);
t=max(z);
F = find(z==-1);
start=1;
m=0;
nn=0;

for i=0:t
    F = find(z==i); 
    F=F';
    s='';
   for f=F
        s=[s,'[',num2str(num(f,1)),',',num2str(num(f,2)),']',','];
   end
   s=s(1:end-1);
   s1=['B',num2str(i+1)];
%    e1=['B',num2str(i+1)];
%    sb=[s1,':',e1];
   s2=['A',num2str(i+1)];
%    e2=['A',num2str(i+1)];
%    sa=[s2,':',e2];
   xlswrite(path,{s},'sheet1',s1); 
   xlswrite(path,i,'sheet1',s2); 
    
    
end 
t    
%plot(x,y,'.','markersize',10);holdon;
%plot(x(k),y(k),'r');
%holdoff;