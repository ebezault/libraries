indexing
	description: "Eiffel Vision list. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_I
	
inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- `Result is all items currently selected in `Current'.
		local
			original_position: INTEGER
		do
			original_position := interface.index
			create Result.make(2)
			from
				interface.start
			until
				interface.off
			loop
				if interface.item.is_selected then
					Result.extend (interface.item)
				end
				interface.forth
			end
			interface.go_i_th (original_position)
		end

feature -- Status report

	ensure_item_visible (an_item: EV_LIST_ITEM) is
			-- Ensure item `an_item' is visible in `Current'.
		deferred
		end

	multiple_selection_enabled: BOOLEAN is
			-- Can more than one item be selected?
		deferred
		end

feature -- Status setting

	enable_multiple_selection is
			-- Allow multiple items to be selected.
		deferred
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		deferred
		end
	
feature {EV_LIST_I, EV_LIST_ITEM_IMP} -- Implementation

	interface: EV_LIST

end -- class EV_LIST_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

