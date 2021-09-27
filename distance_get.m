function  feature=distance_get(str)
pdb=pdbread(str);
acid=[{'ARG'},'LYS','ASP','GLU','GLN','ASN','HIS','SER','THR','TYR','CYS','MET','TRP','ALA','ILE','LEU','PHE','VAL','PRO','GLY'];
feature=zeros(1,20);

%ÇóÖØÐÄ
x0=0;
y0=0;
z0=0;

if length(pdb.Model)==1
    %flag=1;
    n=length(pdb.Model.Atom);
end

if length(pdb.Model)>1
    %flag=1;
    n=length(pdb.Model(1,1).Atom);
end


x=zeros(1,n-1);
y=zeros(1,n-1);
z=zeros(1,n-1);

if length(pdb.Model)==1
    n=length(pdb.Model.Atom);
    for i=1:n-1
        x(i)=pdb.Model.Atom(1,i).X;
        x0=x0+pdb.Model.Atom(1,i).X;
        y(i)=pdb.Model.Atom(1,i).Y;
        y0=y0+pdb.Model.Atom(1,i).Y;
        z(i)=pdb.Model.Atom(1,i).Z;
        z0=z0+pdb.Model.Atom(1,i).Z;
    end
end

if length(pdb.Model)>1
    n=length(pdb.Model(1,1).Atom);
    for i=1:n-1
        x(i)=pdb.Model(1,1).Atom(1,i).X;
        x0=x0+pdb.Model(1,1).Atom(1,i).X;
        y(i)=pdb.Model(1,1).Atom(1,i).Y;
        y0=y0+pdb.Model(1,1).Atom(1,i).Y;
        z(i)=pdb.Model(1,1).Atom(1,i).Z;
        z0=z0+pdb.Model(1,1).Atom(1,i).Z;
    end
end

x0=x0/(n-1);
y0=y0/(n-1);
z0=z0/(n-1);

for i=1:n-1
    x(i)=x(i)-x0;
    y(i)=y(i)-y0;
    z(i)=z(i)-z0;
end

xf=zeros(1,n-1);
yf=zeros(1,n-1);
zf=zeros(1,n-1);

%Cartesian coordinates converted to polar coordinates
for i=1:n-1
    [xf(i),yf(i),zf(i)]=cart2sph(x(i),y(i),z(i));
end

for azimuth=1:360
    for elevation=1:180
        flag=0;
        for i=n-1
            if  (xf(i)>=(azimuth-181)*(pi/180))&&(xf(i)<=(azimuth-180)*(pi/180))&&(yf(i)>=(elevation-91)*(pi/180))&&(yf(i)<=(elevation-90)*(pi/180))
                if flag==0
                    max_loc=i;
                else
                    if zf(i)>zf(max_loc)
                        xf(max_loc)=0;
                        yf(max_loc)=0;
                        zf(max_loc)=0;
                        max_loc=i;
                    else
                        xf(i)=0;
                        yf(i)=0;
                        zf(i)=0;
                    end
                end
            end
        end
    end
end


if length(pdb.Model)==1
    n=length(pdb.Model.Atom);
    for i=1:n-1
        if xf(i)~=0||yf(i)~=0||zf(i)~=0
            if(strcmp(pdb.Model.Atom(1,i).AtomName,'CA')==1)
                for j=1:20
                    if strcmp(pdb.Model.Atom(1,i).resName,acid(j))==1
                        feature(j)=feature(j)+1;
                    end
                end
            end
        end
    end
end

if length(pdb.Model)>1
    n=length(pdb.Model(1,1).Atom);
    for i=1:n-1
        if xf(i)~=0||yf(i)~=0||zf(i)~=0
            if(strcmp(pdb.Model(1,1).Atom(1,i).AtomName,'CA')==1)
                for j=1:20
                    if strcmp(pdb.Model(1,1).Atom(1,i).resName,acid(j))==1
                        feature(j)=feature(j)+1;
                    end
                end
            end
        end
    end
end

