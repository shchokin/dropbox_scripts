d:
cd D:\Auto\kofile-automation\Kofile\venv3.10\Scripts && call activate.bat
cd ..\..
for /L %%x in (1, 1, 3) do (
	  golem run Kofile 64290_Ordering/64291-Order_Queue/63149_oit_workflow.py -p 1 -e qa_ref 
)
cmd /k