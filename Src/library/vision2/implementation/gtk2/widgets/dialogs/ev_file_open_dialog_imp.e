indexing 
	description: "Eiffel Vision file open dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_OPEN_DIALOG_IMP

inherit
	EV_FILE_OPEN_DIALOG_I
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			set_title ("Open")
		end


	multiple_selection_enabled: BOOLEAN

	file_names: ARRAYED_LIST [STRING]

	enable_multiple_selection is do end

	disable_multiple_selection is do end

feature {NONE} -- Implementation

	file_chooser_action: INTEGER is
			-- Action constant of the file chooser, ie: to open or save files, etc.
		do
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_action_open_enum
		end

	interface: EV_FILE_OPEN_DIALOG

end -- class EV_FILE_OPEN_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

