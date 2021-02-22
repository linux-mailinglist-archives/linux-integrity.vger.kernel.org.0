Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B73321147
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 08:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBVHQW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 02:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBVHQM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 02:16:12 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A861C06178C
        for <linux-integrity@vger.kernel.org>; Sun, 21 Feb 2021 23:15:31 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a22so55017189ljp.10
        for <linux-integrity@vger.kernel.org>; Sun, 21 Feb 2021 23:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ptafUMK0hlESDhzX74/0dcaw/GMtAg7QcL3J2k+aHJo=;
        b=PnZ2/mQjUPrJepdNHSpwxRFAFDvyM8fBwAvHwdRde7mSXPoib+maQG8StbdQPZIrHD
         uvUx8f5Dm9n+v8kfuA+H30gZj/lYMIhjuRPgn30K8j+GjrHDHeuRiHH0kvYQdA8NWdPQ
         ceAeZA6TJ/pvsXnO2gbyGZKGYzSuF0+73M3vqg1MdqmlYIA5MoQVT0laUs7tF5XB9u+3
         xBtk9XP6C4BHSyN7GTcsvdJYhVFZHfxbSAr5JbxVl7Ps8IYei7zsZ44QvqZAeHprqda8
         64KTt5MnnkgPr6jAlCLsirc1qQGl+Zz9V2zUnPbV2pckFmjkecu4n4lFws6SHJvX1egu
         FfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ptafUMK0hlESDhzX74/0dcaw/GMtAg7QcL3J2k+aHJo=;
        b=ovUFm4EGSmfTjwhqmHzFHldvqvCdZhORSlkLf1QAB8+zeoaF+ZVaFMOgbh/YZJpscP
         gngip3bOJ63fKDDI/+wnDes5Pho83+77xCHszys/JJ90YbFW/VBcvlWOo+IXN6Q/fL8x
         oplah+q1okXx53VOeJEXMjjIyLqf0wEfJ7j2WRZyRh1QAtSzVzNySAXGLd/GVkMWSrBk
         8Mo5Y5lXNY4HqvOze4MrECnRDEAHhyBM42DMPUPv4D2EHgVdTm+gaoQ/OHYXJcHw3PTS
         aiUUOJ48OjAXf2b6TWTEiLKLWZOgL9jLH7MG2gfZDx5P7XK0GOs0rboLrWqwpV99aKqv
         W11A==
X-Gm-Message-State: AOAM533bALNiwwl9SujkjvFh0hN2Zoj27VHKFXAePeCGDb74Y0srDAhc
        3QyPFfliYcSUIBegQ5frnfwP14wgOOMwTCwGqKLnHw==
X-Google-Smtp-Source: ABdhPJyqpXfsUIk0CqAddZjCgGFwxPOgqGXlxPgNPxl8jj3p87NjV5TBAczvReXu0+rpnVKl5PKZsimUfeQkuAb7TW0=
X-Received: by 2002:a2e:b01a:: with SMTP id y26mr13625700ljk.442.1613978129493;
 Sun, 21 Feb 2021 23:15:29 -0800 (PST)
MIME-Version: 1.0
References: <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
 <01000177223f74d3-1eef7685-4a19-40d2-ace6-d4cd7f35579d-000000@email.amazonses.com>
 <dc3979e8-6bf0-adb7-164d-d50e805a048f@forissier.org> <YAmYu9FxWcLPhBhs@kernel.org>
 <YAmcyKnYCK+Y4IGW@kernel.org> <1486cfe8-bc30-1266-12bd-0049f2b64820@forissier.org>
 <YAsVenGkaqb8205f@kernel.org> <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>
 <YCW/BKmeswM5AThU@kernel.org> <CAFA6WYNiM3cPqPDhzQ5vaadvhqsxm51820RjorZkFB+-ntoRqA@mail.gmail.com>
 <YCt0QPVX4LeFKMsX@kernel.org>
In-Reply-To: <YCt0QPVX4LeFKMsX@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 22 Feb 2021 12:45:18 +0530
Message-ID: <CAFA6WYNL+iqFYfJXa7kj7nDjJs5c5rMBc5hnzxYu-sgiiAykuw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, dave.hansen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 16 Feb 2021 at 12:59, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon, Feb 15, 2021 at 06:37:00PM +0530, Sumit Garg wrote:
> > On Fri, 12 Feb 2021 at 05:04, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
> > >
> > > On Mon, Jan 25, 2021 at 02:47:38PM +0530, Sumit Garg wrote:
> > > > Hi Jarkko,
> > > >
> > > > On Fri, 22 Jan 2021 at 23:42, Jarkko Sakkinen <jarkko@kernel.org> w=
rote:
> > > > >
> > > > > On Thu, Jan 21, 2021 at 05:23:45PM +0100, Jerome Forissier wrote:
> > > > > >
> > > > > >
> > > > > > On 1/21/21 4:24 PM, Jarkko Sakkinen wrote:
> > > > > > > On Thu, Jan 21, 2021 at 05:07:42PM +0200, Jarkko Sakkinen wro=
te:
> > > > > > >> On Thu, Jan 21, 2021 at 09:44:07AM +0100, Jerome Forissier w=
rote:
> > > > > > >>>
> > > > > > >>>
> > > > > > >>> On 1/21/21 1:02 AM, Jarkko Sakkinen via OP-TEE wrote:
> > > > > > >>>> On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote=
:
> > > > > > >>>>> On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@ker=
nel.org> wrote:
> > > > > > >>>>>>
> > > > > > >>>>>> On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkine=
n wrote:
> > > > > > >>>>>>> On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wr=
ote:
> > > > > > >>>>>>>> On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@=
kernel.org> wrote:
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg =
wrote:
> > > > > > >>>>>>>>>> Hi Jarkko,
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkk=
o@kernel.org> wrote:
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Gar=
g wrote:
> > > > > > >>>>>>>>>>>> Add support for TEE based trusted keys where TEE p=
rovides the functionality
> > > > > > >>>>>>>>>>>> to seal and unseal trusted keys using hardware uni=
que key.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> Refer to Documentation/tee.txt for detailed inform=
ation about TEE.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> I haven't yet got QEMU environment working with aar=
ch64, this produces
> > > > > > >>>>>>>>>>> just a blank screen:
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> ./output/host/usr/bin/qemu-system-aarch64 -M virt -=
cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/roo=
tfs.cpio -serial stdio
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> My BuildRoot fork for TPM and keyring testing is lo=
cated over here:
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jar=
kko/buildroot-tpmdd.git/
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> The "ARM version" is at this point in aarch64 branc=
h. Over time I will
> > > > > > >>>>>>>>>>> define tpmdd-x86_64 and tpmdd-aarch64 boards and ev=
erything will be then
> > > > > > >>>>>>>>>>> in the master branch.
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> To create identical images you just need to
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> $ make tpmdd_defconfig && make
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> Can you check if you see anything obviously wrong? =
I'm eager to test this
> > > > > > >>>>>>>>>>> patch set, and in bigger picture I really need to h=
ave ready to run
> > > > > > >>>>>>>>>>> aarch64 environment available.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> I would rather suggest you to follow steps listed he=
re [1] as to test
> > > > > > >>>>>>>>>> this feature on Qemu aarch64 we need to build firmwa=
res such as TF-A,
> > > > > > >>>>>>>>>> OP-TEE, UEFI etc. which are all integrated into OP-T=
EE Qemu build
> > > > > > >>>>>>>>>> system [2]. And then it would be easier to migrate t=
hem to your
> > > > > > >>>>>>>>>> buildroot environment as well.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> [1] https://lists.trustedfirmware.org/pipermail/op-t=
ee/2020-May/000027.html
> > > > > > >>>>>>>>>> [2] https://optee.readthedocs.io/en/latest/building/=
devices/qemu.html#qemu-v8
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> -Sumit
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> Can you provide 'keyctl_change'? Otherwise, the steps=
 are easy to follow.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> $ cat keyctl_change
> > > > > > >>>>>>>> diff --git a/common.mk b/common.mk
> > > > > > >>>>>>>> index aeb7b41..663e528 100644
> > > > > > >>>>>>>> --- a/common.mk
> > > > > > >>>>>>>> +++ b/common.mk
> > > > > > >>>>>>>> @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?=3D $(=
OPTEE_OS_TA_DEV_KIT_DIR)
> > > > > > >>>>>>>>  BR2_PACKAGE_OPTEE_TEST_SITE ?=3D $(OPTEE_TEST_PATH)
> > > > > > >>>>>>>>  BR2_PACKAGE_STRACE ?=3D y
> > > > > > >>>>>>>>  BR2_TARGET_GENERIC_GETTY_PORT ?=3D $(if
> > > > > > >>>>>>>> $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),tt=
yAMA0)
> > > > > > >>>>>>>> +BR2_PACKAGE_KEYUTILS :=3D y
> > > > > > >>>>>>>>
> > > > > > >>>>>>>>  # All BR2_* variables from the makefile or the enviro=
nment are appended to
> > > > > > >>>>>>>>  # ../out-br/extra.conf. All values are quoted "..." e=
xcept y and n.
> > > > > > >>>>>>>> diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> > > > > > >>>>>>>> index 368c18a..832ab74 100644
> > > > > > >>>>>>>> --- a/kconfigs/qemu.conf
> > > > > > >>>>>>>> +++ b/kconfigs/qemu.conf
> > > > > > >>>>>>>> @@ -20,3 +20,5 @@ CONFIG_9P_FS=3Dy
> > > > > > >>>>>>>>  CONFIG_9P_FS_POSIX_ACL=3Dy
> > > > > > >>>>>>>>  CONFIG_HW_RANDOM=3Dy
> > > > > > >>>>>>>>  CONFIG_HW_RANDOM_VIRTIO=3Dy
> > > > > > >>>>>>>> +CONFIG_TRUSTED_KEYS=3Dy
> > > > > > >>>>>>>> +CONFIG_ENCRYPTED_KEYS=3Dy
> > > > > > >>>>>>>>
> > > > > > >>>>>>>>> After I've successfully tested 2/4, I'd suggest that =
you roll out one more
> > > > > > >>>>>>>>> version and CC the documentation patch to Elaine and =
Mini, and clearly
> > > > > > >>>>>>>>> remark in the commit message that TEE is a standard, =
with a link to the
> > > > > > >>>>>>>>> specification.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> Sure, I will roll out the next version after your test=
ing.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Thanks, I'll try this at instant, and give my feedback.
> > > > > > >>>>>>
> > > > > > >>>>>> I bump into this:
> > > > > > >>>>>>
> > > > > > >>>>>> $ make run-only
> > > > > > >>>>>> ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/imag=
es/rootfs.cpio.gz /home/jarkko/devel/tpm/optee/build/../out/bin/
> > > > > > >>>>>> ln: failed to create symbolic link '/home/jarkko/devel/t=
pm/optee/build/../out/bin/': No such file or directory
> > > > > > >>>>>> make: *** [Makefile:194: run-only] Error 1
> > > > > > >>>>>>
> > > > > > >>>>>
> > > > > > >>>>> Could you check if the following directory tree is built =
after
> > > > > > >>>>> executing the below command?
> > > > > > >>>>>
> > > > > > >>>>> $ make -j`nproc`
> > > > > > >>>>> CFG_IN_TREE_EARLY_TAS=3Dtrusted_keys/f04a0fe7-1f5d-4b9b-a=
bf7-619b85b4ce8c
> > > > > > >>>>>
> > > > > > >>>>> $ tree out/bin/
> > > > > > >>>>> out/bin/
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl1.bin -> /home/sumit/build/=
optee/build/../trusted-firmware-a/build/qemu/release/bl1.bin
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl2.bin -> /home/sumit/build/=
optee/build/../trusted-firmware-a/build/qemu/release/bl2.bin
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl31.bin ->
> > > > > > >>>>> /home/sumit/build/optee/build/../trusted-firmware-a/build=
/qemu/release/bl31.bin
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl32.bin ->
> > > > > > >>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/te=
e-header_v2.bin
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl32_extra1.bin ->
> > > > > > >>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/te=
e-pager_v2.bin
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl32_extra2.bin ->
> > > > > > >>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/te=
e-pageable_v2.bin
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl33.bin ->
> > > > > > >>>>> /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKe=
rnel-AARCH64/RELEASE_GCC49/FV/QEMU_EFI.fd
> > > > > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 Image -> /home/sumit/build/op=
tee/build/../linux/arch/arm64/boot/Image
> > > > > > >>>>> =E2=94=94=E2=94=80=E2=94=80 rootfs.cpio.gz ->
> > > > > > >>>>> /home/sumit/build/optee/build/../out-br/images/rootfs.cpi=
o.gz
> > > > > > >>>>>
> > > > > > >>>>> 0 directories, 9 files
> > > > > > >>>>>
> > > > > > >>>>> -Sumit
> > > > > > >>>>
> > > > > > >>>> I actually spotted a build error that was unnoticed last t=
ime:
> > > > > > >>>>
> > > > > > >>>> make[2]: Entering directory '/home/jarkko/devel/tpm/optee/=
edk2/BaseTools/Tests'
> > > > > > >>>> /bin/sh: 1: python: not found
> > > > > > >>>>
> > > > > > >>>> I'd prefer not to install Python2. It has been EOL over a =
year.
> > > > > > >>>
> > > > > > >>> AFAIK, everything should build fine with Python3. On my Ubu=
ntu 20.04
> > > > > > >>> machine, this is accomplished by installing package "python=
-is-python3"
> > > > > > >>> (after uninstalling "python-is-python2" if need be).
> > > > > > >>>
> > > > > > >>> $ ls -l /usr/bin/python
> > > > > > >>> lrwxrwxrwx 1 root root 7 Apr 15  2020 /usr/bin/python -> py=
thon3
> > > > > > >>
> > > > > > >> Right, just found about this in unrelated context :-) [*]
> > > > > > >>
> > > > > > >> Hope this will work out...
> > > > > > >>
> > > > > > >> [*] https://github.com/surge-synthesizer/surge/pull/3655
> > > > > > >
> > > > > > > Now I get
> > > > > > >
> > > > > > > Traceback (most recent call last):
> > > > > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/=
RunTests.py", line 36, in <module>
> > > > > > >     allTests =3D GetAllTestsSuite()
> > > > > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/=
RunTests.py", line 33, in GetAllTestsSuite
> > > > > > >     return unittest.TestSuite([GetCTestSuite(), GetPythonTest=
Suite()])
> > > > > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/=
RunTests.py", line 25, in GetCTestSuite
> > > > > > >     import CToolsTests
> > > > > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/=
CToolsTests.py", line 22, in <module>
> > > > > > >     import TianoCompress
> > > > > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/=
TianoCompress.py", line 69, in <module>
> > > > > > >     TheTestSuite =3D TestTools.MakeTheTestSuite(locals())
> > > > > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/=
TestTools.py", line 43, in MakeTheTestSuite
> > > > > > >     for name, item in localItems.iteritems():
> > > > > > > AttributeError: 'dict' object has no attribute 'iteritems'
> > > > > >
> > > > > > Right. Same here after removing all traces of Python2 from my s=
ystem :-/
> > > > > >
> > > > > > A couple of fixes are needed:
> > > > > > 1. EDK2 needs to be upgraded to tag or later [1]
> > > > > > 2. The PYTHON3_ENABLE environment variable needs to be set to T=
RUE [2]
> > > > > >
> > > > > > [1] https://github.com/OP-TEE/manifest/pull/177
> > > > > > [2] https://github.com/OP-TEE/build/pull/450
> > > > >
> > > > > BTW, Is to *really* impossible to test this with plain BuildRoot.=
  It's
> > > > > obvious that this forks BR internally.
> > > > >
> > > > > I mean even if I get this working once, this will feels like a cl=
umsy way
> > > > > to test Aarch64 regularly. I use BuildRoot extensively for x86 te=
sting. And
> > > > > it would be nice to be able to start doing regular ARM testing.
> > > >
> > > > The main reason to guide you towards the OP-TEE build system is tha=
t
> > > > you will be able to build all the firmwares (TF-A, OP-TEE, edk2 etc=
.)
> > > > from source. If you don't need to rebuild those then I have prepare=
d a
> > > > flash firmware binary blob for your testing (attached flash.bin). S=
o
> > > > Qemu cmdline will look like:
> > > >
> > > > $ qemu-system-aarch64 -nographic -s -machine virt,secure=3Don -cpu
> > > > cortex-a57 -kernel out/bin/Image -no-acpi -append
> > > > 'console=3DttyAMA0,38400 keep_bootcon root=3D/dev/vda2' -initrd
> > > > out/bin/rootfs.cpio.gz -smp 2 -m 1024 -bios flash.bin -d unimp
> > >
> > > I spentt couple of days to try to get this running.
> > >
> > > Here's the log:
> > >
> > > =E2=9D=AF ./qemu.sh
> > > NOTICE:  Booting Trusted Firmware
> > > NOTICE:  BL1: v2.3():v2.3
> > > NOTICE:  BL1: Built : 13:28:04, Jan 25 2021
> > > NOTICE:  BL1: Booting BL2
> > > NOTICE:  BL2: v2.3():v2.3
> > > NOTICE:  BL2: Built : 13:28:06, Jan 25 2021
> > > NOTICE:  BL1: Booting BL31
> > > NOTICE:  BL31: v2.3():v2.3
> > > NOTICE:  BL31: Built : 13:28:08, Jan 25 2021
> > > UEFI firmware (version  built at 18:49:27 on Nov 18 2019)
> > > pflash_write: Write to buffer emulation is flawed
> > > pflash_write: Write to buffer emulation is flawed
> > > EFI stub: Booting Linux Kernel...
> > > EFI stub: Using DTB from configuration table
> > > EFI stub: Exiting boot services and installing virtual address map...
> > > Booting Linux on physical CPU 0x0000000000 [0x411fd070]
> > > Linux version 5.11.0-rc5 (jarkko@suppilovahvero) (aarch64-buildroot-l=
inux-uclibc-gcc.br_real (Buildroot 2021.02-rc1-10-ga72c90b972) 9.3.0, GNU l=
d (GNU Binutils) 2.35.2) #1 SMP Thu Feb 11 22:04:53 EET 2021
> > > Machine model: linux,dummy-virt
> > > efi: EFI v2.70 by EDK II
> > > efi: SMBIOS=3D0x7f520000 SMBIOS 3.0=3D0x7f500000 MEMATTR=3D0x7e59b018=
 MEMRESERVE=3D0x7c143f18
> > > Zone ranges:
> > >   DMA      [mem 0x0000000040000000-0x000000007fffffff]
> > >   DMA32    empty
> > >   Normal   empty
> > > Movable zone start for each node
> > > Early memory node ranges
> > >   node   0: [mem 0x0000000040000000-0x0000000041ffffff]
> > >   node   0: [mem 0x0000000042200000-0x000000007be3ffff]
> > >   node   0: [mem 0x000000007be40000-0x000000007c13ffff]
> > >   node   0: [mem 0x000000007c140000-0x000000007f41ffff]
> > >   node   0: [mem 0x000000007f420000-0x000000007f4affff]
> > >   node   0: [mem 0x000000007f4b0000-0x000000007f4cffff]
> > >   node   0: [mem 0x000000007f4d0000-0x000000007f5dffff]
> > >   node   0: [mem 0x000000007f5e0000-0x000000007fffffff]
> > > Zeroed struct page in unavailable ranges: 864 pages
> > > Initmem setup node 0 [mem 0x0000000040000000-0x000000007fffffff]
> > > psci: probing for conduit method from DT.
> > > psci: PSCIv1.1 detected in firmware.
> > > psci: Using standard PSCI v0.2 function IDs
> > > psci: Trusted OS migration not required
> > > psci: SMC Calling Convention v1.2
> > > percpu: Embedded 21 pages/cpu s48024 r8192 d29800 u86016
> > > Detected PIPT I-cache on CPU0
> > > CPU features: detected: ARM erratum 832075
> > > CPU features: detected: Spectre-v2
> > > CPU features: detected: ARM errata 1165522, 1319367, or 1530923
> > > Built 1 zonelists, mobility grouping on.  Total pages: 257536
> > > Kernel command line: root=3D/dev/vda rw console=3DttyAMA0,115200
> > > Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, lin=
ear)
> > > Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear=
)
> > > mem auto-init: stack:off, heap alloc:off, heap free:off
> > > Memory: 1011284K/1046528K available (6592K kernel code, 804K rwdata, =
1460K rodata, 1088K init, 321K bss, 35244K reserved, 0K cma-reserved)
> > > SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
> > > rcu: Hierarchical RCU implementation.
> > > rcu:    RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_ids=3D1.
> > > rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies=
.
> > > rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D1
> > > NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> > > GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> > > random: get_random_bytes called from start_kernel+0x340/0x53c with cr=
ng_init=3D0
> > > arch_timer: cp15 timer(s) running at 62.50MHz (virt).
> > > clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1=
cd42e208c, max_idle_ns: 881590405314 ns
> > > sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 439804651=
1096ns
> > > Console: colour dummy device 80x25
> > > Calibrating delay loop (skipped), value calculated using timer freque=
ncy.. 125.00 BogoMIPS (lpj=3D250000)
> > > pid_max: default: 32768 minimum: 301
> > > Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
> > > Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, lin=
ear)
> > > rcu: Hierarchical SRCU implementation.
> > > Remapping and enabling EFI services.
> > > smp: Bringing up secondary CPUs ...
> > > smp: Brought up 1 node, 1 CPU
> > > SMP: Total of 1 processors activated.
> > > CPU features: detected: 32-bit EL0 Support
> > > CPU features: detected: CRC32 instructions
> > > CPU: All CPU(s) started at EL1
> > > alternatives: patching kernel code
> > > devtmpfs: initialized
> > > clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_id=
le_ns: 7645041785100000 ns
> > > futex hash table entries: 256 (order: 2, 16384 bytes, linear)
> > > SMBIOS 3.0.0 present.
> > > DMI: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> > > NET: Registered protocol family 16
> > > DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
> > > DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocati=
ons
> > > DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic alloca=
tions
> > > hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
> > > ASID allocator initialised with 65536 entries
> > > Serial: AMBA PL011 UART driver
> > > 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq =3D 46, base_baud =3D 0=
) is a PL011 rev1
> > > printk: console [ttyAMA0] enabled
> > > iommu: Default domain type: Translated
> > > vgaarb: loaded
> > > SCSI subsystem initialized
> > > Registered efivars operations
> > > clocksource: Switched to clocksource arch_sys_counter
> > > NET: Registered protocol family 2
> > > tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 8192 byte=
s, linear)
> > > TCP established hash table entries: 8192 (order: 4, 65536 bytes, line=
ar)
> > > TCP bind hash table entries: 8192 (order: 5, 131072 bytes, linear)
> > > TCP: Hash tables configured (established 8192 bind 8192)
> > > UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
> > > UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
> > > NET: Registered protocol family 1
> > > PCI: CLS 0 bytes, default 64
> > > hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters availa=
ble
> > > workingset: timestamp_bits=3D62 max_order=3D18 bucket_order=3D0
> > > fuse: init (API version 7.33)
> > > Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> > > io scheduler mq-deadline registered
> > > io scheduler kyber registered
> > > pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
> > > pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff=
 -> 0x0000000000
> > > pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff=
 -> 0x0010000000
> > > pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff=
 -> 0x8000000000
> > > pci-host-generic 4010000000.pcie: Memory resource size exceeds max fo=
r 32 bits
> > > pci-host-generic 4010000000.pcie: ECAM at [mem 0x4010000000-0x401ffff=
fff] for [bus 00-ff]
> > > pci-host-generic 4010000000.pcie: PCI host bridge to bus 0000:00
> > > pci_bus 0000:00: root bus resource [bus 00-ff]
> > > pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > > pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
> > > pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
> > > pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> > > pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
> > > pci 0000:00:01.0: reg 0x10: [io  0x0080-0x009f]
> > > pci 0000:00:01.0: reg 0x14: [mem 0x10001000-0x10001fff]
> > > pci 0000:00:01.0: reg 0x20: [mem 0x8000000000-0x8000003fff 64bit pref=
]
> > > pci 0000:00:01.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
> > > pci 0000:00:02.0: [1af4:1001] type 00 class 0x010000
> > > pci 0000:00:02.0: reg 0x10: [io  0x0000-0x007f]
> > > pci 0000:00:02.0: reg 0x14: [mem 0x10000000-0x10000fff]
> > > pci 0000:00:02.0: reg 0x20: [mem 0x8000004000-0x8000007fff 64bit pref=
]
> > > pci 0000:00:01.0: BAR 6: assigned [mem 0x10000000-0x1003ffff pref]
> > > pci 0000:00:01.0: BAR 4: assigned [mem 0x8000000000-0x8000003fff 64bi=
t pref]
> > > pci 0000:00:02.0: BAR 4: assigned [mem 0x8000004000-0x8000007fff 64bi=
t pref]
> > > pci 0000:00:01.0: BAR 1: assigned [mem 0x10040000-0x10040fff]
> > > pci 0000:00:02.0: BAR 1: assigned [mem 0x10041000-0x10041fff]
> > > pci 0000:00:02.0: BAR 0: assigned [io  0x1000-0x107f]
> > > pci 0000:00:01.0: BAR 0: assigned [io  0x1080-0x109f]
> > > virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
> > > virtio-pci 0000:00:02.0: enabling device (0000 -> 0003)
> > > cacheinfo: Unable to detect cache hierarchy for CPU 0
> > > virtio_blk virtio1: [vda] 122880 512-byte logical blocks (62.9 MB/60.=
0 MiB)
> > > SMCCC: SOC_ID: ARCH_FEATURES(ARCH_SOC_ID) returned error: fffffffffff=
ffffd
> > > NET: Registered protocol family 10
> > > Segment Routing with IPv6
> > > sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> > > NET: Registered protocol family 17
> > > NET: Registered protocol family 15
> > > NET: Registered protocol family 40
> > > registered taskstats version 1
> > > EXT4-fs (vda): recovery complete
> > > EXT4-fs (vda): mounted filesystem with ordered data mode. Opts: (null=
). Quota mode: disabled.
> > > VFS: Mounted root (ext4 filesystem) on device 254:0.
> > > devtmpfs: mounted
> > > Freeing unused kernel memory: 1088K
> > > Run /sbin/init as init process
> > > mount: you must be root
> > > mount: you must be root
> > > mkdir: can't create directory '/dev/pts': Permission denied
> > > mkdir: can't create directory '/dev/shm': Permission denied
> > > mount: you must be root
> > > hostname: sethostname: Operation not permitted
> > > Starting syslogd: OK
> > > Starting klogd: OK
> > > Running sysctl: OK
> > > Initializing random number generator: OK
> > > Saving random seed: random: dd: uninitialized urandom read (512 bytes=
 read)
> > > OK
> > > Starting network: ip: RTNETLINK answers: Operation not permitted
> > > ip: SIOCSIFFLAGS: Operation not permitted
> > > sed: /proc/mounts: No such file or directory
> > > Waiting for interface eth0 to appear............... timeout!
> > > run-parts: /etc/network/if-pre-up.d/wait_iface: exit status 1
> > > FAIL
> > > can't open /dev/ttyAMA0: Permission denied
> > > can't open /dev/ttyAMA0: Permission denied
> > > can't open /dev/ttyAMA0: Permission denied
> > > can't open /dev/ttyAMA0: Permission denied
> > >
> > > And it continues...
> > >
> > > The qemu command I got did not work "as it is" and because I'm neithe=
r too
> > > proficient with qemu nor aarch64, it took a while to get something us=
able.
> > > This is my current qemu command:
> > >
> > > qemu-system-aarch64 -nographic -s -machine virt,secure=3Don -cpu cort=
ex-a57 \
> > >                     -kernel ~/Projects/tpm/buildroot/output/images/Im=
age \
> > >                     -no-acpi \
> > >                     -append 'root=3D/dev/vda rw console=3DttyAMA0,115=
200 ' \
> > >                     -drive file=3D~/Projects/tpm/buildroot/output/ima=
ges/rootfs.ext4,format=3Draw \
> > >                     -smp 1 \
> > >                     -monitor telnet:127.0.0.1:55555,server,nowait \
> > >                     -m 1024 -bios ~/Projects/tpm/fw/aarch64-fw.bin -d=
 unimp
> > >
> > > Then I start QEMU monitor from another terminal with:
> > >
> > > socat tcp-connect:127.0.0.1:55555 file:`tty`,raw,echo=3D0
> > >
> > > So... what could be the issue with permissions?
> > >
> >
> > It mostly sounds like an issue with your buildroot filesystem.
> >
> > Can you try with this [1] init ramdisk instead?
> >
> > -initrd rootfs.cpio.gz
> >
> > [1] https://people.linaro.org/~sumit.garg/rootfs.cpio.gz
> >
> > -Sumit
>
> That does not include my LKM's.
>

You can give a try with my kernel image [1] which has required built
in kernel modules. Also, you should be able to build a similar kernel
image.

[1] https://people.linaro.org/~sumit.garg/Image

-Sumit

> /Jarkko
