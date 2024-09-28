locals {
  ami_ids = {
    linux          = data.aws_ami.latest_ubuntu_22.id
    windows        = data.aws_ami.latest_windows_server_2022.id
    linux_graviton = data.aws_ami.latest_ubuntu_22_graviton.id
  }
}

locals {
  user_admin_linux = <<-EOF
    #!/bin/bash

    USERNAME="adminge"
    PASSWORD="adminge"

    # Check if user already exists
    if id "$USERNAME" &>/dev/null; then
        echo "User $USERNAME already exists. Skipping user creation."
    else
        # Create the user
        useradd -m -s /bin/bash "$USERNAME"
        echo "User $USERNAME created."
        
        # Set the password
        echo "$USERNAME:$PASSWORD" | chpasswd
        echo "Password set for user $USERNAME."
    fi

    # Add the user to the sudo group
    usermod -aG sudo "$USERNAME"
    echo "User $USERNAME added to sudo group."

    # Configure SSH to allow password authentication
    SSH_CONFIG="/etc/ssh/sshd_config"

    # Backup the original SSH config file
    cp "$SSH_CONFIG" "$SSH_CONFIG.bak"

    # Enable password authentication
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' "$SSH_CONFIG"
    sed -i 's/^PasswordAuthentication no/#PasswordAuthentication no/' "$SSH_CONFIG"

    # Restart SSH service to apply changes
    systemctl restart sshd

    echo "SSH configured to allow password authentication."
  EOF

  user_admin_windows = <<-EOF
    <powershell>
    # Variables de usuario y contraseña
    $username = "adminge"
    $password = "adminge"

    # Verificar si el usuario ya existe
    if (!(Get-WmiObject -Class Win32_UserAccount | Where-Object {$_.Name -eq $username})) {
        # Crear un nuevo usuario local
        $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
        New-LocalUser -Name $username -Password $securePassword -Description "Local Administrator" -FullName "Local Administrator" -PasswordNeverExpires

        # Agregar el usuario al grupo de administradores locales
        Add-LocalGroupMember -Group "Administrators" -Member $username
        Write-Host "User $username created and added to Administrators group."
    } else {
        Write-Host "User $username already exists. Skipping user creation."
    }

    # Habilitar el firewall para permitir RDP (puerto 3389)
    netsh advfirewall firewall add rule name="Allow RDP" dir=in action=allow protocol=TCP localport=3389

    # Configurar el sistema para permitir conexiones RDP
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

    # Reiniciar el servicio de Escritorio remoto para aplicar los cambios
    Restart-Service -Name TermService -Force

    </powershell>
  EOF

}
locals {
  user_data = {
    linux_db = <<EOF
      #!/bin/bash
      # Formatear /dev/sdb como ext4 y montarlo en /opt
      mkfs.ext4 /dev/sdb
      mkdir /opt
      mount /dev/sdb /opt
      echo "/dev/sdb /opt ext4 defaults 0 0" >> /etc/fstab

      # Configurar /dev/sdc como swap
      mkswap /dev/sdc
      swapon /dev/sdc
      echo "/dev/sdc none swap sw 0 0" >> /etc/fstab

      # Formatear /dev/sdd como ext4 y montarlo en /logs
      mkfs.ext4 /dev/sdd
      mkdir /logs
      mount /dev/sdd /logs
      echo "/dev/sdd /logs ext4 defaults 0 0" >> /etc/fstab

      # Formatear /dev/sde como ext4 y montarlo en /data
      mkfs.ext4 /dev/sde
      mkdir /data
      mount /dev/sde /data
      echo "/dev/sde /data ext4 defaults 0 0" >> /etc/fstab
    EOF

    linux = <<EOF
      #!/bin/bash
      # Formatear /dev/sdb como ext4 y montarlo en /opt
      mkfs.ext4 /dev/sdb
      mkdir /opt
      mount /dev/sdb /opt
      echo "/dev/sdb /opt ext4 defaults 0 0" >> /etc/fstab

      # Configurar /dev/sdc como swap
      mkswap /dev/sdc
      swapon /dev/sdc
      echo "/dev/sdc none swap sw 0 0" >> /etc/fstab
    EOF

    windows = <<EOF
    <powershell>
      $disk2 = Get-Disk | Where-Object {$_.IsSystem -eq $False -and $_.IsBoot -eq $False -and $_.PartitionStyle -eq 'RAW'}
      $disk2 | Initialize-Disk -PartitionStyle GPT
      $disk2 | New-Partition -AssignDriveLetter -UseMaximumSize
      $disk2 | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Data" -Confirm:$false
      $disk3 = Get-Disk | Where-Object {$_.IsSystem -eq $False -and $_.IsBoot -eq $False -and $_.PartitionStyle -eq 'RAW'}
      $disk3 | Initialize-Disk -PartitionStyle GPT
      $disk3 | New-Partition -AssignDriveLetter -UseMaximumSize
      $disk3 | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Pagefile" -Confirm:$false
      Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'PagingFiles' -Value 'E:\pagefile.sys 1024 2048'
    </powershell>
  EOF

  }
}
locals {
  gaviton_instance_types = [null_resource.gaviton_instance_types]
}
