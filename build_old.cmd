winget install "Visual Studio Community 2022"  --override "--add Microsoft.VisualStudio.Workload.NativeDesktop  Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cpp" -s msstore
winget install --id Microsoft.WindowsAppRuntime.1.2
winget install --id Microsoft.NuGet
nuget install Microsoft.Windows.CppWinRT -OutputDirectory packages -Version 2.0.230225.1
nuget install Microsoft.WindowsAppSDK -OutputDirectory packages -Version 1.2.230217.4
packages\Microsoft.Windows.CppWinRT.2.0.230225.1\bin\cppwinrt.exe -optimize -input packages\Microsoft.WindowsAppSDK.1.2.230217.4\lib\uap10.0 -input packages\Microsoft.WindowsAppSDK.1.2.230217.4\lib\uap10.0.18362 -input sdk -output "Generated Files"
cl /I"packages\Microsoft.WindowsAppSDK.1.2.230217.4\include" /I"Generated Files" /EHsc /std:c++17 main.cpp /link /LIBPATH:"packages\Microsoft.WindowsAppSDK.1.2.230217.4\lib\win10-x64" Microsoft.WindowsAppRuntime.Bootstrap.lib Microsoft.WindowsAppRuntime.lib WindowsApp.lib /SUBSYSTEM:WINDOWS /MANIFEST:EMBED
copy packages\Microsoft.WindowsAppSDK.1.2.230217.4\runtimes\win10-x64\native\Microsoft.WindowsAppRuntime.Bootstrap.dll .
main
