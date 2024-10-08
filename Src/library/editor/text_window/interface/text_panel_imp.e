﻿note
	description: "[
			Implementation for TEXT_PANEL
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_PANEL_IMP

inherit
	TEXT_PANEL_I
	
	TEXT_PANEL_CONSTANTS

feature -- Access

	widget: EV_HORIZONTAL_BOX
		-- `Result' is widget with which `Current' is implemented

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
				-- Create all widgets.
			create main_vbox
			create inner_hbox
			create margin_container
			create editor_viewport
			create editor_drawing_area
			create horizontal_scrollbar
			create scroll_vbox
			create vertical_scrollbar
			create scroll_cell

				-- Build_widget_structure.
			widget.extend (main_vbox)
			main_vbox.extend (inner_hbox)
			inner_hbox.extend (margin_container)
			inner_hbox.extend (editor_viewport)
			editor_viewport.extend (editor_drawing_area)
			editor_viewport.resize_actions.extend (agent (x, y, w, h: INTEGER_32) do editor_drawing_area.redraw end)
			editor_viewport.dpi_changed_actions.extend (agent (dpi: NATURAL_32; x, y, w, h: INTEGER_32) do editor_drawing_area.redraw end)
			main_vbox.extend (horizontal_scrollbar)
			widget.extend (scroll_vbox)
			scroll_vbox.extend (vertical_scrollbar)
			scroll_vbox.extend (scroll_cell)

			main_vbox.disable_item_expand (horizontal_scrollbar)
			inner_hbox.disable_item_expand (margin_container)
			--editor_viewport.set_item_width (10)
			--editor_viewport.set_item_height (10)
			--editor_drawing_area.set_minimum_width (10)
			--editor_drawing_area.set_minimum_height (10)
			horizontal_scrollbar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1))
			horizontal_scrollbar.set_step (5)
			scroll_vbox.disable_item_expand (scroll_cell)
			vertical_scrollbar.disable_sensitive
			vertical_scrollbar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1))
			widget.disable_item_expand (scroll_vbox)

				--Connect events.
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Basic operation

	show
			-- Show `Current'.
		do
			widget.show
		end

feature -- Access

	horizontal_scrollbar: EV_HORIZONTAL_SCROLL_BAR
	vertical_scrollbar: EV_VERTICAL_SCROLL_BAR
	main_vbox: EV_VERTICAL_BOX
	scroll_vbox: EV_VERTICAL_BOX
	inner_hbox: EV_HORIZONTAL_BOX
	margin_container: EV_CELL
	scroll_cell: EV_CELL
	editor_viewport: EV_VIEWPORT
	editor_drawing_area: EV_DRAWING_AREA

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
