indexing

	description:
		"General finite-state automata, implemented by arrays";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FIXED_AUTOMATON [S->STATE] inherit

	ARRAY [S]
		rename
			make as array_make
		export
			{ANY} lower, upper, item, put
		end

creation
	make

feature -- Initialization

	make (i, s: INTEGER) is
			-- Make an automaton including at most s states,
			-- with transition 0 to i.
		require
			s_large_enough: s > 0;
			i_large_enough: i >= 0
		do
			array_make (1, s);
		end; 

feature -- Access

	last_position: INTEGER;
			-- Position of last state inserted

feature -- Status setting

	set_final (state, f: INTEGER) is
			-- Make `state' `final' for regular expression `f'.
		require
			is_in_automaton: state <= upper and state >= lower
		do
			item (state).set_final (f)
		end;

feature -- Element change

	add_right (s: S) is
			-- Assign `s' to the first possible item.
		require
			not_full: last_position < count
		do
			last_position := last_position + 1;
			put (s, last_position)
		end; 

end -- class FIXED_AUTOMATON
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
