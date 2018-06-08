all:

test: 
	$(MAKE) -C $@

planemo-venv/bin/planemo: planemo-venv
	. planemo-venv/bin/activate && pip install --upgrade pip setuptools
	. planemo-venv/bin/activate && pip install planemo

planemo-venv:
	virtualenv planemo-venv

planemolint: planemo-venv/bin/planemo
	. planemo-venv/bin/activate && planemo lint galaxy/nmrml2isa

planemotest: planemo-venv/bin/planemo
	. planemo-venv/bin/activate && planemo test --conda_prefix planemo-conda --conda_dependency_resolution --conda_auto_install --conda_auto_init --galaxy_source https://github.com/phnmnl/galaxy.git --galaxy_branch 17.09_with_rwval_requirement_for_testing_under_planemo galaxy/nmrml2isa

clean:
	$(MAKE) -C test $@
	$(RM) -r $(HOME)/.planemo
	$(RM) -r planemo-venv planemo-conda
	$(RM) tool_test_output.*

.PHONY:	all clean test planemolint planemotest
