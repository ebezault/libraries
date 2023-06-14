note
	description: "[
					Define a type of possible index type that occur in the tables we are interested in.
					e MethodDef, ModuleRef,TypeDef, TypeRef, or TypeSpec
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MEMBER_REF_PARENT

inherit
	PE_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index

feature -- Enum: tags

		-- memberrefparent
	TagBits: INTEGER = 3
			-- MemberRefParent
			-- 1 bit to encode.

	TypeDef: INTEGER = 0
	TypeRef: INTEGER = 1
	ModuleRef: INTEGER = 2
	MethodDef: INTEGER = 3
	TypeSpec: INTEGER = 4

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large(a_sizes[{PE_TABLES}.tTypeDef.to_integer_32 + 1]) or else
					  large(a_sizes[{PE_TABLES}.tTypeRef.to_integer_32 + 1]) or else
					  large(a_sizes[{PE_TABLES}.tModule.to_integer_32  + 1]) or else
					  large(a_sizes[{PE_TABLES}.tMethodDef.to_integer_32 + 1]) or else
					  large(a_sizes[{PE_TABLES}.tTypeSpec.to_integer_32  + 1])
		end

end

