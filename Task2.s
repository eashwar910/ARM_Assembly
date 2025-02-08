		AREA Task2, CODE, READONLY
		ENTRY

; Initialize addresses and registers
	LDR sp, =stk_ptr
	LDR r0, =init_array       ; Original init_arrayay
	LDR r1, =left_half   ; Left half
	LDR r2, =right_half  ; Right half
	LDR r3, =out_array    ; Final result
	LDR r4, =sub_array_1      ;Sub array 1
	LDR r5, =sub_array_2      ; Sub array 2

	PUSH {r0-r5, lr}

; Main sorting function
	BL split_init_array       ; Split the main array into two halves
	BL split_sub_arrays_1     ; Split the laves into sub arrays(recursive mergesort)
	BL merge_halves      ; Merge the halves into result

	POP {r0-r5, lr}
	B Done


; Split main array into Left and Right Halves
split_init_array
    MOV r6, #0      ; Counter for elements
    MOV r7, #5      ; Midpoint for splitting
	

left_half_split
    CMP r6, r7
    BEQ right_half_split
    LDR r8, [r0], #4
    STR r8, [r1], #4
    ADD r6, r6, #1
    B left_half_split

right_half_split
    CMP r6, #10
    BEQ half_done
    LDR r8, [r0], #4
    STR r8, [r2], #4
    ADD r6, r6, #1
    B right_half_split

half_done
    BX lr

; Recursive Splitting for the two halves
split_sub_arrays_1
    MOV r6, #0
    MOV r7, #3
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}

left_half_1  ; Splitting the left half into sub array 1
    CMP r6, r7
    BEQ right_half_1
    LDR r8, [r1], #4
    STR r8, [r4], #4
    ADD r6, r6, #1
    B left_half_1

right_half_1  ; splitting the left half into sub array 2
    CMP r6, #5
    BEQ Sort_Left_1
    LDR r8, [r1], #4
    STR r8, [r5], #4
    ADD r6, r6, #1
    B right_half_1
	
Sort_Left_1  ; sorting sub array 1 but putting the least valued number at r10 and greatest at 12
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
	LDR r10, [r4], #4
	LDR r11, [r4], #4
	LDR r12, [r4]
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
	CMP r10, r11
	MOVGT r9, r10
	MOVGT r10, r11
	MOVGT r11, r9
	CMP r10, r12
	MOVGT r9, r10
	MOVGT r10, r12
	MOVGT r12, r9
	CMP r11, r12
	MOVGT r9, r11
	MOVGT r11, r12
	MOVGT r12, r9
	STR r10, [r4], #4
	STR r11, [r4], #4
	STR r12, [r4]
	MOV r9, #0
	MOV r10, #0
	MOV r11, #0
	B Sort_Right_1
	
Sort_Right_1  ; sorting sub array 2 the same way as above 
	LDR r10, [r5], #4
	LDR r11, [r5]
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
	CMP r10, r11
	STRLT r10, [r5], #4
	STRLT r11, [r5]
	STRGT r11, [r5], #4
	STRGT r10, [r5]
	B merge_sub_arrays_1


; Merge two sub arrays
merge_sub_arrays_1
    ; Initialize counters
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
    MOV r6, #3      ; Elements in sub array 1
    MOV r7, #2      ; Elements in sub array 2 
    LDR r8, [r4], #4
    LDR r9, [r5], #4
	
	B main_loop_1
	
main_loop_1 ; merge the sub arrays 
    CMP r6, #0
    BEQ subarr_1_empty_1
    CMP r7, #0
    BEQ subarr_2_empty_1
    CMP r8, r9
    BLT store_subarr_1_1
    BGT store_subarr_2_1

store_subarr_1_1 ; loop to store from sub array 1
    STR r8, [r1], #4
    LDR r8, [r4], #4
    SUB r6, r6, #1
    B main_loop_1

store_subarr_2_1 ; loop to store from sub array 2
    STR r9, [r1], #4
    LDR r9, [r5], #4
    SUB r7, r7, #1
    B main_loop_1

subarr_1_empty_1 ; loop to break when sub array 1 is empty
    STR r9, [r1], #4
    LDR r9, [r5], #4
    SUB r7, r7, #1
    CMP r7, #0
    BNE subarr_1_empty_1
    B split_sub_arrays_2

subarr_2_empty_1 ; loop to break when sub array 2 is empty
    STR r8, [r1], #4
    LDR r8, [r4], #4
    SUB r6, r6, #1
    CMP r6, #0
    BNE subarr_2_empty_1
    B split_sub_arrays_2
	
split_sub_arrays_2 ; splittin the right half into sub arrays 
    MOV r6, #0
    MOV r7, #3
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}

left_half_2 ; splitting right half into sub array 1 
    CMP r6, r7
    BEQ right_half_2
    LDR r8, [r2], #4
    STR r8, [r4], #4
    ADD r6, r6, #1
    B left_half_2

right_half_2  ; splitting right half into sub array 2 
    CMP r6, #5
    BEQ Sort_Left_2
    LDR r8, [r2], #4
    STR r8, [r5], #4
    ADD r6, r6, #1
    B right_half_2
	
Sort_Left_2 ; sorting sub array 1 as the same way as before
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
	LDR r10, [r4], #4
	LDR r11, [r4], #4
	LDR r12, [r4]
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
	CMP r10, r11
	MOVGT r9, r10
	MOVGT r10, r11
	MOVGT r11, r9
	CMP r10, r12
	MOVGT r9, r10
	MOVGT r10, r12
	MOVGT r12, r9
	CMP r11, r12
	MOVGT r9, r11
	MOVGT r11, r12
	MOVGT r12, r9
	STR r10, [r4], #4
	STR r11, [r4], #4
	STR r12, [r4]
	MOV r9, #0
	MOV r10, #0
	MOV r11, #0
	B Sort_Right_2
	
Sort_Right_2 ; sorting sub array 2 as the same way before
	LDR r10, [r5], #4
	LDR r11, [r5]
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
	CMP r10, r11
	STRLT r10, [r5], #4
	STRLT r11, [r5]
	STRGT r11, [r5], #4
	STRGT r10, [r5]
	B Reset_Counter
	
Reset_Counter ; resetting counters to flush memory
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
	MOV r6, #3
	MOV r7, #2
	
merge_sub_arrays_2 ; merging the sub arrays like before
 
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
    MOV r6, #3      ; Elements in sub_array_1
    MOV r7, #2      ; Elements in sub_array_2
    LDR r8, [r4], #4
    LDR r9, [r5], #4
	B MergeLoop_2

MergeLoop_2 ; main merge lloop
    CMP r6, #0
    BEQ subarr_1_empty_2
    CMP r7, #0
    BEQ subarr_2_empty_2
    CMP r8, r9
    BLT store_subarr_1_2
    BGT store_subarr_2_2

store_subarr_1_2 ; storing from sub array 1 
    STR r8, [r2], #4
    LDR r8, [r4], #4
    SUB r6, r6, #1
    B MergeLoop_2

store_subarr_2_2 ; storing from sub aray 2 
    STR r9, [r2], #4
    LDR r9, [r5], #4
    SUB r7, r7, #1
    B MergeLoop_2

subarr_1_empty_2  ; loop break when sub array 1 is empty
    STR r9, [r2], #4
    LDR r9, [r5], #4
    SUB r7, r7, #1
    CMP r7, #0
    BNE subarr_1_empty_2
    B merge_halves
 
subarr_2_empty_2  ; loop break when sub array 2 is empty
    STR r8, [r2], #4
    LDR r8, [r4], #4
    SUB r6, r6, #1
    CMP r6, #0
    BNE subarr_2_empty_2
    B merge_halves

; Merge Final Left and Right halves
merge_halves
    MOV r6, #5      ; Left half size
    MOV r7, #5      ; Right half size
	POP {r0 - r5, lr}
	PUSH {r0 - r5, lr}
    LDR r8, [r1], #4
    LDR r9, [r2], #4
	MOV r6, #5
	MOV r7, #5
	
final_merge
    CMP r6, #0
    BEQ left_empty
    CMP r7, #0
    BEQ right_empty
    CMP r8, r9
    BLT store_left
    BGT store_right

store_left ; store from left half
    STR r8, [r3], #4
    LDR r8, [r1], #4
    SUB r6, r6, #1
    B final_merge

store_right  ; store from right half
    STR r9, [r3], #4
    LDR r9, [r2], #4
    SUB r7, r7, #1
    B final_merge

left_empty ; loop break when left half is empty
    STR r9, [r3], #4
    LDR r9, [r2], #4
    SUB r7, r7, #1
    CMP r7, #0
    BNE left_empty
    B Done

right_empty ; loop break when right half is empty
    STR r8, [r3], #4
    LDR r8, [r1], #4
    SUB r6, r6, #1
    CMP r6, #0
    BNE right_empty
    B Done

Done 
	B Done

; Data Section
; Initializing memory spaces 
init_array        DCD 8, 50, 81, 29, 4, 24, 23, 30, 1, 7
		AREA QUIZ, DATA, READWRITE
stk_ptr EQU 0x60004000
out_array      EQU 0x60000000
left_half     EQU 0x60000100
right_half    EQU 0x60001000
sub_array_1        EQU 0x60002000
sub_array_2        EQU 0x60003000

	END