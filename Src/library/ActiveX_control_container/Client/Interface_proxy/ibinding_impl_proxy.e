indexing
	description: "Implemented `IBinding' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IBINDING_IMPL_PROXY

inherit
	IBINDING_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ibinding_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	abort is
			-- No description available.
		do
			ccom_abort (initializer)
		end

	suspend is
			-- No description available.
		do
			ccom_suspend (initializer)
		end

	resume is
			-- No description available.
		do
			ccom_resume (initializer)
		end

	set_priority (n_priority: INTEGER) is
			-- No description available.
			-- `n_priority' [in].  
		do
			ccom_set_priority (initializer, n_priority)
		end

	get_priority (pn_priority: INTEGER_REF) is
			-- No description available.
			-- `pn_priority' [out].  
		do
			ccom_get_priority (initializer, pn_priority)
		end

	get_bind_result (pclsid_protocol: ECOM_GUID; pdw_result: INTEGER_REF; psz_result: CELL [STRING]; dw_reserved: INTEGER) is
			-- No description available.
			-- `pclsid_protocol' [out].  
			-- `pdw_result' [out].  
			-- `psz_result' [out].  
			-- `dw_reserved' [in].  
		do
			ccom_get_bind_result (initializer, pclsid_protocol.item, pdw_result, psz_result, dw_reserved)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ibinding_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_abort (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"]()"
		end

	ccom_suspend (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"]()"
		end

	ccom_resume (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"]()"
		end

	ccom_set_priority (cpp_obj: POINTER; n_priority: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_get_priority (cpp_obj: POINTER; pn_priority: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_get_bind_result (cpp_obj: POINTER; pclsid_protocol: POINTER; pdw_result: INTEGER_REF; psz_result: CELL [STRING]; dw_reserved: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"](GUID *,EIF_OBJECT,EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_delete_ibinding_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"]()"
		end

	ccom_create_ibinding_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IBinding_impl_proxy %"ecom_control_library_IBinding_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IBINDING_IMPL_PROXY

