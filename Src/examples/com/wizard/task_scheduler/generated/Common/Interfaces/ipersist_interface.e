note
	description: "Task Scheduler."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPERSIST_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID)
			-- `p_class_id' [out].  
		require
			attached_p_class_id: p_class_id /= Void
			valid_p_class_id: p_class_id.item /= default_pointer
		deferred

		end

end -- IPERSIST_INTERFACE


