Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE02FDE7F
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 02:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390823AbhAUBAZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 20:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbhAUAD2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 19:03:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C55DB2368A;
        Thu, 21 Jan 2021 00:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611187313;
        bh=Eh0u5i8AW4x9ntLsFlUAc6rlbY2JykroCggN1fE25ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZ2nE1nWc5IEdueOVVKR9vTP5loybR/I49ORFIwya9nGkp8IRtTWQXNmdnpsV9SHt
         IbC4NVTSRTaW/UTjXdq3t02Fixqlc484JqdK3sdr59lnUVQTR5HL2nmYDC4pzq1Zdl
         qtVGeiJMy2stNYuVaJGshQIh1w82JdOV4Txew7VIhlSAW1jXPry/NY4csB5Ch2gHbo
         UifuHCqGdSgu/kcRvIlwwIsX4+vTLbjmba7Rh6/dmaKun51d+pSOHgGzYj48BPQMmL
         N8XAe+Ze+T3z+dF15H49ScwHfVm4IiTfiLegna6iqRUOAFensVr6vH+u3F/YwcZ+rf
         3owAiDsd4Zxqg==
Date:   Thu, 21 Jan 2021 02:01:46 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Message-ID: <YAjEaq+ZWD/eHU/x@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
 <X/x+N0fgrzIZTeNi@kernel.org>
 <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
 <X/+m6+m2/snYj9Vc@kernel.org>
 <CAFA6WYNyirit_AFhoE+XR9PHw=OjRgEdXDqz1uanj_SN2NXeMw@mail.gmail.com>
 <YAa0ys4YJcZtKdfF@kernel.org>
 <YAeH2pb8szQyjusL@kernel.org>
 <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote:
> On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrote:
> > > > On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
> > > > > > Hi Jarkko,
> > > > > >
> > > > > > On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > > > > > > > Add support for TEE based trusted keys where TEE provides the functionality
> > > > > > > > to seal and unseal trusted keys using hardware unique key.
> > > > > > > >
> > > > > > > > Refer to Documentation/tee.txt for detailed information about TEE.
> > > > > > > >
> > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > >
> > > > > > > I haven't yet got QEMU environment working with aarch64, this produces
> > > > > > > just a blank screen:
> > > > > > >
> > > > > > > ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio
> > > > > > >
> > > > > > > My BuildRoot fork for TPM and keyring testing is located over here:
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/
> > > > > > >
> > > > > > > The "ARM version" is at this point in aarch64 branch. Over time I will
> > > > > > > define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
> > > > > > > in the master branch.
> > > > > > >
> > > > > > > To create identical images you just need to
> > > > > > >
> > > > > > > $ make tpmdd_defconfig && make
> > > > > > >
> > > > > > > Can you check if you see anything obviously wrong? I'm eager to test this
> > > > > > > patch set, and in bigger picture I really need to have ready to run
> > > > > > > aarch64 environment available.
> > > > > >
> > > > > > I would rather suggest you to follow steps listed here [1] as to test
> > > > > > this feature on Qemu aarch64 we need to build firmwares such as TF-A,
> > > > > > OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
> > > > > > system [2]. And then it would be easier to migrate them to your
> > > > > > buildroot environment as well.
> > > > > >
> > > > > > [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.html
> > > > > > [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
> > > > > >
> > > > > > -Sumit
> > > > >
> > > > > Can you provide 'keyctl_change'? Otherwise, the steps are easy to follow.
> > > > >
> > > >
> > > > $ cat keyctl_change
> > > > diff --git a/common.mk b/common.mk
> > > > index aeb7b41..663e528 100644
> > > > --- a/common.mk
> > > > +++ b/common.mk
> > > > @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?= $(OPTEE_OS_TA_DEV_KIT_DIR)
> > > >  BR2_PACKAGE_OPTEE_TEST_SITE ?= $(OPTEE_TEST_PATH)
> > > >  BR2_PACKAGE_STRACE ?= y
> > > >  BR2_TARGET_GENERIC_GETTY_PORT ?= $(if
> > > > $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
> > > > +BR2_PACKAGE_KEYUTILS := y
> > > >
> > > >  # All BR2_* variables from the makefile or the environment are appended to
> > > >  # ../out-br/extra.conf. All values are quoted "..." except y and n.
> > > > diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> > > > index 368c18a..832ab74 100644
> > > > --- a/kconfigs/qemu.conf
> > > > +++ b/kconfigs/qemu.conf
> > > > @@ -20,3 +20,5 @@ CONFIG_9P_FS=y
> > > >  CONFIG_9P_FS_POSIX_ACL=y
> > > >  CONFIG_HW_RANDOM=y
> > > >  CONFIG_HW_RANDOM_VIRTIO=y
> > > > +CONFIG_TRUSTED_KEYS=y
> > > > +CONFIG_ENCRYPTED_KEYS=y
> > > >
> > > > > After I've successfully tested 2/4, I'd suggest that you roll out one more
> > > > > version and CC the documentation patch to Elaine and Mini, and clearly
> > > > > remark in the commit message that TEE is a standard, with a link to the
> > > > > specification.
> > > > >
> > > >
> > > > Sure, I will roll out the next version after your testing.
> > >
> > > Thanks, I'll try this at instant, and give my feedback.
> >
> > I bump into this:
> >
> > $ make run-only
> > ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/images/rootfs.cpio.gz /home/jarkko/devel/tpm/optee/build/../out/bin/
> > ln: failed to create symbolic link '/home/jarkko/devel/tpm/optee/build/../out/bin/': No such file or directory
> > make: *** [Makefile:194: run-only] Error 1
> >
> 
> Could you check if the following directory tree is built after
> executing the below command?
> 
> $ make -j`nproc`
> CFG_IN_TREE_EARLY_TAS=trusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c
> 
> $ tree out/bin/
> out/bin/
> ├── bl1.bin -> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl1.bin
> ├── bl2.bin -> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl2.bin
> ├── bl31.bin ->
> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl31.bin
> ├── bl32.bin ->
> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-header_v2.bin
> ├── bl32_extra1.bin ->
> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pager_v2.bin
> ├── bl32_extra2.bin ->
> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pageable_v2.bin
> ├── bl33.bin ->
> /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEASE_GCC49/FV/QEMU_EFI.fd
> ├── Image -> /home/sumit/build/optee/build/../linux/arch/arm64/boot/Image
> └── rootfs.cpio.gz ->
> /home/sumit/build/optee/build/../out-br/images/rootfs.cpio.gz
> 
> 0 directories, 9 files
> 
> -Sumit

I actually spotted a build error that was unnoticed last time:

make[2]: Entering directory '/home/jarkko/devel/tpm/optee/edk2/BaseTools/Tests'
/bin/sh: 1: python: not found

I'd prefer not to install Python2. It has been EOL over a year.

/Jarkko
