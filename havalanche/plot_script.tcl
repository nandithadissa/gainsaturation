load_file /home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-123022/light_10.plt
load_file /home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-123022/light_100.plt
load_file /home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-123022/light_1.plt
load_file /home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-123022/light_p1.plt
load_file /home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-123022/dark.plt
create_plot -1d
create_curve -plot Plot_1 -dataset dark -axisX {drain OuterVoltage} -axisY {drain TotalCurrent}
create_curve -plot Plot_1 -dataset light_p1 -axisX {drain OuterVoltage} -axisY {drain TotalCurrent}
create_curve -plot Plot_1 -dataset light_1 -axisX {drain OuterVoltage} -axisY {drain TotalCurrent}
create_curve -plot Plot_1 -dataset light_10 -axisX {drain OuterVoltage} -axisY {drain TotalCurrent}
create_curve -plot Plot_1 -dataset light_100 -axisX {drain OuterVoltage} -axisY {drain TotalCurrent}
set_plot_prop -plot Plot_1 -show_grid
create_curve -plot Plot_1 -name net_p1 -function abs(<Curve_2>-<Curve_1>)
create_curve -plot Plot_1 -name net_1 -function abs(<Curve_3>-<Curve_1>)
create_curve -plot Plot_1 -name net_10 -function abs(<Curve_4>-<Curve_1>)
create_curve -plot Plot_1 -name net_100 -function abs(<Curve_5>-<Curve_1>)
remove_curves -plot Plot_1 {Curve_1 Curve_2 Curve_4 Curve_3 Curve_5}
set_axis_prop -plot Plot_1 -axis y -type log
export_view /home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-123022/010423-tapered.png -plots Plot_1 -format png
