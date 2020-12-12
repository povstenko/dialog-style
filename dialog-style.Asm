.386
.model flat, stdcall  ;32 bit memory model
option casemap :none  ;case sensitive

include dialog-style.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov		hInstance,eax

    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,IDD_DIALOG1,NULL,addr DlgProc,NULL
	invoke ExitProcess,0

;########################################################################

DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	mov		eax,uMsg
	.if eax==WM_INITDIALOG
		invoke GetDC,hWin
		mov hdc,eax
		
		invoke CreateRectRgn,500,0,700,700
		mov hrBg,eax 
	.elseif eax==WM_COMMAND
		.if wParam == IDC_BTN1
;			invoke CreateSolidBrush,000ffh
;			mov hBrush, eax
;			invoke FillRgn,hdc,hrBg,hBrush
;			
;			invoke GetDlgItem,hWin,IDC_BTN1
;			invoke RedrawWindow,eax,0,0,RDW_VALIDATE		
;			
			mov x,0
			mov y,50
			.while x<600
				.while y<500
					invoke MulDiv,y,0ffh,600
					invoke SetPixel,hdc,x,y,eax 
					inc y
				.endw
				inc x
				mov y,50
			.endw
			
;			invoke SetTextColor,eax, 0ffh
				
		.elseif wParam == IDC_BTN2
			mov x,0
			mov y,50
			.while x<600
				.while y<500
					; синій зменшується, а червоний та зелений збільшуються
					invoke MulDiv,y,0ffh,600
					mov ecx,0ffh ; ecx = 255
					sub ecx,eax  ; ecx - "pos gradient"
					shl ecx,16 	; ecx -> blue (<< 16)
					mov ebx,eax ; ebx= red
					shl eax,8 ; eax = green
					or eax,ebx ; mix 
					or eax,ecx
					invoke SetPixel,hdc,x,y,eax 
					inc y
				.endw
				inc x
				mov y,50
			.endw
		.elseif wParam == IDC_BTN3
			mov x,0
			mov y,50
			.while x<600
				.while y<500
					invoke SetPixel,hdc,x,y,0ae82e8h
					inc y
				.endw
				inc x
				mov y,50
			.endw
		.endif
	.elseif eax==WM_CLOSE
		invoke ReleaseDC,hWin,hdc
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp

end start
