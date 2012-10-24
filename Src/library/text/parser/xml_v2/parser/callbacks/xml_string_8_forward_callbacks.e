note
	description: "[
			Descendant of callbacks interface forwarding to a client interface
			with instance of STRING_8 instead of potential STRING_32
			
			This is mainly a compatibility layer for code using the "STRING" in the signature
			instead of current "READABLE_STRING_GENERAL"

			]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_STRING_8_FORWARD_CALLBACKS

inherit
	XML_CALLBACKS_SOURCE

	XML_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make (cb: like callbacks)
			-- Don't forward anything
		do
			set_callbacks (cb)
		end

feature -- Access

	callbacks: XML_CALLBACKS
			-- Callbacks event interface to which events are forwarded;

feature -- Setting

	set_callbacks (a_callbacks: like callbacks)
			-- Set `callbacks' to `a_callbacks'.
		do
			callbacks := a_callbacks
		ensure then
			callbacks_set: callbacks = a_callbacks
		end

feature {NONE} -- Conversion

	to_string_8 (s: READABLE_STRING_GENERAL): STRING_8
			-- `s' as compatible STRING_8
		local
			i, nb: INTEGER_32
			l_code: like {READABLE_STRING_GENERAL}.code
			h: STRING
		do
			if attached {READABLE_STRING_8} s as s8 then
				Result := s8.as_string_8
			else
				nb := s.count
				create Result.make (nb)
				from
					i := 1
				until
					i > nb
				loop
					l_code := s.code (i)
					if Result.valid_code (l_code) then
						Result.append_code (l_code)
					else
						-- FIXME: UNICODE/ASCII
						-- Possibilities
						-- 1) escape unicode character using entities
						-- 2) ignore unicode character
						-- 3) convert to UTF8 ...
						-- 4) replace unicode character by %U
						h := l_code.out
						Result.grow (nb + h.count + 2)
						Result.extend ('&')
						Result.extend ('#')
						Result.append (h)
						Result.extend (';')
					end
					i := i + 1
				end
			end
		end

	to_detachable_string_8 (s: detachable READABLE_STRING_GENERAL): detachable STRING_8
		do
			if s /= Void then
				Result := to_string_8 (s)
			end
		end

feature {NONE} -- Document

	on_start
			-- Forward start.
		do
			callbacks.on_start
		end

	on_finish
			-- Forward finish.
		do
			callbacks.on_finish
		end

	on_xml_declaration (a_version: READABLE_STRING_GENERAL; an_encoding: detachable READABLE_STRING_GENERAL; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			callbacks.on_xml_declaration (to_string_8 (a_version), to_detachable_string_8 (an_encoding), a_standalone)
		end

feature {NONE} -- Errors

	on_error (a_message: READABLE_STRING_GENERAL)
			-- Event producer detected an error.
		do
			callbacks.on_error (to_string_8 (a_message))
		end

feature {NONE} -- Meta

	on_processing_instruction (a_name, a_content: READABLE_STRING_GENERAL)
			-- Forward PI.
		do
			callbacks.on_processing_instruction (to_string_8 (a_name), to_string_8 (a_content))
		end

	on_comment (a_content: READABLE_STRING_GENERAL)
			-- Forward comment.
		do
			callbacks.on_comment (to_string_8 (a_content))
		end

feature {NONE} -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_GENERAL; a_prefix: detachable READABLE_STRING_GENERAL; a_local_part: READABLE_STRING_GENERAL)
			-- Start of start tag.
		do
			callbacks.on_start_tag (to_detachable_string_8 (a_namespace), to_detachable_string_8 (a_prefix), to_string_8 (a_local_part))
		end

	on_attribute (a_namespace: detachable READABLE_STRING_GENERAL; a_prefix: detachable READABLE_STRING_GENERAL; a_local_part: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL)
			-- Process attribute.
		do
			callbacks.on_attribute (to_detachable_string_8 (a_namespace), to_detachable_string_8 (a_prefix), to_string_8 (a_local_part), to_string_8 (a_value))
		end

	on_start_tag_finish
			-- End of start tag.
		do
			callbacks.on_start_tag_finish
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_GENERAL; a_prefix: detachable READABLE_STRING_GENERAL; a_local_part: READABLE_STRING_GENERAL)
			-- End tag.
		do
			callbacks.on_end_tag (to_detachable_string_8 (a_namespace), to_detachable_string_8 (a_prefix), to_string_8 (a_local_part))
		end

feature {NONE} -- Content

	on_content (a_content: READABLE_STRING_GENERAL)
			-- Forward content.
		do
			callbacks.on_content (to_string_8 (a_content))
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
