
[num]=xlsread('test.xlsx',1) ;
path='edge.xlsx';
path2='beijing.xlsx';
[nnum]=xlsread('index.xlsx',1);
%x=num(:,1)
%y=num(:,2)
z=num(:,1);
t=max(z);
F = find(z==-1);
x=num(F,2);
y=num(F,3);
%plot(x,y,'g.','markersize',10);hold on;
start=1;
m=0;
%nn=0;
P=cell(t);
zz=nnum(:,3);
for i=0:t
    F=find(zz==i);
    if length(F)==0
        continue
    end
    pp=nnum(F,1);
    ppp=nnum(F,2);
    kkk=reshape([pp',ppp'],length([pp',ppp'])/2,2);
    P(i+1)=mat2cell(kkk);
end
for i=0:t
    F = find(z==i); 
    if length(F)==0
        continue
    end
    i
    x=num(F,2);
    y=num(F,3);
    dt=DelaunayTri(x,y);
    plot(dt.X(:,1),dt.X(:,2),'.','markersize',10);hold on;
   % plot(dt.X(:,1),dt.X(:,2),'.','markersize',10);hold on; 
    if length(dt.Triangulation)==0
        continue
    end
    k=convexHull(dt);
   % plot(dt.X(k,1),dt.X(k,2),'r'); hold on;
    xx=dt.X(k,1);
    yy=dt.X(k,2);
   
    fff=1; %update
    fk=1; 
   
    while fff==1
        
        fff=0;
        for e=1:length(xx) 
            dian=[xx(e),yy(e)];
            ff=0;  %record
            for jj=0:t  %judge in or not
                if jj==i
                    continue
                end
                if length(P(jj+1))==0
                    continue
                end
                poly=cell2mat(P(jj+1));
                %poly=reshape(poly,length(poly)/2,2);
                if length(poly)==0
                    continue
                end
                if judgedian2(poly,dian)==1  %in
                    for h=1:length(x)
                        if x(h)==xx(e) && y(h)==yy(e)
                             x(h)=[];
                             y(h)=[];
                             ff=1;
                             break
                        end
                    end
                end
                if ff==1
                    fff=1;
                    break
                end
            end
        end
    
        if fff==1  %change
          
           if length(x)<4
                fff=0;
                fk=0;
                break  %skip
            end
            dt=DelaunayTri(x,y);
            if length(dt.Triangulation)==0  %not
                fff=0;
                fk=0;
                break
            end
            k=convexHull(dt);
            xx=dt.X(k,1);
            yy=dt.X(k,2);
        end
    end
   
    if fk==1
     P(i+1)=mat2cell([dt.X(k,1),dt.X(k,2)]);
     
     plot(dt.X(k,1),dt.X(k,2),'r'); hold on;
     m=start+length(dt.X(k,1))-1;
    sumx=sum(dt.X(:,1));
    sumy=sum(dt.X(:,2));
    xz=sumx/length(dt.X(:,1));
    yz=sumy/length(dt.X(:,1));
    %nn=nn+length(dt.X(k,1));
    zx=[num2str(xz),',',num2str(yz)];

    s1=['A',num2str(start)];
    e1=['A',num2str(m)];
    s2=['B',num2str(start)];
    e2=['B',num2str(m)];
    s3=['C',num2str(start)];
    e3=['C',num2str(m)];
    sa=[s1,':',e1];
    sb=[s2,':',e2];
    sc=[s3,':',e3];
    s4=['B',num2str(i+1)];
    s5=['A',num2str(i+1)];
    xlswrite(path,dt.X(k,1),'sheet1',sa);
    xlswrite(path,dt.X(k,2),'sheet1',sb);
    xlswrite(path,i,'sheet1',sc);
    xlswrite(path2,{zx},'sheet1',s4);
    xlswrite(path2,i,'sheet1',s5);
    start=m+1;
    end
   
end
t
         
    
        
            
           
   
           
