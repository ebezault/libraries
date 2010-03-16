-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CGDATA_PROVIDER_SKIP_BYTES_CALLBACK_DISPATCHER

inherit

	ANY

	EWG_CARBON_CALLBACK_C_GLUE_CODE_FUNCTIONS_EXTERNAL
		export {NONE} all end

create

	make

feature {NONE}

	make (a_callback: CGDATA_PROVIDER_SKIP_BYTES_CALLBACK_CALLBACK) is
		require
			a_callback_not_void: a_callback /= Void
		do
			callback := a_callback
			set_cgdata_provider_skip_bytes_callback_entry_external (Current, $on_callback)
		end

feature {ANY}

	callback: CGDATA_PROVIDER_SKIP_BYTES_CALLBACK_CALLBACK

	c_dispatcher: POINTER is
		do
			Result := get_cgdata_provider_skip_bytes_callback_stub_external
		end

feature {NONE} -- Implementation

	frozen on_callback (a_info: POINTER; a_count: INTEGER) is 
		do
			callback.on_callback (a_info, a_count) 
		end

invariant

	 callback_not_void: callback /= Void

end
