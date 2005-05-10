indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		GTK implementation.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_IMP
	
inherit
	EV_CELL_IMP
		rename
			item as cell_item
		undefine
			drop_actions
		redefine
			interface,
			initialize,
			make,
			needs_event_box,
			set_background_color,
			set_foreground_color
		end
	
	EV_GRID_I
		undefine
			propagate_background_color,
			propagate_foreground_color
		redefine
			interface,
			initialize
		end
		
create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create grid
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
		end

	initialize is
			-- Initialize `Current'
		do
			Precursor {EV_CELL_IMP}
			initialize_grid
			is_initialized := True
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end

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
