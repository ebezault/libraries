indexing

	description: 	
		"EiffelVision implementation of a Motif check box.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CHECK_BOX_M 

inherit

	CHECK_BOX_I;

	MANAGER_M
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_CHECK_BOX
		rename
			make as mel_check_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			is_shown as shown
		end


creation

	make

feature {NONE} -- Initialization

	make (a_check_box: CHECK_BOX; man: BOOLEAN) is
			-- Create a motif check_box.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_check_make (a_check_box.identifier,
					mel_parent (a_check_box, widget_index),
					man);
		end

end -- class CHECK_BOX_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
