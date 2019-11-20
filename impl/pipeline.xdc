# actual clk source
create_clock -period 30.000 -name clk -waveform {0.000 15.000} [get_ports clk]

#create_clock -period 30.000 -name clk
set_input_delay -clock [get_clocks clk] -min -add_delay 0.100 [get_ports {a[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 0.100 [get_ports {a[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 0.100 [get_ports {b[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 0.100 [get_ports {b[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 0.100 [get_ports {c[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 0.100 [get_ports {c[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 0.100 [get_ports {d[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 0.100 [get_ports {d[*]}]

set_output_delay -clock [get_clocks clk] -min -add_delay 0.100 [get_ports {x[*]}]
set_output_delay -clock [get_clocks clk] -max -add_delay 0.100 [get_ports {x[*]}]
