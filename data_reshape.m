function [output_data] = data_reshape(data,k)
%DATA_RESHAPE Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(data);
output_data{n}=0;
for ii=1:n
    output_data{ii}=reshape(data(:,ii),k,m/k);
end


end

