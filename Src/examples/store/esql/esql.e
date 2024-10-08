note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ESQL

inherit
	RDB_HANDLE

	ACTION
		redefine
			execute, start
		end

create
	make

feature {NONE}

	Stringlength: INTEGER = 80

	base_selection: DB_SELECTION

feature {NONE} -- Initialization

	make
			-- Start SQL_MONITOR
		local
			session_control: DB_CONTROL
			base_update: DB_CHANGE
			tmp_string: detachable STRING
			l_laststring, l_name: detachable STRING
			l_database: like session_database
		do
			io.putstring ("Database user authentication:%N")
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				io.putstring ("Data Source Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_data_source(l_laststring.twin)
 			end

				-- Ask for user's name and password
			io.putstring ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			tmp_string := l_laststring.twin
			io.putstring ("Password: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
				-- Set user's name and password
			login (tmp_string, l_laststring)

				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- Connection to the Relational database
			set_base

				-- Create usefull classes
				-- 'session_control' provides informations control access and
				--  the status of the database.
				-- 'base_selection' provides a SELECT query mechanism.
				-- 'base_update' provides updating facilities.
			create session_control.make
			create base_selection.make
			create base_update.make

				-- Start session
			session_control.connect

			if not session_control.is_connected then
					-- Something went wrong, and the connection failed
				session_control.raise_error
				tmp_string.wipe_out
				tmp_string.append ("exit")
			else
					--  The Eiffel program is now connected to the database
				io.putstring ("%NWelcome to the SQL interpreter%N")
				io.putstring ("Database used: ")
				l_database := session_database
				check l_database /= Void end -- FIXME: implied by `session_control'.is_connected?
				l_name := l_database.name
				check l_name /= Void end -- FIXME: implied by `session_control'.is_connected?
				io.putstring (l_name)
				io.putstring ("%N%TType 'exit' to terminate%N%N")

					-- Set action to be executed after each 'load_result' iteration step.
					-- 'init' and 'execute' method of the current class are to be used.
				base_selection.set_action (Current)

					-- Main loop of the monitor
				from
				until
						-- Terminate?
					tmp_string.is_equal ("exit") or
					io.input.end_of_file
				loop
					read_order
					if io.input.end_of_file then
						tmp_string := "exit"
					else
						tmp_string := io.laststring
					end
					check tmp_string /= Void end -- implied by previous if clause and `read_order' postcondition
					if is_select_statement (tmp_string) then
							-- The query is a SELECT, so we have to use
							-- DB_SELECTION.query
						base_selection.query (tmp_string)
						if session_control.is_ok then
								-- Iterate through resulting data,
								-- and display them
							base_selection.load_result
						else
							manage_errors_and_warnings (session_control)
						end
						base_selection.terminate
					elseif not tmp_string.is_equal ("exit") then
							-- The user updates the database
						base_update.modify (tmp_string)
					end
					manage_errors_and_warnings (session_control)
				end
					-- Terminate session
				session_control.disconnect
			end
		end

feature {NONE}

	manage_errors_and_warnings (session_control: DB_CONTROL)
			-- Manage errors and warnings that may have
			-- occurred during last operation.
		do
			if not session_control.is_ok then
					-- There was an error!
				session_control.raise_error
				session_control.reset
				io.new_line
			else
				if session_control.warning_message_32.count /= 0 then
					io.putstring (session_control.warning_message_32)
					io.new_line
				end
			end
		end

	read_order
			-- Get statement from standard input
		do
			io.putstring ("SQL> ")
			io.readline
		end

	seq_string: SEQ_STRING
		once
			create Result.make (Stringlength)
		end

	is_select_statement(st: STRING): BOOLEAN
			-- Is 'st' a select statement?
		require
			st_not_void: st /= Void
		do
			st.left_adjust
			if st.count /= 0 then
				seq_string.wipe_out
				seq_string.append (st)
				seq_string.start
				seq_string.search_string_after ("select", 0)
				Result := not seq_string.off
				if seq_string.off then
					seq_string.wipe_out
					seq_string.append (st)
					seq_string.to_lower
					seq_string.start
					seq_string.search_string_after ("sql", 0)
					Result := not seq_string.off
					if seq_string.off then
						Result := st.substring(1,1).is_equal("{")
					end
				end
			end
		end

	start
			-- This method is used by the class DB_SELECTION, and is executed after the first
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
			-- In this example, it simply prompts column name on standard output.
		local
			i: INTEGER
			tuple: DB_TUPLE
			l_cursor: detachable DB_RESULT
		do
			from
				i := 1
				l_cursor := base_selection.cursor
				check l_cursor /= Void end -- FIXME: implied by ?
				create tuple.copy (l_cursor)
				io.new_line
			until
				i > tuple.count
			loop
				io.putstring (tuple.column_name (i))
				io.putchar ('%T')
				i := i + 1
			end
			io.new_line
		end

	execute
			-- This method is also  used by the class DB_SELECTION, and is executed after each
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
			-- In this example, it simply prompts column name on standard output.
			-- Prompt column values on standard output.
		local
			i: INTEGER
			r_int: INTEGER_REF
			r_real: REAL_REF
			r_double: DOUBLE_REF
			tuple: DB_TUPLE
			r_any: detachable ANY
			l_cursor: detachable DB_RESULT
		do
			from
				i := 1
				l_cursor := base_selection.cursor
				check l_cursor /= Void end -- FIXME: implied by ...?
				create tuple.copy (l_cursor)
				create r_int
				create r_real
				create r_double
			until
				i > tuple.count
			loop
				r_any := tuple.item (i)
				if r_any /= Void then
					if attached {INTEGER_REF} r_any as l_r_int then
						r_int := l_r_int
						io.putint (r_int.item)
					elseif attached {REAL_REF} r_any as l_r_real then
						r_real := l_r_real
						io.putreal (r_real.item)
					elseif attached {DOUBLE_REF} r_any as l_r_double then
						r_double := l_r_double
						io.putdouble (r_double.item)
					else
						io.putstring (r_any.out)
					end
				else
					io.putstring("*void*")
				end
				io.putstring (" %T")
				i := i + 1
			end
			io.new_line
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
