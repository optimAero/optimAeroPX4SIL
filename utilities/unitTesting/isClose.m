function result = isClose(x, y, varargin)
% isClose: function checks if x is close to y within a given tolerance
%
%=================================
% Inputs
%=================================
% x: scalar, vector, or matrix quantity to compare against the reference 
% y: reference quantity, must have the same dimensions as x or be a scalar
% rtol (optional): relative tolerance parameter, default 1.e-5
% atol (optional): absolute tolerance parameter, default 1.e-8
%=================================
% OUTPUTS
%=================================
% result: a logical having the same dimensions as x of where x and y are 
% equal within the given tolerance.
%
%=================================
% EXAMPLE USAGE
% =================================
% isClose(10.0001,10)
% isClose(10.0001,10,'atol',0.001)
% isClose(10.0001,10,'atol',0.001,'rtol',0.00001)
% isClose([10,10.001,10.02],10)
% isClose([10,10.001,10.02],[10,10.1,10.2])

    rtol = 1.e-5;
    atol = 1.e-8;

    for ii = 1:2:length(varargin)
        if strcmp('rtol', varargin{ii})
            rtol = varargin{ii + 1};
        elseif strcmp('atol', varargin{ii})
            atol = varargin{ii + 1};
        end
    end

    result = abs(x - y) < atol + rtol * abs(y);

end