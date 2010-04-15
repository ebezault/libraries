note
	description: "Summary description for {XML_ELEMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ELEMENT

inherit
	XML_COMPOSITE
		undefine
			debug_output
		end

	XML_NAMED_NODE

	XML_DOCUMENT_NODE
		undefine
			debug_output
		end

create
	make,
	make_last,
	make_root

feature {NONE} -- Initialization

	make (a_name: like name; a_ns: like namespace)
			-- Create a new child element, without attaching to parent.
		require
			a_name_not_void: a_name /= Void
			a_ns_not_void: a_ns /= Void
		do
			name := a_name
			namespace := a_ns
			initialize
		ensure
			name_set: name = a_name
			namespace_set: namespace = a_ns
		end

	make_last (a_parent: XML_ELEMENT; a_name: like name; a_ns: like namespace)
			-- Create a new child element, and add it to the parent.
		require
			a_parent_not_void: a_parent /= Void
			a_name_not_void: a_name /= Void
			a_ns_not_void: a_ns /= Void
		do
			name := a_name
			namespace := a_ns
			initialize
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			name_set: name = a_name
			namespace_set: namespace = a_ns
		end

	make_root (a_parent: XML_DOCUMENT; a_name: like name; a_ns: like namespace)
			-- Create a new root element, and add it to the document parent.
		require
			a_parent_not_void: a_parent /= Void
			a_name_not_void: a_name /= Void
			a_ns_not_void: a_ns /= Void
		do
			name := a_name
			namespace := a_ns
			initialize
			a_parent.set_root_element (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			name_set: name = a_name
			ns_prefix_set: namespace = a_ns
		end

feature -- Status report

	has_attribute_by_qualified_name (a_uri: STRING; a_name: STRING): BOOLEAN
			-- Does current element contain an attribute with
			-- this qualified name?
		require
			a_uri_not_void: a_uri /= Void
			a_name_not_void: a_name /= Void
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result
			loop
				if attached {XML_ATTRIBUTE} elts.item as att and then
					att.has_qualified_name (a_uri, a_name)
				then
					Result := True
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

	has_attribute_by_name (a_name: STRING): BOOLEAN
			-- Does current element contain an attribute named `a_name'?
			-- element?
		require
			a_name_not_void: a_name /= Void
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result
			loop
				if attached {XML_ATTRIBUTE} elts.item as att and then
					attribute_same_name (att, a_name)
				then
					Result := True
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

feature {NONE} -- Name comparison with namespace.

	attribute_same_name (a_named: XML_ATTRIBUTE; a_name: STRING): BOOLEAN
			-- Has 'a_named' attribute the same name as `a_name',
			-- either because of same namespace or within the
			-- default namespace.
		require
			named_not_void: a_named /= Void
		do
			Result := same_string (a_named.name, a_name) and (a_named.namespace.uri.count = 0)
		ensure
			same_name: Result implies same_string (a_named.name, a_name)
			default_ns: (a_named.namespace.uri.count = 0) implies (Result = same_string (a_named.name, a_name))
		end

	named_same_name (a_named: XML_NAMED_NODE; a_name: STRING): BOOLEAN
			-- Has 'a_named' same name as 'a_name' and
			-- same namespace as current node?
		require
			a_named_not_void: a_named /= Void
			a_name_not_void: a_name /= Void
		do
			Result := same_string (a_named.name, a_name) and same_namespace (a_named)
		ensure
			same_name: Result implies same_string (a_named.name, a_name)
		end

feature -- Access (from XM_COMPOSITE)

	has_element_by_name (a_name: STRING): BOOLEAN
			-- Has current node at least one direct child
			-- element with the name `a_name'?
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result
			loop
				if attached {XML_ELEMENT} elts.item as e and then
					named_same_name (e, a_name)
				then
					Result := True
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

	has_element_by_qualified_name (a_uri: STRING; a_name: STRING): BOOLEAN
			-- Has current node at least one direct child
			-- element with this qualified name ?
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result
			loop
				if attached {XML_ELEMENT} elts.item as e and then
					e.has_qualified_name (a_uri, a_name)
				then
					Result := True
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

	element_by_name (a_name: STRING): detachable XML_ELEMENT
			-- Direct child element with name `a_name';
			-- If there are more than one element with that name, anyone may be returned.
			-- Return Void if no element with that name is a child of current node.
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result /= Void
			loop
				if attached {XML_ELEMENT} elts.item as e and then
					named_same_name (e, a_name)
				then
					Result := e
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

	element_by_qualified_name (a_uri: STRING; a_name: STRING): detachable XML_ELEMENT
			-- Direct child element with given qualified name;
			-- If there are more than one element with that name, anyone may be returned.
			-- Return Void if no element with that name is a child of current node.
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result /= Void
			loop
				if attached {XML_ELEMENT} elts.item as e and then
					e.has_qualified_name (a_uri, a_name)
				then
					Result := e
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

feature -- Access

	attribute_by_name (a_name: STRING): detachable XML_ATTRIBUTE
			-- Attribute named `a_name' in current element;
			-- Return Void if no such attribute was found.
		require
			a_name_not_void: a_name /= Void
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result /= Void
			loop
				if attached {XML_ATTRIBUTE} elts.item as att and then
					attribute_same_name (att, a_name)
				then
					Result := att
				else
					elts.forth
				end
			end
			elts.go_to (c)
		ensure
			attribute_not_void: has_attribute_by_name (a_name) = (Result /= Void)
			namespace: Result /= Void implies (not Result.has_prefix)
		end

	attribute_by_qualified_name (a_uri: STRING; a_name: STRING): detachable XML_ATTRIBUTE
			-- Attribute named `a_name' in current element;
			-- Return Void if no such attribute was found.
		require
			a_uri_not_void: a_uri /= Void
			a_name_not_void: a_name /= Void
		local
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after or Result /= Void
			loop
				if attached {XML_ATTRIBUTE} elts.item as att and then
					att.has_qualified_name (a_uri, a_name)
				then
					Result := att
				else
					elts.forth
				end
			end
			elts.go_to (c)
		ensure
			attribute_not_void: has_attribute_by_qualified_name (a_uri, a_name) = (Result /= Void)
			namespace: Result /= Void implies Result.has_qualified_name (a_uri, a_name)
		end

	namespace_declarations: LINKED_LIST [XML_NAMESPACE]
			-- Namespaces declared directly in this element;
			-- This list must contain at most one namespace with a
			-- void prefix. If such a namespace exists it is a declared
			-- default namespace.
			-- (Returns a new list object at each call.)
		local
			c: CURSOR
			elts: like elements
		do
			create Result.make
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after
			loop
				if attached {XML_ATTRIBUTE} elts.item as att and then
					att.is_namespace_declaration
				then
					Result.force (att.namespace_declaration)
				end
				elts.forth
			end
			elts.go_to (c)
		ensure
			namespace_declarations_not_void: Result /= Void
--			no_void_declaration: not Result.has (Void)
		end

	attributes: LIST [XML_ATTRIBUTE]
			-- List of all attributes in current element
			-- (Create a new list at each call.)
		local
			c: CURSOR
			elts: like elements
		do
			create {LINKED_LIST [XML_ATTRIBUTE]} Result.make
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after
			loop
				if attached {XML_ATTRIBUTE} elts.item as att then
					Result.force (att)
				end
				elts.forth
			end
			elts.go_to (c)
		end

feature -- Query

--	joined_content: STRING
--		local
--			c: CURSOR
--			elts: like elements
--		do
--			create Result.make_empty
--			elts := elements
--			c := elts.cursor
--			from
--				elts.start
--			until
--				elts.after
--			loop
--				if attached {XML_CHARACTER_DATA} elts.item as l_data then
--					Result.append_string (l_data.content)
--				end
--				elts.forth
--			end
--			elts.go_to (c)
--		end

	contents: LIST [XML_CHARACTER_DATA]
			-- List of all XML_CHARACTER_DATA in current element
			-- (Create a new list at each call.)
		local
			c: CURSOR
			elts: like elements
		do
			create {LINKED_LIST [XML_CHARACTER_DATA]} Result.make
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after
			loop
				if attached {XML_CHARACTER_DATA} elts.item as att then
					Result.force (att)
				end
				elts.forth
			end
			elts.go_to (c)
		end

feature -- Element change

--	add_unqualified_attribute (a_name: STRING; a_value: STRING) is
--			-- Add an attribute without a specific namespace.
--		require
--			a_name_not_void: a_name /= Void
--			a_name_not_empty: a_name.count > 0
--			a_value_not_void: a_value /= Void
--		do
--			add_attribute (a_name, Default_ns, a_value)
--		ensure
--			attribute_added: has_attribute_by_name (a_name)
--		end
--		
--	add_attribute (a_name: STRING; a_ns: XM_NAMESPACE; a_value: STRING) is
--			-- Add an attribute to current element.
--			-- (at end if last is an attribute, at beginning otherwise)
--		require
--			a_name_not_void: a_name /= Void
--			a_name_not_empty: a_name.count > 0
--			a_ns_not_void: a_ns /= Void
--			a_value_not_void: a_value /= Void
--		local
--			an_attribute: XM_ATTRIBUTE
--			typer: XM_NODE_TYPER
--		do
--			create an_attribute.make (a_name, a_ns, a_value, Current)
--			if count = 0 then
--				force_last (an_attribute)
--			else
--				create typer
--				last.process (typer)
--				if typer.is_attribute then
--					force_last (an_attribute)
--				else
--					force_first (an_attribute)
--				end
--			end
--		ensure
--			attribute_added: has_attribute_by_qualified_name (a_ns.uri, a_name)
--		end		

feature -- Removal

--	remove_attribute_by_name (a_name: STRING) is
--			-- Remove attribute named `a_name' from current element.
--		require
--			a_name_not_void: a_name /= Void
--			has_attribute: has_attribute_by_name (a_name)
--		local
--			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
--			typer: XM_NODE_TYPER
--		do
--			create typer
--			a_cursor := new_cursor
--			from a_cursor.start until a_cursor.after loop
--				a_cursor.item.process (typer)
--				if typer.is_attribute and then
--					attribute_same_name (typer.xml_attribute, a_name)
--				then
--					remove_at_cursor (a_cursor)
--				else
--					a_cursor.forth
--				end
--			end
--		end

--	remove_attribute_by_qualified_name (a_uri: STRING; a_name: STRING) is
--			-- Remove attribute named `a_name' from current element.
--		require
--			a_uri_not_void: a_uri /= Void
--			a_name_not_void: a_name /= Void
--			has_attribute: has_attribute_by_qualified_name (a_uri, a_name)
--		local
--			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
--			typer: XM_NODE_TYPER
--		do
--			create typer
--			a_cursor := new_cursor
--			from a_cursor.start until a_cursor.after loop
--				a_cursor.item.process (typer)
--				if typer.is_attribute and then
--					typer.xml_attribute.has_qualified_name (a_uri, a_name)
--				then
--					remove_at_cursor (a_cursor)
--				else
--					a_cursor.forth
--				end
--			end
--		end
--		
	join_text_nodes
			-- Join sequences of text nodes.
		local
			joint_text_node: XML_CHARACTER_DATA
			c: CURSOR
			elts: like elements
		do
			elts := elements
			c := elts.cursor
			from
				elts.start
			until
				elts.after
			loop
				if attached {XML_CHARACTER_DATA} elts.item as text_node then
						-- Found a text node.
						-- Now join all text-nodes that are following it
						-- until there is a node that is no text-node.
					joint_text_node := text_node.twin
					elts.forth
					from
					until
						elts.after or text_node = Void
					loop
						if attached {XML_CHARACTER_DATA} elts.item as other_text_node then
								-- Found another text-node -> join.
							joint_text_node.append_content (other_text_node)
							elts.remove
						else
							elts.forth
						end
					end
					elts.replace (joint_text_node)
				else
					elts.forth
				end
			end
			elts.go_to (c)
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_element (Current)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
