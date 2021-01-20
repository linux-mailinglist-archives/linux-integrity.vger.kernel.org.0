Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725702FCB73
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 08:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbhATHYf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 02:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbhATHYV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 02:24:21 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D08C0613D3
        for <linux-integrity@vger.kernel.org>; Tue, 19 Jan 2021 23:23:41 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id p13so24927935ljg.2
        for <linux-integrity@vger.kernel.org>; Tue, 19 Jan 2021 23:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IUrgv0FBuTz3H165Mc6si/82NmlQEG5UHik5rW9EBXc=;
        b=Z331GKUf4msxWQjIsscyU4jNlxcRf4pxDM2Uz6mDa89b78iB1MTaYFw1M7w11vF92h
         HVH8eTSRaamzb/MxUh9KeqM6+MqnMJoUcHJ1m1kG+2YjSntSPaBT9NognuJtRcb91UlT
         HhPHINiUeMpNd3RuTdek5oJDxNzSXUD4aQJifORFowq98JoRqV4EsmkMIV7kDllPo4Pa
         tp11kBRk2uInvz0FwjBcJvo3wYzmh18/ZTOeEbyJTCQ6uPJUmWzfqZizWJeRYMoobGtM
         N/dvWKYJ+EdJIrodZecOtXksqYriISceww1J4WD9M/s7kAFdeUkcqEthd8S4pQDbc2pj
         fuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IUrgv0FBuTz3H165Mc6si/82NmlQEG5UHik5rW9EBXc=;
        b=Qk0orf+6vCS0OdgK5K06bHlRJBvfE5KLS4f27UBkZrr6xya/TZwaW5MDLgOAdMJHvv
         vWKYgbBuMzQyryU2UTO7HnJ+0lS+MRdtEQIPQhvZjW6Y2wPTbiSHLnWZL3ZZncLPPV9g
         4sRLog8k5J2wL1/L05oWBHVkKSJm77aqttXSuBUcvtlZd+/t8a+gCy3VzBink6t3HehJ
         xAs2vajwQyAi30oqr5iDntIAwkH1MVTMM2D7Kgmd4jqya5pSSyl+ma6PJGdlBVak6Ceu
         g0bUPPOHkv9aPhPdgut8rmrLnbydtRZkLF8nIk73taIwCRysQPOmgXa7f0dMt9HMvWcQ
         hwVQ==
X-Gm-Message-State: AOAM5329xlQqUGiQg/CLeDwizGxzggsWJFjMp5IjeiTrU7y61SEXQIUw
        NRjGEBB6VBDTRV8ehk4CAWy2KLgeDtF9tfK1OwkCVw==
X-Google-Smtp-Source: ABdhPJyckOX7g74YSWC/ebW0pan/8Eqz0VHarq+xR94sRitnHKl336t8hKlAqWXfY8EZ7wW8kJQ/ToXhb+NEXaFgrlI=
X-Received: by 2002:a05:651c:1192:: with SMTP id w18mr3565930ljo.40.1611127419625;
 Tue, 19 Jan 2021 23:23:39 -0800 (PST)
MIME-Version: 1.0
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org> <X/x+N0fgrzIZTeNi@kernel.org>
 <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
 <X/+m6+m2/snYj9Vc@kernel.org> <CAFA6WYNyirit_AFhoE+XR9PHw=OjRgEdXDqz1uanj_SN2NXeMw@mail.gmail.com>
 <YAa0ys4YJcZtKdfF@kernel.org> <YAeH2pb8szQyjusL@kernel.org>
In-Reply-To: <YAeH2pb8szQyjusL@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 20 Jan 2021 12:53:28 +0530
Message-ID: <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrote:
> > > On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel.org> wro=
te:
> > > >
> > > > On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
> > > > > Hi Jarkko,
> > > > >
> > > > > On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> > > > > >
> > > > > > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > > > > > > Add support for TEE based trusted keys where TEE provides the=
 functionality
> > > > > > > to seal and unseal trusted keys using hardware unique key.
> > > > > > >
> > > > > > > Refer to Documentation/tee.txt for detailed information about=
 TEE.
> > > > > > >
> > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > >
> > > > > > I haven't yet got QEMU environment working with aarch64, this p=
roduces
> > > > > > just a blank screen:
> > > > > >
> > > > > > ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a=
53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -se=
rial stdio
> > > > > >
> > > > > > My BuildRoot fork for TPM and keyring testing is located over h=
ere:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroo=
t-tpmdd.git/
> > > > > >
> > > > > > The "ARM version" is at this point in aarch64 branch. Over time=
 I will
> > > > > > define tpmdd-x86_64 and tpmdd-aarch64 boards and everything wil=
l be then
> > > > > > in the master branch.
> > > > > >
> > > > > > To create identical images you just need to
> > > > > >
> > > > > > $ make tpmdd_defconfig && make
> > > > > >
> > > > > > Can you check if you see anything obviously wrong? I'm eager to=
 test this
> > > > > > patch set, and in bigger picture I really need to have ready to=
 run
> > > > > > aarch64 environment available.
> > > > >
> > > > > I would rather suggest you to follow steps listed here [1] as to =
test
> > > > > this feature on Qemu aarch64 we need to build firmwares such as T=
F-A,
> > > > > OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
> > > > > system [2]. And then it would be easier to migrate them to your
> > > > > buildroot environment as well.
> > > > >
> > > > > [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/0=
00027.html
> > > > > [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.=
html#qemu-v8
> > > > >
> > > > > -Sumit
> > > >
> > > > Can you provide 'keyctl_change'? Otherwise, the steps are easy to f=
ollow.
> > > >
> > >
> > > $ cat keyctl_change
> > > diff --git a/common.mk b/common.mk
> > > index aeb7b41..663e528 100644
> > > --- a/common.mk
> > > +++ b/common.mk
> > > @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?=3D $(OPTEE_OS_TA_DEV=
_KIT_DIR)
> > >  BR2_PACKAGE_OPTEE_TEST_SITE ?=3D $(OPTEE_TEST_PATH)
> > >  BR2_PACKAGE_STRACE ?=3D y
> > >  BR2_TARGET_GENERIC_GETTY_PORT ?=3D $(if
> > > $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
> > > +BR2_PACKAGE_KEYUTILS :=3D y
> > >
> > >  # All BR2_* variables from the makefile or the environment are appen=
ded to
> > >  # ../out-br/extra.conf. All values are quoted "..." except y and n.
> > > diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> > > index 368c18a..832ab74 100644
> > > --- a/kconfigs/qemu.conf
> > > +++ b/kconfigs/qemu.conf
> > > @@ -20,3 +20,5 @@ CONFIG_9P_FS=3Dy
> > >  CONFIG_9P_FS_POSIX_ACL=3Dy
> > >  CONFIG_HW_RANDOM=3Dy
> > >  CONFIG_HW_RANDOM_VIRTIO=3Dy
> > > +CONFIG_TRUSTED_KEYS=3Dy
> > > +CONFIG_ENCRYPTED_KEYS=3Dy
> > >
> > > > After I've successfully tested 2/4, I'd suggest that you roll out o=
ne more
> > > > version and CC the documentation patch to Elaine and Mini, and clea=
rly
> > > > remark in the commit message that TEE is a standard, with a link to=
 the
> > > > specification.
> > > >
> > >
> > > Sure, I will roll out the next version after your testing.
> >
> > Thanks, I'll try this at instant, and give my feedback.
>
> I bump into this:
>
> $ make run-only
> ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/images/rootfs.cpio.gz=
 /home/jarkko/devel/tpm/optee/build/../out/bin/
> ln: failed to create symbolic link '/home/jarkko/devel/tpm/optee/build/..=
/out/bin/': No such file or directory
> make: *** [Makefile:194: run-only] Error 1
>

Could you check if the following directory tree is built after
executing the below command?

$ make -j`nproc`
CFG_IN_TREE_EARLY_TAS=3Dtrusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c

$ tree out/bin/
out/bin/
=E2=94=9C=E2=94=80=E2=94=80 bl1.bin -> /home/sumit/build/optee/build/../tru=
sted-firmware-a/build/qemu/release/bl1.bin
=E2=94=9C=E2=94=80=E2=94=80 bl2.bin -> /home/sumit/build/optee/build/../tru=
sted-firmware-a/build/qemu/release/bl2.bin
=E2=94=9C=E2=94=80=E2=94=80 bl31.bin ->
/home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl31=
.bin
=E2=94=9C=E2=94=80=E2=94=80 bl32.bin ->
/home/sumit/build/optee/build/../optee_os/out/arm/core/tee-header_v2.bin
=E2=94=9C=E2=94=80=E2=94=80 bl32_extra1.bin ->
/home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pager_v2.bin
=E2=94=9C=E2=94=80=E2=94=80 bl32_extra2.bin ->
/home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pageable_v2.bin
=E2=94=9C=E2=94=80=E2=94=80 bl33.bin ->
/home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEA=
SE_GCC49/FV/QEMU_EFI.fd
=E2=94=9C=E2=94=80=E2=94=80 Image -> /home/sumit/build/optee/build/../linux=
/arch/arm64/boot/Image
=E2=94=94=E2=94=80=E2=94=80 rootfs.cpio.gz ->
/home/sumit/build/optee/build/../out-br/images/rootfs.cpio.gz

0 directories, 9 files

-Sumit

> /Jarkko
