﻿note
	description: "Test suites."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TEST_SUITE inherit

	TESTABLE
		undefine
			copy, is_equal, set_standard_output
		end

	ARGUMENT_CONTEXT
		rename
			context as fixture, is_context_set as is_fixture_set,
			set_context as set_fixture
		undefine
			copy, is_equal
		end

	ARRAYED_TEST_CONTAINER
		rename
			make as list_make
		redefine
			extend, replace, remove, put_summary
		end

	STRATEGY_FACTORY
		undefine
			copy, is_equal
		end

	EXCEPTIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Create suite.
		do
			create test_results.make
			list_make (0)
			name := "TEST SUITE"
			select_strategy ("linear")
		ensure
			non_empty_name: name /= Void and then not name.is_empty
			test_results_exist: test_results /= Void
			sequential_strategy: equal (selected_strategy, "linear")
		end

	new_filled_list (n: INTEGER_32): like Current
		do
			create Result.make
		end

feature -- Access

	test_results: TEST_SUITE_RESULT
			-- Results of tests

	available_strategies: ARRAY [STRING]
			-- Array containing the names of the available strategies
		do
			Result := strategy_factory.available_products
		end

	selected_strategy: STRING
			-- Name of selected strategy
		require
			strategy_set: is_strategy_set
		do
			Result := strategy_factory.selected_product_key
		ensure
			non_empty_result: Result /= Void and then not Result.is_empty
		end

	name: STRING
			-- Name of test suite

	seed: INTEGER
			-- Random seed
		do
			Result := execution_strategy.seed
		end

feature -- Measurement

	run_count: INTEGER
			-- Number of runs
		do
			Result := test_results.run_count
		end

feature -- Status report

	Top_level_allowed: BOOLEAN = True
			-- Can test be inserted in the top level of test hierarchy?
			-- (Answer: Yes)

	Produces_result: BOOLEAN = True
			-- Does test produce result? (Answer: yes)

	Is_complete_test: BOOLEAN = True
	 		-- Is test a complete test case? (Answer: yes)

	Is_test_container: BOOLEAN = True
			-- is test a container? (Answer: yes)

	has_strategy (s: STRING): BOOLEAN
			-- Is there a strategy named `s'
		require
			non_empty_name: s /= Void and then not s.is_empty
		do
			Result := strategy_factory.has_product (s)
		end

	is_strategy_set: BOOLEAN
			-- Is execution strategy set?
		do
			Result := execution_strategy /= Void
		end

	is_context_needed: BOOLEAN
			-- Does selected execution strategy need a context?
		require
			strategy_set: is_strategy_set
		do
			Result := execution_strategy.is_context_needed and not
				is_context_set
		end

	is_context_set: BOOLEAN
			-- Is a context set for selected strategy?
		require
			strategy_set: is_strategy_set
		do
			Result := execution_strategy.is_context_set
		end

	Has_random_generator: BOOLEAN
			-- Does current object have access to a random number generator?
		do
			Result := execution_strategy.has_random_generator
		end

	is_ready: BOOLEAN
			-- Can tests in suite be run?
		do
			Result := not is_empty and is_strategy_set and is_name_set and
				is_number_set and (is_context_needed implies is_context_set)
		end

	contains_complete_tests: BOOLEAN
			-- Does test suite contain complete tests?
			-- (`False' means that suite contains test steps.)
		require
			not_empty: not is_empty
		do
			Result := test (1).is_complete_test
		end

	insertable (v: TESTABLE): BOOLEAN
			-- Can `v' be inserted into test suite?
		do
			Result := is_empty or else
					(v.is_complete_test = contains_complete_tests)
		ensure then
			insertable_definition: is_empty or else
					(v.is_complete_test = contains_complete_tests)
		end

feature -- Status setting

	select_strategy (s: STRING)
			-- Set execution strategy to strategy named `s'.
		require
			non_empty_name: s /= Void and then not s.is_empty
			existing_strategy: has_strategy (s)
		do
			strategy_factory.select_product (s)
			execution_strategy := strategy_factory.product
			execution_strategy.set_suite (Current)
		ensure
			strategy_set: is_strategy_set
			empty_or_ready_or_context_request:
				(is_empty or is_context_needed) xor is_ready
			strategy_selected: selected_strategy = s
			is_suite_set: execution_strategy.is_suite_set
		end

	set_name (n: STRING)
			-- Set name to `n'.
		require
			non_empty_name: n /= Void and then not n.is_empty
		do
			name := n
		ensure
			name_set: name = n
		end

	set_context (c: ANY)
			-- Set context to `c'.
		require
			strategy_set: is_strategy_set
			context_needed: is_context_needed
		do
			execution_strategy.set_context (c)
			if not execution_strategy.is_context_ok then
				raise ("Invalid context")
			end
		end

	set_seed (s: INTEGER)
			-- Set seed to `s'.
		do
			execution_strategy.set_seed (s)
		end

	clear_results
			-- Clear results.
		local
			old_idx: INTEGER
			i: INTEGER
		do
			old_idx := index
			test_results.clear_results
			from i := 1 until i > test_count loop
				select_test (i)
				selected_test.clear_results
				i := i + 1
			end
			select_test (old_idx)
		ensure then
			index_unchanged: index = old index
		end

feature -- Element change

	extend (v: TESTABLE)
			-- At `v' to end.
		do
			Precursor (v)
			v.set_container (Current)
		ensure then
			container_set: v.container = Current
		end

	replace (v: TESTABLE; i: INTEGER)
			-- Replace `i'-th item with `v'.
		do
			Precursor (v, i)
			v.set_container (Current)
		ensure then
			container_set: v.container = Current
		end

feature -- Removal

	remove (i: INTEGER)
			-- Remove `i'-th item.
		local
			old_idx: INTEGER
		do
			old_idx := index
			select_test (i)
			selected_test.set_container (Void)
			Precursor (i)
			select_test (old_idx)
		end

feature -- Basic operations

	execute
			-- Execute test suite.
		local
			old_idx: INTEGER
			res: ARRAY [detachable TEST_RUN_RESULT]
			stop: BOOLEAN
		do
			old_idx := index
			set_up
			from
				create res.make_filled (Void, 1, test_count)
				execution_strategy.start
			until
				stop or (stop_on_failure and failure_stop)
			loop
				if selected_test.is_test_enabled then
					execution_strategy.execute
					if selected_test.produces_result then
						res.put (selected_test.result_record
							(selected_test.run_count), index)
					end
				end
				if not execution_strategy.is_finished then
					execution_strategy.forth
				else
					stop := True
				end
			end
			if not res.is_empty then
				test_results.add_result (res.linear_representation)
			end
			tear_down
		end

feature -- Output

	put_summary (f: LOG_FACILITY)
			-- Output test summary to `f'.
		do
			f.put_summary (Current)
			f.put_container_results (Current)
			Precursor (f)
		end

feature {NONE} -- Implementation

	execution_strategy: EXECUTION_STRATEGY
			-- Selected execution strategy

invariant

	strategy_selected: is_strategy_set
	non_empty_name: name /= Void and then not name.is_empty
	test_result_exists: test_results /= Void

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
