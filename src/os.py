import platform

# This function detects the OS the user is running and if Valorant is officially supported on that platform
# Returns ["operating system" (string), "Runs Valorant" (bool)]
def get_os():   
    system = platform.system()
    
    if system == "Windows":
        win_version = platform.win32_ver()[0]
        win_build_number = int(platform.win32_ver()[1].split(".")[-1])
        # Check for Windows 10
        if win_version == '10':
            # Specific check for Windows 11 using build number (workaround for misidentification issue)
            if win_build_number >= 22000:
                return f"Windows 11 {platform.win32_edition()} {platform.win32_ver()[1]}", True
            return f"Windows 10 {platform.win32_edition()} {platform.win32_ver()[1]}", True
        # Check for Windows 11 (assuming direct identification is possible in the future)
        elif win_version == '11':
            return f"Windows 11 {platform.win32_edition()} {platform.win32_ver()[1]}", True
        # Other Windows versions
        else:
            return f"Unsupported Windows version: Windows {win_version} {platform.win32_edition()} {platform.win32_ver()[1]}", False

    # Non-Windows operating systems
    else:
        return "Non-Windows operating system", False
