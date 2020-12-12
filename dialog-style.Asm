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
	.elseif eax==WM_COMMAND
		.if wParam == IDC_BTN1
			
			mov x,0
			mov y,0
			.while x<500
				.while y<500
					invoke MulDiv,y,0ffh,500
					invoke SetPixel,hdc,x,y,eax 
					inc y
				.endw
				inc x
				mov y,0
			.endw
		.elseif wParam == IDC_BTN2
			mov x,0
			mov y,0
			.while x<700
				.while y<500
					; синій зменшується, а червоний та зелений збільшуються
					invoke MulDiv,y,0ffh,500
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
				mov y,0
			.endw
		.elseif wParam == IDC_BTN3
			invoke MessageBox,0,0,0,MB_OK
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
