note
	description: "Implemented `IPersist' interface."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IPERSIST_IMPL_STUB

inherit
	IPERSIST_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID)
			-- `p_class_id' [out].  
		do
			-- Put Implementation here.
		end

	create_item
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IPERSIST_IMPL_STUB): POINTER
			-- Initialize `item'
		external
			"C++ [new ecom_MS_TaskSched_lib::IPersist_impl_stub %"ecom_MS_TaskSched_lib_IPersist_impl_stub.h%"](EIF_OBJECT)"
		end

end -- IPERSIST_IMPL_STUB


