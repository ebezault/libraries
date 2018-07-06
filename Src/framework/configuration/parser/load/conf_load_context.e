note
	description: "Summary description for {CONF_LOAD_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_CONTEXT

create
	make

feature {NONE} -- Initialization

	make
		do
			create redirections.make (0)
		end

feature -- Access: Redirection

	redirections: ARRAYED_LIST [PATH]

feature -- Element change

	record_redirection (p: PATH)
		do
			redirections.force (p)
		end

feature -- Access: parent target

	targets: detachable ARRAYED_LIST [CONF_TARGET]
			-- structure containing current processed target, and eventual parents.

	has_target (tgt: CONF_TARGET): BOOLEAN
		do
			if attached targets as lst then
				Result := across lst as ic some tgt.same_as (ic.item)  end
			end
		end

feature -- Element change

	enter_target (t: CONF_TARGET)
		local
			lst: like targets
		do
			lst := targets
			if lst = Void then
				create lst.make (1)
				targets := lst
			end
			lst.force (t)
		end

	leave_target (t: CONF_TARGET)
		local
			lst: like targets
		do
			lst := targets
			if
				lst /= Void and then
				lst.last = t
			then
				lst.finish
				lst.remove
				if lst.is_empty then
					targets := Void
				end
			else
				check is_created: False end
			end
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end