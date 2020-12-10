add_library(fpds-conversion-utility INTERFACE)
target_include_directories(fpds-conversion-utility INTERFACE .)

file(GLOB files xsl/* sql/*)
foreach(file ${files})
	get_filename_component(pt ${file} DIRECTORY)
	get_filename_component(fn ${file} NAME)
	get_filename_component(bn ${file} NAME_WLE)
	execute_process(
		COMMAND xxd -i ${fn} ${CMAKE_BINARY_DIR}/include/restyle/${bn}.h
		WORKING_DIRECTORY ${pt}
	)
endforeach()
