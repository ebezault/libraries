indexing
	description: "Interface wrapper"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_INTERFACE

inherit
	ECOM_WRAPPER
		rename
			item as interface,
			delete_wrapper as release_interface
		end

	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end

end -- class ECOM_INTERFACE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

