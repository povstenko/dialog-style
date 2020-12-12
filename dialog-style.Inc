
include windows.inc
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc

includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib

include gdi32.inc
includelib gdi32.lib

DlgProc			PROTO	:HWND,:UINT,:WPARAM,:LPARAM

.const

;dialog-style.dlg
IDD_DIALOG1						equ 101
IDC_BTN1						equ 1001
IDC_BTN2						equ 1002
IDC_BTN3						equ 1003

;dialog-style.Rc

;#########################################################################
.data

hdc  dd 	0	
x	dd 	0	
y	dd 	0

.data?
hBrush				dd ?
hrBg				dd ?
hInstance			dd ?

;#########################################################################
