note
	description: "[
		Mimics a {XTL_TAG_LIBRARY} and provides a hardcoded library for <page:X> tags.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_PAGE_CONF_TAG_LIB

inherit
	XTL_TAG_LIBRARY
		redefine
			create_tag,
			get_class_for_name,
			contains,
			argument_belongs_to_tag
		end

create
	make_with_arguments

feature -- Initialization

	make_with_arguments (a_id: STRING; a_parser_callback: XP_XML_PARSER_CALLBACKS)
			-- `a_id': The id of the tag lib (namespace)
			-- `a_parser_callback': The parser_callback using Current
		require
			a_id_attached: a_id /= Void
			a_parser_callback_attached: a_parser_callback /= Void
		do
			make
			id := a_id
			parser_callback := a_parser_callback
			create {HASH_TABLE [ARRAYED_LIST [STRING], STRING]} allowed_tags.make (5)
			allowed_tags.put (create {ARRAYED_LIST [STRING]}.make (2), "controller")
			allowed_tags.put (create {ARRAYED_LIST [STRING]}.make (2), "declare_region")
			allowed_tags.put (create {ARRAYED_LIST [STRING]}.make (2), "define_region")
			allowed_tags.put (create {ARRAYED_LIST [STRING]}.make (2), "include")
			allowed_tags ["controller"].extend ("class")
			allowed_tags ["declare_region"].extend ("id")
			allowed_tags ["define_region"].extend ("id")
			allowed_tags ["include"].extend ("template")
		ensure
			id_attached: attached id
			parser_callback_attached: attached parser_callback
		end

feature {NONE} -- Access

	parser_callback: XP_XML_PARSER_CALLBACKS
			-- The parser_callback using Current

	allowed_tags: HASH_TABLE [ARRAYED_LIST [STRING], STRING]
			-- All the tag names which are allowed

feature -- Access

	create_tag (a_prefix, a_local_part, a_class_name, a_debug_information: STRING): XP_TAG_ELEMENT
			-- Creates the appropriate XP_TAG_ELEMENT
		require else
			a_prefix_attached: a_prefix /= Void
			a_local_part_attached: attached a_local_part
			a_class_name_attached: a_class_name /= Void
			a_debug_information_attached: a_debug_information /= Void
		do
				-- If you add a tag, please update the 'make' feature
			if a_local_part.is_equal ("controller") then
				create {XP_AGENT_TAG_ELEMENT} Result.make_with_additional_arguments (a_prefix, a_local_part, a_class_name, a_debug_information, agent handle_controller_attribute)
			elseif a_local_part.is_equal ("template") then
				parser_callback.is_template := True
				create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			elseif a_local_part.is_equal ("declare_region") then
				parser_callback.is_template := True
				create {XP_REGION_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			elseif a_local_part.is_equal ("include") then
				create {XP_INCLUDE_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			else
				create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			end
		end

	get_class_for_name (a_name: STRING): STRING
			-- Searches for the class corresponding to
			-- the tag name. If no class is found
			-- the empty string is returned
			-- Yeah, right...
		do
			Result := "XTAG_PAGE_NOOP_TAG"
		end

	argument_belongs_to_tag (a_attribute, a_tag: STRING) : BOOLEAN
			-- Verifies that `a_attribute' belongs to `a_tag'
		do
			Result := False
			if attached allowed_tags [a_tag] as l_attributes then
				from
					l_attributes.start
				until
					l_attributes.after
				loop
					Result := Result or else l_attributes.item.is_equal (a_attribute)
					l_attributes.forth
				end
			end
		end

	contains (a_tag_id: STRING): BOOLEAN
			-- Checks, if the tag is available in the tag library
		do
			Result := attached allowed_tags [a_tag_id]
		end

	handle_controller_attribute (a_id: STRING; a_value: XP_TAG_ARGUMENT)
			-- Handles attribute reading while parsing
		do
			if a_id.is_equal ("class") then
				parser_callback.put_class_name (a_value.value (""))
			end
		end

invariant
	id_attached: attached id
	parser_callback_attached: attached parser_callback

end
