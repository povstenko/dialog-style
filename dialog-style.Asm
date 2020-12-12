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

	.elseif eax==WM_COMMAND
		.if wParam == IDC_BTN1
			invoke MessageBox,0,0,0,MB_OK
		.elseif wParam == IDC_BTN2
			invoke MessageBox,0,0,0,MB_OK
		.elseif wParam == IDC_BTN3
			invoke MessageBox,0,0,0,MB_OK
		.endif
	.elseif eax==WM_CLOSE
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp

end start
