function epsPrinter(filename,h)

set(0,'CurrentFigure',h);
k = 1;

    axes_handle = get(gcf,'CurrentAxes');
    axis(axes_handle,'square');
    set(axes_handle,'FontName','Times New Roman');
    set(axes_handle,'Fontsize',14*k);

    legend_handle = legend(axes_handle);
    xlabel_handle = get(axes_handle,'Xlabel');
    ylabel_handle = get(axes_handle,'Ylabel');
    title_handle = get(axes_handle,'Title');

    set(legend_handle,'FontName','Times New Roman','FontSize',14*k);
    set(xlabel_handle,'FontName','Times New Roman','FontSize',14*k);
    set(ylabel_handle,'FontName','Times New Roman','FontSize',14*k);
    set(title_handle,'FontName','Times New Roman','FontSize',14*k);
%     axes_handle = get(gcf,'CurrentAxes');
%     axis(axes_handle,'square');
%     set(axes_handle,'FontName','Times New Roman');
%     set(axes_handle,'Fontsize',8*k);
% 
%     legend_handle = legend(axes_handle);
%     xlabel_handle = get(axes_handle,'Xlabel');
%     ylabel_handle = get(axes_handle,'Ylabel');
%     title_handle = get(axes_handle,'Title');
% 
%     set(legend_handle,'FontName','Times New Roman','FontSize',9*k);
%     set(xlabel_handle,'FontName','Times New Roman','FontSize',12*k);
%     set(ylabel_handle,'FontName','Times New Roman','FontSize',12*k);
%     set(title_handle,'FontName','Times New Roman','FontSize',12*k);



print(h,'-depsc',filename)

end
