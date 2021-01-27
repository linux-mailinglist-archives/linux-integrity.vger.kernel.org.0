Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CAE3061B4
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhA0RRH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 12:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234624AbhA0RPe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 12:15:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA34964DA5;
        Wed, 27 Jan 2021 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611767692;
        bh=Z+m8yP/xeOGksi+/HYuz8Fqq3ItMzroR0QB+GyMKVMc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f3y1wVDEuXs9czvTGWkqiEeFNlhUpaWtnb6YCUtE8hP7nPjqyc0FAmyRjImJXUgd9
         u9len0dNTo1t0vWl4qa1peVVt1ACHCHPN9aps2G98J8mt0f4PmfqtNxci7NK98uQkj
         tiurWDbHdo+VImuxpNXt4/u/j/Q7Lu8/CQdlalB4hZZ56tycFCwNgIA5c36fZAQCnY
         vT7rGRYYtcmRWRuRx428EPxZafkPplFORIlrnvGb26/vcXdFMuQGyeo+/ktCvHcV0p
         JRVLiC0qXrx/5d678L0EFi8P5FT+MSeRyuDVvsSIZ0oS9BXG5a21tKpZO5I7yYvYID
         ypSPtYWcvu2dQ==
Message-ID: <51c01b2b7843d36f4373f75f6c87ad135dd82799.camel@kernel.org>
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
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
        "Serge E. Hallyn" <serge@hallyn.com>
Date:   Wed, 27 Jan 2021 19:14:48 +0200
In-Reply-To: <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>
References: <X/+m6+m2/snYj9Vc@kernel.org>
         <CAFA6WYNyirit_AFhoE+XR9PHw=OjRgEdXDqz1uanj_SN2NXeMw@mail.gmail.com>
         <YAa0ys4YJcZtKdfF@kernel.org> <YAeH2pb8szQyjusL@kernel.org>
         <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
         <01000177223f74d3-1eef7685-4a19-40d2-ace6-d4cd7f35579d-000000@email.amazonses.com>
         <dc3979e8-6bf0-adb7-164d-d50e805a048f@forissier.org>
         <YAmYu9FxWcLPhBhs@kernel.org> <YAmcyKnYCK+Y4IGW@kernel.org>
         <1486cfe8-bc30-1266-12bd-0049f2b64820@forissier.org>
         <YAsVenGkaqb8205f@kernel.org>
         <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-01-25 at 14:47 +0530, Sumit Garg wrote:
> Hi Jarkko,
>=20
> On Fri, 22 Jan 2021 at 23:42, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > On Thu, Jan 21, 2021 at 05:23:45PM +0100, Jerome Forissier wrote:
> > >=20
> > >=20
> > > On 1/21/21 4:24 PM, Jarkko Sakkinen wrote:
> > > > On Thu, Jan 21, 2021 at 05:07:42PM +0200, Jarkko Sakkinen wrote:
> > > > > On Thu, Jan 21, 2021 at 09:44:07AM +0100, Jerome Forissier wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 1/21/21 1:02 AM, Jarkko Sakkinen via OP-TEE wrote:
> > > > > > > On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote:
> > > > > > > > On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kerne=
l.org> wrote:
> > > > > > > > >=20
> > > > > > > > > On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen=
 wrote:
> > > > > > > > > > On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wr=
ote:
> > > > > > > > > > > On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko=
@kernel.org> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Gar=
g wrote:
> > > > > > > > > > > > > Hi Jarkko,
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <ja=
rkko@kernel.org> wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit=
 Garg wrote:
> > > > > > > > > > > > > > > Add support for TEE based trusted keys where =
TEE provides the functionality
> > > > > > > > > > > > > > > to seal and unseal trusted keys using hardwar=
e unique key.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Refer to Documentation/tee.txt for detailed i=
nformation about TEE.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.=
org>
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I haven't yet got QEMU environment working with=
 aarch64, this produces
> > > > > > > > > > > > > > just a blank screen:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > ./output/host/usr/bin/qemu-system-aarch64 -M vi=
rt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images=
/rootfs.cpio -serial stdio
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > My BuildRoot fork for TPM and keyring testing i=
s located over here:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git=
/jarkko/buildroot-tpmdd.git/
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > The "ARM version" is at this point in aarch64 b=
ranch. Over time I will
> > > > > > > > > > > > > > define tpmdd-x86_64 and tpmdd-aarch64 boards an=
d everything will be then
> > > > > > > > > > > > > > in the master branch.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > To create identical images you just need to
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > $ make tpmdd_defconfig && make
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Can you check if you see anything obviously wro=
ng? I'm eager to test this
> > > > > > > > > > > > > > patch set, and in bigger picture I really need =
to have ready to run
> > > > > > > > > > > > > > aarch64 environment available.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I would rather suggest you to follow steps listed=
 here [1] as to test
> > > > > > > > > > > > > this feature on Qemu aarch64 we need to build fir=
mwares such as TF-A,
> > > > > > > > > > > > > OP-TEE, UEFI etc. which are all integrated into O=
P-TEE Qemu build
> > > > > > > > > > > > > system [2]. And then it would be easier to migrat=
e them to your
> > > > > > > > > > > > > buildroot environment as well.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > [1] https://lists.trustedfirmware.org/pipermail/o=
p-tee/2020-May/000027.html
> > > > > > > > > > > > > [2] https://optee.readthedocs.io/en/latest/buildi=
ng/devices/qemu.html#qemu-v8
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > -Sumit
> > > > > > > > > > > >=20
> > > > > > > > > > > > Can you provide 'keyctl_change'? Otherwise, the ste=
ps are easy to follow.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > $ cat keyctl_change
> > > > > > > > > > > diff --git a/common.mk b/common.mk
> > > > > > > > > > > index aeb7b41..663e528 100644
> > > > > > > > > > > --- a/common.mk
> > > > > > > > > > > +++ b/common.mk
> > > > > > > > > > > @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?=3D $=
(OPTEE_OS_TA_DEV_KIT_DIR)
> > > > > > > > > > > =C2=A0BR2_PACKAGE_OPTEE_TEST_SITE ?=3D $(OPTEE_TEST_P=
ATH)
> > > > > > > > > > > =C2=A0BR2_PACKAGE_STRACE ?=3D y
> > > > > > > > > > > =C2=A0BR2_TARGET_GENERIC_GETTY_PORT ?=3D $(if
> > > > > > > > > > > $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),t=
tyAMA0)
> > > > > > > > > > > +BR2_PACKAGE_KEYUTILS :=3D y
> > > > > > > > > > >=20
> > > > > > > > > > > =C2=A0# All BR2_* variables from the makefile or the =
environment are appended to
> > > > > > > > > > > =C2=A0# ../out-br/extra.conf. All values are quoted "=
..." except y and n.
> > > > > > > > > > > diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> > > > > > > > > > > index 368c18a..832ab74 100644
> > > > > > > > > > > --- a/kconfigs/qemu.conf
> > > > > > > > > > > +++ b/kconfigs/qemu.conf
> > > > > > > > > > > @@ -20,3 +20,5 @@ CONFIG_9P_FS=3Dy
> > > > > > > > > > > =C2=A0CONFIG_9P_FS_POSIX_ACL=3Dy
> > > > > > > > > > > =C2=A0CONFIG_HW_RANDOM=3Dy
> > > > > > > > > > > =C2=A0CONFIG_HW_RANDOM_VIRTIO=3Dy
> > > > > > > > > > > +CONFIG_TRUSTED_KEYS=3Dy
> > > > > > > > > > > +CONFIG_ENCRYPTED_KEYS=3Dy
> > > > > > > > > > >=20
> > > > > > > > > > > > After I've successfully tested 2/4, I'd suggest tha=
t you roll out one more
> > > > > > > > > > > > version and CC the documentation patch to Elaine an=
d Mini, and clearly
> > > > > > > > > > > > remark in the commit message that TEE is a standard=
, with a link to the
> > > > > > > > > > > > specification.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Sure, I will roll out the next version after your tes=
ting.
> > > > > > > > > >=20
> > > > > > > > > > Thanks, I'll try this at instant, and give my feedback.
> > > > > > > > >=20
> > > > > > > > > I bump into this:
> > > > > > > > >=20
> > > > > > > > > $ make run-only
> > > > > > > > > ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/image=
s/rootfs.cpio.gz /home/jarkko/devel/tpm/optee/build/../out/bin/
> > > > > > > > > ln: failed to create symbolic link '/home/jarkko/devel/tp=
m/optee/build/../out/bin/': No such file or directory
> > > > > > > > > make: *** [Makefile:194: run-only] Error 1
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Could you check if the following directory tree is built af=
ter
> > > > > > > > executing the below command?
> > > > > > > >=20
> > > > > > > > $ make -j`nproc`
> > > > > > > > CFG_IN_TREE_EARLY_TAS=3Dtrusted_keys/f04a0fe7-1f5d-4b9b-abf=
7-619b85b4ce8c
> > > > > > > >=20
> > > > > > > > $ tree out/bin/
> > > > > > > > out/bin/
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl1.bin -> /home/sumit/build/op=
tee/build/../trusted-firmware-a/build/qemu/release/bl1.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl2.bin -> /home/sumit/build/op=
tee/build/../trusted-firmware-a/build/qemu/release/bl2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl31.bin ->
> > > > > > > > /home/sumit/build/optee/build/../trusted-firmware-a/build/q=
emu/release/bl31.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl32.bin ->
> > > > > > > > /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-=
header_v2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl32_extra1.bin ->
> > > > > > > > /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-=
pager_v2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl32_extra2.bin ->
> > > > > > > > /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-=
pageable_v2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl33.bin ->
> > > > > > > > /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKern=
el-AARCH64/RELEASE_GCC49/FV/QEMU_EFI.fd
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 Image -> /home/sumit/build/opte=
e/build/../linux/arch/arm64/boot/Image
> > > > > > > > =E2=94=94=E2=94=80=E2=94=80 rootfs.cpio.gz ->
> > > > > > > > /home/sumit/build/optee/build/../out-br/images/rootfs.cpio.=
gz
> > > > > > > >=20
> > > > > > > > 0 directories, 9 files
> > > > > > > >=20
> > > > > > > > -Sumit
> > > > > > >=20
> > > > > > > I actually spotted a build error that was unnoticed last time=
:
> > > > > > >=20
> > > > > > > make[2]: Entering directory '/home/jarkko/devel/tpm/optee/edk=
2/BaseTools/Tests'
> > > > > > > /bin/sh: 1: python: not found
> > > > > > >=20
> > > > > > > I'd prefer not to install Python2. It has been EOL over a yea=
r.
> > > > > >=20
> > > > > > AFAIK, everything should build fine with Python3. On my Ubuntu =
20.04
> > > > > > machine, this is accomplished by installing package "python-is-=
python3"
> > > > > > (after uninstalling "python-is-python2" if need be).
> > > > > >=20
> > > > > > $ ls -l /usr/bin/python
> > > > > > lrwxrwxrwx 1 root root 7 Apr 15=C2=A0 2020 /usr/bin/python -> p=
ython3
> > > > >=20
> > > > > Right, just found about this in unrelated context :-) [*]
> > > > >=20
> > > > > Hope this will work out...
> > > > >=20
> > > > > [*] https://github.com/surge-synthesizer/surge/pull/3655
> > > >=20
> > > > Now I get
> > > >=20
> > > > Traceback (most recent call last):
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/R=
unTests.py", line 36, in <module>
> > > > =C2=A0=C2=A0=C2=A0 allTests =3D GetAllTestsSuite()
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/R=
unTests.py", line 33, in GetAllTestsSuite
> > > > =C2=A0=C2=A0=C2=A0 return unittest.TestSuite([GetCTestSuite(), GetP=
ythonTestSuite()])
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/R=
unTests.py", line 25, in GetCTestSuite
> > > > =C2=A0=C2=A0=C2=A0 import CToolsTests
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/C=
ToolsTests.py", line 22, in <module>
> > > > =C2=A0=C2=A0=C2=A0 import TianoCompress
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/T=
ianoCompress.py", line 69, in <module>
> > > > =C2=A0=C2=A0=C2=A0 TheTestSuite =3D TestTools.MakeTheTestSuite(loca=
ls())
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/T=
estTools.py", line 43, in MakeTheTestSuite
> > > > =C2=A0=C2=A0=C2=A0 for name, item in localItems.iteritems():
> > > > AttributeError: 'dict' object has no attribute 'iteritems'
> > >=20
> > > Right. Same here after removing all traces of Python2 from my system =
:-/
> > >=20
> > > A couple of fixes are needed:
> > > 1. EDK2 needs to be upgraded to tag or later [1]
> > > 2. The PYTHON3_ENABLE environment variable needs to be set to TRUE [2=
]
> > >=20
> > > [1] https://github.com/OP-TEE/manifest/pull/177
> > > [2] https://github.com/OP-TEE/build/pull/450
> >=20
> > BTW, Is to *really* impossible to test this with plain BuildRoot.=C2=A0=
 It's
> > obvious that this forks BR internally.
> >=20
> > I mean even if I get this working once, this will feels like a clumsy w=
ay
> > to test Aarch64 regularly. I use BuildRoot extensively for x86 testing.=
 And
> > it would be nice to be able to start doing regular ARM testing.
>=20
> The main reason to guide you towards the OP-TEE build system is that
> you will be able to build all the firmwares (TF-A, OP-TEE, edk2 etc.)
> from source. If you don't need to rebuild those then I have prepared a
> flash firmware binary blob for your testing (attached flash.bin). So
> Qemu cmdline will look like:
>=20
> $ qemu-system-aarch64 -nographic -s -machine virt,secure=3Don -cpu
> cortex-a57 -kernel out/bin/Image -no-acpi -append
> 'console=3DttyAMA0,38400 keep_bootcon root=3D/dev/vda2' -initrd
> out/bin/rootfs.cpio.gz -smp 2 -m 1024 -bios flash.bin -d unimp
>=20
> Here you can use "Image" and "rootfs.cpio.gz" from your plain BR builds.
>=20
> Give it a try and let me know if this works for you.
>=20
> >=20
> > The mainline BuildRoot does have bunch of BR2_PACKAGE_OPTEE_* included.
> > Are they all broken?
>=20
> These aren't broken but they are used to package OP-TEE user-space
> components into rootfs but they aren't required to test Trusted Keys
> as it uses kernel interface to OP-TEE instead.
>=20
> -Sumit
>=20
> >=20
> > Here's a reference where I got with that endeavour:
> >=20
> > https://lore.kernel.org/linux-integrity/X%2Fx+N0fgrzIZTeNi@kernel.org/
> >=20
> > /Jarkko

