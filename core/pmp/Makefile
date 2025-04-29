# questa library
library        ?= work
# Top level module to compile
top_level      ?= pmp_tb
# QuestaSim Version
questa_version ?= # -10.7b

compile_flags = +cover -incr -64 -permissive
sim_flags = -t 1ps -debugdb -voptargs="+acc" -do "run -all; quit"
verilate_flags = --binary -j 0 --assert
ignore-warnings = -Wno-TIMESCALEMOD -Wno-fatal
vc_makeshift = +libext+.v+.sv +incdir+src/ +incdir+include/ +incdir+../include/ +incdir+./tb/ +incdir+../../vendor/pulp-platform/common_cells/src/

src = $(wildcard src/*.sv)
inc = $(wildcard include/*.sv) ../include/config_pkg.sv ../../vendor/pulp-platform/common_cells/src/lzc.sv
# incdir := vendor/pulp-platform/common_cells/include/ vendor/pulp-platform/axi/include/ corev_apu/register_interface/include/
# list_incdir := $(foreach dir, ${incdir}, +incdir+$(dir))
# tb = $(wildcard tb/*.sv)
tb = tb/tb_pkg.sv tb/pmp_tb.sv

compile-sim:
	rm -rf ${library}
	vlog${questa_version} -work ${library} ${compile_flags} ${inc}
	vlog${questa_version} -work ${library} ${compile_flags} ${src}
	vlog${questa_version} -work ${library} ${compile_flags} ${tb}

compile-verilate:
	# verilator ${verilate_flags} ${ignore-warnings} --top-module ${top_level} ${list_incdir} ${inc} ${src} ${tb}
	# verilator ${verilate_flags} ${ignore-warnings} ${vc_makeshift} --top-module ${top_level} tb/pmp_tb.sv
	verilator ${verilate_flags} ${ignore-warnings} -f tb.list --top-module ${top_level} tb/pmp_tb.sv

sim: compile-sim
	vsim${questa_version} -c -work ${library} ${sim_flags} ${top_level}

sim-gui:
	rm -rf ${library}
	vlog${questa_version} -work ${library} ${compile_flags} ${src}
	vlog${questa_version} -work ${library} ${compile_flags} ${tb}
	vsim${questa_version} -work ${library} ${sim_flags} ${top_level}

clean:
	@rm -rf obj_dir
	@rm -rf ${library} transcript vsim.dbg vsim.wlf
