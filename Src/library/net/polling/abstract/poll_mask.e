indexing

	description:
		"A mask for use with a medium poller.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class POLL_MASK

inherit

	TO_SPECIAL [CHARACTER] 
		rename
			area as mask,
			make_area as make_mask
		redefine
			copy, is_equal
		select
			copy
		end

	TO_SPECIAL [CHARACTER] 
		rename
			area as mask,
			make_area as make_mask,
			copy as old_copy
		redefine
			is_equal
		end

creation

	make

feature -- Initialization

	make is
			-- Create a mask
		do
			make_mask (mask_size)
			clear
		end

feature -- Measurement

	count: INTEGER is
			-- size of mask in bytes
		do
			Result := mask.count
		end

feature -- Comparison

	is_equal (other: like Current ): BOOLEAN is
		do
			Result := mask.is_equal (other.mask)
		end

feature -- Status report

	is_medium_ready (s: IO_MEDIUM): BOOLEAN is
			-- is the bit identified by the medium handle set
		require
			valid_medium: s /= Void and then not s.is_closed
		do
			Result := c_is_bit_set ($mask, s.handle)
		end

	is_bit_set (b: INTEGER): BOOLEAN is
			-- is the bit identified by b set
		do
			Result := c_is_bit_set ($mask, b)
		end

feature -- Status setting

	clear is
			-- Blank out all bits in mask
		do
			c_zero_mask ($mask)
		end

	clear_bit (b: INTEGER) is
			-- clear bit at position b in mask
		do
			c_mask_clear ($mask, b)
		ensure
			has_cleared: not is_bit_set (b)
		end

	clear_medium (s: IO_MEDIUM) is
			-- clear bit at position, decided by medium handle, in mask
		require
			valid_medium: s /= Void and then not s.is_closed
		do
			c_mask_clear ($mask, s.handle)
		ensure
			has_cleared: not is_bit_set (s.handle)
		end

	set_medium (s: IO_MEDIUM) is
			-- set bit at position, decided by medium handle, in mask
		require
			valid_medium: s /= Void and then not s.is_closed
		do
			c_set_bit ($mask, s.handle)
		ensure
			has_set: is_bit_set (s.handle)
		end

	set_bit (b: INTEGER) is
			-- set bit at position b in mask
		do
			c_set_bit ($mask, b)
		ensure
			has_set: is_bit_set (b)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		do
			old_copy (other)
			make_mask (other.count)
			mask.copy (other.mask)
		ensure then
			size_valid: count = other.count or else count = mask_size
		end

feature {NONE} -- External

	mask_size: INTEGER is
			-- get the size of the poll mask in number of characters
		external
			"C"
		end

	c_mask_clear (a_mask: POINTER; pos: INTEGER) is
			--clear the bit in the mask located at pos
		external
			"C"
		end

	c_set_bit (a_mask: POINTER; pos: INTEGER) is
			-- set the bit in the mask located at pos
		external
			"C"
		end

	c_is_bit_set (a_mask: POINTER; pos: INTEGER): BOOLEAN is
			-- is  the bit  in the mask located at pos set
		external
			"C"
		end

	c_zero_mask (a_mask: POINTER) is
			-- zero total mask area
		external
			"C"
		end

end -- class POLL_MASK

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

