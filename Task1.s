	AREA Task1, CODE, READONLY
    ENTRY
	
	; initialize resultpointer
	LDR r0, =result
	LDR r1, =resultpointer
	STR r0, [r1]
	
	LDR r0, =queue	; load the beginning address of queue
	LDR r1, =queueend	; load the address of queueend
	STR r0, [r1]	; intialize the queueend
	LDR r1, =queuebegin
	STR r0, [r1]	; initialize the queuebegin

	BL BFS
	
Enqueue
	; push node to queue
	LDR r1, =queueend
	LDR r2, [r1]
	LDR r3, [r0]	; load the value of node
	STR r3, [r2]	; store the value of node to queue
	LDR r3, [r0, #4]	; load the left node
	STR r3, [r2, #4]	; store the left node to queue
	LDR r3, [r0, #8]	; load the right node
	STR r3, [r2, #8]	; store the right node to queue
	
	; move queueend forward
	ADD r2, r2, #12
	STR r2, [r1]
	BX LR
	
BFS
	LDR r0, =Node1
	BL Enqueue
	
Loop
	; check if queue is empty
	LDR r0, =queueend
	LDR r1, [r0]	; load the queueend
	LDR r0, =queuebegin
	LDR r2, [r0]	; load the queuebegin
	CMP r1, r2	; compare queueend and queuebegin
	BEQ BubbleSort	; if equal, queue is empty, go to BubbleSort

	; dequeue and store value to result
	LDR r0, [r2]	; load the current queuebegin
	LDR r1, =resultpointer
	LDR r3, [r1]	; load the current place of result array
	STR r0, [r3]	; push the node value to result array
	ADD r3, r3, #4	; update the result array address
	STR r3, [r1]	; store updated result array
	
	; enqueue left and right nodes
	LDR r0, [r2, #4]	; load left node address
	CMP r0, #0	; check if is empty
	BEQ NoLeft
	BL Enqueue
NoLeft
	LDR r0, =queuebegin
	LDR r2, [r0] 
	LDR r0, [r2, #8]	; load right node address
	CMP r0, #0	; check if is empty
	BEQ NoRight
	BL Enqueue
NoRight
	; move queuebegin forward
	LDR r1, =queuebegin
	LDR r2, [r1]	; load the queuebegin
	ADD r2, r2, #12	; queuebegin move forward
	STR r2, [r1]	; update queuebegin
	B Loop
	
BubbleSort
	LDR r0, =result;
	MOV r1, #0	;r1 is outer counter
OutterLoop
	CMP r1, #14
	BGE EndOutLoop
	MOV r2, #0	;r2 is swapflag
	
	MOV r4, #15
	SUB r4, r4, r1
	SUB r4, r4, #1	;r4 is inner loop max
	MOV r3, #0	; r3 is inner counter
InnerLoop
	CMP r3, r4
	BGE EndInnerLoop
	LDR r5, [r0, r3, LSL #2]
	MOV r8, r3
	ADD r7, r3, #1
	LDR r6, [r0, r7, LSL #2]
	ADD r3, r3, #1
	CMP r5, r6
	BLE InnerLoop
	; exchange two numbers
	STR r5, [r0, r7, LSL #2]
	STR r6, [r0, r8, LSL #2]
	MOV r2, #1	;r2 is true
	B InnerLoop
EndInnerLoop
	
	CMP r2, #0
	BEQ EndOutLoop
	
	ADD r1, r1, #1
	B OutterLoop
EndOutLoop
	
	B SafeEnd
	
	
	
	
Node1   DCD 10            ; node value
        DCD Node2         ; left node 
        DCD Node3         ; right node 

Node2   DCD 5             ; node value
        DCD Node4         ; left node
        DCD Node5         ; right node

Node3   DCD 30            ; node value
        DCD Node6         ; left node
        DCD Node7         ; right node

Node4   DCD 78            ; node value
        DCD Node8         ; left node
        DCD Node9         ; right node

Node5   DCD 2             ; node value
        DCD Node10        ; left node
        DCD Node11        ; right node

Node6   DCD 19            ; node value
        DCD Node12        ; left node
        DCD Node13        ; right node

Node7   DCD 11            ; node value
        DCD Node14        ; left node
        DCD Node15        ; right node
			
Node8   DCD 23            ; node value
        DCD 0             ; left node
        DCD 0   		  ; right node

Node9   DCD 48            ; node value
        DCD 0             ; left node
        DCD 0   		  ; right node

Node10  DCD 79            ; node value
        DCD 0             ; left node
        DCD 0   		  ; right node
			
Node11  DCD 1             ; node value
        DCD 0             ; left node
        DCD 0			  ; right node

Node12  DCD 14            ; node value
        DCD 0             ; left node
        DCD 0			  ; right node

Node13  DCD 9             ; node value
        DCD 0             ; left node
        DCD 0			  ; right node

Node14  DCD 41            ; node value
        DCD 0             ; left node
        DCD 0			  ; right node
			
Node15  DCD 31            ; node value
        DCD 0             ; left node
        DCD 0			  ; right node
			
SafeEnd
	B SafeEnd
	
	AREA BFSResult, DATA, READWRITE
resultpointer SPACE 4
queue SPACE  180	; 12*15=180
queueend SPACE 4
queuebegin SPACE 4
result SPACE 60		; 4*15=60
	
		END 
			

