--| FIXME Not for release
indexing
	description: 
	"EiffelVision scrollable text area. To query multiple lines of text from the user."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_TEXT

inherit
	EV_TEXT
		rename
			make as old_make,
			make_with_text as old_make_with_text
		export
			{None} old_make, old_make_with_text
		redefine
			implementation
		end
	
create
	make,
	make_with_text,
	make_horizontally_scrollable,
	make_vertically_scrollable,
	make_horizontally_scrollable_with_text,
	make_vertically_scrollable_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty scrollable text area with `par' as parent.
			-- Scrollable in both directions.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
			-- Scrollable in both directions.
		do
			!EV_SCROLLABLE_TEXT_IMP!implementation.make_with_properties (txt, True, True)
			widget_make (par)
		end

	make_horizontally_scrollable (par: EV_CONTAINER) is
			-- Create a scrollable text area with `par' as a parent
			-- and only horizontally scrollable.
		do
			make_horizontally_scrollable_with_text (par, "")
		end

	make_vertically_scrollable (par: EV_CONTAINER) is
			-- Create a scrollable text area with `par' as a parent
			-- and only vertical scrollable.
		do
			make_vertically_scrollable_with_text (par, "")
		end

	make_horizontally_scrollable_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a scrollable text area with `par' as a parent,
			-- `txt' as text and only horizontally scrollable.
		do
			!EV_SCROLLABLE_TEXT_IMP!implementation.make_with_properties (txt, True, False)
			widget_make (par)
		end

	make_vertically_scrollable_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a scrollable text area with `par' as a parent,
			-- `txt' as text and only vertical scrollable.
		do
			!EV_SCROLLABLE_TEXT_IMP!implementation.make_with_properties (txt, False, True)
			widget_make (par)
		end

feature -- Status Report
	
	horizontal_scroll_bar_visible: BOOLEAN is
			-- True if horizontal scroll bar shown.
		do
			Result := implementation.horizontal_scroll_bar_visible
		end
	
	vertical_scroll_bar_visible: BOOLEAN is
			-- True if vertical scroll bar shown.
		do
			Result := implementation.vertical_scroll_bar_visible
		end

	has_horizontal_scrolling: BOOLEAN is
			-- True if can be scrolled horizontally.
		do
			Result := implementation.has_horizontal_scrolling
		end

	has_vertical_scrolling: BOOLEAN is
			-- True if can be scrolled vertically.
		do
			Result := implementation.has_vertical_scrolling
		end

feature -- Status Settings

	show_horizontal_scroll_bar is
			-- Show horizontal scroll bar.
		require
			horizontal_scrolling_enabled: has_horizontal_scrolling
		do
			implementation.show_horizontal_scroll_bar
		end

	show_vertical_scroll_bar is
			-- Show vertical scroll bar.
		require
			vertical_scrolling_enabled: has_vertical_scrolling
		do
			implementation.show_vertical_scroll_bar
		end

	hide_horizontal_scroll_bar is
			-- Hide horizontal scroll bar.
		require
			horizontal_scrolling_enabled: has_horizontal_scrolling
		do
			implementation.hide_horizontal_scroll_bar
		end

	hide_vertical_scroll_bar is
			-- Hide vertical scroll bar.
		require
			vertical_scrolling_enabled: has_vertical_scrolling
		do
			implementation.hide_vertical_scroll_bar
		end

feature {NONE} -- Implementation

	implementation: EV_SCROLLABLE_TEXT_I
			-- Implementation 
			
end -- class EV_SCROLLABLE_TEXT

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
