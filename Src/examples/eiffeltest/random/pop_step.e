indexing
	description:
		"Pop operation on stack"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class POP_STEP inherit

	TEST_STEP
		redefine
			make
		end

	STACK_ACCESSOR [INTEGER]
		rename 
			make as accessor_make
		export
			{EVALUATOR} all
		undefine
			copy, is_equal
		end
		
create

	make

feature {NONE} -- Initialization

	make is
			-- Create step.
		do
			Precursor
			accessor_make (Current)
		end

feature -- Access

	Name: STRING is "POP"

feature -- Basic operations

	do_test is
			-- Do test action.
		do
			stack.remove
		end;

indexing

	library: "[
			EiffelTest: Library of reusable components for developping unit
			tests.
			]"

	status: "[
			Copyright 2000-2001 Interactive Software Engineering (ISE).
			]"

	license: "[
			EiffelTest may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class POP_STEP
