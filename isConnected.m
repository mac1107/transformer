function state=isConnected(image,px,py)
state=0;
if image(px+1,py-1)~=0
    state=1;
end
if image(px+1,py)~=0
    state=1;
end
if image(px+1,py+1)~=0
    state=1;
end

    