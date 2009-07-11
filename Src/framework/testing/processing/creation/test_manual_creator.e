note
	description: "[
		Implementation of {TEST_CREATOR_I} creating manual test classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MANUAL_CREATOR

inherit
	TEST_MANUAL_CREATOR_I

	TEST_CREATOR

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {TEST_PROCESSOR_SCHEDULER_I} -- Status report

	sleep_time: NATURAL = 0
			-- <Precursor>

feature {NONE} -- Status report

	is_creating_new_class: BOOLEAN
			-- <Precursor>
		do
			Result := configuration.is_new_class
		end

feature {NONE} -- Basic operations

	proceed_process
			-- <Precursor>
		do
			if configuration.is_new_class then
				create_new_class
			end
			is_finished := True
		end

	print_new_class (a_file: KL_TEXT_OUTPUT_FILE; a_class_name: STRING)
			-- Create test routine in new class
		do
			a_file.close
			render_class_text (a_file.name)
		end

	render_class_text (a_file_name: STRING)
			-- Render test class text from default template to file.
			--
			-- `a_file_name': Name of file to which class text will be rendered.
		require
			a_file_name_not_empty: a_file_name /= Void and then not a_file_name.is_empty
			a_file_name_createable: (create {RAW_FILE}.make (a_file_name)).is_creatable
		local
			l_retried: BOOLEAN
			l_template, l_user_template: FILE_NAME
			l_wizard: SERVICE_CONSUMER [WIZARD_ENGINE_S]
		do
			if not l_retried then
				create l_template.make_from_string (eiffel_layout.templates_path)
				l_template.extend ("defaults")
				l_template.set_file_name ("test.e.tpl")
				l_user_template := eiffel_layout.user_priority_file_name (l_template, True)
				if l_user_template /= Void then
					l_template := l_user_template
				end
				if (create {RAW_FILE}.make (l_template)).exists then
					create l_wizard
					if l_wizard.is_service_available then
						l_wizard.service.render_template_from_file_to_file (l_template, template_parameters, a_file_name)
					else
						test_suite.propagate_error (w_wizard_service_not_available, [], Current)
					end
				else
					test_suite.propagate_error (w_template_file, [l_template], Current)
				end
			end
		rescue
			l_retried := True
			retry
		end

	template_parameters: DS_HASH_TABLE [STRING, STRING]
			-- Template parameters for creating actual class text from template file.
		local
			l_redefine, l_body, l_indexing, l_name: STRING
			l_cursor: DS_LINEAR_CURSOR [STRING]
			l_count: INTEGER
			l_tags: DS_LINEAR [STRING]
		do
			create Result.make_default
			if configuration.cluster.options.syntax.index = {CONF_OPTION}.syntax_index_obsolete then
					-- Use old syntax
				Result.force_last ({EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword, v_note_keyword)
			else
					-- Use new syntax
				Result.force_last ({EIFFEL_KEYWORD_CONSTANTS}.note_keyword, v_note_keyword)
			end
			l_name := configuration.new_class_name
			Result.force_last (l_name, v_class_name)
			if False then--configuration.is_system_level_test then
					-- TODO: switch to system level tests
				Result.force_last (test_set_ancestor, v_test_set_ancestor)
			else
				Result.force_last (test_set_ancestor, v_test_set_ancestor)
			end
			if configuration.has_prepare or configuration.has_clean then
				create l_body.make (100)
				l_body.append ("%N%T%T%T-- <Precursor>%N")
				l_body.append ("%T%Tdo%N")
				l_body.append ("%T%T%Tassert (%"not_implemented%", False)%N")
				l_body.append ("%T%Tend%N")
				create l_redefine.make (300)
				l_redefine.append ("%T%Tredefine%N")
				if configuration.has_prepare then
					l_redefine.append ("%T%T%T")
					l_redefine.append ({TEST_CONSTANTS}.prepare_routine_name)
					if configuration.has_clean then
						l_redefine.append (",%N")
					end
				end
				if configuration.has_clean then
					l_redefine.append ("%T%T%T")
					l_redefine.append ({TEST_CONSTANTS}.clean_routine_name)
				end
				l_redefine.append ("%N%T%Tend%N%N")
				l_redefine.append ("feature {NONE} -- Events%N%N")


				if configuration.has_prepare then
					l_redefine.append_character ('%T')
					l_redefine.append ({TEST_CONSTANTS}.prepare_routine_name)
					l_redefine.append (l_body)
					if configuration.has_clean then
						l_redefine.append_character ('%N')
					end
				end
				if configuration.has_clean then
					l_redefine.append_character ('%T')
					l_redefine.append ({TEST_CONSTANTS}.clean_routine_name)
					l_redefine.append (l_body)
				end
				Result.force_last (l_redefine, v_redefine_events)
			end
			Result.force_last (configuration.name, v_test_name)
			l_tags := configuration.tags
			if not l_tags.is_empty then
				create l_indexing.make (100)
				l_indexing.append ("%T%Tindexing%N%T%T%Ttesting: ")
				from
					l_cursor := l_tags.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					l_count := l_count + l_cursor.item.count
					if l_count > 80 then
						l_indexing.append ("%N%T%T%T         ")
						l_count := l_cursor.item.count
					end
					l_indexing.append (" %"")
					l_indexing.append (l_cursor.item)
					l_indexing.append_character ('"')
					l_cursor.forth
					if not l_cursor.after then
						l_indexing.append_character (',')
					else
						l_indexing.append_character ('%N')
					end
				end
				Result.force_last (l_indexing, v_indexing)
			end
		end

feature {NONE} -- Constants

	w_wizard_service_not_available: STRING = "Could not generate class text because wizard service not available."
	w_template_file: STRING = "Template file $1 does not exists."

	v_note_keyword: STRING = "NOTE_KEYWORD"
	v_class_name: STRING = "CLASS_NAME"
	v_test_set_ancestor: STRING = "TEST_SET_ANCESTOR"
	v_redefine_events: STRING = "REDEFINE_EVENTS"
	v_test_name: STRING = "TEST_NAME"
	v_indexing: STRING = "INDEXING"

	test_set_ancestor: STRING
		do
			Result := {TEST_CONSTANTS}.common_test_class_ancestor_name
		end

	system_level_test_ancestor: STRING
		do
			Result := {TEST_CONSTANTS}.system_level_test_ancestor_name
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
