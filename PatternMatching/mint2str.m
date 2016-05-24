function s = mint2str(n,m,p)
% mint2str(n,m) converts the integer number n into a string with m digits before the period, 
% patching with zeros if necessary

s=int2str(n(:));
if nargin>1
    if isstr(m)
        p = m;
        m = [];
    elseif nargin<3
        p = '0';
    end
else
    m = [];
    p = '0';
end
for j=1:size(s,1)
    s(j,:) = strrep(s(j,:),' ',p);
end
if ~isempty(m)
    s = [repmat(p,size(s,1),m-size(s,2)) s];   
end
