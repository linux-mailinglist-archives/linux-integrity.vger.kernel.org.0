Return-Path: <linux-integrity+bounces-1750-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE03B87C149
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Mar 2024 17:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B4F1F21EBA
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Mar 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635533FC7;
	Thu, 14 Mar 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIbyN6Ag"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8754F8D
	for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433902; cv=none; b=WAaIvcL5Nxe/Vqd9Ec4UfDiorIGYiiud16Iiq+89opds4oY3D8vRi896afVk/rHUaKj9TX6nPGe6CeFHgBngqocVAmQBp1km2tXyRZXxEolUaWi2a7aWvrbTAqFtMLYct4EeyPojlrFjmJSrms+alNxJreA+vRNuYKjnANMY49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433902; c=relaxed/simple;
	bh=eGFLmlu78q6b0zQ7d891I6TnHlnjjhOwIPCNINBRrGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aU+scUzrQfsC/dFQub9pilAFslripquxsY6+zqE0cGY40mQ/acM/kgGSsk+Y+NESYt+DVtUJk4Ty/FnE5t3SIWEWTgyr5RBva2OW5j+HcrDeAZ/q56XjmT1iGDNUq1TGAM6KkraMn7O5I62w3n8aaFgZrgdEUDoktk5zV/tVXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIbyN6Ag; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso1027111276.0
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2024 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710433899; x=1711038699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krAMKHDaLviOm6jEpzpQSCReRN10COBcmNv4XjgDLAA=;
        b=YIbyN6Ag5EWN4bOap/gCBbwWxYI2GOCJ8V8354g8Ub6R0RYfE+ypUAaBsSP55VIx6e
         iUT1eGeEqQJcvmbndtrEgxWrkb4TNBANPtBzkLyZC+yh5fDfOlON+QzPmT86myZk58NH
         6n2X/QqD6gf90+7TmCDlTmu4bj39VIuahWtkKgXaI2Jz31s9Kc67KU1e5H4cY9QJJz1I
         pCz7gStrkqFLkETHUlSt5BVLCEalmozq1VV8DlTbXj5MpYmbDoEWyEJzjuLR01Yex434
         uoaPT0Ctvr6ED7Oh8sg+pshiv76eNGKZNt/MxHTW2U7oOYzVO5n3dWJh++7u3Mus1oUJ
         j9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710433899; x=1711038699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krAMKHDaLviOm6jEpzpQSCReRN10COBcmNv4XjgDLAA=;
        b=xQvuCWcMcIuFBU4km917QyGL7qFXdnN0Gmk4Tx+xPrkPFC7kZJFTWvAszlwIfeiISa
         ABVzSf9DJvD20LvUuwUCgm2qAL5JIi9xfQnkGpJeNa6tJ/KvTX20SagrWoFecOzTshsi
         olhq1/Osf5unLBiiWPaMQpSQzu0OO+GSlHLSuxYq0KwwK5hCbIujwLBxEEvxoVAwx7ow
         vn4+GB9svORunqSVRCqri8sXK/pbYrfvl2PUvhXAx5gt0F/C8HFC49f8Tg/LkhTl9tqN
         i0r+lkyslvIBzqqFY1xhVhy71MY4j0V6mASDOoixkJn1OWCpijVHXB6X5wBjY3ea7Cyt
         fPSA==
X-Forwarded-Encrypted: i=1; AJvYcCVqF8jJnHxMI0QmGm+NiD96IgnAdlJsKgm4ofVirlTehgZUCZkOhclkJJ8wAbECbg9r8S5jtzapKowuNWBBw9xY7nMLaHwjG7zQuRRDN9VQ
X-Gm-Message-State: AOJu0YxK6eqRsDKINvg+zH1YMJ4HinfjJg/9j15pTjwLIym5E8aw+3FW
	HJ3U7WKsd7eNQmjGdZR6JtojkQMAUu/MpXdXE7DErhz8auS1yn/yq6lvHL/4g4D1riqvdwWkmsy
	v8Vl95crfKnT8C+2hvAZ32DiHL2w=
X-Google-Smtp-Source: AGHT+IHAg+Wn8IfZC+nHsLMmwv5lrhhmLVW5ZW8/vB0SVTt7KcFU/M39NN8eqI08jmnF/XR6o3Y3ADPCRDfYxTBLnxU=
X-Received: by 2002:a25:ae98:0:b0:dcf:fc74:358a with SMTP id
 b24-20020a25ae98000000b00dcffc74358amr2166561ybj.10.1710433898825; Thu, 14
 Mar 2024 09:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org> <20240307224957.29432-1-adamoa@gmail.com>
 <CZR6VBRUEPKW.26B7HTOJZ0ANX@kernel.org> <CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com>
In-Reply-To: <CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com>
From: Adam Alves <adamoa@gmail.com>
Date: Thu, 14 Mar 2024 13:31:27 -0300
Message-ID: <CAHwaaX-j37rq4+DCNSRAgPmeQmrYZiX2sLv4ugBjPJSj9LPxcg@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by preserving
 chip Locality
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

I have an update here. I would like you to check if it makes sense
before I submit a patch.

The problem might be related to the chip itself which leaves the idle
state whenever the locality is relinquished.

I probed the chip while operating and noted that the
TPM_CRB_CTRL_STS_0.tpmIdle bit (located at `regs_t->ctrl_sts` on
`crb_priv` structure in tpm_crb.c) is always cleared whenever the
locality is relinquished.

The result is that this chip never becomes idle since after going idle
the locality is relinquished (`tpm_chip_stop` function in tpm-chip.c).

I patched the 7.8.0 kernel for bypassing the `tpm_relinquish_locality`
call and so far the PC is suspending and power off normally,
TPM_CRB_CTRL_STS_0.tpmIdle remains set whenever the device is not used
now.

I believe this is related to this specific chip, if the fix remains
working for 2 weeks I will submit the patch. Please advise me if it
makes sense.

Best regards,
Adam

Em qua., 13 de mar. de 2024 =C3=A0s 14:02, Adam Alves <adamoa@gmail.com> es=
creveu:
>
> Hi Jarkko,
>
> Thank you very much for kindly reviewing this proposal.
>
> After one week without any issues with my PC hanging, it happened
> again. It seems that the fix I am proposing is not final (it only
> reduced the frequency since it always happened when I shutdown after
> couple hours of power up time and now it only happened after two weeks
> with a similar usage rate).
>
> I will share with you the data you requested below.
>
> > The lacking information here is the CPU model (/proc/cpuinfo), on
> > which kernel version the bug was produced and what kind of TPM the
> > system has (discrete chip or firmware TPM should be easy to check
> > from BIOS).
>
> CPU model: Intel(R) Core(TM) i7-10700F CPU @ 2.90GHz
> I am attaching data from /proc/cpuinfo
>
> TPM: No info on mainboard documentation regarding TPM. BIOS is not
> clear whether or not it is discrete or firmware. Based on dmidecode
> (attached) I get the following:
> TPM Device
>         Vendor ID: INTC
>         Specification Version: 2.0
>         Firmware Revision: 500.16
>         Description: INTEL
>         Characteristics:
>                 Family configurable via platform software support
>         OEM-specific Information: 0x00000000
> I also extracted TPM_CRB_INTF_ID_0 from the TPM: `a13a808600084311`
> (Vendor ID 8086, Device ID a13a, Revision ID 00). The only match I
> found while browsing for this device ID is 100 Series/C230 Series
> Chipset Family MEI Controller #1, which is a PCI device, so it might
> not be related to the TPM.
>
> The driver bound to the tpm0 device is tpm_crb. The disassembled TPM2
> ACPI table is also attached in case it helps.
>
> The bug was reproduced from upstream kernel version 6.8.0 (attached
> build .config that I used).
>
> > Also, which firmwre version you have and have you tested with the
> > most up to date firmware (BIOS)?
>
> I have the most updated firmware provided by ASUS: TUF GAMING
> B460M-PLUS BIOS 1601
>
> > What is "the ACPI command"? Refer to concrete items instead of
> > asking to guess what you is the ACPI command for you.
>
> I enabled ACPI_DEBUG on my kernel to know where the it was actually
> hanging. The last function is actually the last function that should
> be called by the kernel for a successful shutdown:
> hwsleep-0078 hw_legacy_sleep       : Entering sleep state [S5]^M
> hwregs-0460 hw_write_pm1_control  : ----Entry^M
> hwvalid-0097 hw_validate_io_request: ----Entry^M
> hwvalid-0111 hw_validate_io_request: Address 0000000000001804
> LastAddress 0000000000001805 Length 2  hwvalid-0128
> hw_validate_io_request: ----Exit- AE_OK^M
> hwregs-0360 hw_write              : Wrote: 0000000000001C01 width 16
> to 0000000000001804 (SystemIO)^M
> hwregs-0473 hw_write_pm1_control  : ----Exit- AE_OK^M
> hwregs-0460 hw_write_pm1_control  : ----Entry^M
> hwvalid-0097 hw_validate_io_request: ----Entry^M
> hwvalid-0111 hw_validate_io_request: Address 0000000000001804
> LastAddress 0000000000001805 Length 2  hwvalid-0128
> hw_validate_io_request: ----Exit- AE_OK^M
>
> It is writing both SLP_TYP + SLP_EN to ACPI PM1b_CNT registers (as
> expected by specification). I checked the flags and it is in line with
> the flags required by the system ACPI tables.
>
> I understand from that that the system is hanging after ACPI firmware
> takes over. The same issue happens if I force a EFI shutdown.
>
> Since the the BUG has appeared again even with the fix implemented, I
> am holding this patch for now until I find a solution that permanently
> fixes the issue. The next time I try to submit a patch that will
> comply with all your suggestions, thank you very much.
>
> I would appreciate if you had any hint on how I could keep digging to
> find the issue that might be causing this bug. This is an issue that
> only happens when I shutdown from Linux and my TPM is activated in
> BIOS. That's why my guess is that this is what should be causing it.
> From Windows, shutdown is always flawless.
>
> Best regards,
> Adam
>
> >
> > > chip expecting it to be in Locality 0 as expected by TCG PC Client
> > > Platform Firmware Profile Version 1.06 Revision 52 (3.1.1 =E2=80=93 P=
re-OS
> > > Environment) and then when it fails to do so it simply halts the
> > > whole system.
> >
> > We don't speculate about the root cause here, only document it.
> > Please move this paragraph before diffstat (see below)>
> >
> > > Enable a user to configure the kernel through
> > > =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D boot parameter so that =
the locality is set
> > > before suspend/shutdown in order to diagnose whether or not the board=
 is
> > > one of the buggy ones that require this workaround. Since this bug is
> > > related to the board/platform instead of the specific TPM chip, call
> > > dmi_check_system on the tpm_init function so that this setting is
> > > automatically enabled for boards specified in code (ASUS TUF GAMING
> > > B460M-PLUS already included) =E2=80=93 automatic configuration only w=
orks in
> > > case CONFIG_DMI is set though, since dmi_check_system is a non-op whe=
n
> > > CONFIG_DMI is not set.
> >
> > Please describe what the *kernel command-line" (for clarity
> > sake) semantically means.
> >
> > Also please remove anything about diangnosing. We care only
> > about fixes.
> >
> > >
> > > In case =E2=80=9Ctpm.locality_on_suspend=3D0=E2=80=9D (the default) d=
on't change any
> > > behavior thus preserving current functionality of any other board
> > > except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly futur=
e
> > > boards as we successfully diagnose other boards with the same issue
> > > fixed by using =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D.
> >
> > This neither documents the default value. I'm also lost did setting
> > this "1" or "0" fix the issue in your case?
> >
> > So: firmware version and being up-to-date is important and also this
> > needs to be reproduciable with the mainline Linux tree, not distro
> > kernel or custom kernel.
> >
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217890
> > > Signed-off-by: Adam Alves <adamoa@gmail.com>
> > > ---
> >
> > <cover letter>
> >
> > OK, I'll try to check what is done here but please re-read
> > "describing your changes" before sending next version:
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
describe-your-changes
> >
> > > v1->v2: fix formatting issues and simplified tpm_chip_stop code.
> > >
> > >  drivers/char/tpm/tpm-chip.c      | 12 +++++++++++
> > >  drivers/char/tpm/tpm-interface.c | 37 ++++++++++++++++++++++++++++++=
++
> > >  drivers/char/tpm/tpm.h           |  1 +
> > >  include/linux/tpm.h              |  1 +
> > >  4 files changed, 51 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.=
c
> > > index 42b1062e33cd..a183e1355289 100644
> > > --- a/drivers/char/tpm/tpm-chip.c
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -137,6 +137,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
> > >   */
> > >  void tpm_chip_stop(struct tpm_chip *chip)
> > >  {
> > > +     if (chip->flags & TPM_CHIP_FLAG_PRESERVE_LOCALITY) {
> >
> > The commit message did not explain what this flag is and what is its
> > purpose.
> >
> > Also why you need to populate global flag inside chip, or the value
> > of it?
> >
> > Why this is not just:
> >
> >         if (tpm_locality_on_suspend) {
> > ?
> >
> >
> > > +             if (chip->locality !=3D 0)
> > > +                     tpm_request_locality(chip);
> >
> > This will unconditionally skip calling tpm_request_locality() because
> > Linux only uses locality 0. Not sure what good does this make.
> >
> > > +             return;
> > > +     }
> > > +
> > >       tpm_go_idle(chip);
> > >       tpm_relinquish_locality(chip);
> > >       tpm_clk_disable(chip);
> > > @@ -291,6 +297,9 @@ int tpm_class_shutdown(struct device *dev)
> > >  {
> > >       struct tpm_chip *chip =3D container_of(dev, struct tpm_chip, de=
v);
> > >
> > > +     if (tpm_locality_on_suspend)
> > > +             chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> > > +
> > >       down_write(&chip->ops_sem);
> > >       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > >               if (!tpm_chip_start(chip)) {
> > > @@ -668,6 +677,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
> > >   */
> > >  void tpm_chip_unregister(struct tpm_chip *chip)
> > >  {
> > > +     if (tpm_locality_on_suspend)
> > > +             chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> > > +
> > >       tpm_del_legacy_sysfs(chip);
> > >       if (tpm_is_hwrng_enabled(chip))
> > >               hwrng_unregister(&chip->hwrng);
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-=
interface.c
> > > index 66b16d26eecc..7f770ea98402 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/suspend.h>
> > >  #include <linux/freezer.h>
> > >  #include <linux/tpm_eventlog.h>
> > > +#include <linux/dmi.h>
> > >
> > >  #include "tpm.h"
> > >
> > > @@ -382,6 +383,36 @@ int tpm_auto_startup(struct tpm_chip *chip)
> > >       return rc;
> > >  }
> > >
> > > +/*
> > > + * Bug workaround - some boards expect the TPM to be on Locality 0
> > > + * before suspend/shutdown, halting the system otherwise before
> > > + * suspend and shutdown. Change suspend behavior for these cases.
> > > + */
> > > +bool tpm_locality_on_suspend;
> > > +module_param_named(locality_on_suspend, tpm_locality_on_suspend, boo=
l, 0644);
> > > +MODULE_PARM_DESC(locality_on_suspend,
> > > +              "Put TPM at locality 0 before suspend/shutdown.");
> > > +
> > > +static int __init tpm_set_locality_on_suspend(const struct dmi_syste=
m_id *system_id)
> > > +{
> > > +     pr_info("Board %s: TPM locality preserved before suspend/shutdo=
wn.\n",
> > > +             system_id->ident);
> >
> > Please remove pr_info(), we do not want to bloat klog.
> >
> > > +     tpm_locality_on_suspend =3D true;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct dmi_system_id tpm_board_quirks[] __initconst =3D=
 {
> >
> > The commit message did not introduce this. Also should have inline
> > documentation.
> >
> > /*
> >  * What the heck this.
> >  */
> >
> > > +     {
> > > +             .ident =3D "TUF GAMING B460M-PLUS",
> > > +             .matches =3D {
> > > +                     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER I=
NC."),
> > > +                     DMI_MATCH(DMI_BOARD_NAME, "TUF GAMING B460M-PLU=
S"),
> > > +             },
> > > +             .callback =3D tpm_set_locality_on_suspend,
> > > +     },
> > > +};
> > > +
> > >  /*
> > >   * We are about to suspend. Save the TPM state
> > >   * so that it can be restored.
> > > @@ -394,6 +425,9 @@ int tpm_pm_suspend(struct device *dev)
> > >       if (!chip)
> > >               return -ENODEV;
> > >
> > > +     if (tpm_locality_on_suspend)
> > > +             chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> > > +
> > >       if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > >               goto suspended;
> > >
> > > @@ -431,6 +465,7 @@ int tpm_pm_resume(struct device *dev)
> > >       if (chip =3D=3D NULL)
> > >               return -ENODEV;
> > >
> > > +     chip->flags &=3D ~TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> > >       chip->flags &=3D ~TPM_CHIP_FLAG_SUSPENDED;
> > >
> > >       /*
> > > @@ -476,6 +511,8 @@ static int __init tpm_init(void)
> > >  {
> > >       int rc;
> > >
> > > +     dmi_check_system(tpm_board_quirks);
> > > +
> > >       rc =3D class_register(&tpm_class);
> > >       if (rc) {
> > >               pr_err("couldn't create tpm class\n");
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index 61445f1dc46d..f2657b611b81 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -236,6 +236,7 @@ extern dev_t tpm_devt;
> > >  extern const struct file_operations tpm_fops;
> > >  extern const struct file_operations tpmrm_fops;
> > >  extern struct idr dev_nums_idr;
> > > +extern bool tpm_locality_on_suspend;
> > >
> > >  ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
> > >  int tpm_get_timeouts(struct tpm_chip *);
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index 4ee9d13749ad..1fbb33f386d1 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -284,6 +284,7 @@ enum tpm_chip_flags {
> > >       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
> > >       TPM_CHIP_FLAG_SUSPENDED                 =3D BIT(8),
> > >       TPM_CHIP_FLAG_HWRNG_DISABLED            =3D BIT(9),
> > > +     TPM_CHIP_FLAG_PRESERVE_LOCALITY         =3D BIT(10),
> > >  };
> > >
> > >  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> >
> >
> > BR, Jarkko
>
>
>
> --
> Adam Oliveira Alves



--=20
Adam Oliveira Alves

