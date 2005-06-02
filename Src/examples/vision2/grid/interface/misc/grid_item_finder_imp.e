indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRID_ITEM_FINDER_IMP

inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_HORIZONTAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create prompt_label
			create pixmap_parent
			create cursor_pixmap
			
				-- Build_widget_structure.
			extend (prompt_label)
			extend (pixmap_parent)
			pixmap_parent.extend (cursor_pixmap)
			
			prompt_label.set_text ("	")
			prompt_label.align_text_left
			pixmap_parent.set_minimum_width (32)
			pixmap_parent.set_minimum_height (32)
			disable_item_expand (prompt_label)
			disable_item_expand (pixmap_parent)
			
				--Connect events.
			cursor_pixmap.pointer_button_press_actions.extend (agent pointer_pressed (?, ?, ?, ?, ?, ?, ?, ?))
			cursor_pixmap.pointer_button_release_actions.extend (agent pointer_released (?, ?, ?, ?, ?, ?, ?, ?))
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	pixmap_parent: EV_CELL
	cursor_pixmap: EV_PIXMAP
	prompt_label: EV_LABEL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	pointer_pressed (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `cursor_pixmap'.
		deferred
		end
	
	pointer_released (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `cursor_pixmap'.
		deferred
		end
	

end -- class GRID_ITEM_FINDER_IMP
