indexing
	description: "Implementation of DB_DYN_SELECTION"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_DYN_SELECTION [G -> DATABASE create default_create end]

inherit
	DATABASE_SELECTION [G]
		undefine
			set_map_name, unset_map_name, is_mapped, mapped_value, clear_all,
			replacement_string
		end

	PARAMETER_HDL
		undefine
			out, copy, is_equal
		end

creation

	make

feature

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_statement: s.count > 0
		local
			parsed_s: STRING
			parsed: BOOLEAN
			ArgNum: INTEGER
		do
			sql_string := clone (s)
			s.wipe_out
			s.append (parse (sql_string))
			ArgNum := s.occurrences('?')

			descriptor := db_spec.new_descriptor
			if not db_spec.normal_parse then
				parsed := db_spec.parse (descriptor, ht, handle, s)	
			end
			if not parsed then
				parsed_s := s
				if is_ok then
					handle.status.set (db_spec.init_order (descriptor, parsed_s))
				end
				if is_ok then
					handle.status.set (db_spec.pre_immediate (descriptor, ArgNum))
				end
			end
			set_executed (FALSE)
			set_prepared (TRUE)
		ensure
			prepared_statement: is_prepared
			prepared_statement: not is_executed
		end

	bind_parameter is
			-- Bind of the prarameters of the sql statement 
		require
			prepared_statement: is_prepared
		do
			db_spec.bind_parameter (parameters_value, parameters_value, descriptor, handle, "")	
		end

	execute is
			-- Execute the sql statement
		require
			prepared_statement: is_prepared
		do
			if is_ok then
				handle.status.set (db_spec.unset_catalog_flag(descriptor))
			end
			if is_ok then
				handle.status.set (db_spec.start_order (descriptor))
			end	
			if is_ok then
				handle.status.set (db_spec.result_order (descriptor))
			end
			next
			set_executed (TRUE)
		ensure
			prepared_statement: is_executed
		end

	reset_cursor is
		require
			prepared_statement: is_prepared
		do
			if is_ok then
				handle.status.set (db_spec.close_cursor (descriptor))
			end
		end


feature {NONE} -- Implementation

	sql_string: STRING

end -- class DATABASE_DYN_SELECTION

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
