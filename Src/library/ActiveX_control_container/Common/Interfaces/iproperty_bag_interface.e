indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPROPERTY_BAG_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	read_user_precondition (psz_prop_name: STRING; p_var: ECOM_VARIANT; p_error_log: IERROR_LOG_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `read'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	write_user_precondition (psz_prop_name: STRING; p_var: ECOM_VARIANT): BOOLEAN is
			-- User-defined preconditions for `write'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	read (psz_prop_name: STRING; p_var: ECOM_VARIANT; p_error_log: IERROR_LOG_INTERFACE) is
			-- No description available.
			-- `psz_prop_name' [in].  
			-- `p_var' [out].  
			-- `p_error_log' [in].  
		require
			non_void_p_var: p_var /= Void
			valid_p_var: p_var.item /= default_pointer
			read_user_precondition: read_user_precondition (psz_prop_name, p_var, p_error_log)
		deferred

		end

	write (psz_prop_name: STRING; p_var: ECOM_VARIANT) is
			-- No description available.
			-- `psz_prop_name' [in].  
			-- `p_var' [in].  
		require
			non_void_p_var: p_var /= Void
			valid_p_var: p_var.item /= default_pointer
			write_user_precondition: write_user_precondition (psz_prop_name, p_var)
		deferred

		end

end -- IPROPERTY_BAG_INTERFACE

