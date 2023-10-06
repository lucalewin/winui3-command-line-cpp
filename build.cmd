@rem winget install "Visual Studio Community 2022"  --override "--add Microsoft.VisualStudio.Workload.NativeDesktop  Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cpp" -s msstore
@rem winget install --id Microsoft.WindowsAppRuntime.1.4.230913002
@rem winget install --id Microsoft.NuGet

@rem install cppwinrt and the windows app sdk
@rem nuget install Microsoft.Windows.CppWinRT -OutputDirectory packages -Version 2.0.230225.1
nuget install Microsoft.WindowsAppSDK -OutputDirectory packages -Version 1.4.230913002

@rem generate header files
@rem packages\Microsoft.Windows.CppWinRT.2.0.230225.1\bin\cppwinrt.exe -optimize -input packages\Microsoft.WindowsAppSDK.1.4.230913002\lib\uap10.0 -input packages\Microsoft.WindowsAppSDK.1.4.230913002\lib\uap10.0.18362 -input sdk -output "generated_files"
cppwinrt -optimize -input packages\Microsoft.WindowsAppSDK.1.4.230913002\lib\uap10.0 -input packages\Microsoft.WindowsAppSDK.1.4.230913002\lib\uap10.0.18362 -input sdk -output "generated_files"

@rem compile the source code
cl /I"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" /I"packages\Microsoft.WindowsAppSDK.1.4.230913002\include" /I"C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\ucrt" /I"generated_files" /I"C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um" /I"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.37.32822\include" /I"C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\shared" /EHsc /std:c++17 main.cpp /link /LIBPATH:"packages\Microsoft.WindowsAppSDK.1.4.230913002\lib\win10-x64" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" /LIBPATH:"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\14.37.32822\lib\x64" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\ucrt\x64" Microsoft.WindowsAppRuntime.Bootstrap.lib Microsoft.WindowsAppRuntime.lib WindowsApp.lib /SUBSYSTEM:WINDOWS /MANIFEST:EMBED

@rem copy the bootstrap dll into the same directory as main.exe
copy packages\Microsoft.WindowsAppSDK.1.4.230913002\runtimes\win10-x64\native\Microsoft.WindowsAppRuntime.Bootstrap.dll .

@rem run the application
main.exe
