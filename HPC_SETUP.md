# HPC Setup

## Connecting to Mantis (UConn HPC)

Because of UConn-specific security requirements, access to `Mantis` (UCONN HPC) will be through a special instance of Open OnDemand. [Open OnDemand](https://www.openondemand.org/) allows remote access to `Mantis` resources via a web browser. Some key resources are available as “apps”. Access via Open OnDemand requires 2-factor authentication with an Authenticator app. Several apps are suitable, including:

- Google Authenticator
- Microsoft Authenticator
- FreeOTP

Once configured, these apps generate time-based one-time passwords (TOTP) as a second form of authentication in addition to your user ID and password (which will be sent directly to each participant via email).


To log in with a course account, visit https://learn.hpc.cam.uchc.edu and enter the user ID and password assigned to you:


![](./resources/img/authentication1.png)


On first login, you will see the Mobile Authenticator Setup message with instructions to configure your OTP device.

Follow the instructions and retrieve the code from the OTP application you chose. Enter the code in the One-time code field and click “Submit”. You will be logged into the Mantis Open OnDemand portal.

![](./resources/img/authentication2.png)


Once you are logged in, you'll see something like this:


![](./resources/img/ondemand.png)


- You can start a `Mantis Shell Access`. Once there, you can request resources for an interactive session, which we'll use for most of the workshop.

- You can start an interactive session as shown below; the important part is that you specify the QoS (Quality of Service) as interactive (`--qos=interactive`). 

```
srun -p general --qos=interactive -c 1 --mem=1G --pty bash
```

> **IMPORTANT** ‼️
> The  QoS (interactive) can optionally be used for starting  interactive jobs, which will give the job a higher priority in the queue. This QOS has the following limits:
>   - 1 concurrent job
>   - no more than 8 CPUs
>   - no more than 64 GB of memory
>   - no more than 8 hours of wall time


## Testing the TE Tools container

After receiving your account and logging in:

- You'll have the script that calls the Singularity container, and the container itself,  in your home directory.
- You can use it like so:
```
 ./dfam-tetools.sh --container dfam-tetools.sif --singularity
```
Or:
```
   $HOME/dfam-tetools.sh --container dfam-tetools.sif --singularity
```
 Or:
 ```
   ~/dfam-tetools.sh --container dfam-tetools.sif --singularity
 ```

 ## Test the installation on `Mantis.`

 Once in the container, you'll see the following prompt:
 ```
 Singularity>
 ```
 
 To test that everything is working, you can run the same code as for your local installation:

 ```
   RepeatMasker -v ; RepeatModeler -version ; which faToTwoBit twoBitInfo
```

 And you should see something like this:

 ```
 Singularity> RepeatMasker -v ; RepeatModeler -version ; which faToTwoBit twoBitInfo
 RepeatMasker version 4.2.6
 RepeatModeler version 2.0.9
 /opt/ucsc_tools/faToTwoBit
 /opt/ucsc_tools/twoBitInfo
 ```

If you got all of this, we are ready to go and start our workshop!!!

