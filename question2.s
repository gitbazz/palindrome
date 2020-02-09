		AREA question2, CODE, READWRITE
		ENTRY
		
		LDR r10, =STRING								;Set r10 to point to the location of STRING
		MOV r1, #0										;Set r1 to equal 0, the index location of the first character of the string
		
LENGTH	LDRB r12, [r10, r2]								;Load a byte of STRING into r12. Starts at index equal to 0
		CMP r12, #0x00									;Check if the character at r12 is the null character
		BEQ EMPTY										;If the character in r12 is the null character then jump to EMPTY
		ADD r2, #1										;Increment the null character pointer r2 by 1
		B LENGTH										;If the character in r12 is not the null character jump to LENGTH

EMPTY	CMP r1, r2										;Check if the string is empty
		BEQ VALID										;If the string is empty then it is a palindrome, jump to VALID

LEFT	LDRB r3, [r10, r1]								;Load the first character of STRING into r3
		ADD r1, #1										;Increment r1 to point to the next character index
		CMP r3, #0x41									;Check if the character in r3 is greater than the character 'A'
		BLE LEFT										;If character in r3 is less than the character 'A' then jump to LEFT
		CMP r3, #0x5A									;Check if the character in r3 is less than the character 'Z'
		ADDLE r3, #0x20									;Convert upper case character to lower case
		CMP r3, #0x61									;Check if the character in r3 is greater than the character 'a'
		BLT LEFT										;If the character in r3 is less than the character 'a' then jump to LEFT
		CMP r3, #0x7A									;Check if the character in r3 is less than the character 'z'
		BGT LEFT										;If the character in r3 is greater than the character 'z' then jump to LEFT


RIGHT	LDRB r4, [r10, r2]								;Load the last character of STRING into r4
		SUB r2, #1										;Decrement r2 to point to the previous character index
		CMP r4, #0x41									;Check if the character in r4 is greater than the character 'A'
		BLE RIGHT										;If character in r4 is less than the character 'A' then jump to RIGHT
		CMP r4, #0x5A									;Check if the character in r4 is less than the character 'Z'
		ADDLE r4, #0x20									;Convert upper case character to lower case
		CMP r4, #0x61									;Check if the character in r4 is greater than the character 'a'
		BLT RIGHT										;If the character in r4 is less than the character 'a' then jump to RIGHT
		CMP r4, #0x7A									;Check if the character in r4 is less than the character 'z'
		BGT RIGHT										;If the character in r4 is greater than the character 'z' then jump to RIGHT

		
COMPARE	CMP r3, r4										;Compare the character in r3 with the character in r4
		BNE INVALID										;If the characters are not the same then the string is not a palindrome, jump to INVALID
		CMP r1, r2										;Compare the position of character index r1 with the position of character index r2
		BGT VALID										;If the position of r1 is greater than the position of r2 then the string is a palindrome, jump to valid
		B LEFT											;If the position of character indexs r1 and r2 have not overlapped, then jump to LEFT to check remaining characters
		
VALID	MOV r0, #1										;If the string is a palindrome store 1 in r0
		B FINISH										;Jump to FINISH

INVALID	MOV r0, #2										;If the string is not a palindrome store 2 in r0
		
FINISH	B FINISH

STRING	DCB	"He lived as a devil, eh?"					;String
EoS		DCB 0x00										;End of string
		
		END