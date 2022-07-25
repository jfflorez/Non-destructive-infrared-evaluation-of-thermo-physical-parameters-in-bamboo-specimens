function [y_top,y_bot,y_filt] = mef(y,x,R)

% Morphological filter
    ysc = max(x)*(y-min(y))/(max(y)-min(y));
%     xsc = length(x)*(x-min(x))/(max(x)-min(x));

    y_top = zeros(1,length(ysc));
    y_bot = zeros(1,length(ysc));
    y_plus = zeros(1,length(ysc));
    y_minus = zeros(1,length(ysc));
    for i = 1:length(x)
        x0 = x(i);
        sq_x_x0 = (x - x0).^2;
        idx_in = (sq_x_x0<=R^2);
        K_plus  = ysc(idx_in) + sqrt(R^2 - sq_x_x0(idx_in));
        K_minus = ysc(idx_in) - sqrt(R^2 - sq_x_x0(idx_in));
        y_plus(i)  = max(K_plus);        
        y_minus(i) = min(K_minus);
    end
    
    for i = 1:length(x)
        x0 = x(i);
        sq_x_x0 = (x - x0).^2;
        idx_in = (sq_x_x0<=R^2);
        K_minus = y_plus(idx_in) - sqrt(R^2 - sq_x_x0(idx_in));
        K_plus  = y_minus(idx_in) + sqrt(R^2 - sq_x_x0(idx_in));
        y_top(i) = min(K_minus);    
        y_bot(i) = max(K_plus); 
   
    end
    y_top = ((max(y)-min(y))*y_top/max(x))+ min(y);
    y_bot = ((max(y)-min(y))*y_bot/max(x))+ min(y);
    y_filt = (y_top + y_bot)/2;


end