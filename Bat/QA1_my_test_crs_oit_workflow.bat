d:
cd D:\Auto\kofile-automation\Kofile\venv3.10\Scripts && call activate.bat
cd ..\..
for /L %%x in (1, 1, 1) do (
	  golem run Kofile my_test/crs_oit_workflow.py -p 1 -e qa_48999_loc_2 
)
cmd /k