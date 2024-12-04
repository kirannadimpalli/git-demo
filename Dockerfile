FROM mcr.microsoft.com/windowsservercore

# USER Administrator

ENV PYTHON_VERSION=3.10.7

ENV S3_BUCKET_NAME="genietester"
ENV S3_PREFIX="msix-hero-3.0.0.0.msix"

# RUN powershell -Command \
#     Install-WindowsFeature -Name Web-Server; \
#     Invoke-WebRequest -Uri "https://www.python.org/ftp/python/$env:PYTHON_VERSION/python-$env:PYTHON_VERSION-amd64.exe" -OutFile "python-installer.exe"; \
#     Start-Process -Wait -FilePath "python-installer.exe" -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1"; \
#     Remove-Item -Force "python-installer.exe";

ADD https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe C:/python3.exe
RUN powershell -Command \
  $ErrorActionPreference = 'Stop'; \
  Start-Process c:\python3.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1' -Wait ; \
  Remove-Item c:\python3.exe -Force

# RUN powershell Start-Service -Name mpssvc 

RUN python -m ensurepip --upgrade

COPY . . 

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]
