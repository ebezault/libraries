indexing
	description:
		"Table column storing date strings"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DATE_COLUMN inherit

	TEST_DATA_COLUMN
		redefine
			test_case
		end

feature {NONE} -- Implementation

	test_case: VALIDITY_TEST
			-- Test case to be injected

	inject_data (s: STRING) is
			-- Inject `s' into `test_case'
		do
			test_case.set_date_string (s)
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

end -- class DATE_COLUMN
