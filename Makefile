all: prepare_rust compile_rust compile_c memory_usage_rust memory_usage_c

prepare_rust:
	rustc --crate-type cdylib ./merge_sort.rs

compile_rust:
	time gcc -o sort_with_rust sort_with_rust.c -L. -lmerge_sort -Wl,-rpath,.

compile_c:
	time gcc -o sort_with_c sort_with_c.c

memory_usage_rust:
	echo "Memory usage for Rust"
	valgrind ./sort_with_rust

memory_usage_c:
	echo "Memory usage for C"
	valgrind ./sort_with_c