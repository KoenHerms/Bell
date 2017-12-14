namespace Quantum.Bell
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Set (desired: Result, q1: Qubit) : ()
    {
        body
        {
            let current = M(q1);
			if(desired != current)
			{
				X(q1);
			}
        }
    }

	operation BellTest(count: Int, initial: Result) : (Int, Int, Int)
	{
		body
		{
			mutable numberOfOnes = 0;
			mutable numberOfAgrees = 0;
			using(qubits = Qubit[2])
			{
				for (test in 1..count)
				{
					Set(initial, qubits[0]);
					Set(Zero, qubits[1]);

					H(qubits[0]);
					CNOT(qubits[0], qubits[1]);

					let result0 = M(qubits[0]);
					let result1 = M(qubits[1]);

					if(result0 == result1)
					{
						set numberOfAgrees = numberOfAgrees + 1;
					}

					if(result0 == One)
					{
						set numberOfOnes = numberOfOnes + 1;
					}
				}
				for(qcounter in 0..1)
				{
					Set(Zero, qubits[qcounter]);
				}
			}
			return(count-numberOfOnes, numberOfOnes, numberOfAgrees);
		}
	}
}
