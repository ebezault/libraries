note
	description: "[
		Special implementation of a XP_TAG_ELEMENT. Makes sure include calls are resolved with the proper
		template.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_INCLUDE_TAG_ELEMENT

inherit
	XP_TAG_ELEMENT
		redefine
			accept,
			resolve_all_dependencies,
			copy_self
		end
	ERROR_SHARED_MULTI_ERROR_MANAGER
		undefine
			out
		end

create
	make

feature -- Initialization

feature -- Access

	copy_self: XP_TAG_ELEMENT
		do
			create {XP_INCLUDE_TAG_ELEMENT} Result.make (namespace, id, class_name, debug_information)
		end

	resolve_all_dependencies (a_templates: HASH_TABLE [XP_TEMPLATE, STRING]; a_pending: LIST [PROCEDURE [ANY, TUPLE [a_uid: STRING; a_controller_class: STRING]]]; a_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR; a_regions: HASH_TABLE [LIST[XP_TAG_ELEMENT], STRING])
			-- Precursor
		local
			l_child: XP_TAG_ELEMENT
			l_region: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING]
			l_template: XP_TEMPLATE
		do
			from
				children.start
				create l_region.make (10)
				l_region.merge (a_regions)
			until
				children.after
			loop
				l_child := children.item
				if l_child.id.is_equal ("define_region") then
						-- We have found a region so we can put the tag tree at the appropriate position
					l_region [l_child.retrieve_value ("id").value (controller_id)] := l_child.children
				end
				children.forth
			end
				-- Set the child of current to the resolved template (i.e. replace all the regions by the found regions)
			l_template := a_templates [retrieve_value ("template").value (controller_id)]
			if attached l_template then
				set_child (l_template.resolve (a_templates, l_region, a_pending, a_servlet_gen))
				if date < children [1].date then
					date := children [1].date
				end
			else
				error_manager.add_error (create {XERROR_PARSE}.make
					(["Template '" + retrieve_value ("template").value (controller_id) + "' not found."]), False)
			end
		end

	accept (visitor: XP_TAG_ELEMENT_VISITOR)
			-- Element part of the Visitor Pattern
		do
			visitor.visit_include_tag_element (Current)
			accept_children (visitor)
		end

end
