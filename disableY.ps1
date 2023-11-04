<# disabling the cmd close button by batch command #>
<# https://stackoverflow.com/questions/13763134/disabling-the-cmd-close-button-by-batch-command #>

<# How to bring focus to window by process name? #>
<# https://stackoverflow.com/questions/42566799/how-to-bring-focus-to-window-by-process-name #>


$code = @'
using System;
using System.Diagnostics;
using System.ComponentModel;
using System.Runtime.InteropServices;

namespace Win32_Api {

 public static class WinAPI {
   [DllImport("kernel32.dll")]
   public static extern IntPtr GetConsoleWindow();

   [DllImport("user32.dll")]
   [return: MarshalAs(UnmanagedType.Bool)]
   public static extern bool DeleteMenu(IntPtr hMenu,
                          uint uPosition, uint uFlags);

   [DllImport("user32.dll")]
   [return: MarshalAs(UnmanagedType.Bool)]
   public static extern bool DrawMenuBar(IntPtr hWnd);

   [DllImport("user32.dll")]
   public static extern IntPtr GetSystemMenu(IntPtr hWnd,
              [MarshalAs(UnmanagedType.Bool)]bool bRevert);
              
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
      
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool IsIconic(IntPtr hWnd);    // Is the window minimized?

   const uint SC_CLOSE     = 0xF060;
   const uint SC_MAXIMIZE  = 0xF030;
   const uint SC_MINIMIZE  = 0xF020;
   const uint SC_SIZE      = 0xF000;
   const uint MF_BYCOMMAND = 0;

   internal static void ChangeCurrentState(IntPtr Console, bool state) {
     IntPtr hMenu = GetSystemMenu(Console, state);
     DeleteMenu(hMenu, SC_SIZE, MF_BYCOMMAND);
     DeleteMenu(hMenu, SC_MINIMIZE, MF_BYCOMMAND);
     DeleteMenu(hMenu, SC_MAXIMIZE, MF_BYCOMMAND);
     DrawMenuBar(Console);
   }
   internal static void ChangeCurrentState(bool state) {
     IntPtr Console = GetConsoleWindow();
     IntPtr hMenu = GetSystemMenu(Console, state);
     DeleteMenu(hMenu, SC_SIZE, MF_BYCOMMAND);
     DeleteMenu(hMenu, SC_MINIMIZE, MF_BYCOMMAND);
     DeleteMenu(hMenu, SC_MAXIMIZE, MF_BYCOMMAND);
     DrawMenuBar(Console);
   }
 }

 public static class Status {
   public static void Disable(IntPtr Console) {
     WinAPI.ChangeCurrentState(Console, false); //its 'true' if need to enable
   }
   public static void Disable() {
     WinAPI.ChangeCurrentState(false); //its 'true' if need to enable
   }
 }
}
'@

Add-Type $code;
[Win32_Api.Status]::Disable();
exit;
