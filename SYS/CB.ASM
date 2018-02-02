Ideal

P386
Model  use16 large, prolog

	Public  calc_bytes

CodeSeg

PROC  calc_bytes  uses es bx
      arg  value: WORD, strPtr: PTR WORD

	Xor	eax, eax
	Mov	ax, [value]
	Shl	ax, 4
	Les	bx, [strPtr]
	Mov	[dword ptr es:bx], eax
	Ret

ENDP  calc_bytes

	END
