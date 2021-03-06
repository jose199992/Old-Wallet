:: _______________________________________________________________ ::
::|           ____ _  _ _    _    ____ _  _ ____ _ _  _           |::
::|           [__  |  | |    |    |___ |  | |__/ |  \/            |::
::|           ___] |__| |___ |___ |    |__| |  \ | _/\_           |::
::|_______________________________________________________________|::
@echo off & cls & color 0B
mode con cols=70 lines=13

:menu
cls & color 0B
mode con cols=70 lines=13
Title Old Wallet

echo.
echo.      ==========================Menu============================
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.
echo.      ==========================================================
set choice=
echo. & set /p choice=The number of your choice and press ENTER: || goto :menu
echo. & call :menu_[%choice%]
goto:menu
::********************************************************************************************
:menu_[1] Add address
mode con cols=70 lines=10
Title Add address...
cls & color 0B

echo.
echo.      ==========================Menu============================
echo.
echo.           [1]  Add an address and a cryptocurrency
echo.           [2]  Add an address in an existing cryptocurrency
echo.           [3]  Go back
echo.
echo.      ==========================================================
set choice=
echo. & set /p choice=The number of your choice and press ENTER: || goto :menu_[1]
echo. & call :subAddMenu_[%choice%]
goto:menu_[1]
::=============================================
:subAddMenu_[1]
mode con cols=75 lines=13
Title Add address and cryptocurrency...
cls & color 0B

set /p cryptoName=Enter the name of the cryptocurrency you wish to add(ex:Bitcoin):
mkdir ".\wallet\%cryptoName%"

set /p addressName=Enter the name of the address you wish to add(ex:Address1):

set /p cryptoPublic=Enter your public key:
echo.%addressName%:%cryptoPublic%>>.\wallet\%cryptoName%\%cryptoName%_public.key

set /p cryptoPrivate=Enter your private key:
echo.%addressName%:%cryptoPrivate%>>.\wallet\%cryptoName%\%cryptoName%_private.key

echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subAddMenu_[2]
mode con cols=90 lines=999999
Title Add address
cls & color 0B

dir /b/o:n ".\wallet\"

set /p cryptoName=Choose the name of the cryptocurrency to which you want to add an address:
set /p addressName=Enter the name of the address you wish to add(ex:Address1):

set /p cryptoPublic=Enter your public key:
echo.%addressName%:%cryptoPublic%>>.\wallet\%cryptoName%\%cryptoName%_public.key

set /p cryptoPrivate=Enter your private key:
echo.%addressName%:%cryptoPrivate%>>.\wallet\%cryptoName%\%cryptoName%_private.key

echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subAddMenu_[3]
goto:menu
::********************************************************************************************
:menu_[2] Show address
mode con cols=84 lines=13
Title Show address...
cls & color 0B

echo.
echo.      ================================Menu==================================
echo.
echo.           [1]  Display the public key for a specific cryptocurrency
echo.           [2]  Display the private key for a specific cryptocurrency
echo.           [3]  Display all public keys of all crypto currencies
echo.           [4]  Display all private keys of all crypto currencies
echo.           [5]  Go back
echo.
echo.      ======================================================================
set choice=
echo. & set /p choice=The number of your choice and press ENTER: || goto :menu_[2]
echo. & call :subShowMenu_[%choice%]
goto:menu_[2]
::=============================================
:subShowMenu_[1] Show a public key
mode con cols=72 lines=999999
Title Show a public key...
cls & color 0B

dir /b/o:n ".\wallet\"

set /p cryptoName=Enter the name of the cryptocurrency:
set publicKey=.\wallet\%cryptoName%\%cryptoName%_public.key
echo ----%cryptoName%----
type %publicKey%

echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subShowMenu_[2] Show a private key
mode con cols=72 lines=999999
Title Show a private key...
cls & color 0B

dir /b/o:n ".\wallet\"

set /p cryptoName=Enter the name of the cryptocurrency:
set privateKey=.\wallet\%cryptoName%\%cryptoName%_private.key
echo ----%cryptoName%----
type %privateKey%

echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subShowMenu_[3] Show all public keys
mode con cols=72 lines=999999
Title Show all public keys...
cls & color 0B

for /f "tokens=*" %%c in ('dir /b/o:n ".\wallet\"') do echo ----%%c----&& type ".\wallet\%%c\%%c_public.key"

echo.
echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subShowMenu_[4] Show all private keys
mode con cols=72 lines=999999
Title Show all private keys...
cls & color 0B

for /f "tokens=*" %%c in ('dir /b/o:n ".\wallet\"') do echo ----%%c----&& type ".\wallet\%%c\%%c_private.key"

echo.
echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subShowMenu_[5]
goto:menu
::********************************************************************************************
:menu_[3] Delete address
mode con cols=84 lines=13
Title Delete address...
cls & color 0B

echo.
echo.      ================================Menu==================================
echo.
echo.           [1]  Delete an address
echo.           [2]  Delete a cryptocurrency
echo.           [3]  Go back
echo.
echo.      ======================================================================
set choice=
echo. & set /p choice=The number of your choice and press ENTER: || goto :menu_[3]
echo. & call :subDelMenu_[%choice%]
goto:menu_[3]
::=============================================
:subDelMenu_[1] Delete an address
mode con cols=72 lines=999999
Title Delete an address...
cls & color 0B

dir /b/o:n ".\wallet\"
set /p cryptoName=Enter the name of the cryptocurrency to delete an address:

set publicKey=.\wallet\%cryptoName%\%cryptoName%_public.key
echo -----%cryptoName%-----
type %publicKey%
set /p addressName=Enter the name of the address:

type ".\wallet\%cryptoName%\%cryptoName%_public.key" | findstr /b /v "%addressName%:">%cryptoName%_public.key
move "%cryptoName%_public.key" ".\wallet\%cryptoName%\%cryptoName%_public.key"

type ".\wallet\%cryptoName%\%cryptoName%_private.key" | findstr /b /v "%addressName%:">%cryptoName%_private.key
move "%cryptoName%_private.key" ".\wallet\%cryptoName%\%cryptoName%_private.key"

echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subDelMenu_[2] Delete a cryptocurrency
mode con cols=72 lines=999999
Title Delete a cryptocurrency...
cls & color 0B

dir /b/o:n ".\wallet\"
set /p cryptoName=Enter the name of the cryptocurrency you wish to delete:
rmdir /s /q .\wallet\%cryptoName%

echo Click on a key to return to the menu
pause>nul
goto:menu
::=============================================
:subDelMenu_[3]
goto:menu
::********************************************************************************************
:menu_[4] Credits
@echo off
mode con cols=72 lines=13
Title Credits...
cls & color 0B
echo.
echo.
echo.	Old Wallet	By SullFurix
echo.
echo.
echo Click on a key to return to the menu
pause>nul
goto:menu
::********************************************************************************************
:EOF
EXIT