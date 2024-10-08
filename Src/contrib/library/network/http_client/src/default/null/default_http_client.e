note
	description: "[
			Default HTTP_CLIENT based on NULL_HTTP_CLIENT.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_HTTP_CLIENT

inherit
	HTTP_CLIENT

	DEFAULT_HTTP_CLIENT_I

feature -- Access

	new_session (a_base_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
			-- Create a new session using `a_base_url'.
		do
			create {NULL_HTTP_CLIENT_SESSION} Result.make (a_base_url)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
