indexing

	description: 
		"EiffelVision horizontal split."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			make,			
			implementation
		end
	
creation
	make
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a widget with, `par' as parent
		do
			!EV_HORIZONTAL_SPLIT_AREA_IMP!implementation.make
			widget_make (par)
		end	
	
feature {NONE} -- Implementation
	
	implementation: EV_HORIZONTAL_SPLIT_AREA_I
			
end -- class EV_HORIZONTAL_SPLIT_AREA

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

