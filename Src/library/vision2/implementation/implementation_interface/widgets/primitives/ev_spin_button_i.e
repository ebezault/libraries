indexing
	description: "Eiffel Vision spin button. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPIN_BUTTON_I

inherit
	EV_GAUGE_I
		redefine
			interface
		end

	EV_TEXT_FIELD_I
		undefine
			set_default_colors
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementatio

	interface: EV_SPIN_BUTTON

end -- class EV_SPIN_BUTTON_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.5  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.2.6.4  2000/02/01 01:41:20  brendel
--| Added undefine of set_default_colors from EV_WIDGET.
--|
--| Revision 1.2.6.3  2000/02/01 01:27:54  brendel
--| Revised.
--|
--| Revision 1.2.6.2  2000/01/27 19:30:05  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:30:13  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
