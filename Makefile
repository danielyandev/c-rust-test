export LD_LIBRARY_PATH=.

all: prepare_rust_lib prepare_c_lib \
	compile_c_with_rust_import compile_pure_c compile_rust_with_c_import \
	memory_usage_c_with_rust_import memory_usage_pure_c memory_usage_rust_with_c_import

prepare_rust_lib:
	rustc --crate-type cdylib merge_sort.rs

prepare_c_lib:
	gcc -shared -o libmerge_sort_c.so merge_sort.c

compile_c_with_rust_import:
	time gcc -o sort_c_with_rust_import sort_c_with_rust_import.c -L. -lmerge_sort -Wl,-rpath,.

compile_pure_c:
	time gcc -o sort_pure_c sort_pure_c.c

compile_rust_with_c_import:
	time rustc -o sort_rust_with_c_import sort_rust_with_c_import.rs -L. -lmerge_sort_c

memory_usage_c_with_rust_import:
	@echo "Memory usage for C with Rust import"
	valgrind ./sort_c_with_rust_import

memory_usage_pure_c:
	@echo "Memory usage for pure C"
	valgrind ./sort_pure_c

memory_usage_rust_with_c_import:
	@echo "Memory usage for Rust with C import"
	valgrind ./sort_rust_with_c_import