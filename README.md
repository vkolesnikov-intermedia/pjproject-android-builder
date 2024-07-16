# PJSIP Android Builder

Easily build PJSIP with: OpenSSL, Opus and G.729 (without Intel IPP) for Android.

## Purpose trigger

I needed an easily replicable build system to build PJSIP <http://www.pjsip.org/> native library with NDK for Android. 
So, I created an Ubuntu docker container (22.04 LTS) and wrote some scripts to download, install all the requirements needed to make it a complete build environment and some automated build scripts.
If you want to contribute, your help is really appreciated :)

## Support - PJSIP 2.13+

Using Android API `28`.
Default versions included:

- Android Cmd Tools: `8512546`
- Android NKD: `r26c`
- OpenSSL: `3.1.2` (Uses NDK Level 28)
- Opus: `1.3.1`
- bcg729: `1.1.1`
- Swig: `4.0.2`

## Setup

You can install everything on your local machine, or (the way I do) use an Ubuntu Docker container and mount an external volume with this repo. E.g.:

```bash
docker run -it --name pjsip-builder -v /path/to/host/repo:/home ubuntu bash
```

### Configuration

1. Clone this repo on your machine or in the mounted volume inside your container.
2. Properly configure the `config.conf` file. It's possible to configure libraries versions and build settings by editing it. The settings in the `Support` section above have been tested. Please read the comments in the file for more details. Now single libraries can be configured to be compiled with PJSIP without further editing, just enable the switches in the config file.
3. In the `config.conf` file there are some toggles to apply patches ([`fixed_callid`](patches/fixed_callid)). See the respective README for more info.

### Prepare Environment

1. Execute `./prepare-build-system`
2. If everything goes well you should see all the compiled libraries (opus, openssl, bcg729) in the **output** folder.

## Build PJSIP

After you have successfully set up everything, to build PJSIP execute `./build`

The script is going to create a new folder inside the output named **pjsip-output-build** organized as follows:

```none
pjsip-output-build
 |-- logs/  contains the full build log for each target architecture
 |-- lib/   contains the compiled libraries for each target architecture
 |-- java/   contains PJSUA Java wrapper to work with the library
```

If something goes wrong during the compilation of a particular target architecture, the main script will be terminated and you can see the full log in `./pjsip-output-build/logs/<arch>.log`. So for example if there's an error for **x86**, you can see the full log in `./pjsip-output-build/logs/x86.log`

#### x86 Relocation

To fix the issue, popping up in recent NDK versions. I've used the fix proposed by @alexmelnikov [here](https://github.com/VoiSmart/pjsip-android-builder/pull/28/commits/b4b1868b741f7eae037ea8b7ab274c8f1ac2c3e8), but I have applied it only for `x86` arch.

## Build Libraries only

This project has separate independent script to build only single libraries:

- Bcg729
- OpenSSL
- Opus

If you want to build a single library, or just change it's version, you can disable everything except the library you want to build from the `config.conf` file and specify the version you want (of course you would also need the NDK). Then execute the `prepare-build-system` script. If the environment is ready you can also just run the lib dedicated script.

## License

```text
Copyright (C) 2015-2022 VoiSmart Srl

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
