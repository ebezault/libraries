﻿note
	description: "[
		The Windows implementation of the dynamic API loader {DYNAMIC_API_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DYNAMIC_API_LOADER

inherit
	DYNAMIC_API_LOADER_I

feature -- Status report

	is_dynamic_library_supported: BOOLEAN = True
			-- <Precursor>

feature -- Query

	api_pointer (a_hnd: POINTER; a_api_name: READABLE_STRING_8): POINTER
			-- <Precursor>
		local
			l_name: C_STRING
		do
			create l_name.make (a_api_name)
			Result := c_get_proc_address (a_hnd, l_name.item)
		end

feature -- Basic operations

	load_library (a_name: READABLE_STRING_32; a_version: detachable READABLE_STRING_32): POINTER
			-- <Precursor>
		local
			l_fn: PATH
			l_dll_fn: PATH
		do
			create l_fn.make_from_string (if attached a_version then a_name + a_version else a_name end)
			l_dll_fn := l_fn.twin
			l_dll_fn := l_dll_fn.appended_with_extension (once "dll")
			Result := load_library_from_path (l_dll_fn.utf_8_name)
			if Result = default_pointer then
					-- No DLL found, attempt EXE
				l_fn := l_fn.appended_with_extension (once "exe")
				Result := load_library_from_path (l_fn.utf_8_name)
				if Result = default_pointer and a_version /= Void then
						-- Use an unversioned library, because Windows libraries typically do not
						-- have a version number.
					Result := load_library (a_name, Void)
				end
			end
		end

	load_library_from_path (a_path: READABLE_STRING_32): POINTER
			-- <Precursor>
		local
			l_path: C_STRING
		do
			create l_path.make (a_path)
			Result := c_load_library (l_path.item)
		end

	unload_library (a_hnd: POINTER)
			-- <Precursor>
		local
			l_result: BOOLEAN
		do
			l_result := c_free_library (a_hnd)
			check
				library_freed: l_result
			end
		end

feature {NONE} -- Externals

	c_load_library (a_path: POINTER): POINTER
			-- The LoadLibrary function maps the specified executable module into the address space of the calling process.
			--
			-- `a_path': Pointer to a null-terminated string that names the executable module (either a .dll or .exe file)
			-- `Result': If the function succeeds, the return value is a handle to the module.
		require
			not_a_path_is_null: a_path /= default_pointer
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) LoadLibraryA ((LPCSTR)$a_path);"
		end

	c_get_proc_address (a_hnd: POINTER; a_api_name: POINTER): POINTER
			-- The GetProcAddress function retrieves the address of an exported function or variable from the specified dynamic-link library (DLL).
			--
			-- `a_hnd': Handle to the DLL module that contains the function or variable.
			-- `a_api_name': Pointer to a null-terminated string that specifies the function or variable name, or the function's ordinal value.
			-- `Result': If the function succeeds, the return value is the address of the exported function or variable.
		require
			not_a_hnd_is_null: a_hnd /= default_pointer
			not_a_api_name_is_null: a_api_name /= default_pointer
		external
			"C inline use <windows.h>"
		alias
			"return GetProcAddress ((HMODULE) $a_hnd, (LPCSTR)$a_api_name);"
		end

	c_free_library (a_hnd: POINTER): BOOLEAN
			-- The FreeLibrary function decrements the reference count of the loaded dynamic-link library
			-- (DLL). When the reference count reaches zero, the module is unmapped from the address space
			-- of the calling process and the handle is no longer valid.
			--
			-- `a_hnd': Handle to the loaded DLL module.
			-- `Result': True if the free succeeds, False otherwise.
		require
			not_a_hnd_is_null: a_hnd /= default_pointer
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_BOOLEAN) FreeLibrary ((HMODULE)$a_hnd);"
		end

;note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
