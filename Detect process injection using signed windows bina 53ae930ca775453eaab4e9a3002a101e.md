# Detect process injection using signed windows binary Mavinject.exe

Status: Done
Owner: Ahmed Mohmood
UUID: 30ddffdb-511a-42b3-915e-114c0e854f71
File Name: process_injection_mavinject
Description: Attacker can inject code (dll) into legitimate running process to proxy their execution and hide their tracks. using the signed binary Mavinject.exe 
Tactic: Defense Evasion
Technique: T1218.013
Security Control: Windows
Logsource: process_creation
Has Atomic: Yes
Created: September 13, 2023
Created time: March 8, 2024 6:12 PM
Last edited by: Ahmed Mohmood
Last edited time: March 15, 2024 4:11 PM

## Information

**From Mitre:**

Adversaries may abuse mavinject.exe to proxy execution of malicious code. Mavinject.exe is the Microsoft Application Virtualization Injector, a Windows utility that can inject code into external processes as part of Microsoft Application Virtualization (App-V).[[1]](https://lolbas-project.github.io/lolbas/Binaries/Mavinject/)

Adversaries may abuse mavinject.exe to inject malicious DLLs into running processes (i.e. [Dynamic-link Library Injection](https://attack.mitre.org/techniques/T1055/001)), allowing for arbitrary code execution (ex. `C:\Windows\system32\mavinject.exe PID /INJECTRUNNING PATH_DLL`).[[2]](https://cybersecurity.att.com/blogs/labs-research/lazarus-campaign-ttps-and-evolution)[[3]](https://reaqta.com/2017/12/mavinject-microsoft-injector/) Since mavinject.exe may be digitally signed by Microsoft, proxying execution via this method may evade detection by security products because the execution is masked under a legitimate process.

---

## Artifacts & Detection

- Process creation
    
    Event id: 1
    
    **`Image** C:\Windows\System32\mavinject.exe`
    
    **`CommandLine** C:\Windows\system32\mavinject.exe 3124 /INJECTRUNNING meow.dll`
    

The detection would be threw processes creation events on image **`mavinject`** and command line `INJECTRUNNING` 

---

## Resources

- [https://github.com/redcanaryco/atomic-red-team/blob/master/atomics/T1055.001/T1055.001.md](https://github.com/redcanaryco/atomic-red-team/blob/master/atomics/T1055.001/T1055.001.md)
- [https://posts.specterops.io/mavinject-exe-functionality-deconstructed-c29ab2cf5c0e](https://posts.specterops.io/mavinject-exe-functionality-deconstructed-c29ab2cf5c0e)