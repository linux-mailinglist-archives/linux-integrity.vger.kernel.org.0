Return-Path: <linux-integrity+bounces-1747-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82987AEE4
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Mar 2024 19:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65812856A8
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Mar 2024 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5595B76913;
	Wed, 13 Mar 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFbJLLC7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB9762DE
	for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349374; cv=none; b=m0Fn+IInWimhkPpm9agdZjeRO5nB3H4k/VbPKQuMwsOt3GXxhaZoqNgJxu55Z5XlufhxG5pBSChr2ZPH2izW5yqXkO+XV9uFvTza9mth62VkuTPSM8PsOxWrSl+kydBiflU7JzZaldEriMIgcRKT361TABxcCQrhLR8QLxg1aQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349374; c=relaxed/simple;
	bh=UhNFvY0M3G2fNK3t77pI/0Q5QmnqLy6QZYvOE1VJ0d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi0L2PDrXfiPKdabF3mKZAOYlM9OFucWVG4pMe/vUpZtYBSmHOq/eijKSvgvu539aqabaZrVuM8ANuWZvTSYo+df7JvskPR8HSuEh7d77EZLa3JB+7nGr+jDyD/XdsYO0EFyRgOk6oP+8pOfJOEy+iOoLdZ9UxhKMOwhZylHAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFbJLLC7; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd045349d42so6455359276.2
        for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2024 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710349369; x=1710954169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=274bBZi9m0iiNFmhLJ5NWrEjwlyS8AwBWjFAipaTZwQ=;
        b=AFbJLLC7R+5OdDxqyDiDSlNDSBZb+aarVtu+2XGI8kWR551HPJYVK/NJ9GQbHYJYFZ
         oqurq49fNipksqLrYVmtQiQFBZeh40NZ5ajLFinPzKgHRPsvV1WJKUdbJE/gg+VovJfp
         StCuyD02sikWWGgi4c7+hil9RCIF5PoPbllg/qUtzOjOjBkxtCaH355JkoEtE9az5wQ6
         DfwMA+ilHiX5/zs6eeDLM9mEoPYE7OIgHrxZkGdyTjXqqeCtecAe3gukl/NtjA5hRsEh
         IKeYzcsRDnap0W7wW9CXtEwZGBksE7dBnHApKe4Wgj9R2zcatzif0qecPXferwH+gta5
         Zo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349369; x=1710954169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=274bBZi9m0iiNFmhLJ5NWrEjwlyS8AwBWjFAipaTZwQ=;
        b=dMJDIleJXyCUSfkQG9DLdzA/Qdlj6mNj89iFEo1uX1Pb91QA/J/12v2ggllQa3xi4W
         Waf9zcKHmLF90UE2mYJ6lrvDw0a4guYhauJCvHy/hhrlUahx5GFaDmP2lGSLJ9Ikmcfq
         jlUdHb+zsyr2prRBIWHjbJ0slYqzYx+zqOtdOn3tAZiEYsYXiUXa0ugTIa5Zz/GyiDw1
         eOYn9n4E0oOtI9IcG/Kryb1shl7WD5+R5f9RLdOFKvkbpsjT/mkMfJ3Ro0Uq2NoWteJe
         QZM9kEjntYCSXjthpTFe24376ccDabxOL0PD2jTHfgIs+7LBUZH0E1GYAvVr3M49UDDr
         B9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVTiNT9yYIcI4AOJpdig0qpaCD5sEbq4nnf2wWD3Oim9Cp6plRgz4+ytcotYAKGtVUAC23qCjJI0uHWoToie1lQoCDuCt5/vFD8xMv9jIAO
X-Gm-Message-State: AOJu0YxVRrHcw2SxCJ5TBndBZ77uiWkM+Y0cQCFW6wLgnHHXH7wnflFR
	50xOkKTKv18YsXdhPDoqZqd9q7Ds5wVW1GsvFRl+0aQoVjkhzpD/S9RCJnFyvfPT2KhrYuI67Pz
	ADUlaY9WRaDTLRiT7gQQlZB+TjrQ=
X-Google-Smtp-Source: AGHT+IElw6mH2n4M8m5+EQESyNgr0xYY63vnDqVgysFCfEYUNkb1nGa5F1tvXto4QOs1+thAvQKJHcedHywx15tj0Yw=
X-Received: by 2002:a5b:b86:0:b0:dc6:4062:1341 with SMTP id
 l6-20020a5b0b86000000b00dc640621341mr2821688ybq.16.1710349368687; Wed, 13 Mar
 2024 10:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org> <20240307224957.29432-1-adamoa@gmail.com>
 <CZR6VBRUEPKW.26B7HTOJZ0ANX@kernel.org>
In-Reply-To: <CZR6VBRUEPKW.26B7HTOJZ0ANX@kernel.org>
From: Adam Alves <adamoa@gmail.com>
Date: Wed, 13 Mar 2024 14:02:37 -0300
Message-ID: <CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by preserving
 chip Locality
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009026a806138dbef9"

--0000000000009026a806138dbef9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Thank you very much for kindly reviewing this proposal.

After one week without any issues with my PC hanging, it happened
again. It seems that the fix I am proposing is not final (it only
reduced the frequency since it always happened when I shutdown after
couple hours of power up time and now it only happened after two weeks
with a similar usage rate).

I will share with you the data you requested below.

> The lacking information here is the CPU model (/proc/cpuinfo), on
> which kernel version the bug was produced and what kind of TPM the
> system has (discrete chip or firmware TPM should be easy to check
> from BIOS).

CPU model: Intel(R) Core(TM) i7-10700F CPU @ 2.90GHz
I am attaching data from /proc/cpuinfo

TPM: No info on mainboard documentation regarding TPM. BIOS is not
clear whether or not it is discrete or firmware. Based on dmidecode
(attached) I get the following:
TPM Device
        Vendor ID: INTC
        Specification Version: 2.0
        Firmware Revision: 500.16
        Description: INTEL
        Characteristics:
                Family configurable via platform software support
        OEM-specific Information: 0x00000000
I also extracted TPM_CRB_INTF_ID_0 from the TPM: `a13a808600084311`
(Vendor ID 8086, Device ID a13a, Revision ID 00). The only match I
found while browsing for this device ID is 100 Series/C230 Series
Chipset Family MEI Controller #1, which is a PCI device, so it might
not be related to the TPM.

The driver bound to the tpm0 device is tpm_crb. The disassembled TPM2
ACPI table is also attached in case it helps.

The bug was reproduced from upstream kernel version 6.8.0 (attached
build .config that I used).

> Also, which firmwre version you have and have you tested with the
> most up to date firmware (BIOS)?

I have the most updated firmware provided by ASUS: TUF GAMING
B460M-PLUS BIOS 1601

> What is "the ACPI command"? Refer to concrete items instead of
> asking to guess what you is the ACPI command for you.

I enabled ACPI_DEBUG on my kernel to know where the it was actually
hanging. The last function is actually the last function that should
be called by the kernel for a successful shutdown:
hwsleep-0078 hw_legacy_sleep       : Entering sleep state [S5]^M
hwregs-0460 hw_write_pm1_control  : ----Entry^M
hwvalid-0097 hw_validate_io_request: ----Entry^M
hwvalid-0111 hw_validate_io_request: Address 0000000000001804
LastAddress 0000000000001805 Length 2  hwvalid-0128
hw_validate_io_request: ----Exit- AE_OK^M
hwregs-0360 hw_write              : Wrote: 0000000000001C01 width 16
to 0000000000001804 (SystemIO)^M
hwregs-0473 hw_write_pm1_control  : ----Exit- AE_OK^M
hwregs-0460 hw_write_pm1_control  : ----Entry^M
hwvalid-0097 hw_validate_io_request: ----Entry^M
hwvalid-0111 hw_validate_io_request: Address 0000000000001804
LastAddress 0000000000001805 Length 2  hwvalid-0128
hw_validate_io_request: ----Exit- AE_OK^M

It is writing both SLP_TYP + SLP_EN to ACPI PM1b_CNT registers (as
expected by specification). I checked the flags and it is in line with
the flags required by the system ACPI tables.

I understand from that that the system is hanging after ACPI firmware
takes over. The same issue happens if I force a EFI shutdown.

Since the the BUG has appeared again even with the fix implemented, I
am holding this patch for now until I find a solution that permanently
fixes the issue. The next time I try to submit a patch that will
comply with all your suggestions, thank you very much.

I would appreciate if you had any hint on how I could keep digging to
find the issue that might be causing this bug. This is an issue that
only happens when I shutdown from Linux and my TPM is activated in
BIOS. That's why my guess is that this is what should be causing it.
From Windows, shutdown is always flawless.

Best regards,
Adam

>
> > chip expecting it to be in Locality 0 as expected by TCG PC Client
> > Platform Firmware Profile Version 1.06 Revision 52 (3.1.1 =E2=80=93 Pre=
-OS
> > Environment) and then when it fails to do so it simply halts the
> > whole system.
>
> We don't speculate about the root cause here, only document it.
> Please move this paragraph before diffstat (see below)>
>
> > Enable a user to configure the kernel through
> > =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D boot parameter so that th=
e locality is set
> > before suspend/shutdown in order to diagnose whether or not the board i=
s
> > one of the buggy ones that require this workaround. Since this bug is
> > related to the board/platform instead of the specific TPM chip, call
> > dmi_check_system on the tpm_init function so that this setting is
> > automatically enabled for boards specified in code (ASUS TUF GAMING
> > B460M-PLUS already included) =E2=80=93 automatic configuration only wor=
ks in
> > case CONFIG_DMI is set though, since dmi_check_system is a non-op when
> > CONFIG_DMI is not set.
>
> Please describe what the *kernel command-line" (for clarity
> sake) semantically means.
>
> Also please remove anything about diangnosing. We care only
> about fixes.
>
> >
> > In case =E2=80=9Ctpm.locality_on_suspend=3D0=E2=80=9D (the default) don=
't change any
> > behavior thus preserving current functionality of any other board
> > except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
> > boards as we successfully diagnose other boards with the same issue
> > fixed by using =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D.
>
> This neither documents the default value. I'm also lost did setting
> this "1" or "0" fix the issue in your case?
>
> So: firmware version and being up-to-date is important and also this
> needs to be reproduciable with the mainline Linux tree, not distro
> kernel or custom kernel.
>
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217890
> > Signed-off-by: Adam Alves <adamoa@gmail.com>
> > ---
>
> <cover letter>
>
> OK, I'll try to check what is done here but please re-read
> "describing your changes" before sending next version:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
scribe-your-changes
>
> > v1->v2: fix formatting issues and simplified tpm_chip_stop code.
> >
> >  drivers/char/tpm/tpm-chip.c      | 12 +++++++++++
> >  drivers/char/tpm/tpm-interface.c | 37 ++++++++++++++++++++++++++++++++
> >  drivers/char/tpm/tpm.h           |  1 +
> >  include/linux/tpm.h              |  1 +
> >  4 files changed, 51 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 42b1062e33cd..a183e1355289 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -137,6 +137,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
> >   */
> >  void tpm_chip_stop(struct tpm_chip *chip)
> >  {
> > +     if (chip->flags & TPM_CHIP_FLAG_PRESERVE_LOCALITY) {
>
> The commit message did not explain what this flag is and what is its
> purpose.
>
> Also why you need to populate global flag inside chip, or the value
> of it?
>
> Why this is not just:
>
>         if (tpm_locality_on_suspend) {
> ?
>
>
> > +             if (chip->locality !=3D 0)
> > +                     tpm_request_locality(chip);
>
> This will unconditionally skip calling tpm_request_locality() because
> Linux only uses locality 0. Not sure what good does this make.
>
> > +             return;
> > +     }
> > +
> >       tpm_go_idle(chip);
> >       tpm_relinquish_locality(chip);
> >       tpm_clk_disable(chip);
> > @@ -291,6 +297,9 @@ int tpm_class_shutdown(struct device *dev)
> >  {
> >       struct tpm_chip *chip =3D container_of(dev, struct tpm_chip, dev)=
;
> >
> > +     if (tpm_locality_on_suspend)
> > +             chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> > +
> >       down_write(&chip->ops_sem);
> >       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> >               if (!tpm_chip_start(chip)) {
> > @@ -668,6 +677,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
> >   */
> >  void tpm_chip_unregister(struct tpm_chip *chip)
> >  {
> > +     if (tpm_locality_on_suspend)
> > +             chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> > +
> >       tpm_del_legacy_sysfs(chip);
> >       if (tpm_is_hwrng_enabled(chip))
> >               hwrng_unregister(&chip->hwrng);
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-in=
terface.c
> > index 66b16d26eecc..7f770ea98402 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/suspend.h>
> >  #include <linux/freezer.h>
> >  #include <linux/tpm_eventlog.h>
> > +#include <linux/dmi.h>
> >
> >  #include "tpm.h"
> >
> > @@ -382,6 +383,36 @@ int tpm_auto_startup(struct tpm_chip *chip)
> >       return rc;
> >  }
> >
> > +/*
> > + * Bug workaround - some boards expect the TPM to be on Locality 0
> > + * before suspend/shutdown, halting the system otherwise before
> > + * suspend and shutdown. Change suspend behavior for these cases.
> > + */
> > +bool tpm_locality_on_suspend;
> > +module_param_named(locality_on_suspend, tpm_locality_on_suspend, bool,=
 0644);
> > +MODULE_PARM_DESC(locality_on_suspend,
> > +              "Put TPM at locality 0 before suspend/shutdown.");
> > +
> > +static int __init tpm_set_locality_on_suspend(const struct dmi_system_=
id *system_id)
> > +{
> > +     pr_info("Board %s: TPM locality preserved before suspend/shutdown=
.\n",
> > +             system_id->ident);
>
> Please remove pr_info(), we do not want to bloat klog.
>
> > +     tpm_locality_on_suspend =3D true;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dmi_system_id tpm_board_quirks[] __initconst =3D {
>
> The commit message did not introduce this. Also should have inline
> documentation.
>
> /*
>  * What the heck this.
>  */
>
> > +     {
> > +             .ident =3D "TUF GAMING B460M-PLUS",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC=
."),
> > +                     DMI_MATCH(DMI_BOARD_NAME, "TUF GAMING B460M-PLUS"=
),
> > +             },
> > +             .callback =3D tpm_set_locality_on_suspend,
> > +     },
> > +};
> > +
> >  /*
> >   * We are about to suspend. Save the TPM state
> >   * so that it can be restored.
> > @@ -394,6 +425,9 @@ int tpm_pm_suspend(struct device *dev)
> >       if (!chip)
> >               return -ENODEV;
> >
> > +     if (tpm_locality_on_suspend)
> > +             chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> > +
> >       if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> >               goto suspended;
> >
> > @@ -431,6 +465,7 @@ int tpm_pm_resume(struct device *dev)
> >       if (chip =3D=3D NULL)
> >               return -ENODEV;
> >
> > +     chip->flags &=3D ~TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> >       chip->flags &=3D ~TPM_CHIP_FLAG_SUSPENDED;
> >
> >       /*
> > @@ -476,6 +511,8 @@ static int __init tpm_init(void)
> >  {
> >       int rc;
> >
> > +     dmi_check_system(tpm_board_quirks);
> > +
> >       rc =3D class_register(&tpm_class);
> >       if (rc) {
> >               pr_err("couldn't create tpm class\n");
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 61445f1dc46d..f2657b611b81 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -236,6 +236,7 @@ extern dev_t tpm_devt;
> >  extern const struct file_operations tpm_fops;
> >  extern const struct file_operations tpmrm_fops;
> >  extern struct idr dev_nums_idr;
> > +extern bool tpm_locality_on_suspend;
> >
> >  ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
> >  int tpm_get_timeouts(struct tpm_chip *);
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 4ee9d13749ad..1fbb33f386d1 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -284,6 +284,7 @@ enum tpm_chip_flags {
> >       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
> >       TPM_CHIP_FLAG_SUSPENDED                 =3D BIT(8),
> >       TPM_CHIP_FLAG_HWRNG_DISABLED            =3D BIT(9),
> > +     TPM_CHIP_FLAG_PRESERVE_LOCALITY         =3D BIT(10),
> >  };
> >
> >  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>
>
> BR, Jarkko



--
Adam Oliveira Alves

--0000000000009026a806138dbef9
Content-Type: text/plain; charset="US-ASCII"; name="dmidecode.txt"
Content-Disposition: attachment; filename="dmidecode.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ltq1mfcu1>
X-Attachment-Id: f_ltq1mfcu1

IyBkbWlkZWNvZGUgMy41CkdldHRpbmcgU01CSU9TIGRhdGEgZnJvbSBzeXNmcy4KU01CSU9TIDMu
Mi4wIHByZXNlbnQuClRhYmxlIGF0IDB4N0ZCQjQwMDAuCgpIYW5kbGUgMHgwMDAwLCBETUkgdHlw
ZSAwLCAyNiBieXRlcwpCSU9TIEluZm9ybWF0aW9uCglWZW5kb3I6IEFtZXJpY2FuIE1lZ2F0cmVu
ZHMgSW5jLgoJVmVyc2lvbjogMTYwMQoJUmVsZWFzZSBEYXRlOiAwMi8xMS8yMDIyCglBZGRyZXNz
OiAweEYwMDAwCglSdW50aW1lIFNpemU6IDY0IGtCCglST00gU2l6ZTogMTYgTUIKCUNoYXJhY3Rl
cmlzdGljczoKCQlQQ0kgaXMgc3VwcG9ydGVkCgkJQklPUyBpcyB1cGdyYWRlYWJsZQoJCUJJT1Mg
c2hhZG93aW5nIGlzIGFsbG93ZWQKCQlCb290IGZyb20gQ0QgaXMgc3VwcG9ydGVkCgkJU2VsZWN0
YWJsZSBib290IGlzIHN1cHBvcnRlZAoJCUJJT1MgUk9NIGlzIHNvY2tldGVkCgkJRUREIGlzIHN1
cHBvcnRlZAoJCTUuMjUiLzEuMiBNQiBmbG9wcHkgc2VydmljZXMgYXJlIHN1cHBvcnRlZCAoaW50
IDEzaCkKCQkzLjUiLzcyMCBrQiBmbG9wcHkgc2VydmljZXMgYXJlIHN1cHBvcnRlZCAoaW50IDEz
aCkKCQkzLjUiLzIuODggTUIgZmxvcHB5IHNlcnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxM2gp
CgkJUHJpbnQgc2NyZWVuIHNlcnZpY2UgaXMgc3VwcG9ydGVkIChpbnQgNWgpCgkJU2VyaWFsIHNl
cnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxNGgpCgkJUHJpbnRlciBzZXJ2aWNlcyBhcmUgc3Vw
cG9ydGVkIChpbnQgMTdoKQoJCUFDUEkgaXMgc3VwcG9ydGVkCgkJVVNCIGxlZ2FjeSBpcyBzdXBw
b3J0ZWQKCQlCSU9TIGJvb3Qgc3BlY2lmaWNhdGlvbiBpcyBzdXBwb3J0ZWQKCQlUYXJnZXRlZCBj
b250ZW50IGRpc3RyaWJ1dGlvbiBpcyBzdXBwb3J0ZWQKCQlVRUZJIGlzIHN1cHBvcnRlZAoJQklP
UyBSZXZpc2lvbjogMTYuMQoKSGFuZGxlIDB4MDAwMSwgRE1JIHR5cGUgMSwgMjcgYnl0ZXMKU3lz
dGVtIEluZm9ybWF0aW9uCglNYW51ZmFjdHVyZXI6IEFTVVMKCVByb2R1Y3QgTmFtZTogU3lzdGVt
IFByb2R1Y3QgTmFtZQoJVmVyc2lvbjogU3lzdGVtIFZlcnNpb24KCVNlcmlhbCBOdW1iZXI6IFN5
c3RlbSBTZXJpYWwgTnVtYmVyCglVVUlEOiAxOGUxNTc1NC03MTk4LTRjZDAtYjQ2YS0zYzdjM2Yz
YmVmZTIKCVdha2UtdXAgVHlwZTogUG93ZXIgU3dpdGNoCglTS1UgTnVtYmVyOiBTS1UKCUZhbWls
eTogVG8gYmUgZmlsbGVkIGJ5IE8uRS5NLgoKSGFuZGxlIDB4MDAwMiwgRE1JIHR5cGUgMiwgMTUg
Ynl0ZXMKQmFzZSBCb2FyZCBJbmZvcm1hdGlvbgoJTWFudWZhY3R1cmVyOiBBU1VTVGVLIENPTVBV
VEVSIElOQy4KCVByb2R1Y3QgTmFtZTogVFVGIEdBTUlORyBCNDYwTS1QTFVTCglWZXJzaW9uOiBS
ZXYgMS54eAoJU2VyaWFsIE51bWJlcjogMjEwMzc4NDA4MjAzNjM3CglBc3NldCBUYWc6IERlZmF1
bHQgc3RyaW5nCglGZWF0dXJlczoKCQlCb2FyZCBpcyBhIGhvc3RpbmcgYm9hcmQKCQlCb2FyZCBp
cyByZXBsYWNlYWJsZQoJTG9jYXRpb24gSW4gQ2hhc3NpczogRGVmYXVsdCBzdHJpbmcKCUNoYXNz
aXMgSGFuZGxlOiAweDAwMDMKCVR5cGU6IE1vdGhlcmJvYXJkCglDb250YWluZWQgT2JqZWN0IEhh
bmRsZXM6IDAKCkhhbmRsZSAweDAwMDMsIERNSSB0eXBlIDMsIDIyIGJ5dGVzCkNoYXNzaXMgSW5m
b3JtYXRpb24KCU1hbnVmYWN0dXJlcjogRGVmYXVsdCBzdHJpbmcKCVR5cGU6IERlc2t0b3AKCUxv
Y2s6IE5vdCBQcmVzZW50CglWZXJzaW9uOiBEZWZhdWx0IHN0cmluZwoJU2VyaWFsIE51bWJlcjog
RGVmYXVsdCBzdHJpbmcKCUFzc2V0IFRhZzogRGVmYXVsdCBzdHJpbmcKCUJvb3QtdXAgU3RhdGU6
IFNhZmUKCVBvd2VyIFN1cHBseSBTdGF0ZTogU2FmZQoJVGhlcm1hbCBTdGF0ZTogU2FmZQoJU2Vj
dXJpdHkgU3RhdHVzOiBOb25lCglPRU0gSW5mb3JtYXRpb246IDB4MDAwMDAwMDAKCUhlaWdodDog
VW5zcGVjaWZpZWQKCU51bWJlciBPZiBQb3dlciBDb3JkczogMQoJQ29udGFpbmVkIEVsZW1lbnRz
OiAwCglTS1UgTnVtYmVyOiBEZWZhdWx0IHN0cmluZwoKSGFuZGxlIDB4MDAwNCwgRE1JIHR5cGUg
OCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNl
IERlc2lnbmF0b3I6IEtCTVNfVVNCOTEwCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJ
RXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFBTLzIgTW91c2UvS2V5Ym9hcmQKCUV4dGVy
bmFsIENvbm5lY3RvciBUeXBlOiBQUy8yCglQb3J0IFR5cGU6IE1vdXNlIFBvcnQKCkhhbmRsZSAw
eDAwMDUsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUlu
dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBIRE1JX0RQCglJbnRlcm5hbCBDb25uZWN0b3Ig
VHlwZTogTm9uZQoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IEhETUlfRFAKCUV4dGVy
bmFsIENvbm5lY3RvciBUeXBlOiBPdGhlcgoJUG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAw
NiwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJu
YWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IERWSQoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5v
bmUKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBEVkkKCUV4dGVybmFsIENvbm5lY3Rv
ciBUeXBlOiBPdGhlcgoJUG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAwNywgRE1JIHR5cGUg
OCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNl
IERlc2lnbmF0b3I6IFUzMkcxXzM0CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJRXh0
ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFUzMkcxXzM0CglFeHRlcm5hbCBDb25uZWN0b3Ig
VHlwZTogQWNjZXNzIEJ1cyAoVVNCKQoJUG9ydCBUeXBlOiBVU0IKCkhhbmRsZSAweDAwMDgsIERN
SSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJl
ZmVyZW5jZSBEZXNpZ25hdG9yOiBMQU5fVTMyRzFfMTIKCUludGVybmFsIENvbm5lY3RvciBUeXBl
OiBOb25lCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTEFOX1UzMkcxXzEyCglFeHRl
cm5hbCBDb25uZWN0b3IgVHlwZTogUkotNDUKCVBvcnQgVHlwZTogTmV0d29yayBQb3J0CgpIYW5k
bGUgMHgwMDA5LCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9u
CglJbnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogQVVESU8KCUludGVybmFsIENvbm5lY3Rv
ciBUeXBlOiBOb25lCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogQVVESU8KCUV4dGVy
bmFsIENvbm5lY3RvciBUeXBlOiBPdGhlcgoJUG9ydCBUeXBlOiBBdWRpbyBQb3J0CgpIYW5kbGUg
MHgwMDBBLCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJ
bnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogQ1BVX0ZBTgoJSW50ZXJuYWwgQ29ubmVjdG9y
IFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmll
ZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRs
ZSAweDAwMEIsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24K
CUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBDUFVfT1BUCglJbnRlcm5hbCBDb25uZWN0
b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3QgU3BlY2lm
aWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9ydCBUeXBlOiBPdGhlcgoKSGFu
ZGxlIDB4MDAwQywgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlv
bgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IENIQV9GQU4xCglJbnRlcm5hbCBDb25u
ZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3QgU3Bl
Y2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9ydCBUeXBlOiBPdGhlcgoK
SGFuZGxlIDB4MDAwRCwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1h
dGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IENIQV9GQU4yCglJbnRlcm5hbCBD
b25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3Qg
U3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9ydCBUeXBlOiBPdGhl
cgoKSGFuZGxlIDB4MDAwRSwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZv
cm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFJHQl9IRUFERVIxCglJbnRl
cm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9y
OiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9ydCBUeXBl
OiBPdGhlcgoKSGFuZGxlIDB4MDAwRiwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3Rv
ciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFJHQl9IRUFERVIy
CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNp
Z25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9y
dCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxMCwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENv
bm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IEFERF9H
RU4yCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBE
ZXNpZ25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJ
UG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxMSwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0
IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IENP
TQoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVz
aWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBv
cnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMTIsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBD
b25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBBQUZQ
CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNp
Z25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9y
dCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxMywgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENv
bm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFBBTkVM
CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNp
Z25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9y
dCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxNCwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENv
bm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IENPTV9E
RUJVRwoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2Ug
RGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUK
CVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMTUsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9y
dCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBV
U0I3OAoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IEFjY2VzcyBCdXMgKFVTQikKCUV4dGVybmFs
IFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3Ig
VHlwZTogTm9uZQoJUG9ydCBUeXBlOiBVU0IKCkhhbmRsZSAweDAwMTYsIERNSSB0eXBlIDgsIDkg
Ynl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNp
Z25hdG9yOiBVU0JfRTEyCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogQWNjZXNzIEJ1cyAoVVNC
KQoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IE5vdCBTcGVjaWZpZWQKCUV4dGVybmFs
IENvbm5lY3RvciBUeXBlOiBOb25lCglQb3J0IFR5cGU6IFVTQgoKSGFuZGxlIDB4MDAxNywgRE1J
IHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVm
ZXJlbmNlIERlc2lnbmF0b3I6IFUzMkcxXzU2CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogQWNj
ZXNzIEJ1cyAoVVNCKQoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IE5vdCBTcGVjaWZp
ZWQKCUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25lCglQb3J0IFR5cGU6IFVTQgoKSGFuZGxl
IDB4MDAxOCwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJ
SW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFNBVEE2R18xCglJbnRlcm5hbCBDb25uZWN0
b3IgVHlwZTogU0FTL1NBVEEgUGx1ZyBSZWNlcHRhY2xlCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVz
aWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBv
cnQgVHlwZTogU0FUQQoKSGFuZGxlIDB4MDAxOSwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENv
bm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFNBVEE2
R18yCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogU0FTL1NBVEEgUGx1ZyBSZWNlcHRhY2xlCglF
eHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29u
bmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogU0FUQQoKSGFuZGxlIDB4MDAxQSwgRE1JIHR5
cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJl
bmNlIERlc2lnbmF0b3I6IFNBVEE2R18zCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogU0FTL1NB
VEEgUGx1ZyBSZWNlcHRhY2xlCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNw
ZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogU0FUQQoK
SGFuZGxlIDB4MDAxQiwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1h
dGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFNBVEE2R180CglJbnRlcm5hbCBD
b25uZWN0b3IgVHlwZTogU0FTL1NBVEEgUGx1ZyBSZWNlcHRhY2xlCglFeHRlcm5hbCBSZWZlcmVu
Y2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5v
bmUKCVBvcnQgVHlwZTogU0FUQQoKSGFuZGxlIDB4MDAxQywgRE1JIHR5cGUgOCwgOSBieXRlcwpQ
b3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6
IFNBVEE2R181CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogU0FTL1NBVEEgUGx1ZyBSZWNlcHRh
Y2xlCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJu
YWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogU0FUQQoKSGFuZGxlIDB4MDAxRCwg
RE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwg
UmVmZXJlbmNlIERlc2lnbmF0b3I6IFNBVEE2R182CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTog
U0FTL1NBVEEgUGx1ZyBSZWNlcHRhY2xlCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjog
Tm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTog
U0FUQQoKSGFuZGxlIDB4MDAxRSwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJ
bmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IE0uMl8xKFNPQ0tFVDMp
CglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogU0FTL1NBVEEgUGx1ZyBSZWNlcHRhY2xlCglFeHRl
cm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVj
dG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogU0FUQQoKSGFuZGxlIDB4MDAxRiwgRE1JIHR5cGUg
OCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNl
IERlc2lnbmF0b3I6IE0uMl8yKFNPQ0tFVDMpCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogU0FT
L1NBVEEgUGx1ZyBSZWNlcHRhY2xlCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90
IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogU0FU
QQoKSGFuZGxlIDB4MDAyMCwgRE1JIHR5cGUgOSwgMTcgYnl0ZXMKU3lzdGVtIFNsb3QgSW5mb3Jt
YXRpb24KCURlc2lnbmF0aW9uOiBQQ0lFWDE2XzEKCVR5cGU6IHgxNiBQQ0kgRXhwcmVzcwoJQ3Vy
cmVudCBVc2FnZTogSW4gVXNlCglMZW5ndGg6IExvbmcKCUlEOiAwCglDaGFyYWN0ZXJpc3RpY3M6
CgkJMy4zIFYgaXMgcHJvdmlkZWQKCQlPcGVuaW5nIGlzIHNoYXJlZAoJCVBNRSBzaWduYWwgaXMg
c3VwcG9ydGVkCglCdXMgQWRkcmVzczogMDAwMDowMTowMS4wCgpIYW5kbGUgMHgwMDIxLCBETUkg
dHlwZSA5LCAxNyBieXRlcwpTeXN0ZW0gU2xvdCBJbmZvcm1hdGlvbgoJRGVzaWduYXRpb246IFBD
SUVYMQoJVHlwZTogeDEgUENJIEV4cHJlc3MKCUN1cnJlbnQgVXNhZ2U6IEluIFVzZQoJTGVuZ3Ro
OiBTaG9ydAoJSUQ6IDEKCUNoYXJhY3RlcmlzdGljczoKCQkzLjMgViBpcyBwcm92aWRlZAoJCU9w
ZW5pbmcgaXMgc2hhcmVkCgkJUE1FIHNpZ25hbCBpcyBzdXBwb3J0ZWQKCUJ1cyBBZGRyZXNzOiAw
MDAwOjAyOjBkLjQKCkhhbmRsZSAweDAwMjIsIERNSSB0eXBlIDksIDE3IGJ5dGVzClN5c3RlbSBT
bG90IEluZm9ybWF0aW9uCglEZXNpZ25hdGlvbjogUENJRVgxNl8yCglUeXBlOiB4MTYgUENJIEV4
cHJlc3MKCUN1cnJlbnQgVXNhZ2U6IEF2YWlsYWJsZQoJTGVuZ3RoOiBMb25nCglJRDogMgoJQ2hh
cmFjdGVyaXN0aWNzOgoJCTMuMyBWIGlzIHByb3ZpZGVkCgkJT3BlbmluZyBpcyBzaGFyZWQKCQlQ
TUUgc2lnbmFsIGlzIHN1cHBvcnRlZAoJQnVzIEFkZHJlc3M6IDAwMDA6ZmY6MGUuMAoKSGFuZGxl
IDB4MDAyMywgRE1JIHR5cGUgMTAsIDYgYnl0ZXMKT24gQm9hcmQgRGV2aWNlIEluZm9ybWF0aW9u
CglUeXBlOiBWaWRlbwoJU3RhdHVzOiBFbmFibGVkCglEZXNjcmlwdGlvbjogICAgVG8gQmUgRmls
bGVkIEJ5IE8uRS5NLgoKSGFuZGxlIDB4MDAyNCwgRE1JIHR5cGUgMTEsIDUgYnl0ZXMKT0VNIFN0
cmluZ3MKCVN0cmluZyAxOiBEZWZhdWx0IHN0cmluZwoJU3RyaW5nIDI6IERlZmF1bHQgc3RyaW5n
CglTdHJpbmcgMzogTUFSWUxBTkQKCVN0cmluZyA0OiBEZWZhdWx0IHN0cmluZwoJU3RyaW5nIDU6
IERlZmF1bHQgc3RyaW5nCglTdHJpbmcgNjogRGVmYXVsdCBzdHJpbmcKCVN0cmluZyA3OiBEZWZh
dWx0IHN0cmluZwoJU3RyaW5nIDg6IERlZmF1bHQgc3RyaW5nCgpIYW5kbGUgMHgwMDI1LCBETUkg
dHlwZSAxMiwgNSBieXRlcwpTeXN0ZW0gQ29uZmlndXJhdGlvbiBPcHRpb25zCglPcHRpb24gMTog
RGVmYXVsdCBzdHJpbmcKCkhhbmRsZSAweDAwMjYsIERNSSB0eXBlIDMyLCAyMCBieXRlcwpTeXN0
ZW0gQm9vdCBJbmZvcm1hdGlvbgoJU3RhdHVzOiBObyBlcnJvcnMgZGV0ZWN0ZWQKCkhhbmRsZSAw
eDAwMjcsIERNSSB0eXBlIDM0LCAxMSBieXRlcwpNYW5hZ2VtZW50IERldmljZQoJRGVzY3JpcHRp
b246IE51dm90b24gTkNUNjc5OEQKCVR5cGU6IExNNzgKCUFkZHJlc3M6IDB4MDAwMDAwMDAKCUFk
ZHJlc3MgVHlwZTogSS9PIFBvcnQKCkhhbmRsZSAweDAwMjgsIERNSSB0eXBlIDI2LCAyMiBieXRl
cwpWb2x0YWdlIFByb2JlCglEZXNjcmlwdGlvbjogTE03OEEKCUxvY2F0aW9uOiBNb3RoZXJib2Fy
ZAoJU3RhdHVzOiBPSwoJTWF4aW11bSBWYWx1ZTogVW5rbm93bgoJTWluaW11bSBWYWx1ZTogVW5r
bm93bgoJUmVzb2x1dGlvbjogVW5rbm93bgoJVG9sZXJhbmNlOiBVbmtub3duCglBY2N1cmFjeTog
VW5rbm93bgoJT0VNLXNwZWNpZmljIEluZm9ybWF0aW9uOiAweDAwMDAwMDAwCglOb21pbmFsIFZh
bHVlOiBVbmtub3duCgpIYW5kbGUgMHgwMDI5LCBETUkgdHlwZSAzNiwgMTYgYnl0ZXMKTWFuYWdl
bWVudCBEZXZpY2UgVGhyZXNob2xkIERhdGEKCUxvd2VyIE5vbi1jcml0aWNhbCBUaHJlc2hvbGQ6
IDEKCVVwcGVyIE5vbi1jcml0aWNhbCBUaHJlc2hvbGQ6IDIKCUxvd2VyIENyaXRpY2FsIFRocmVz
aG9sZDogMwoJVXBwZXIgQ3JpdGljYWwgVGhyZXNob2xkOiA0CglMb3dlciBOb24tcmVjb3ZlcmFi
bGUgVGhyZXNob2xkOiA1CglVcHBlciBOb24tcmVjb3ZlcmFibGUgVGhyZXNob2xkOiA2CgpIYW5k
bGUgMHgwMDJBLCBETUkgdHlwZSAzNSwgMTEgYnl0ZXMKTWFuYWdlbWVudCBEZXZpY2UgQ29tcG9u
ZW50CglEZXNjcmlwdGlvbjogRGVmYXVsdCBzdHJpbmcKCU1hbmFnZW1lbnQgRGV2aWNlIEhhbmRs
ZTogMHgwMDI3CglDb21wb25lbnQgSGFuZGxlOiAweDAwMjgKCVRocmVzaG9sZCBIYW5kbGU6IDB4
MDAyOQoKSGFuZGxlIDB4MDAyQiwgRE1JIHR5cGUgMjgsIDIyIGJ5dGVzClRlbXBlcmF0dXJlIFBy
b2JlCglEZXNjcmlwdGlvbjogTE03OEEKCUxvY2F0aW9uOiBNb3RoZXJib2FyZAoJU3RhdHVzOiBP
SwoJTWF4aW11bSBWYWx1ZTogVW5rbm93bgoJTWluaW11bSBWYWx1ZTogVW5rbm93bgoJUmVzb2x1
dGlvbjogVW5rbm93bgoJVG9sZXJhbmNlOiBVbmtub3duCglBY2N1cmFjeTogVW5rbm93bgoJT0VN
LXNwZWNpZmljIEluZm9ybWF0aW9uOiAweDAwMDAwMDAwCglOb21pbmFsIFZhbHVlOiBVbmtub3du
CgpIYW5kbGUgMHgwMDJDLCBETUkgdHlwZSAzNiwgMTYgYnl0ZXMKTWFuYWdlbWVudCBEZXZpY2Ug
VGhyZXNob2xkIERhdGEKCUxvd2VyIE5vbi1jcml0aWNhbCBUaHJlc2hvbGQ6IDEKCVVwcGVyIE5v
bi1jcml0aWNhbCBUaHJlc2hvbGQ6IDIKCUxvd2VyIENyaXRpY2FsIFRocmVzaG9sZDogMwoJVXBw
ZXIgQ3JpdGljYWwgVGhyZXNob2xkOiA0CglMb3dlciBOb24tcmVjb3ZlcmFibGUgVGhyZXNob2xk
OiA1CglVcHBlciBOb24tcmVjb3ZlcmFibGUgVGhyZXNob2xkOiA2CgpIYW5kbGUgMHgwMDJELCBE
TUkgdHlwZSAzNSwgMTEgYnl0ZXMKTWFuYWdlbWVudCBEZXZpY2UgQ29tcG9uZW50CglEZXNjcmlw
dGlvbjogRGVmYXVsdCBzdHJpbmcKCU1hbmFnZW1lbnQgRGV2aWNlIEhhbmRsZTogMHgwMDI3CglD
b21wb25lbnQgSGFuZGxlOiAweDAwMkIKCVRocmVzaG9sZCBIYW5kbGU6IDB4MDAyQwoKSGFuZGxl
IDB4MDAyRSwgRE1JIHR5cGUgMjcsIDE1IGJ5dGVzCkNvb2xpbmcgRGV2aWNlCglUZW1wZXJhdHVy
ZSBQcm9iZSBIYW5kbGU6IDB4MDAyQgoJVHlwZTogUG93ZXIgU3VwcGx5IEZhbgoJU3RhdHVzOiBP
SwoJQ29vbGluZyBVbml0IEdyb3VwOiAxCglPRU0tc3BlY2lmaWMgSW5mb3JtYXRpb246IDB4MDAw
MDAwMDAKCU5vbWluYWwgU3BlZWQ6IFVua25vd24gT3IgTm9uLXJvdGF0aW5nCglEZXNjcmlwdGlv
bjogQ29vbGluZyBEZXYgMQoKSGFuZGxlIDB4MDAyRiwgRE1JIHR5cGUgMzYsIDE2IGJ5dGVzCk1h
bmFnZW1lbnQgRGV2aWNlIFRocmVzaG9sZCBEYXRhCglMb3dlciBOb24tY3JpdGljYWwgVGhyZXNo
b2xkOiAxCglVcHBlciBOb24tY3JpdGljYWwgVGhyZXNob2xkOiAyCglMb3dlciBDcml0aWNhbCBU
aHJlc2hvbGQ6IDMKCVVwcGVyIENyaXRpY2FsIFRocmVzaG9sZDogNAoJTG93ZXIgTm9uLXJlY292
ZXJhYmxlIFRocmVzaG9sZDogNQoJVXBwZXIgTm9uLXJlY292ZXJhYmxlIFRocmVzaG9sZDogNgoK
SGFuZGxlIDB4MDAzMCwgRE1JIHR5cGUgMzUsIDExIGJ5dGVzCk1hbmFnZW1lbnQgRGV2aWNlIENv
bXBvbmVudAoJRGVzY3JpcHRpb246IERlZmF1bHQgc3RyaW5nCglNYW5hZ2VtZW50IERldmljZSBI
YW5kbGU6IDB4MDAyNwoJQ29tcG9uZW50IEhhbmRsZTogMHgwMDJFCglUaHJlc2hvbGQgSGFuZGxl
OiAweDAwMkYKCkhhbmRsZSAweDAwMzEsIERNSSB0eXBlIDI3LCAxNSBieXRlcwpDb29saW5nIERl
dmljZQoJVGVtcGVyYXR1cmUgUHJvYmUgSGFuZGxlOiAweDAwMkIKCVR5cGU6IFBvd2VyIFN1cHBs
eSBGYW4KCVN0YXR1czogT0sKCUNvb2xpbmcgVW5pdCBHcm91cDogMQoJT0VNLXNwZWNpZmljIElu
Zm9ybWF0aW9uOiAweDAwMDAwMDAwCglOb21pbmFsIFNwZWVkOiBVbmtub3duIE9yIE5vbi1yb3Rh
dGluZwoJRGVzY3JpcHRpb246IE5vdCBTcGVjaWZpZWQKCkhhbmRsZSAweDAwMzIsIERNSSB0eXBl
IDM2LCAxNiBieXRlcwpNYW5hZ2VtZW50IERldmljZSBUaHJlc2hvbGQgRGF0YQoJTG93ZXIgTm9u
LWNyaXRpY2FsIFRocmVzaG9sZDogMQoJVXBwZXIgTm9uLWNyaXRpY2FsIFRocmVzaG9sZDogMgoJ
TG93ZXIgQ3JpdGljYWwgVGhyZXNob2xkOiAzCglVcHBlciBDcml0aWNhbCBUaHJlc2hvbGQ6IDQK
CUxvd2VyIE5vbi1yZWNvdmVyYWJsZSBUaHJlc2hvbGQ6IDUKCVVwcGVyIE5vbi1yZWNvdmVyYWJs
ZSBUaHJlc2hvbGQ6IDYKCkhhbmRsZSAweDAwMzMsIERNSSB0eXBlIDM1LCAxMSBieXRlcwpNYW5h
Z2VtZW50IERldmljZSBDb21wb25lbnQKCURlc2NyaXB0aW9uOiBEZWZhdWx0IHN0cmluZwoJTWFu
YWdlbWVudCBEZXZpY2UgSGFuZGxlOiAweDAwMjcKCUNvbXBvbmVudCBIYW5kbGU6IDB4MDAzMQoJ
VGhyZXNob2xkIEhhbmRsZTogMHgwMDMyCgpIYW5kbGUgMHgwMDM0LCBETUkgdHlwZSAyOSwgMjIg
Ynl0ZXMKRWxlY3RyaWNhbCBDdXJyZW50IFByb2JlCglEZXNjcmlwdGlvbjogQUJDCglMb2NhdGlv
bjogTW90aGVyYm9hcmQKCVN0YXR1czogT0sKCU1heGltdW0gVmFsdWU6IFVua25vd24KCU1pbmlt
dW0gVmFsdWU6IFVua25vd24KCVJlc29sdXRpb246IFVua25vd24KCVRvbGVyYW5jZTogVW5rbm93
bgoJQWNjdXJhY3k6IFVua25vd24KCU9FTS1zcGVjaWZpYyBJbmZvcm1hdGlvbjogMHgwMDAwMDAw
MAoJTm9taW5hbCBWYWx1ZTogVW5rbm93bgoKSGFuZGxlIDB4MDAzNSwgRE1JIHR5cGUgMzYsIDE2
IGJ5dGVzCk1hbmFnZW1lbnQgRGV2aWNlIFRocmVzaG9sZCBEYXRhCgpIYW5kbGUgMHgwMDM2LCBE
TUkgdHlwZSAzNSwgMTEgYnl0ZXMKTWFuYWdlbWVudCBEZXZpY2UgQ29tcG9uZW50CglEZXNjcmlw
dGlvbjogRGVmYXVsdCBzdHJpbmcKCU1hbmFnZW1lbnQgRGV2aWNlIEhhbmRsZTogMHgwMDI3CglD
b21wb25lbnQgSGFuZGxlOiAweDAwMzQKCVRocmVzaG9sZCBIYW5kbGU6IDB4MDAzNQoKSGFuZGxl
IDB4MDAzNywgRE1JIHR5cGUgMjYsIDIyIGJ5dGVzClZvbHRhZ2UgUHJvYmUKCURlc2NyaXB0aW9u
OiBMTTc4QQoJTG9jYXRpb246IFBvd2VyIFVuaXQKCVN0YXR1czogT0sKCU1heGltdW0gVmFsdWU6
IFVua25vd24KCU1pbmltdW0gVmFsdWU6IFVua25vd24KCVJlc29sdXRpb246IFVua25vd24KCVRv
bGVyYW5jZTogVW5rbm93bgoJQWNjdXJhY3k6IFVua25vd24KCU9FTS1zcGVjaWZpYyBJbmZvcm1h
dGlvbjogMHgwMDAwMDAwMAoJTm9taW5hbCBWYWx1ZTogVW5rbm93bgoKSGFuZGxlIDB4MDAzOCwg
RE1JIHR5cGUgMjgsIDIyIGJ5dGVzClRlbXBlcmF0dXJlIFByb2JlCglEZXNjcmlwdGlvbjogTE03
OEEKCUxvY2F0aW9uOiBQb3dlciBVbml0CglTdGF0dXM6IE9LCglNYXhpbXVtIFZhbHVlOiBVbmtu
b3duCglNaW5pbXVtIFZhbHVlOiBVbmtub3duCglSZXNvbHV0aW9uOiBVbmtub3duCglUb2xlcmFu
Y2U6IFVua25vd24KCUFjY3VyYWN5OiBVbmtub3duCglPRU0tc3BlY2lmaWMgSW5mb3JtYXRpb246
IDB4MDAwMDAwMDAKCU5vbWluYWwgVmFsdWU6IFVua25vd24KCkhhbmRsZSAweDAwMzksIERNSSB0
eXBlIDI3LCAxNSBieXRlcwpDb29saW5nIERldmljZQoJVGVtcGVyYXR1cmUgUHJvYmUgSGFuZGxl
OiAweDAwMzgKCVR5cGU6IFBvd2VyIFN1cHBseSBGYW4KCVN0YXR1czogT0sKCUNvb2xpbmcgVW5p
dCBHcm91cDogMQoJT0VNLXNwZWNpZmljIEluZm9ybWF0aW9uOiAweDAwMDAwMDAwCglOb21pbmFs
IFNwZWVkOiBVbmtub3duIE9yIE5vbi1yb3RhdGluZwoJRGVzY3JpcHRpb246IENvb2xpbmcgRGV2
IDEKCkhhbmRsZSAweDAwM0EsIERNSSB0eXBlIDI5LCAyMiBieXRlcwpFbGVjdHJpY2FsIEN1cnJl
bnQgUHJvYmUKCURlc2NyaXB0aW9uOiBBQkMKCUxvY2F0aW9uOiBQb3dlciBVbml0CglTdGF0dXM6
IE9LCglNYXhpbXVtIFZhbHVlOiBVbmtub3duCglNaW5pbXVtIFZhbHVlOiBVbmtub3duCglSZXNv
bHV0aW9uOiBVbmtub3duCglUb2xlcmFuY2U6IFVua25vd24KCUFjY3VyYWN5OiBVbmtub3duCglP
RU0tc3BlY2lmaWMgSW5mb3JtYXRpb246IDB4MDAwMDAwMDAKCU5vbWluYWwgVmFsdWU6IFVua25v
d24KCkhhbmRsZSAweDAwM0IsIERNSSB0eXBlIDM5LCAyMiBieXRlcwpTeXN0ZW0gUG93ZXIgU3Vw
cGx5CglQb3dlciBVbml0IEdyb3VwOiAxCglMb2NhdGlvbjogVG8gQmUgRmlsbGVkIEJ5IE8uRS5N
LgoJTmFtZTogVG8gQmUgRmlsbGVkIEJ5IE8uRS5NLgoJTWFudWZhY3R1cmVyOiBUbyBCZSBGaWxs
ZWQgQnkgTy5FLk0uCglTZXJpYWwgTnVtYmVyOiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uCglBc3Nl
dCBUYWc6IFRvIEJlIEZpbGxlZCBCeSBPLkUuTS4KCU1vZGVsIFBhcnQgTnVtYmVyOiBUbyBCZSBG
aWxsZWQgQnkgTy5FLk0uCglSZXZpc2lvbjogVG8gQmUgRmlsbGVkIEJ5IE8uRS5NLgoJTWF4IFBv
d2VyIENhcGFjaXR5OiBVbmtub3duCglTdGF0dXM6IFByZXNlbnQsIE9LCglUeXBlOiBTd2l0Y2hp
bmcKCUlucHV0IFZvbHRhZ2UgUmFuZ2UgU3dpdGNoaW5nOiBBdXRvLXN3aXRjaAoJUGx1Z2dlZDog
WWVzCglIb3QgUmVwbGFjZWFibGU6IE5vCglJbnB1dCBWb2x0YWdlIFByb2JlIEhhbmRsZTogMHgw
MDM3CglDb29saW5nIERldmljZSBIYW5kbGU6IDB4MDAzOQoJSW5wdXQgQ3VycmVudCBQcm9iZSBI
YW5kbGU6IDB4MDAzQQoKSGFuZGxlIDB4MDAzQywgRE1JIHR5cGUgNDAsIDUwIGJ5dGVzCkFkZGl0
aW9uYWwgSW5mb3JtYXRpb24gMQoJUmVmZXJlbmNlZCBIYW5kbGU6IDB4MDAyMwoJUmVmZXJlbmNl
ZCBPZmZzZXQ6IDB4MDEKCVN0cmluZzogVG8gQmUgRmlsbGVkIEJ5IE8uRS5NLiAxCglWYWx1ZTog
MHgwMDAwMDAwMApBZGRpdGlvbmFsIEluZm9ybWF0aW9uIDIKCVJlZmVyZW5jZWQgSGFuZGxlOiAw
eDAwMDEKCVJlZmVyZW5jZWQgT2Zmc2V0OiAweDBmCglTdHJpbmc6IE5vdCBTcGVjaWZpZWQKCVZh
bHVlOiAweDAwMDAwMDFlCkFkZGl0aW9uYWwgSW5mb3JtYXRpb24gMwoJUmVmZXJlbmNlZCBIYW5k
bGU6IDB4MDA0ZQoJUmVmZXJlbmNlZCBPZmZzZXQ6IDB4MDEKCVN0cmluZzogTm90IFNwZWNpZmll
ZAoJVmFsdWU6IDB4MDAwMDAwMDAKQWRkaXRpb25hbCBJbmZvcm1hdGlvbiA0CglSZWZlcmVuY2Vk
IEhhbmRsZTogMHgwMDAxCglSZWZlcmVuY2VkIE9mZnNldDogMHgxYQoJU3RyaW5nOiBQUk9EVUNU
X0xJTkUKCVZhbHVlOiAweDAwMDAwMDAwCkFkZGl0aW9uYWwgSW5mb3JtYXRpb24gNQoJUmVmZXJl
bmNlZCBIYW5kbGU6IDB4MDAwMQoJUmVmZXJlbmNlZCBPZmZzZXQ6IDB4MTkKCVN0cmluZzogUFJP
RFVDVF9TS1UKCVZhbHVlOiAweDAwMDAwMDAzCgpIYW5kbGUgMHgwMDNELCBETUkgdHlwZSA0Mywg
MzEgYnl0ZXMKVFBNIERldmljZQoJVmVuZG9yIElEOiBJTlRDCglTcGVjaWZpY2F0aW9uIFZlcnNp
b246IDIuMAoJRmlybXdhcmUgUmV2aXNpb246IDUwMC4xNgoJRGVzY3JpcHRpb246IElOVEVMCglD
aGFyYWN0ZXJpc3RpY3M6CgkJRmFtaWx5IGNvbmZpZ3VyYWJsZSB2aWEgcGxhdGZvcm0gc29mdHdh
cmUgc3VwcG9ydAoJT0VNLXNwZWNpZmljIEluZm9ybWF0aW9uOiAweDAwMDAwMDAwCgpIYW5kbGUg
MHgwMDNFLCBETUkgdHlwZSAxNiwgMjMgYnl0ZXMKUGh5c2ljYWwgTWVtb3J5IEFycmF5CglMb2Nh
dGlvbjogU3lzdGVtIEJvYXJkIE9yIE1vdGhlcmJvYXJkCglVc2U6IFN5c3RlbSBNZW1vcnkKCUVy
cm9yIENvcnJlY3Rpb24gVHlwZTogTm9uZQoJTWF4aW11bSBDYXBhY2l0eTogNjQgR0IKCUVycm9y
IEluZm9ybWF0aW9uIEhhbmRsZTogTm90IFByb3ZpZGVkCglOdW1iZXIgT2YgRGV2aWNlczogNAoK
SGFuZGxlIDB4MDAzRiwgRE1JIHR5cGUgMTcsIDg0IGJ5dGVzCk1lbW9yeSBEZXZpY2UKCUFycmF5
IEhhbmRsZTogMHgwMDNFCglFcnJvciBJbmZvcm1hdGlvbiBIYW5kbGU6IE5vdCBQcm92aWRlZAoJ
VG90YWwgV2lkdGg6IDY0IGJpdHMKCURhdGEgV2lkdGg6IDY0IGJpdHMKCVNpemU6IDggR0IKCUZv
cm0gRmFjdG9yOiBESU1NCglTZXQ6IE5vbmUKCUxvY2F0b3I6IENoYW5uZWxBLURJTU0xCglCYW5r
IExvY2F0b3I6IEJBTksgMAoJVHlwZTogRERSNAoJVHlwZSBEZXRhaWw6IFN5bmNocm9ub3VzCglT
cGVlZDogMjY2NiBNVC9zCglNYW51ZmFjdHVyZXI6IEtpbmdzdG9uCglTZXJpYWwgTnVtYmVyOiBF
NEJDODA3QgoJQXNzZXQgVGFnOiA5ODc2NTQzMjEwCglQYXJ0IE51bWJlcjogS0hYMjY2NkMxNi84
RyAgICAgICAKCVJhbms6IDEKCUNvbmZpZ3VyZWQgTWVtb3J5IFNwZWVkOiAyNjY2IE1UL3MKCU1p
bmltdW0gVm9sdGFnZTogMS4yIFYKCU1heGltdW0gVm9sdGFnZTogMS4yIFYKCUNvbmZpZ3VyZWQg
Vm9sdGFnZTogMS4yIFYKCU1lbW9yeSBUZWNobm9sb2d5OiBEUkFNCglNZW1vcnkgT3BlcmF0aW5n
IE1vZGUgQ2FwYWJpbGl0eTogVm9sYXRpbGUgbWVtb3J5CglGaXJtd2FyZSBWZXJzaW9uOiBOb3Qg
U3BlY2lmaWVkCglNb2R1bGUgTWFudWZhY3R1cmVyIElEOiBCYW5rIDIsIEhleCAweDk4CglNb2R1
bGUgUHJvZHVjdCBJRDogVW5rbm93bgoJTWVtb3J5IFN1YnN5c3RlbSBDb250cm9sbGVyIE1hbnVm
YWN0dXJlciBJRDogVW5rbm93bgoJTWVtb3J5IFN1YnN5c3RlbSBDb250cm9sbGVyIFByb2R1Y3Qg
SUQ6IFVua25vd24KCU5vbi1Wb2xhdGlsZSBTaXplOiBOb25lCglWb2xhdGlsZSBTaXplOiA4IEdC
CglDYWNoZSBTaXplOiBOb25lCglMb2dpY2FsIFNpemU6IE5vbmUKCkhhbmRsZSAweDAwNDAsIERN
SSB0eXBlIDE3LCA4NCBieXRlcwpNZW1vcnkgRGV2aWNlCglBcnJheSBIYW5kbGU6IDB4MDAzRQoJ
RXJyb3IgSW5mb3JtYXRpb24gSGFuZGxlOiBOb3QgUHJvdmlkZWQKCVRvdGFsIFdpZHRoOiA2NCBi
aXRzCglEYXRhIFdpZHRoOiA2NCBiaXRzCglTaXplOiA4IEdCCglGb3JtIEZhY3RvcjogRElNTQoJ
U2V0OiBOb25lCglMb2NhdG9yOiBDaGFubmVsQS1ESU1NMgoJQmFuayBMb2NhdG9yOiBCQU5LIDEK
CVR5cGU6IEREUjQKCVR5cGUgRGV0YWlsOiBTeW5jaHJvbm91cwoJU3BlZWQ6IDI2NjYgTVQvcwoJ
TWFudWZhY3R1cmVyOiBLaW5nc3RvbgoJU2VyaWFsIE51bWJlcjogQjhCQzdCMkUKCUFzc2V0IFRh
ZzogOTg3NjU0MzIxMAoJUGFydCBOdW1iZXI6IEtIWDI2NjZDMTYvOEcgICAgICAgCglSYW5rOiAx
CglDb25maWd1cmVkIE1lbW9yeSBTcGVlZDogMjY2NiBNVC9zCglNaW5pbXVtIFZvbHRhZ2U6IDEu
MiBWCglNYXhpbXVtIFZvbHRhZ2U6IDEuMiBWCglDb25maWd1cmVkIFZvbHRhZ2U6IDEuMiBWCglN
ZW1vcnkgVGVjaG5vbG9neTogRFJBTQoJTWVtb3J5IE9wZXJhdGluZyBNb2RlIENhcGFiaWxpdHk6
IFZvbGF0aWxlIG1lbW9yeQoJRmlybXdhcmUgVmVyc2lvbjogTm90IFNwZWNpZmllZAoJTW9kdWxl
IE1hbnVmYWN0dXJlciBJRDogQmFuayAyLCBIZXggMHg5OAoJTW9kdWxlIFByb2R1Y3QgSUQ6IFVu
a25vd24KCU1lbW9yeSBTdWJzeXN0ZW0gQ29udHJvbGxlciBNYW51ZmFjdHVyZXIgSUQ6IFVua25v
d24KCU1lbW9yeSBTdWJzeXN0ZW0gQ29udHJvbGxlciBQcm9kdWN0IElEOiBVbmtub3duCglOb24t
Vm9sYXRpbGUgU2l6ZTogTm9uZQoJVm9sYXRpbGUgU2l6ZTogOCBHQgoJQ2FjaGUgU2l6ZTogTm9u
ZQoJTG9naWNhbCBTaXplOiBOb25lCgpIYW5kbGUgMHgwMDQxLCBETUkgdHlwZSAxNywgODQgYnl0
ZXMKTWVtb3J5IERldmljZQoJQXJyYXkgSGFuZGxlOiAweDAwM0UKCUVycm9yIEluZm9ybWF0aW9u
IEhhbmRsZTogTm90IFByb3ZpZGVkCglUb3RhbCBXaWR0aDogNjQgYml0cwoJRGF0YSBXaWR0aDog
NjQgYml0cwoJU2l6ZTogOCBHQgoJRm9ybSBGYWN0b3I6IERJTU0KCVNldDogTm9uZQoJTG9jYXRv
cjogQ2hhbm5lbEItRElNTTEKCUJhbmsgTG9jYXRvcjogQkFOSyAyCglUeXBlOiBERFI0CglUeXBl
IERldGFpbDogU3luY2hyb25vdXMKCVNwZWVkOiAyNjY2IE1UL3MKCU1hbnVmYWN0dXJlcjogS2lu
Z3N0b24KCVNlcmlhbCBOdW1iZXI6IEJBQkM3QjFFCglBc3NldCBUYWc6IDk4NzY1NDMyMTAKCVBh
cnQgTnVtYmVyOiBLSFgyNjY2QzE2LzhHICAgICAgIAoJUmFuazogMQoJQ29uZmlndXJlZCBNZW1v
cnkgU3BlZWQ6IDI2NjYgTVQvcwoJTWluaW11bSBWb2x0YWdlOiAxLjIgVgoJTWF4aW11bSBWb2x0
YWdlOiAxLjIgVgoJQ29uZmlndXJlZCBWb2x0YWdlOiAxLjIgVgoJTWVtb3J5IFRlY2hub2xvZ3k6
IERSQU0KCU1lbW9yeSBPcGVyYXRpbmcgTW9kZSBDYXBhYmlsaXR5OiBWb2xhdGlsZSBtZW1vcnkK
CUZpcm13YXJlIFZlcnNpb246IE5vdCBTcGVjaWZpZWQKCU1vZHVsZSBNYW51ZmFjdHVyZXIgSUQ6
IEJhbmsgMiwgSGV4IDB4OTgKCU1vZHVsZSBQcm9kdWN0IElEOiBVbmtub3duCglNZW1vcnkgU3Vi
c3lzdGVtIENvbnRyb2xsZXIgTWFudWZhY3R1cmVyIElEOiBVbmtub3duCglNZW1vcnkgU3Vic3lz
dGVtIENvbnRyb2xsZXIgUHJvZHVjdCBJRDogVW5rbm93bgoJTm9uLVZvbGF0aWxlIFNpemU6IE5v
bmUKCVZvbGF0aWxlIFNpemU6IDggR0IKCUNhY2hlIFNpemU6IE5vbmUKCUxvZ2ljYWwgU2l6ZTog
Tm9uZQoKSGFuZGxlIDB4MDA0MiwgRE1JIHR5cGUgMTcsIDg0IGJ5dGVzCk1lbW9yeSBEZXZpY2UK
CUFycmF5IEhhbmRsZTogMHgwMDNFCglFcnJvciBJbmZvcm1hdGlvbiBIYW5kbGU6IE5vdCBQcm92
aWRlZAoJVG90YWwgV2lkdGg6IDY0IGJpdHMKCURhdGEgV2lkdGg6IDY0IGJpdHMKCVNpemU6IDgg
R0IKCUZvcm0gRmFjdG9yOiBESU1NCglTZXQ6IE5vbmUKCUxvY2F0b3I6IENoYW5uZWxCLURJTU0y
CglCYW5rIExvY2F0b3I6IEJBTksgMwoJVHlwZTogRERSNAoJVHlwZSBEZXRhaWw6IFN5bmNocm9u
b3VzCglTcGVlZDogMjY2NiBNVC9zCglNYW51ZmFjdHVyZXI6IEtpbmdzdG9uCglTZXJpYWwgTnVt
YmVyOiBFMUJDN0JFMwoJQXNzZXQgVGFnOiA5ODc2NTQzMjEwCglQYXJ0IE51bWJlcjogS0hYMjY2
NkMxNi84RyAgICAgICAKCVJhbms6IDEKCUNvbmZpZ3VyZWQgTWVtb3J5IFNwZWVkOiAyNjY2IE1U
L3MKCU1pbmltdW0gVm9sdGFnZTogMS4yIFYKCU1heGltdW0gVm9sdGFnZTogMS4yIFYKCUNvbmZp
Z3VyZWQgVm9sdGFnZTogMS4yIFYKCU1lbW9yeSBUZWNobm9sb2d5OiBEUkFNCglNZW1vcnkgT3Bl
cmF0aW5nIE1vZGUgQ2FwYWJpbGl0eTogVm9sYXRpbGUgbWVtb3J5CglGaXJtd2FyZSBWZXJzaW9u
OiBOb3QgU3BlY2lmaWVkCglNb2R1bGUgTWFudWZhY3R1cmVyIElEOiBCYW5rIDIsIEhleCAweDk4
CglNb2R1bGUgUHJvZHVjdCBJRDogVW5rbm93bgoJTWVtb3J5IFN1YnN5c3RlbSBDb250cm9sbGVy
IE1hbnVmYWN0dXJlciBJRDogVW5rbm93bgoJTWVtb3J5IFN1YnN5c3RlbSBDb250cm9sbGVyIFBy
b2R1Y3QgSUQ6IFVua25vd24KCU5vbi1Wb2xhdGlsZSBTaXplOiBOb25lCglWb2xhdGlsZSBTaXpl
OiA4IEdCCglDYWNoZSBTaXplOiBOb25lCglMb2dpY2FsIFNpemU6IE5vbmUKCkhhbmRsZSAweDAw
NDMsIERNSSB0eXBlIDE5LCAzMSBieXRlcwpNZW1vcnkgQXJyYXkgTWFwcGVkIEFkZHJlc3MKCVN0
YXJ0aW5nIEFkZHJlc3M6IDB4MDAwMDAwMDAwMDAKCUVuZGluZyBBZGRyZXNzOiAweDAwN0ZGRkZG
RkZGCglSYW5nZSBTaXplOiAzMiBHQgoJUGh5c2ljYWwgQXJyYXkgSGFuZGxlOiAweDAwM0UKCVBh
cnRpdGlvbiBXaWR0aDogNAoKSGFuZGxlIDB4MDA0NCwgRE1JIHR5cGUgMjAsIDM1IGJ5dGVzCk1l
bW9yeSBEZXZpY2UgTWFwcGVkIEFkZHJlc3MKCVN0YXJ0aW5nIEFkZHJlc3M6IDB4MDAwMDAwMDAw
MDAKCUVuZGluZyBBZGRyZXNzOiAweDAwMUZGRkZGRkZGCglSYW5nZSBTaXplOiA4IEdCCglQaHlz
aWNhbCBEZXZpY2UgSGFuZGxlOiAweDAwM0YKCU1lbW9yeSBBcnJheSBNYXBwZWQgQWRkcmVzcyBI
YW5kbGU6IDB4MDA0MwoJUGFydGl0aW9uIFJvdyBQb3NpdGlvbjogVW5rbm93bgoJSW50ZXJsZWF2
ZSBQb3NpdGlvbjogMQoJSW50ZXJsZWF2ZWQgRGF0YSBEZXB0aDogMgoKSGFuZGxlIDB4MDA0NSwg
RE1JIHR5cGUgMjAsIDM1IGJ5dGVzCk1lbW9yeSBEZXZpY2UgTWFwcGVkIEFkZHJlc3MKCVN0YXJ0
aW5nIEFkZHJlc3M6IDB4MDA0MDAwMDAwMDAKCUVuZGluZyBBZGRyZXNzOiAweDAwNUZGRkZGRkZG
CglSYW5nZSBTaXplOiA4IEdCCglQaHlzaWNhbCBEZXZpY2UgSGFuZGxlOiAweDAwNDAKCU1lbW9y
eSBBcnJheSBNYXBwZWQgQWRkcmVzcyBIYW5kbGU6IDB4MDA0MwoJUGFydGl0aW9uIFJvdyBQb3Np
dGlvbjogVW5rbm93bgoJSW50ZXJsZWF2ZSBQb3NpdGlvbjogMQoJSW50ZXJsZWF2ZWQgRGF0YSBE
ZXB0aDogMgoKSGFuZGxlIDB4MDA0NiwgRE1JIHR5cGUgMjAsIDM1IGJ5dGVzCk1lbW9yeSBEZXZp
Y2UgTWFwcGVkIEFkZHJlc3MKCVN0YXJ0aW5nIEFkZHJlc3M6IDB4MDAyMDAwMDAwMDAKCUVuZGlu
ZyBBZGRyZXNzOiAweDAwM0ZGRkZGRkZGCglSYW5nZSBTaXplOiA4IEdCCglQaHlzaWNhbCBEZXZp
Y2UgSGFuZGxlOiAweDAwNDEKCU1lbW9yeSBBcnJheSBNYXBwZWQgQWRkcmVzcyBIYW5kbGU6IDB4
MDA0MwoJUGFydGl0aW9uIFJvdyBQb3NpdGlvbjogVW5rbm93bgoJSW50ZXJsZWF2ZSBQb3NpdGlv
bjogMgoJSW50ZXJsZWF2ZWQgRGF0YSBEZXB0aDogMgoKSGFuZGxlIDB4MDA0NywgRE1JIHR5cGUg
MjAsIDM1IGJ5dGVzCk1lbW9yeSBEZXZpY2UgTWFwcGVkIEFkZHJlc3MKCVN0YXJ0aW5nIEFkZHJl
c3M6IDB4MDA2MDAwMDAwMDAKCUVuZGluZyBBZGRyZXNzOiAweDAwN0ZGRkZGRkZGCglSYW5nZSBT
aXplOiA4IEdCCglQaHlzaWNhbCBEZXZpY2UgSGFuZGxlOiAweDAwNDIKCU1lbW9yeSBBcnJheSBN
YXBwZWQgQWRkcmVzcyBIYW5kbGU6IDB4MDA0MwoJUGFydGl0aW9uIFJvdyBQb3NpdGlvbjogVW5r
bm93bgoJSW50ZXJsZWF2ZSBQb3NpdGlvbjogMgoJSW50ZXJsZWF2ZWQgRGF0YSBEZXB0aDogMgoK
SGFuZGxlIDB4MDA0OCwgRE1JIHR5cGUgMjIxLCAyNiBieXRlcwpPRU0tc3BlY2lmaWMgVHlwZQoJ
SGVhZGVyIGFuZCBEYXRhOgoJCUREIDFBIDQ4IDAwIDAzIDAxIDAwIDA5IDAwIDMwIDUwIDAwIDAy
IDAwIDAwIDAwCgkJMDAgRTIgMDAgMDMgMDAgRkYgRkYgRkYgRkYgRkYKCVN0cmluZ3M6CgkJUmVm
ZXJlbmNlIENvZGUgLSBDUFUKCQl1Q29kZSBWZXJzaW9uCgkJVFhUIEFDTSB2ZXJzaW9uCgpIYW5k
bGUgMHgwMDQ5LCBETUkgdHlwZSAyMjEsIDI2IGJ5dGVzCk9FTS1zcGVjaWZpYyBUeXBlCglIZWFk
ZXIgYW5kIERhdGE6CgkJREQgMUEgNDkgMDAgMDMgMDEgMDAgMDkgMDAgMzAgNTAgMDAgMDIgMDAg
MDAgMDAKCQkwMCAwMCAwMCAwMyAwNCAwRSAwNSAxOSBDRCAwNAoJU3RyaW5nczoKCQlSZWZlcmVu
Y2UgQ29kZSAtIE1FCgkJTUVCeCB2ZXJzaW9uCgkJTUUgRmlybXdhcmUgVmVyc2lvbgoJCUNvbnN1
bWVyIFNLVQoKSGFuZGxlIDB4MDA0QSwgRE1JIHR5cGUgMjIxLCA0NyBieXRlcwpPRU0tc3BlY2lm
aWMgVHlwZQoJSGVhZGVyIGFuZCBEYXRhOgoJCUREIDJGIDRBIDAwIDA2IDAxIDAwIDA5IDAwIDMw
IDUwIDAwIDAyIDAzIEZGIEZGCgkJRkYgRkYgRkYgMDQgMDAgRkYgRkYgRkYgMDAgMDAgMDUgMDAg
RkYgRkYgRkYgMDAKCQkwMCAwNiAwMCBGRiBGRiBGRiBGRiBGRiAwNyAwMCAwQiAwMCAwMCAwMCAw
MAoJU3RyaW5nczoKCQlSZS5lcmVuY2UgQ29kZSAtIENNTCBQQ0gKCQlQQ0gtQ1JJRCBTdGF0dXMK
CQlEaXNhYmxlZAoJCVBDSC1DUklEIE9yaWdpbmFsIFZhbHVlCgkJUENILUNSSUQgTmV3IFZhbHVl
CgkJT1BST00gLSBSU1QgLSBSQUlECgkJQ01MViBQQ0ggSCBBeCBIc2lvIFZlcnNpb24KCkhhbmRs
ZSAweDAwNEIsIERNSSB0eXBlIDIyMSwgNTQgYnl0ZXMKT0VNLXNwZWNpZmljIFR5cGUKCUhlYWRl
ciBhbmQgRGF0YToKCQlERCAzNiA0QiAwMCAwNyAwMSAwMCAwOSAwMCAzMCA1MCAwMCAwMiAwMCAw
MCAwMAoJCTAwIDQ1IDAwIDAzIDAwIDA5IDAwIDMwIDUwIDAwIDA0IDA1IEZGIEZGIEZGIEZGCgkJ
RkYgMDYgMDAgMDAgMDAgMDAgMDUgMDAgMDcgMDAgMDAgMDAgMDAgMDUgMDAgMDgKCQkwMCBGRiBG
RiBGRiBGRiBGRgoJU3RyaW5nczoKCQlSZWZlcmVuY2UgQ29kZSAtIFNBIC0gU3lzdGVtIEFnZW50
CgkJUmVmZXJlbmNlIENvZGUgLSBNUkMKCQlTQSAtIFBDSWUgVmVyc2lvbgoJCVNBLUNSSUQgU3Rh
dHVzCgkJRGlzYWJsZWQKCQlTQS1DUklEIE9yaWdpbmFsIFZhbHVlCgkJU0EtQ1JJRCBOZXcgVmFs
dWUKCQlPUFJPTSAtIFZCSU9TCgpIYW5kbGUgMHgwMDRDLCBETUkgdHlwZSAyMjEsIDEyIGJ5dGVz
Ck9FTS1zcGVjaWZpYyBUeXBlCglIZWFkZXIgYW5kIERhdGE6CgkJREQgMEMgNEMgMDAgMDEgMDEg
MDAgMDQgMDAgMDAgMDAgMDAKCVN0cmluZ3M6CgkJRlNQIEJpbmFyeSBWZXJzaW9uCgpIYW5kbGUg
MHgwMDRELCBETUkgdHlwZSA3LCAyNyBieXRlcwpDYWNoZSBJbmZvcm1hdGlvbgoJU29ja2V0IERl
c2lnbmF0aW9uOiBMMSBDYWNoZQoJQ29uZmlndXJhdGlvbjogRW5hYmxlZCwgTm90IFNvY2tldGVk
LCBMZXZlbCAxCglPcGVyYXRpb25hbCBNb2RlOiBXcml0ZSBCYWNrCglMb2NhdGlvbjogSW50ZXJu
YWwKCUluc3RhbGxlZCBTaXplOiA1MTIga0IKCU1heGltdW0gU2l6ZTogNTEyIGtCCglTdXBwb3J0
ZWQgU1JBTSBUeXBlczoKCQlTeW5jaHJvbm91cwoJSW5zdGFsbGVkIFNSQU0gVHlwZTogU3luY2hy
b25vdXMKCVNwZWVkOiBVbmtub3duCglFcnJvciBDb3JyZWN0aW9uIFR5cGU6IFBhcml0eQoJU3lz
dGVtIFR5cGU6IFVuaWZpZWQKCUFzc29jaWF0aXZpdHk6IDgtd2F5IFNldC1hc3NvY2lhdGl2ZQoK
SGFuZGxlIDB4MDA0RSwgRE1JIHR5cGUgNywgMjcgYnl0ZXMKQ2FjaGUgSW5mb3JtYXRpb24KCVNv
Y2tldCBEZXNpZ25hdGlvbjogTDIgQ2FjaGUKCUNvbmZpZ3VyYXRpb246IEVuYWJsZWQsIE5vdCBT
b2NrZXRlZCwgTGV2ZWwgMgoJT3BlcmF0aW9uYWwgTW9kZTogV3JpdGUgQmFjawoJTG9jYXRpb246
IEludGVybmFsCglJbnN0YWxsZWQgU2l6ZTogMiBNQgoJTWF4aW11bSBTaXplOiAyIE1CCglTdXBw
b3J0ZWQgU1JBTSBUeXBlczoKCQlTeW5jaHJvbm91cwoJSW5zdGFsbGVkIFNSQU0gVHlwZTogU3lu
Y2hyb25vdXMKCVNwZWVkOiBVbmtub3duCglFcnJvciBDb3JyZWN0aW9uIFR5cGU6IFNpbmdsZS1i
aXQgRUNDCglTeXN0ZW0gVHlwZTogVW5pZmllZAoJQXNzb2NpYXRpdml0eTogNC13YXkgU2V0LWFz
c29jaWF0aXZlCgpIYW5kbGUgMHgwMDRGLCBETUkgdHlwZSA3LCAyNyBieXRlcwpDYWNoZSBJbmZv
cm1hdGlvbgoJU29ja2V0IERlc2lnbmF0aW9uOiBMMyBDYWNoZQoJQ29uZmlndXJhdGlvbjogRW5h
YmxlZCwgTm90IFNvY2tldGVkLCBMZXZlbCAzCglPcGVyYXRpb25hbCBNb2RlOiBXcml0ZSBCYWNr
CglMb2NhdGlvbjogSW50ZXJuYWwKCUluc3RhbGxlZCBTaXplOiAxNiBNQgoJTWF4aW11bSBTaXpl
OiAxNiBNQgoJU3VwcG9ydGVkIFNSQU0gVHlwZXM6CgkJU3luY2hyb25vdXMKCUluc3RhbGxlZCBT
UkFNIFR5cGU6IFN5bmNocm9ub3VzCglTcGVlZDogVW5rbm93bgoJRXJyb3IgQ29ycmVjdGlvbiBU
eXBlOiBNdWx0aS1iaXQgRUNDCglTeXN0ZW0gVHlwZTogVW5pZmllZAoJQXNzb2NpYXRpdml0eTog
MTYtd2F5IFNldC1hc3NvY2lhdGl2ZQoKSGFuZGxlIDB4MDA1MCwgRE1JIHR5cGUgNCwgNDggYnl0
ZXMKUHJvY2Vzc29yIEluZm9ybWF0aW9uCglTb2NrZXQgRGVzaWduYXRpb246IExHQTEyMDAKCVR5
cGU6IENlbnRyYWwgUHJvY2Vzc29yCglGYW1pbHk6IENvcmUgaTcKCU1hbnVmYWN0dXJlcjogSW50
ZWwoUikgQ29ycG9yYXRpb24KCUlEOiA1NSAwNiAwQSAwMCBGRiBGQiBFQiBCRgoJU2lnbmF0dXJl
OiBUeXBlIDAsIEZhbWlseSA2LCBNb2RlbCAxNjUsIFN0ZXBwaW5nIDUKCUZsYWdzOgoJCUZQVSAo
RmxvYXRpbmctcG9pbnQgdW5pdCBvbi1jaGlwKQoJCVZNRSAoVmlydHVhbCBtb2RlIGV4dGVuc2lv
bikKCQlERSAoRGVidWdnaW5nIGV4dGVuc2lvbikKCQlQU0UgKFBhZ2Ugc2l6ZSBleHRlbnNpb24p
CgkJVFNDIChUaW1lIHN0YW1wIGNvdW50ZXIpCgkJTVNSIChNb2RlbCBzcGVjaWZpYyByZWdpc3Rl
cnMpCgkJUEFFIChQaHlzaWNhbCBhZGRyZXNzIGV4dGVuc2lvbikKCQlNQ0UgKE1hY2hpbmUgY2hl
Y2sgZXhjZXB0aW9uKQoJCUNYOCAoQ01QWENIRzggaW5zdHJ1Y3Rpb24gc3VwcG9ydGVkKQoJCUFQ
SUMgKE9uLWNoaXAgQVBJQyBoYXJkd2FyZSBzdXBwb3J0ZWQpCgkJU0VQIChGYXN0IHN5c3RlbSBj
YWxsKQoJCU1UUlIgKE1lbW9yeSB0eXBlIHJhbmdlIHJlZ2lzdGVycykKCQlQR0UgKFBhZ2UgZ2xv
YmFsIGVuYWJsZSkKCQlNQ0EgKE1hY2hpbmUgY2hlY2sgYXJjaGl0ZWN0dXJlKQoJCUNNT1YgKENv
bmRpdGlvbmFsIG1vdmUgaW5zdHJ1Y3Rpb24gc3VwcG9ydGVkKQoJCVBBVCAoUGFnZSBhdHRyaWJ1
dGUgdGFibGUpCgkJUFNFLTM2ICgzNi1iaXQgcGFnZSBzaXplIGV4dGVuc2lvbikKCQlDTEZTSCAo
Q0xGTFVTSCBpbnN0cnVjdGlvbiBzdXBwb3J0ZWQpCgkJRFMgKERlYnVnIHN0b3JlKQoJCUFDUEkg
KEFDUEkgc3VwcG9ydGVkKQoJCU1NWCAoTU1YIHRlY2hub2xvZ3kgc3VwcG9ydGVkKQoJCUZYU1Ig
KEZYU0FWRSBhbmQgRlhTVE9SIGluc3RydWN0aW9ucyBzdXBwb3J0ZWQpCgkJU1NFIChTdHJlYW1p
bmcgU0lNRCBleHRlbnNpb25zKQoJCVNTRTIgKFN0cmVhbWluZyBTSU1EIGV4dGVuc2lvbnMgMikK
CQlTUyAoU2VsZi1zbm9vcCkKCQlIVFQgKE11bHRpLXRocmVhZGluZykKCQlUTSAoVGhlcm1hbCBt
b25pdG9yIHN1cHBvcnRlZCkKCQlQQkUgKFBlbmRpbmcgYnJlYWsgZW5hYmxlZCkKCVZlcnNpb246
IEludGVsKFIpIENvcmUoVE0pIGk3LTEwNzAwRiBDUFUgQCAyLjkwR0h6CglWb2x0YWdlOiAwLjkg
VgoJRXh0ZXJuYWwgQ2xvY2s6IDEwMCBNSHoKCU1heCBTcGVlZDogODMwMCBNSHoKCUN1cnJlbnQg
U3BlZWQ6IDI4NzEgTUh6CglTdGF0dXM6IFBvcHVsYXRlZCwgRW5hYmxlZAoJVXBncmFkZTogT3Ro
ZXIKCUwxIENhY2hlIEhhbmRsZTogMHgwMDRECglMMiBDYWNoZSBIYW5kbGU6IDB4MDA0RQoJTDMg
Q2FjaGUgSGFuZGxlOiAweDAwNEYKCVNlcmlhbCBOdW1iZXI6IFRvIEJlIEZpbGxlZCBCeSBPLkUu
TS4KCUFzc2V0IFRhZzogVG8gQmUgRmlsbGVkIEJ5IE8uRS5NLgoJUGFydCBOdW1iZXI6IFRvIEJl
IEZpbGxlZCBCeSBPLkUuTS4KCUNvcmUgQ291bnQ6IDgKCUNvcmUgRW5hYmxlZDogOAoJVGhyZWFk
IENvdW50OiAxNgoJQ2hhcmFjdGVyaXN0aWNzOgoJCTY0LWJpdCBjYXBhYmxlCgkJTXVsdGktQ29y
ZQoJCUhhcmR3YXJlIFRocmVhZAoJCUV4ZWN1dGUgUHJvdGVjdGlvbgoJCUVuaGFuY2VkIFZpcnR1
YWxpemF0aW9uCgkJUG93ZXIvUGVyZm9ybWFuY2UgQ29udHJvbAoKSGFuZGxlIDB4MDA1MSwgRE1J
IHR5cGUgMTMxLCA2NCBieXRlcwpPRU0tc3BlY2lmaWMgVHlwZQoJSGVhZGVyIGFuZCBEYXRhOgoJ
CTgzIDQwIDUxIDAwIDMxIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCgkJRjggMDAg
QzggQTMgMDAgMDAgMDAgMDAgMDEgMDAgMDAgMDAgMDUgMDAgMEUgMDAKCQlDRCAwNCAxOSAwMCAw
MCAwMCAwMCAwMCBGRSAwMCA1NSAwRCAwMCAwMCAwMCAwMAoJCTAwIDAwIDAwIDAwIDIyIDAwIDAw
IDAwIDc2IDUwIDcyIDZGIDAwIDAwIDAwIDAwCgpIYW5kbGUgMHgwMDUyLCBETUkgdHlwZSA0MSwg
MTEgYnl0ZXMKT25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAt
IE90aGVyCglUeXBlOiBPdGhlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAxCglC
dXMgQWRkcmVzczogMDAwMDowMDowMC4wCgpIYW5kbGUgMHgwMDUzLCBETUkgdHlwZSA0MSwgMTEg
Ynl0ZXMKT25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90
aGVyCglUeXBlOiBPdGhlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAyCglCdXMg
QWRkcmVzczogMDAwMDowMDoxNC4wCgpIYW5kbGUgMHgwMDU0LCBETUkgdHlwZSA0MSwgMTEgYnl0
ZXMKT25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90aGVy
CglUeXBlOiBPdGhlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAzCglCdXMgQWRk
cmVzczogMDAwMDowMDoxNi4wCgpIYW5kbGUgMHgwMDU1LCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMK
T25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIFNBVEEKCVR5
cGU6IFNBVEEgQ29udHJvbGxlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAxCglC
dXMgQWRkcmVzczogMDAwMDowMDoxNy4wCgpIYW5kbGUgMHgwMDU2LCBETUkgdHlwZSA0MSwgMTEg
Ynl0ZXMKT25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90
aGVyCglUeXBlOiBPdGhlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiA0CglCdXMg
QWRkcmVzczogMDAwMDowMDoxZi4wCgpIYW5kbGUgMHgwMDU3LCBETUkgdHlwZSA0MSwgMTEgYnl0
ZXMKT25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90aGVy
CglUeXBlOiBPdGhlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiA1CglCdXMgQWRk
cmVzczogMDAwMDowMDoxZi4yCgpIYW5kbGUgMHgwMDU4LCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMK
T25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIFNvdW5kCglU
eXBlOiBTb3VuZAoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAxCglCdXMgQWRkcmVz
czogMDAwMDowMDoxZi4zCgpIYW5kbGUgMHgwMDU5LCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMKT25i
b2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90aGVyCglUeXBl
OiBPdGhlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiA2CglCdXMgQWRkcmVzczog
MDAwMDowMDoxZi40CgpIYW5kbGUgMHgwMDVBLCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMKT25ib2Fy
ZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIEV0aGVybmV0CglUeXBl
OiBFdGhlcm5ldAoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAxCglCdXMgQWRkcmVz
czogMDAwMDowMDoxZi42CgpIYW5kbGUgMHgwMDVCLCBETUkgdHlwZSAyMjEsIDg5IGJ5dGVzCk9F
TS1zcGVjaWZpYyBUeXBlCglIZWFkZXIgYW5kIERhdGE6CgkJREQgNTkgNUIgMDAgMEMgMDEgMDAg
MDAgMDAgMDAgQTYgMDAgMDIgMDAgRkYgRkYKCQlGRiBGRiBGRiAwMyAwNCBGRiBGRiBGRiBGRiBG
RiAwNSAwNiBGRiBGRiBGRiBGRgoJCUZGIDA3IDA4IEZGIEZGIEZGIEZGIEZGIDA5IDAwIDAwIDAw
IDAwIDAwIDAwIDBBCgkJMDAgRkYgRkYgRkYgRkYgRkYgMEIgMDAgRkYgRkYgMDAgMDAgMDAgMEMg
MDAgRkYKCQlGRiBGRiBGRiBGRiAwRCAwMCBGRiBGRiBGRiBGRiBGRiAwRSAwMCAwMCAwNyAwMAoJ
CTAwIDAwIDBGIDAwIDAwIDAyIDAwIDBGIDAwCglTdHJpbmdzOgoJCUxhbiBQaHkgVmVyc2lvbgoJ
CVNlbnNvciBGaXJtd2FyZSBWZXJzaW9uCgkJRGVidWcgTW9kZSBTdGF0dXMKCQlEaXNhYmxlZAoJ
CVBlcmZvcm1hbmNlIE1vZGUgU3RhdHVzCgkJRGlzYWJsZWQKCQlEZWJ1ZyBVc2UgVVNCKERpc2Fi
bGVkOlNlcmlhbCkKCQlEaXNhYmxlZAoJCUlDQyBPdmVyY2xvY2tpbmcgVmVyc2lvbgoJCVVOREkg
VmVyc2lvbgoJCUVDIEZXIFZlcnNpb24KCQlHT1AgVmVyc2lvbgoJCVJveWFsIFBhcmsgVmVyc2lv
bgoJCVBsYXRmb3JtIFZlcnNpb24KCQlDbGllbnQgU2lsaWNvbiBWZXJzaW9uCgpIYW5kbGUgMHgw
MDVDLCBETUkgdHlwZSAxNCwgOCBieXRlcwpHcm91cCBBc3NvY2lhdGlvbnMKCU5hbWU6ICRNRUkK
CUl0ZW1zOiAxCgkJMHgwMDAwIChPRU0tc3BlY2lmaWMpCgpIYW5kbGUgMHgwMDVELCBETUkgdHlw
ZSAyMTksIDEwNiBieXRlcwpPRU0tc3BlY2lmaWMgVHlwZQoJSGVhZGVyIGFuZCBEYXRhOgoJCURC
IDZBIDVEIDAwIDAxIDA0IDAxIDQ1IDAyIDAwIDkwIDA2IDAxIDEwIDgyIDIwCgkJMDAgMDAgMDAg
MDAgNDggMDggMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgNDAgMDIKCQlGRiBGRiBGRiBGRiBGRiBG
RiBGRiBGRiBGRiBGRiBGRiBGRiBGRiBGRiBGRiBGRgoJCUZGIEZGIEZGIEZGIEZGIEZGIEZGIEZG
IDAzIDAwIDAwIDAwIDgwIDAwIDAwIDAwCgkJMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAKCQkwMCAwNCBGRiBGRiBGRiBGRiBGRiBGRiBGRiBGRiBGRiBGRiBG
RiBGRiBGRiBGRgoJCUZGIEZGIEZGIEZGIEZGIEZGIEZGIEZGIEZGIEZGCglTdHJpbmdzOgoJCU1F
STEKCQlNRUkyCgkJTUVJMwoJCU1FSTQKCkhhbmRsZSAweDAwNUUsIERNSSB0eXBlIDEzNiwgNiBi
eXRlcwpPRU0tc3BlY2lmaWMgVHlwZQoJSGVhZGVyIGFuZCBEYXRhOgoJCTg4IDA2IDVFIDAwIDAw
IDAwCgpIYW5kbGUgMHgwMDVGLCBETUkgdHlwZSAxNCwgMjMgYnl0ZXMKR3JvdXAgQXNzb2NpYXRp
b25zCglOYW1lOiBGaXJtd2FyZSBWZXJzaW9uIEluZm8KCUl0ZW1zOiA2CgkJMHgwMDQ4IChPRU0t
c3BlY2lmaWMpCgkJMHgwMDQ5IChPRU0tc3BlY2lmaWMpCgkJMHgwMDRBIChPRU0tc3BlY2lmaWMp
CgkJMHgwMDRCIChPRU0tc3BlY2lmaWMpCgkJMHgwMDRDIChPRU0tc3BlY2lmaWMpCgkJMHgwMDVC
IChPRU0tc3BlY2lmaWMpCgpIYW5kbGUgMHgwMDYwLCBETUkgdHlwZSAxMywgMjIgYnl0ZXMKQklP
UyBMYW5ndWFnZSBJbmZvcm1hdGlvbgoJTGFuZ3VhZ2UgRGVzY3JpcHRpb24gRm9ybWF0OiBMb25n
CglJbnN0YWxsYWJsZSBMYW5ndWFnZXM6IDkKCQllbnxVU3xpc284ODU5LTEKCQlmcnxGUnxpc284
ODU5LTEKCQl6aHxUV3x1bmljb2RlCgkJemh8Q058dW5pY29kZQoJCWphfEpQfHVuaWNvZGUKCQlk
ZXxERXxpc284ODU5LTEKCQllc3xFU3xpc284ODU5LTEKCQlydXxSVXxpc284ODU5LTUKCQlrb3xL
Unx1bmljb2RlCglDdXJyZW50bHkgSW5zdGFsbGVkIExhbmd1YWdlOiBlbnxVU3xpc284ODU5LTEK
CkhhbmRsZSAweDAwNjEsIERNSSB0eXBlIDEyNywgNCBieXRlcwpFbmQgT2YgVGFibGUKCg==
--0000000000009026a806138dbef9
Content-Type: text/x-dsl; charset="US-ASCII"; name="TPM2.dsl"
Content-Disposition: attachment; filename="TPM2.dsl"
Content-Transfer-Encoding: base64
Content-ID: <f_ltq1mfcw2>
X-Attachment-Id: f_ltq1mfcw2

LyoKICogSW50ZWwgQUNQSSBDb21wb25lbnQgQXJjaGl0ZWN0dXJlCiAqIEFNTC9BU0wrIERpc2Fz
c2VtYmxlciB2ZXJzaW9uIDIwMjIwMzMxICg2NC1iaXQgdmVyc2lvbikKICogQ29weXJpZ2h0IChj
KSAyMDAwIC0gMjAyMiBJbnRlbCBDb3Jwb3JhdGlvbgogKiAKICogRGlzYXNzZW1ibHkgb2YgVFBN
MiwgU3VuIEZlYiAyNSAwMDoyODo0OCAyMDI0CiAqCiAqIEFDUEkgRGF0YSBUYWJsZSBbVFBNMl0K
ICoKICogRm9ybWF0OiBbSGV4T2Zmc2V0IERlY2ltYWxPZmZzZXQgQnl0ZUxlbmd0aF0gIEZpZWxk
TmFtZSA6IEZpZWxkVmFsdWUgKGluIGhleCkKICovCgpbMDAwaCAwMDAwICAgNF0gICAgICAgICAg
ICAgICAgICAgIFNpZ25hdHVyZSA6ICJUUE0yIiAgICBbVHJ1c3RlZCBQbGF0Zm9ybSBNb2R1bGUg
aGFyZHdhcmUgaW50ZXJmYWNlIFRhYmxlXQpbMDA0aCAwMDA0ICAgNF0gICAgICAgICAgICAgICAg
IFRhYmxlIExlbmd0aCA6IDAwMDAwMDRDClswMDhoIDAwMDggICAxXSAgICAgICAgICAgICAgICAg
ICAgIFJldmlzaW9uIDogMDQKWzAwOWggMDAwOSAgIDFdICAgICAgICAgICAgICAgICAgICAgQ2hl
Y2tzdW0gOiBEQQpbMDBBaCAwMDEwICAgNl0gICAgICAgICAgICAgICAgICAgICAgIE9lbSBJRCA6
ICJBTEFTS0EiClswMTBoIDAwMTYgICA4XSAgICAgICAgICAgICAgICAgT2VtIFRhYmxlIElEIDog
IkEgTSBJICIKWzAxOGggMDAyNCAgIDRdICAgICAgICAgICAgICAgICBPZW0gUmV2aXNpb24gOiAw
MDAwMDAwMQpbMDFDaCAwMDI4ICAgNF0gICAgICAgICAgICAgIEFzbCBDb21waWxlciBJRCA6ICJB
TUkgIgpbMDIwaCAwMDMyICAgNF0gICAgICAgIEFzbCBDb21waWxlciBSZXZpc2lvbiA6IDAwMDAw
MDAwCgpbMDI0aCAwMDM2ICAgMl0gICAgICAgICAgICAgICBQbGF0Zm9ybSBDbGFzcyA6IDAwMDAK
WzAyNmggMDAzOCAgIDJdICAgICAgICAgICAgICAgICAgICAgUmVzZXJ2ZWQgOiAwMDAwClswMjho
IDAwNDAgICA4XSAgICAgICAgICAgICAgQ29udHJvbCBBZGRyZXNzIDogMDAwMDAwMDBGRUQ0MDA0
MApbMDMwaCAwMDQ4ICAgNF0gICAgICAgICAgICAgICAgIFN0YXJ0IE1ldGhvZCA6IDA3IFtDb21t
YW5kIFJlc3BvbnNlIEJ1ZmZlcl0KClswMzRoIDAwNTIgIDEyXSAgICAgICAgICAgIE1ldGhvZCBQ
YXJhbWV0ZXJzIDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKWzA0MGggMDA2
NCAgIDRdICAgICAgICAgICBNaW5pbXVtIExvZyBMZW5ndGggOiAwMDAxMDAwMApbMDQ0aCAwMDY4
ICAgOF0gICAgICAgICAgICAgICAgICBMb2cgQWRkcmVzcyA6IDAwMDAwMDAwOEUzRkYwMDAKClJh
dyBUYWJsZSBEYXRhOiBMZW5ndGggNzYgKDB4NEMpCgogICAgMDAwMDogNTQgNTAgNEQgMzIgNEMg
MDAgMDAgMDAgMDQgREEgNDEgNEMgNDEgNTMgNEIgNDEgIC8vIFRQTTJMLi4uLi5BTEFTS0EKICAg
IDAwMTA6IDQxIDIwIDREIDIwIDQ5IDIwIDAwIDAwIDAxIDAwIDAwIDAwIDQxIDREIDQ5IDIwICAv
LyBBIE0gSSAuLi4uLi5BTUkgCiAgICAwMDIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA0MCAw
MCBENCBGRSAwMCAwMCAwMCAwMCAgLy8gLi4uLi4uLi5ALi4uLi4uLgogICAgMDAzMDogMDcgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIC8vIC4uLi4uLi4uLi4u
Li4uLi4KICAgIDAwNDA6IDAwIDAwIDAxIDAwIDAwIEYwIDNGIDhFIDAwIDAwIDAwIDAwICAgICAg
ICAgICAgICAvLyAuLi4uLi4/Li4uLi4K
--0000000000009026a806138dbef9
Content-Type: text/plain; charset="US-ASCII"; name="cpuinfo.txt"
Content-Disposition: attachment; filename="cpuinfo.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ltq1mfch0>
X-Attachment-Id: f_ltq1mfch0

cHJvY2Vzc29yCTogMAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYKbW9k
ZWwJCTogMTY1Cm1vZGVsIG5hbWUJOiBJbnRlbChSKSBDb3JlKFRNKSBpNy0xMDcwMEYgQ1BVIEAg
Mi45MEdIegpzdGVwcGluZwk6IDUKbWljcm9jb2RlCTogMHhmOApjcHUgTUh6CQk6IDgwMC4wODAK
Y2FjaGUgc2l6ZQk6IDE2Mzg0IEtCCnBoeXNpY2FsIGlkCTogMApzaWJsaW5ncwk6IDE2CmNvcmUg
aWQJCTogMApjcHUgY29yZXMJOiA4CmFwaWNpZAkJOiAwCmluaXRpYWwgYXBpY2lkCTogMApmcHUJ
CTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiAyMgp3cAkJOiB5ZXMKZmxh
Z3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBn
ZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBz
cyBodCB0bSBwYmUgc3lzY2FsbCBueCBwZHBlMWdiIHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJ0
IGFyY2hfcGVyZm1vbiBwZWJzIGJ0cyByZXBfZ29vZCBub3BsIHh0b3BvbG9neSBub25zdG9wX3Rz
YyBjcHVpZCBhcGVyZm1wZXJmIHBuaSBwY2xtdWxxZHEgZHRlczY0IG1vbml0b3IgZHNfY3BsIHZt
eCBlc3QgdG0yIHNzc2UzIHNkYmcgZm1hIGN4MTYgeHRwciBwZGNtIHBjaWQgc3NlNF8xIHNzZTRf
MiB4MmFwaWMgbW92YmUgcG9wY250IHRzY19kZWFkbGluZV90aW1lciBhZXMgeHNhdmUgYXZ4IGYx
NmMgcmRyYW5kIGxhaGZfbG0gYWJtIDNkbm93cHJlZmV0Y2ggY3B1aWRfZmF1bHQgZXBiIHNzYmQg
aWJycyBpYnBiIHN0aWJwIGlicnNfZW5oYW5jZWQgdHByX3NoYWRvdyBmbGV4cHJpb3JpdHkgZXB0
IHZwaWQgZXB0X2FkIGZzZ3NiYXNlIHRzY19hZGp1c3Qgc2d4IGJtaTEgYXZ4MiBzbWVwIGJtaTIg
ZXJtcyBpbnZwY2lkIG1weCByZHNlZWQgYWR4IHNtYXAgY2xmbHVzaG9wdCBpbnRlbF9wdCB4c2F2
ZW9wdCB4c2F2ZWMgeGdldGJ2MSB4c2F2ZXMgZHRoZXJtIGlkYSBhcmF0IHBsbiBwdHMgaHdwIGh3
cF9ub3RpZnkgaHdwX2FjdF93aW5kb3cgaHdwX2VwcCB2bm1pIHBrdSBvc3BrZSBzZ3hfbGMgbWRf
Y2xlYXIgZmx1c2hfbDFkIGFyY2hfY2FwYWJpbGl0aWVzCnZteCBmbGFncwk6IHZubWkgcHJlZW1w
dGlvbl90aW1lciBwb3N0ZWRfaW50ciBpbnZ2cGlkIGVwdF94X29ubHkgZXB0X2FkIGVwdF8xZ2Ig
ZmxleHByaW9yaXR5IGFwaWN2IHRzY19vZmZzZXQgdnRwciBtdGYgdmFwaWMgZXB0IHZwaWQgdW5y
ZXN0cmljdGVkX2d1ZXN0IHZhcGljX3JlZyB2aWQgcGxlIHNoYWRvd192bWNzIHBtbCBlcHRfbW9k
ZV9iYXNlZF9leGVjCmJ1Z3MJCTogc3BlY3RyZV92MSBzcGVjdHJlX3YyIHNwZWNfc3RvcmVfYnlw
YXNzIHN3YXBncyBpdGxiX211bHRpaGl0IHNyYmRzIG1taW9fc3RhbGVfZGF0YSByZXRibGVlZCBl
aWJyc19wYnJzYiBnZHMKYm9nb21pcHMJOiA1Nzk5Ljc3CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hl
X2FsaWdubWVudAk6IDY0CmFkZHJlc3Mgc2l6ZXMJOiAzOSBiaXRzIHBoeXNpY2FsLCA0OCBiaXRz
IHZpcnR1YWwKcG93ZXIgbWFuYWdlbWVudDoKCnByb2Nlc3Nvcgk6IDEKdmVuZG9yX2lkCTogR2Vu
dWluZUludGVsCmNwdSBmYW1pbHkJOiA2Cm1vZGVsCQk6IDE2NQptb2RlbCBuYW1lCTogSW50ZWwo
UikgQ29yZShUTSkgaTctMTA3MDBGIENQVSBAIDIuOTBHSHoKc3RlcHBpbmcJOiA1Cm1pY3JvY29k
ZQk6IDB4ZjgKY3B1IE1IegkJOiA4MDAuMDIwCmNhY2hlIHNpemUJOiAxNjM4NCBLQgpwaHlzaWNh
bCBpZAk6IDAKc2libGluZ3MJOiAxNgpjb3JlIGlkCQk6IDEKY3B1IGNvcmVzCTogOAphcGljaWQJ
CTogMgppbml0aWFsIGFwaWNpZAk6IDIKZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNw
dWlkIGxldmVsCTogMjIKd3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3Ig
cGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2gg
ZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggcGRwZTFn
YiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFydCBhcmNoX3BlcmZtb24gcGVicyBidHMgcmVwX2dv
b2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgY3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNsbXVs
cWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXggZXN0IHRtMiBzc3NlMyBzZGJnIGZtYSBjeDE2
IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0XzIgeDJhcGljIG1vdmJlIHBvcGNudCB0c2NfZGVh
ZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xtIGFibSAzZG5vd3By
ZWZldGNoIGNwdWlkX2ZhdWx0IGVwYiBzc2JkIGlicnMgaWJwYiBzdGlicCBpYnJzX2VuaGFuY2Vk
IHRwcl9zaGFkb3cgZmxleHByaW9yaXR5IGVwdCB2cGlkIGVwdF9hZCBmc2dzYmFzZSB0c2NfYWRq
dXN0IHNneCBibWkxIGF2eDIgc21lcCBibWkyIGVybXMgaW52cGNpZCBtcHggcmRzZWVkIGFkeCBz
bWFwIGNsZmx1c2hvcHQgaW50ZWxfcHQgeHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVzIGR0
aGVybSBpZGEgYXJhdCBwbG4gcHRzIGh3cCBod3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93IGh3cF9l
cHAgdm5taSBwa3Ugb3Nwa2Ugc2d4X2xjIG1kX2NsZWFyIGZsdXNoX2wxZCBhcmNoX2NhcGFiaWxp
dGllcwp2bXggZmxhZ3MJOiB2bm1pIHByZWVtcHRpb25fdGltZXIgcG9zdGVkX2ludHIgaW52dnBp
ZCBlcHRfeF9vbmx5IGVwdF9hZCBlcHRfMWdiIGZsZXhwcmlvcml0eSBhcGljdiB0c2Nfb2Zmc2V0
IHZ0cHIgbXRmIHZhcGljIGVwdCB2cGlkIHVucmVzdHJpY3RlZF9ndWVzdCB2YXBpY19yZWcgdmlk
IHBsZSBzaGFkb3dfdm1jcyBwbWwgZXB0X21vZGVfYmFzZWRfZXhlYwpidWdzCQk6IHNwZWN0cmVf
djEgc3BlY3RyZV92MiBzcGVjX3N0b3JlX2J5cGFzcyBzd2FwZ3MgaXRsYl9tdWx0aWhpdCBzcmJk
cyBtbWlvX3N0YWxlX2RhdGEgcmV0YmxlZWQgZWlicnNfcGJyc2IgZ2RzCmJvZ29taXBzCTogNTc5
OS43NwpjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNzIHNpemVz
CTogMzkgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1lbnQ6Cgpw
cm9jZXNzb3IJOiAyCnZlbmRvcl9pZAk6IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2Rl
bAkJOiAxNjUKbW9kZWwgbmFtZQk6IEludGVsKFIpIENvcmUoVE0pIGk3LTEwNzAwRiBDUFUgQCAy
LjkwR0h6CnN0ZXBwaW5nCTogNQptaWNyb2NvZGUJOiAweGY4CmNwdSBNSHoJCTogODAwLjAwMApj
YWNoZSBzaXplCTogMTYzODQgS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogMTYKY29yZSBp
ZAkJOiAyCmNwdSBjb3Jlcwk6IDgKYXBpY2lkCQk6IDQKaW5pdGlhbCBhcGljaWQJOiA0CmZwdQkJ
OiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDIyCndwCQk6IHllcwpmbGFn
cwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdl
IG1jYSBjbW92IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2UyIHNz
IGh0IHRtIHBiZSBzeXNjYWxsIG54IHBkcGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcnQg
YXJjaF9wZXJmbW9uIHBlYnMgYnRzIHJlcF9nb29kIG5vcGwgeHRvcG9sb2d5IG5vbnN0b3BfdHNj
IGNwdWlkIGFwZXJmbXBlcmYgcG5pIHBjbG11bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14
IGVzdCB0bTIgc3NzZTMgc2RiZyBmbWEgY3gxNiB4dHByIHBkY20gcGNpZCBzc2U0XzEgc3NlNF8y
IHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBhdnggZjE2
YyByZHJhbmQgbGFoZl9sbSBhYm0gM2Rub3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBlcGIgc3NiZCBp
YnJzIGlicGIgc3RpYnAgaWJyc19lbmhhbmNlZCB0cHJfc2hhZG93IGZsZXhwcmlvcml0eSBlcHQg
dnBpZCBlcHRfYWQgZnNnc2Jhc2UgdHNjX2FkanVzdCBzZ3ggYm1pMSBhdngyIHNtZXAgYm1pMiBl
cm1zIGludnBjaWQgbXB4IHJkc2VlZCBhZHggc21hcCBjbGZsdXNob3B0IGludGVsX3B0IHhzYXZl
b3B0IHhzYXZlYyB4Z2V0YnYxIHhzYXZlcyBkdGhlcm0gaWRhIGFyYXQgcGxuIHB0cyBod3AgaHdw
X25vdGlmeSBod3BfYWN0X3dpbmRvdyBod3BfZXBwIHZubWkgcGt1IG9zcGtlIHNneF9sYyBtZF9j
bGVhciBmbHVzaF9sMWQgYXJjaF9jYXBhYmlsaXRpZXMKdm14IGZsYWdzCTogdm5taSBwcmVlbXB0
aW9uX3RpbWVyIHBvc3RlZF9pbnRyIGludnZwaWQgZXB0X3hfb25seSBlcHRfYWQgZXB0XzFnYiBm
bGV4cHJpb3JpdHkgYXBpY3YgdHNjX29mZnNldCB2dHByIG10ZiB2YXBpYyBlcHQgdnBpZCB1bnJl
c3RyaWN0ZWRfZ3Vlc3QgdmFwaWNfcmVnIHZpZCBwbGUgc2hhZG93X3ZtY3MgcG1sIGVwdF9tb2Rl
X2Jhc2VkX2V4ZWMKYnVncwkJOiBzcGVjdHJlX3YxIHNwZWN0cmVfdjIgc3BlY19zdG9yZV9ieXBh
c3Mgc3dhcGdzIGl0bGJfbXVsdGloaXQgc3JiZHMgbW1pb19zdGFsZV9kYXRhIHJldGJsZWVkIGVp
YnJzX3BicnNiIGdkcwpib2dvbWlwcwk6IDU3OTkuNzcKY2xmbHVzaCBzaXplCTogNjQKY2FjaGVf
YWxpZ25tZW50CTogNjQKYWRkcmVzcyBzaXplcwk6IDM5IGJpdHMgcGh5c2ljYWwsIDQ4IGJpdHMg
dmlydHVhbApwb3dlciBtYW5hZ2VtZW50OgoKcHJvY2Vzc29yCTogMwp2ZW5kb3JfaWQJOiBHZW51
aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYKbW9kZWwJCTogMTY1Cm1vZGVsIG5hbWUJOiBJbnRlbChS
KSBDb3JlKFRNKSBpNy0xMDcwMEYgQ1BVIEAgMi45MEdIegpzdGVwcGluZwk6IDUKbWljcm9jb2Rl
CTogMHhmOApjcHUgTUh6CQk6IDgwMC4wOTEKY2FjaGUgc2l6ZQk6IDE2Mzg0IEtCCnBoeXNpY2Fs
IGlkCTogMApzaWJsaW5ncwk6IDE2CmNvcmUgaWQJCTogMwpjcHUgY29yZXMJOiA4CmFwaWNpZAkJ
OiA2CmluaXRpYWwgYXBpY2lkCTogNgpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1
aWQgbGV2ZWwJOiAyMgp3cAkJOiB5ZXMKZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBw
YWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVzaCBk
dHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bSBwYmUgc3lzY2FsbCBueCBwZHBlMWdi
IHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJ0IGFyY2hfcGVyZm1vbiBwZWJzIGJ0cyByZXBfZ29v
ZCBub3BsIHh0b3BvbG9neSBub25zdG9wX3RzYyBjcHVpZCBhcGVyZm1wZXJmIHBuaSBwY2xtdWxx
ZHEgZHRlczY0IG1vbml0b3IgZHNfY3BsIHZteCBlc3QgdG0yIHNzc2UzIHNkYmcgZm1hIGN4MTYg
eHRwciBwZGNtIHBjaWQgc3NlNF8xIHNzZTRfMiB4MmFwaWMgbW92YmUgcG9wY250IHRzY19kZWFk
bGluZV90aW1lciBhZXMgeHNhdmUgYXZ4IGYxNmMgcmRyYW5kIGxhaGZfbG0gYWJtIDNkbm93cHJl
ZmV0Y2ggY3B1aWRfZmF1bHQgZXBiIHNzYmQgaWJycyBpYnBiIHN0aWJwIGlicnNfZW5oYW5jZWQg
dHByX3NoYWRvdyBmbGV4cHJpb3JpdHkgZXB0IHZwaWQgZXB0X2FkIGZzZ3NiYXNlIHRzY19hZGp1
c3Qgc2d4IGJtaTEgYXZ4MiBzbWVwIGJtaTIgZXJtcyBpbnZwY2lkIG1weCByZHNlZWQgYWR4IHNt
YXAgY2xmbHVzaG9wdCBpbnRlbF9wdCB4c2F2ZW9wdCB4c2F2ZWMgeGdldGJ2MSB4c2F2ZXMgZHRo
ZXJtIGlkYSBhcmF0IHBsbiBwdHMgaHdwIGh3cF9ub3RpZnkgaHdwX2FjdF93aW5kb3cgaHdwX2Vw
cCB2bm1pIHBrdSBvc3BrZSBzZ3hfbGMgbWRfY2xlYXIgZmx1c2hfbDFkIGFyY2hfY2FwYWJpbGl0
aWVzCnZteCBmbGFncwk6IHZubWkgcHJlZW1wdGlvbl90aW1lciBwb3N0ZWRfaW50ciBpbnZ2cGlk
IGVwdF94X29ubHkgZXB0X2FkIGVwdF8xZ2IgZmxleHByaW9yaXR5IGFwaWN2IHRzY19vZmZzZXQg
dnRwciBtdGYgdmFwaWMgZXB0IHZwaWQgdW5yZXN0cmljdGVkX2d1ZXN0IHZhcGljX3JlZyB2aWQg
cGxlIHNoYWRvd192bWNzIHBtbCBlcHRfbW9kZV9iYXNlZF9leGVjCmJ1Z3MJCTogc3BlY3RyZV92
MSBzcGVjdHJlX3YyIHNwZWNfc3RvcmVfYnlwYXNzIHN3YXBncyBpdGxiX211bHRpaGl0IHNyYmRz
IG1taW9fc3RhbGVfZGF0YSByZXRibGVlZCBlaWJyc19wYnJzYiBnZHMKYm9nb21pcHMJOiA1Nzk5
Ljc3CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2FsaWdubWVudAk6IDY0CmFkZHJlc3Mgc2l6ZXMJ
OiAzOSBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1YWwKcG93ZXIgbWFuYWdlbWVudDoKCnBy
b2Nlc3Nvcgk6IDQKdmVuZG9yX2lkCTogR2VudWluZUludGVsCmNwdSBmYW1pbHkJOiA2Cm1vZGVs
CQk6IDE2NQptb2RlbCBuYW1lCTogSW50ZWwoUikgQ29yZShUTSkgaTctMTA3MDBGIENQVSBAIDIu
OTBHSHoKc3RlcHBpbmcJOiA1Cm1pY3JvY29kZQk6IDB4ZjgKY3B1IE1IegkJOiA4MDAuMjI1CmNh
Y2hlIHNpemUJOiAxNjM4NCBLQgpwaHlzaWNhbCBpZAk6IDAKc2libGluZ3MJOiAxNgpjb3JlIGlk
CQk6IDQKY3B1IGNvcmVzCTogOAphcGljaWQJCTogOAppbml0aWFsIGFwaWNpZAk6IDgKZnB1CQk6
IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTogMjIKd3AJCTogeWVzCmZsYWdz
CQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2Ug
bWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3Mg
aHQgdG0gcGJlIHN5c2NhbGwgbnggcGRwZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFydCBh
cmNoX3BlcmZtb24gcGVicyBidHMgcmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2Mg
Y3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNsbXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXgg
ZXN0IHRtMiBzc3NlMyBzZGJnIGZtYSBjeDE2IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0XzIg
eDJhcGljIG1vdmJlIHBvcGNudCB0c2NfZGVhZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZj
IHJkcmFuZCBsYWhmX2xtIGFibSAzZG5vd3ByZWZldGNoIGNwdWlkX2ZhdWx0IGVwYiBzc2JkIGli
cnMgaWJwYiBzdGlicCBpYnJzX2VuaGFuY2VkIHRwcl9zaGFkb3cgZmxleHByaW9yaXR5IGVwdCB2
cGlkIGVwdF9hZCBmc2dzYmFzZSB0c2NfYWRqdXN0IHNneCBibWkxIGF2eDIgc21lcCBibWkyIGVy
bXMgaW52cGNpZCBtcHggcmRzZWVkIGFkeCBzbWFwIGNsZmx1c2hvcHQgaW50ZWxfcHQgeHNhdmVv
cHQgeHNhdmVjIHhnZXRidjEgeHNhdmVzIGR0aGVybSBpZGEgYXJhdCBwbG4gcHRzIGh3cCBod3Bf
bm90aWZ5IGh3cF9hY3Rfd2luZG93IGh3cF9lcHAgdm5taSBwa3Ugb3Nwa2Ugc2d4X2xjIG1kX2Ns
ZWFyIGZsdXNoX2wxZCBhcmNoX2NhcGFiaWxpdGllcwp2bXggZmxhZ3MJOiB2bm1pIHByZWVtcHRp
b25fdGltZXIgcG9zdGVkX2ludHIgaW52dnBpZCBlcHRfeF9vbmx5IGVwdF9hZCBlcHRfMWdiIGZs
ZXhwcmlvcml0eSBhcGljdiB0c2Nfb2Zmc2V0IHZ0cHIgbXRmIHZhcGljIGVwdCB2cGlkIHVucmVz
dHJpY3RlZF9ndWVzdCB2YXBpY19yZWcgdmlkIHBsZSBzaGFkb3dfdm1jcyBwbWwgZXB0X21vZGVf
YmFzZWRfZXhlYwpidWdzCQk6IHNwZWN0cmVfdjEgc3BlY3RyZV92MiBzcGVjX3N0b3JlX2J5cGFz
cyBzd2FwZ3MgaXRsYl9tdWx0aWhpdCBzcmJkcyBtbWlvX3N0YWxlX2RhdGEgcmV0YmxlZWQgZWli
cnNfcGJyc2IgZ2RzCmJvZ29taXBzCTogNTc5OS43NwpjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9h
bGlnbm1lbnQJOiA2NAphZGRyZXNzIHNpemVzCTogMzkgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2
aXJ0dWFsCnBvd2VyIG1hbmFnZW1lbnQ6Cgpwcm9jZXNzb3IJOiA1CnZlbmRvcl9pZAk6IEdlbnVp
bmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJOiAxNjUKbW9kZWwgbmFtZQk6IEludGVsKFIp
IENvcmUoVE0pIGk3LTEwNzAwRiBDUFUgQCAyLjkwR0h6CnN0ZXBwaW5nCTogNQptaWNyb2NvZGUJ
OiAweGY4CmNwdSBNSHoJCTogODAwLjIxNgpjYWNoZSBzaXplCTogMTYzODQgS0IKcGh5c2ljYWwg
aWQJOiAwCnNpYmxpbmdzCTogMTYKY29yZSBpZAkJOiA1CmNwdSBjb3Jlcwk6IDgKYXBpY2lkCQk6
IDEwCmluaXRpYWwgYXBpY2lkCTogMTAKZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNw
dWlkIGxldmVsCTogMjIKd3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3Ig
cGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2gg
ZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggcGRwZTFn
YiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFydCBhcmNoX3BlcmZtb24gcGVicyBidHMgcmVwX2dv
b2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgY3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNsbXVs
cWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXggZXN0IHRtMiBzc3NlMyBzZGJnIGZtYSBjeDE2
IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0XzIgeDJhcGljIG1vdmJlIHBvcGNudCB0c2NfZGVh
ZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xtIGFibSAzZG5vd3By
ZWZldGNoIGNwdWlkX2ZhdWx0IGVwYiBzc2JkIGlicnMgaWJwYiBzdGlicCBpYnJzX2VuaGFuY2Vk
IHRwcl9zaGFkb3cgZmxleHByaW9yaXR5IGVwdCB2cGlkIGVwdF9hZCBmc2dzYmFzZSB0c2NfYWRq
dXN0IHNneCBibWkxIGF2eDIgc21lcCBibWkyIGVybXMgaW52cGNpZCBtcHggcmRzZWVkIGFkeCBz
bWFwIGNsZmx1c2hvcHQgaW50ZWxfcHQgeHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVzIGR0
aGVybSBpZGEgYXJhdCBwbG4gcHRzIGh3cCBod3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93IGh3cF9l
cHAgdm5taSBwa3Ugb3Nwa2Ugc2d4X2xjIG1kX2NsZWFyIGZsdXNoX2wxZCBhcmNoX2NhcGFiaWxp
dGllcwp2bXggZmxhZ3MJOiB2bm1pIHByZWVtcHRpb25fdGltZXIgcG9zdGVkX2ludHIgaW52dnBp
ZCBlcHRfeF9vbmx5IGVwdF9hZCBlcHRfMWdiIGZsZXhwcmlvcml0eSBhcGljdiB0c2Nfb2Zmc2V0
IHZ0cHIgbXRmIHZhcGljIGVwdCB2cGlkIHVucmVzdHJpY3RlZF9ndWVzdCB2YXBpY19yZWcgdmlk
IHBsZSBzaGFkb3dfdm1jcyBwbWwgZXB0X21vZGVfYmFzZWRfZXhlYwpidWdzCQk6IHNwZWN0cmVf
djEgc3BlY3RyZV92MiBzcGVjX3N0b3JlX2J5cGFzcyBzd2FwZ3MgaXRsYl9tdWx0aWhpdCBzcmJk
cyBtbWlvX3N0YWxlX2RhdGEgcmV0YmxlZWQgZWlicnNfcGJyc2IgZ2RzCmJvZ29taXBzCTogNTc5
OS43NwpjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNzIHNpemVz
CTogMzkgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1lbnQ6Cgpw
cm9jZXNzb3IJOiA2CnZlbmRvcl9pZAk6IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2Rl
bAkJOiAxNjUKbW9kZWwgbmFtZQk6IEludGVsKFIpIENvcmUoVE0pIGk3LTEwNzAwRiBDUFUgQCAy
LjkwR0h6CnN0ZXBwaW5nCTogNQptaWNyb2NvZGUJOiAweGY4CmNwdSBNSHoJCTogODAwLjA3Ngpj
YWNoZSBzaXplCTogMTYzODQgS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogMTYKY29yZSBp
ZAkJOiA2CmNwdSBjb3Jlcwk6IDgKYXBpY2lkCQk6IDEyCmluaXRpYWwgYXBpY2lkCTogMTIKZnB1
CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTogMjIKd3AJCTogeWVzCmZs
YWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBw
Z2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIg
c3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggcGRwZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFy
dCBhcmNoX3BlcmZtb24gcGVicyBidHMgcmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90
c2MgY3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNsbXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2
bXggZXN0IHRtMiBzc3NlMyBzZGJnIGZtYSBjeDE2IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0
XzIgeDJhcGljIG1vdmJlIHBvcGNudCB0c2NfZGVhZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBm
MTZjIHJkcmFuZCBsYWhmX2xtIGFibSAzZG5vd3ByZWZldGNoIGNwdWlkX2ZhdWx0IGVwYiBzc2Jk
IGlicnMgaWJwYiBzdGlicCBpYnJzX2VuaGFuY2VkIHRwcl9zaGFkb3cgZmxleHByaW9yaXR5IGVw
dCB2cGlkIGVwdF9hZCBmc2dzYmFzZSB0c2NfYWRqdXN0IHNneCBibWkxIGF2eDIgc21lcCBibWky
IGVybXMgaW52cGNpZCBtcHggcmRzZWVkIGFkeCBzbWFwIGNsZmx1c2hvcHQgaW50ZWxfcHQgeHNh
dmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVzIGR0aGVybSBpZGEgYXJhdCBwbG4gcHRzIGh3cCBo
d3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93IGh3cF9lcHAgdm5taSBwa3Ugb3Nwa2Ugc2d4X2xjIG1k
X2NsZWFyIGZsdXNoX2wxZCBhcmNoX2NhcGFiaWxpdGllcwp2bXggZmxhZ3MJOiB2bm1pIHByZWVt
cHRpb25fdGltZXIgcG9zdGVkX2ludHIgaW52dnBpZCBlcHRfeF9vbmx5IGVwdF9hZCBlcHRfMWdi
IGZsZXhwcmlvcml0eSBhcGljdiB0c2Nfb2Zmc2V0IHZ0cHIgbXRmIHZhcGljIGVwdCB2cGlkIHVu
cmVzdHJpY3RlZF9ndWVzdCB2YXBpY19yZWcgdmlkIHBsZSBzaGFkb3dfdm1jcyBwbWwgZXB0X21v
ZGVfYmFzZWRfZXhlYwpidWdzCQk6IHNwZWN0cmVfdjEgc3BlY3RyZV92MiBzcGVjX3N0b3JlX2J5
cGFzcyBzd2FwZ3MgaXRsYl9tdWx0aWhpdCBzcmJkcyBtbWlvX3N0YWxlX2RhdGEgcmV0YmxlZWQg
ZWlicnNfcGJyc2IgZ2RzCmJvZ29taXBzCTogNTc5OS43NwpjbGZsdXNoIHNpemUJOiA2NApjYWNo
ZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNzIHNpemVzCTogMzkgYml0cyBwaHlzaWNhbCwgNDggYml0
cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1lbnQ6Cgpwcm9jZXNzb3IJOiA3CnZlbmRvcl9pZAk6IEdl
bnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJOiAxNjUKbW9kZWwgbmFtZQk6IEludGVs
KFIpIENvcmUoVE0pIGk3LTEwNzAwRiBDUFUgQCAyLjkwR0h6CnN0ZXBwaW5nCTogNQptaWNyb2Nv
ZGUJOiAweGY4CmNwdSBNSHoJCTogODAwLjAwMApjYWNoZSBzaXplCTogMTYzODQgS0IKcGh5c2lj
YWwgaWQJOiAwCnNpYmxpbmdzCTogMTYKY29yZSBpZAkJOiA3CmNwdSBjb3Jlcwk6IDgKYXBpY2lk
CQk6IDE0CmluaXRpYWwgYXBpY2lkCTogMTQKZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVz
CmNwdWlkIGxldmVsCTogMjIKd3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBt
c3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1
c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggcGRw
ZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFydCBhcmNoX3BlcmZtb24gcGVicyBidHMgcmVw
X2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgY3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNs
bXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXggZXN0IHRtMiBzc3NlMyBzZGJnIGZtYSBj
eDE2IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0XzIgeDJhcGljIG1vdmJlIHBvcGNudCB0c2Nf
ZGVhZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xtIGFibSAzZG5v
d3ByZWZldGNoIGNwdWlkX2ZhdWx0IGVwYiBzc2JkIGlicnMgaWJwYiBzdGlicCBpYnJzX2VuaGFu
Y2VkIHRwcl9zaGFkb3cgZmxleHByaW9yaXR5IGVwdCB2cGlkIGVwdF9hZCBmc2dzYmFzZSB0c2Nf
YWRqdXN0IHNneCBibWkxIGF2eDIgc21lcCBibWkyIGVybXMgaW52cGNpZCBtcHggcmRzZWVkIGFk
eCBzbWFwIGNsZmx1c2hvcHQgaW50ZWxfcHQgeHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVz
IGR0aGVybSBpZGEgYXJhdCBwbG4gcHRzIGh3cCBod3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93IGh3
cF9lcHAgdm5taSBwa3Ugb3Nwa2Ugc2d4X2xjIG1kX2NsZWFyIGZsdXNoX2wxZCBhcmNoX2NhcGFi
aWxpdGllcwp2bXggZmxhZ3MJOiB2bm1pIHByZWVtcHRpb25fdGltZXIgcG9zdGVkX2ludHIgaW52
dnBpZCBlcHRfeF9vbmx5IGVwdF9hZCBlcHRfMWdiIGZsZXhwcmlvcml0eSBhcGljdiB0c2Nfb2Zm
c2V0IHZ0cHIgbXRmIHZhcGljIGVwdCB2cGlkIHVucmVzdHJpY3RlZF9ndWVzdCB2YXBpY19yZWcg
dmlkIHBsZSBzaGFkb3dfdm1jcyBwbWwgZXB0X21vZGVfYmFzZWRfZXhlYwpidWdzCQk6IHNwZWN0
cmVfdjEgc3BlY3RyZV92MiBzcGVjX3N0b3JlX2J5cGFzcyBzd2FwZ3MgaXRsYl9tdWx0aWhpdCBz
cmJkcyBtbWlvX3N0YWxlX2RhdGEgcmV0YmxlZWQgZWlicnNfcGJyc2IgZ2RzCmJvZ29taXBzCTog
NTc5OS43NwpjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNzIHNp
emVzCTogMzkgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1lbnQ6
Cgpwcm9jZXNzb3IJOiA4CnZlbmRvcl9pZAk6IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgpt
b2RlbAkJOiAxNjUKbW9kZWwgbmFtZQk6IEludGVsKFIpIENvcmUoVE0pIGk3LTEwNzAwRiBDUFUg
QCAyLjkwR0h6CnN0ZXBwaW5nCTogNQptaWNyb2NvZGUJOiAweGY4CmNwdSBNSHoJCTogODAwLjAw
MApjYWNoZSBzaXplCTogMTYzODQgS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogMTYKY29y
ZSBpZAkJOiAwCmNwdSBjb3Jlcwk6IDgKYXBpY2lkCQk6IDEKaW5pdGlhbCBhcGljaWQJOiAxCmZw
dQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDIyCndwCQk6IHllcwpm
bGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIg
cGdlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2Uy
IHNzIGh0IHRtIHBiZSBzeXNjYWxsIG54IHBkcGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBh
cnQgYXJjaF9wZXJmbW9uIHBlYnMgYnRzIHJlcF9nb29kIG5vcGwgeHRvcG9sb2d5IG5vbnN0b3Bf
dHNjIGNwdWlkIGFwZXJmbXBlcmYgcG5pIHBjbG11bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwg
dm14IGVzdCB0bTIgc3NzZTMgc2RiZyBmbWEgY3gxNiB4dHByIHBkY20gcGNpZCBzc2U0XzEgc3Nl
NF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBhdngg
ZjE2YyByZHJhbmQgbGFoZl9sbSBhYm0gM2Rub3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBlcGIgc3Ni
ZCBpYnJzIGlicGIgc3RpYnAgaWJyc19lbmhhbmNlZCB0cHJfc2hhZG93IGZsZXhwcmlvcml0eSBl
cHQgdnBpZCBlcHRfYWQgZnNnc2Jhc2UgdHNjX2FkanVzdCBzZ3ggYm1pMSBhdngyIHNtZXAgYm1p
MiBlcm1zIGludnBjaWQgbXB4IHJkc2VlZCBhZHggc21hcCBjbGZsdXNob3B0IGludGVsX3B0IHhz
YXZlb3B0IHhzYXZlYyB4Z2V0YnYxIHhzYXZlcyBkdGhlcm0gaWRhIGFyYXQgcGxuIHB0cyBod3Ag
aHdwX25vdGlmeSBod3BfYWN0X3dpbmRvdyBod3BfZXBwIHZubWkgcGt1IG9zcGtlIHNneF9sYyBt
ZF9jbGVhciBmbHVzaF9sMWQgYXJjaF9jYXBhYmlsaXRpZXMKdm14IGZsYWdzCTogdm5taSBwcmVl
bXB0aW9uX3RpbWVyIHBvc3RlZF9pbnRyIGludnZwaWQgZXB0X3hfb25seSBlcHRfYWQgZXB0XzFn
YiBmbGV4cHJpb3JpdHkgYXBpY3YgdHNjX29mZnNldCB2dHByIG10ZiB2YXBpYyBlcHQgdnBpZCB1
bnJlc3RyaWN0ZWRfZ3Vlc3QgdmFwaWNfcmVnIHZpZCBwbGUgc2hhZG93X3ZtY3MgcG1sIGVwdF9t
b2RlX2Jhc2VkX2V4ZWMKYnVncwkJOiBzcGVjdHJlX3YxIHNwZWN0cmVfdjIgc3BlY19zdG9yZV9i
eXBhc3Mgc3dhcGdzIGl0bGJfbXVsdGloaXQgc3JiZHMgbW1pb19zdGFsZV9kYXRhIHJldGJsZWVk
IGVpYnJzX3BicnNiIGdkcwpib2dvbWlwcwk6IDU3OTkuNzcKY2xmbHVzaCBzaXplCTogNjQKY2Fj
aGVfYWxpZ25tZW50CTogNjQKYWRkcmVzcyBzaXplcwk6IDM5IGJpdHMgcGh5c2ljYWwsIDQ4IGJp
dHMgdmlydHVhbApwb3dlciBtYW5hZ2VtZW50OgoKcHJvY2Vzc29yCTogOQp2ZW5kb3JfaWQJOiBH
ZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYKbW9kZWwJCTogMTY1Cm1vZGVsIG5hbWUJOiBJbnRl
bChSKSBDb3JlKFRNKSBpNy0xMDcwMEYgQ1BVIEAgMi45MEdIegpzdGVwcGluZwk6IDUKbWljcm9j
b2RlCTogMHhmOApjcHUgTUh6CQk6IDgwMC4wNDkKY2FjaGUgc2l6ZQk6IDE2Mzg0IEtCCnBoeXNp
Y2FsIGlkCTogMApzaWJsaW5ncwk6IDE2CmNvcmUgaWQJCTogMQpjcHUgY29yZXMJOiA4CmFwaWNp
ZAkJOiAzCmluaXRpYWwgYXBpY2lkCTogMwpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMK
Y3B1aWQgbGV2ZWwJOiAyMgp3cAkJOiB5ZXMKZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1z
ciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVz
aCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bSBwYmUgc3lzY2FsbCBueCBwZHBl
MWdiIHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJ0IGFyY2hfcGVyZm1vbiBwZWJzIGJ0cyByZXBf
Z29vZCBub3BsIHh0b3BvbG9neSBub25zdG9wX3RzYyBjcHVpZCBhcGVyZm1wZXJmIHBuaSBwY2xt
dWxxZHEgZHRlczY0IG1vbml0b3IgZHNfY3BsIHZteCBlc3QgdG0yIHNzc2UzIHNkYmcgZm1hIGN4
MTYgeHRwciBwZGNtIHBjaWQgc3NlNF8xIHNzZTRfMiB4MmFwaWMgbW92YmUgcG9wY250IHRzY19k
ZWFkbGluZV90aW1lciBhZXMgeHNhdmUgYXZ4IGYxNmMgcmRyYW5kIGxhaGZfbG0gYWJtIDNkbm93
cHJlZmV0Y2ggY3B1aWRfZmF1bHQgZXBiIHNzYmQgaWJycyBpYnBiIHN0aWJwIGlicnNfZW5oYW5j
ZWQgdHByX3NoYWRvdyBmbGV4cHJpb3JpdHkgZXB0IHZwaWQgZXB0X2FkIGZzZ3NiYXNlIHRzY19h
ZGp1c3Qgc2d4IGJtaTEgYXZ4MiBzbWVwIGJtaTIgZXJtcyBpbnZwY2lkIG1weCByZHNlZWQgYWR4
IHNtYXAgY2xmbHVzaG9wdCBpbnRlbF9wdCB4c2F2ZW9wdCB4c2F2ZWMgeGdldGJ2MSB4c2F2ZXMg
ZHRoZXJtIGlkYSBhcmF0IHBsbiBwdHMgaHdwIGh3cF9ub3RpZnkgaHdwX2FjdF93aW5kb3cgaHdw
X2VwcCB2bm1pIHBrdSBvc3BrZSBzZ3hfbGMgbWRfY2xlYXIgZmx1c2hfbDFkIGFyY2hfY2FwYWJp
bGl0aWVzCnZteCBmbGFncwk6IHZubWkgcHJlZW1wdGlvbl90aW1lciBwb3N0ZWRfaW50ciBpbnZ2
cGlkIGVwdF94X29ubHkgZXB0X2FkIGVwdF8xZ2IgZmxleHByaW9yaXR5IGFwaWN2IHRzY19vZmZz
ZXQgdnRwciBtdGYgdmFwaWMgZXB0IHZwaWQgdW5yZXN0cmljdGVkX2d1ZXN0IHZhcGljX3JlZyB2
aWQgcGxlIHNoYWRvd192bWNzIHBtbCBlcHRfbW9kZV9iYXNlZF9leGVjCmJ1Z3MJCTogc3BlY3Ry
ZV92MSBzcGVjdHJlX3YyIHNwZWNfc3RvcmVfYnlwYXNzIHN3YXBncyBpdGxiX211bHRpaGl0IHNy
YmRzIG1taW9fc3RhbGVfZGF0YSByZXRibGVlZCBlaWJyc19wYnJzYiBnZHMKYm9nb21pcHMJOiA1
Nzk5Ljc3CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2FsaWdubWVudAk6IDY0CmFkZHJlc3Mgc2l6
ZXMJOiAzOSBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1YWwKcG93ZXIgbWFuYWdlbWVudDoK
CnByb2Nlc3Nvcgk6IDEwCnZlbmRvcl9pZAk6IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgpt
b2RlbAkJOiAxNjUKbW9kZWwgbmFtZQk6IEludGVsKFIpIENvcmUoVE0pIGk3LTEwNzAwRiBDUFUg
QCAyLjkwR0h6CnN0ZXBwaW5nCTogNQptaWNyb2NvZGUJOiAweGY4CmNwdSBNSHoJCTogODAwLjAw
MApjYWNoZSBzaXplCTogMTYzODQgS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogMTYKY29y
ZSBpZAkJOiAyCmNwdSBjb3Jlcwk6IDgKYXBpY2lkCQk6IDUKaW5pdGlhbCBhcGljaWQJOiA1CmZw
dQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDIyCndwCQk6IHllcwpm
bGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIg
cGdlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2Uy
IHNzIGh0IHRtIHBiZSBzeXNjYWxsIG54IHBkcGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBh
cnQgYXJjaF9wZXJmbW9uIHBlYnMgYnRzIHJlcF9nb29kIG5vcGwgeHRvcG9sb2d5IG5vbnN0b3Bf
dHNjIGNwdWlkIGFwZXJmbXBlcmYgcG5pIHBjbG11bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwg
dm14IGVzdCB0bTIgc3NzZTMgc2RiZyBmbWEgY3gxNiB4dHByIHBkY20gcGNpZCBzc2U0XzEgc3Nl
NF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBhdngg
ZjE2YyByZHJhbmQgbGFoZl9sbSBhYm0gM2Rub3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBlcGIgc3Ni
ZCBpYnJzIGlicGIgc3RpYnAgaWJyc19lbmhhbmNlZCB0cHJfc2hhZG93IGZsZXhwcmlvcml0eSBl
cHQgdnBpZCBlcHRfYWQgZnNnc2Jhc2UgdHNjX2FkanVzdCBzZ3ggYm1pMSBhdngyIHNtZXAgYm1p
MiBlcm1zIGludnBjaWQgbXB4IHJkc2VlZCBhZHggc21hcCBjbGZsdXNob3B0IGludGVsX3B0IHhz
YXZlb3B0IHhzYXZlYyB4Z2V0YnYxIHhzYXZlcyBkdGhlcm0gaWRhIGFyYXQgcGxuIHB0cyBod3Ag
aHdwX25vdGlmeSBod3BfYWN0X3dpbmRvdyBod3BfZXBwIHZubWkgcGt1IG9zcGtlIHNneF9sYyBt
ZF9jbGVhciBmbHVzaF9sMWQgYXJjaF9jYXBhYmlsaXRpZXMKdm14IGZsYWdzCTogdm5taSBwcmVl
bXB0aW9uX3RpbWVyIHBvc3RlZF9pbnRyIGludnZwaWQgZXB0X3hfb25seSBlcHRfYWQgZXB0XzFn
YiBmbGV4cHJpb3JpdHkgYXBpY3YgdHNjX29mZnNldCB2dHByIG10ZiB2YXBpYyBlcHQgdnBpZCB1
bnJlc3RyaWN0ZWRfZ3Vlc3QgdmFwaWNfcmVnIHZpZCBwbGUgc2hhZG93X3ZtY3MgcG1sIGVwdF9t
b2RlX2Jhc2VkX2V4ZWMKYnVncwkJOiBzcGVjdHJlX3YxIHNwZWN0cmVfdjIgc3BlY19zdG9yZV9i
eXBhc3Mgc3dhcGdzIGl0bGJfbXVsdGloaXQgc3JiZHMgbW1pb19zdGFsZV9kYXRhIHJldGJsZWVk
IGVpYnJzX3BicnNiIGdkcwpib2dvbWlwcwk6IDU3OTkuNzcKY2xmbHVzaCBzaXplCTogNjQKY2Fj
aGVfYWxpZ25tZW50CTogNjQKYWRkcmVzcyBzaXplcwk6IDM5IGJpdHMgcGh5c2ljYWwsIDQ4IGJp
dHMgdmlydHVhbApwb3dlciBtYW5hZ2VtZW50OgoKcHJvY2Vzc29yCTogMTEKdmVuZG9yX2lkCTog
R2VudWluZUludGVsCmNwdSBmYW1pbHkJOiA2Cm1vZGVsCQk6IDE2NQptb2RlbCBuYW1lCTogSW50
ZWwoUikgQ29yZShUTSkgaTctMTA3MDBGIENQVSBAIDIuOTBHSHoKc3RlcHBpbmcJOiA1Cm1pY3Jv
Y29kZQk6IDB4ZjgKY3B1IE1IegkJOiA4MDAuMjY0CmNhY2hlIHNpemUJOiAxNjM4NCBLQgpwaHlz
aWNhbCBpZAk6IDAKc2libGluZ3MJOiAxNgpjb3JlIGlkCQk6IDMKY3B1IGNvcmVzCTogOAphcGlj
aWQJCTogNwppbml0aWFsIGFwaWNpZAk6IDcKZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVz
CmNwdWlkIGxldmVsCTogMjIKd3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBt
c3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1
c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggcGRw
ZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFydCBhcmNoX3BlcmZtb24gcGVicyBidHMgcmVw
X2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgY3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNs
bXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXggZXN0IHRtMiBzc3NlMyBzZGJnIGZtYSBj
eDE2IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0XzIgeDJhcGljIG1vdmJlIHBvcGNudCB0c2Nf
ZGVhZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xtIGFibSAzZG5v
d3ByZWZldGNoIGNwdWlkX2ZhdWx0IGVwYiBzc2JkIGlicnMgaWJwYiBzdGlicCBpYnJzX2VuaGFu
Y2VkIHRwcl9zaGFkb3cgZmxleHByaW9yaXR5IGVwdCB2cGlkIGVwdF9hZCBmc2dzYmFzZSB0c2Nf
YWRqdXN0IHNneCBibWkxIGF2eDIgc21lcCBibWkyIGVybXMgaW52cGNpZCBtcHggcmRzZWVkIGFk
eCBzbWFwIGNsZmx1c2hvcHQgaW50ZWxfcHQgeHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVz
IGR0aGVybSBpZGEgYXJhdCBwbG4gcHRzIGh3cCBod3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93IGh3
cF9lcHAgdm5taSBwa3Ugb3Nwa2Ugc2d4X2xjIG1kX2NsZWFyIGZsdXNoX2wxZCBhcmNoX2NhcGFi
aWxpdGllcwp2bXggZmxhZ3MJOiB2bm1pIHByZWVtcHRpb25fdGltZXIgcG9zdGVkX2ludHIgaW52
dnBpZCBlcHRfeF9vbmx5IGVwdF9hZCBlcHRfMWdiIGZsZXhwcmlvcml0eSBhcGljdiB0c2Nfb2Zm
c2V0IHZ0cHIgbXRmIHZhcGljIGVwdCB2cGlkIHVucmVzdHJpY3RlZF9ndWVzdCB2YXBpY19yZWcg
dmlkIHBsZSBzaGFkb3dfdm1jcyBwbWwgZXB0X21vZGVfYmFzZWRfZXhlYwpidWdzCQk6IHNwZWN0
cmVfdjEgc3BlY3RyZV92MiBzcGVjX3N0b3JlX2J5cGFzcyBzd2FwZ3MgaXRsYl9tdWx0aWhpdCBz
cmJkcyBtbWlvX3N0YWxlX2RhdGEgcmV0YmxlZWQgZWlicnNfcGJyc2IgZ2RzCmJvZ29taXBzCTog
NTc5OS43NwpjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNzIHNp
emVzCTogMzkgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1lbnQ6
Cgpwcm9jZXNzb3IJOiAxMgp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYK
bW9kZWwJCTogMTY1Cm1vZGVsIG5hbWUJOiBJbnRlbChSKSBDb3JlKFRNKSBpNy0xMDcwMEYgQ1BV
IEAgMi45MEdIegpzdGVwcGluZwk6IDUKbWljcm9jb2RlCTogMHhmOApjcHUgTUh6CQk6IDgwMC4w
MjcKY2FjaGUgc2l6ZQk6IDE2Mzg0IEtCCnBoeXNpY2FsIGlkCTogMApzaWJsaW5ncwk6IDE2CmNv
cmUgaWQJCTogNApjcHUgY29yZXMJOiA4CmFwaWNpZAkJOiA5CmluaXRpYWwgYXBpY2lkCTogOQpm
cHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiAyMgp3cAkJOiB5ZXMK
ZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJy
IHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3Nl
MiBzcyBodCB0bSBwYmUgc3lzY2FsbCBueCBwZHBlMWdiIHJkdHNjcCBsbSBjb25zdGFudF90c2Mg
YXJ0IGFyY2hfcGVyZm1vbiBwZWJzIGJ0cyByZXBfZ29vZCBub3BsIHh0b3BvbG9neSBub25zdG9w
X3RzYyBjcHVpZCBhcGVyZm1wZXJmIHBuaSBwY2xtdWxxZHEgZHRlczY0IG1vbml0b3IgZHNfY3Bs
IHZteCBlc3QgdG0yIHNzc2UzIHNkYmcgZm1hIGN4MTYgeHRwciBwZGNtIHBjaWQgc3NlNF8xIHNz
ZTRfMiB4MmFwaWMgbW92YmUgcG9wY250IHRzY19kZWFkbGluZV90aW1lciBhZXMgeHNhdmUgYXZ4
IGYxNmMgcmRyYW5kIGxhaGZfbG0gYWJtIDNkbm93cHJlZmV0Y2ggY3B1aWRfZmF1bHQgZXBiIHNz
YmQgaWJycyBpYnBiIHN0aWJwIGlicnNfZW5oYW5jZWQgdHByX3NoYWRvdyBmbGV4cHJpb3JpdHkg
ZXB0IHZwaWQgZXB0X2FkIGZzZ3NiYXNlIHRzY19hZGp1c3Qgc2d4IGJtaTEgYXZ4MiBzbWVwIGJt
aTIgZXJtcyBpbnZwY2lkIG1weCByZHNlZWQgYWR4IHNtYXAgY2xmbHVzaG9wdCBpbnRlbF9wdCB4
c2F2ZW9wdCB4c2F2ZWMgeGdldGJ2MSB4c2F2ZXMgZHRoZXJtIGlkYSBhcmF0IHBsbiBwdHMgaHdw
IGh3cF9ub3RpZnkgaHdwX2FjdF93aW5kb3cgaHdwX2VwcCB2bm1pIHBrdSBvc3BrZSBzZ3hfbGMg
bWRfY2xlYXIgZmx1c2hfbDFkIGFyY2hfY2FwYWJpbGl0aWVzCnZteCBmbGFncwk6IHZubWkgcHJl
ZW1wdGlvbl90aW1lciBwb3N0ZWRfaW50ciBpbnZ2cGlkIGVwdF94X29ubHkgZXB0X2FkIGVwdF8x
Z2IgZmxleHByaW9yaXR5IGFwaWN2IHRzY19vZmZzZXQgdnRwciBtdGYgdmFwaWMgZXB0IHZwaWQg
dW5yZXN0cmljdGVkX2d1ZXN0IHZhcGljX3JlZyB2aWQgcGxlIHNoYWRvd192bWNzIHBtbCBlcHRf
bW9kZV9iYXNlZF9leGVjCmJ1Z3MJCTogc3BlY3RyZV92MSBzcGVjdHJlX3YyIHNwZWNfc3RvcmVf
YnlwYXNzIHN3YXBncyBpdGxiX211bHRpaGl0IHNyYmRzIG1taW9fc3RhbGVfZGF0YSByZXRibGVl
ZCBlaWJyc19wYnJzYiBnZHMKYm9nb21pcHMJOiA1Nzk5Ljc3CmNsZmx1c2ggc2l6ZQk6IDY0CmNh
Y2hlX2FsaWdubWVudAk6IDY0CmFkZHJlc3Mgc2l6ZXMJOiAzOSBiaXRzIHBoeXNpY2FsLCA0OCBi
aXRzIHZpcnR1YWwKcG93ZXIgbWFuYWdlbWVudDoKCnByb2Nlc3Nvcgk6IDEzCnZlbmRvcl9pZAk6
IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJOiAxNjUKbW9kZWwgbmFtZQk6IElu
dGVsKFIpIENvcmUoVE0pIGk3LTEwNzAwRiBDUFUgQCAyLjkwR0h6CnN0ZXBwaW5nCTogNQptaWNy
b2NvZGUJOiAweGY4CmNwdSBNSHoJCTogNzk5Ljk5OApjYWNoZSBzaXplCTogMTYzODQgS0IKcGh5
c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogMTYKY29yZSBpZAkJOiA1CmNwdSBjb3Jlcwk6IDgKYXBp
Y2lkCQk6IDExCmluaXRpYWwgYXBpY2lkCTogMTEKZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTog
eWVzCmNwdWlkIGxldmVsCTogMjIKd3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRz
YyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNs
Zmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbngg
cGRwZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFydCBhcmNoX3BlcmZtb24gcGVicyBidHMg
cmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgY3B1aWQgYXBlcmZtcGVyZiBwbmkg
cGNsbXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXggZXN0IHRtMiBzc3NlMyBzZGJnIGZt
YSBjeDE2IHh0cHIgcGRjbSBwY2lkIHNzZTRfMSBzc2U0XzIgeDJhcGljIG1vdmJlIHBvcGNudCB0
c2NfZGVhZGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xtIGFibSAz
ZG5vd3ByZWZldGNoIGNwdWlkX2ZhdWx0IGVwYiBzc2JkIGlicnMgaWJwYiBzdGlicCBpYnJzX2Vu
aGFuY2VkIHRwcl9zaGFkb3cgZmxleHByaW9yaXR5IGVwdCB2cGlkIGVwdF9hZCBmc2dzYmFzZSB0
c2NfYWRqdXN0IHNneCBibWkxIGF2eDIgc21lcCBibWkyIGVybXMgaW52cGNpZCBtcHggcmRzZWVk
IGFkeCBzbWFwIGNsZmx1c2hvcHQgaW50ZWxfcHQgeHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNh
dmVzIGR0aGVybSBpZGEgYXJhdCBwbG4gcHRzIGh3cCBod3Bfbm90aWZ5IGh3cF9hY3Rfd2luZG93
IGh3cF9lcHAgdm5taSBwa3Ugb3Nwa2Ugc2d4X2xjIG1kX2NsZWFyIGZsdXNoX2wxZCBhcmNoX2Nh
cGFiaWxpdGllcwp2bXggZmxhZ3MJOiB2bm1pIHByZWVtcHRpb25fdGltZXIgcG9zdGVkX2ludHIg
aW52dnBpZCBlcHRfeF9vbmx5IGVwdF9hZCBlcHRfMWdiIGZsZXhwcmlvcml0eSBhcGljdiB0c2Nf
b2Zmc2V0IHZ0cHIgbXRmIHZhcGljIGVwdCB2cGlkIHVucmVzdHJpY3RlZF9ndWVzdCB2YXBpY19y
ZWcgdmlkIHBsZSBzaGFkb3dfdm1jcyBwbWwgZXB0X21vZGVfYmFzZWRfZXhlYwpidWdzCQk6IHNw
ZWN0cmVfdjEgc3BlY3RyZV92MiBzcGVjX3N0b3JlX2J5cGFzcyBzd2FwZ3MgaXRsYl9tdWx0aWhp
dCBzcmJkcyBtbWlvX3N0YWxlX2RhdGEgcmV0YmxlZWQgZWlicnNfcGJyc2IgZ2RzCmJvZ29taXBz
CTogNTc5OS43NwpjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNz
IHNpemVzCTogMzkgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1l
bnQ6Cgpwcm9jZXNzb3IJOiAxNAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6
IDYKbW9kZWwJCTogMTY1Cm1vZGVsIG5hbWUJOiBJbnRlbChSKSBDb3JlKFRNKSBpNy0xMDcwMEYg
Q1BVIEAgMi45MEdIegpzdGVwcGluZwk6IDUKbWljcm9jb2RlCTogMHhmOApjcHUgTUh6CQk6IDc5
OS45OTAKY2FjaGUgc2l6ZQk6IDE2Mzg0IEtCCnBoeXNpY2FsIGlkCTogMApzaWJsaW5ncwk6IDE2
CmNvcmUgaWQJCTogNgpjcHUgY29yZXMJOiA4CmFwaWNpZAkJOiAxMwppbml0aWFsIGFwaWNpZAk6
IDEzCmZwdQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDIyCndwCQk6
IHllcwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2Vw
IG10cnIgcGdlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNz
ZSBzc2UyIHNzIGh0IHRtIHBiZSBzeXNjYWxsIG54IHBkcGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50
X3RzYyBhcnQgYXJjaF9wZXJmbW9uIHBlYnMgYnRzIHJlcF9nb29kIG5vcGwgeHRvcG9sb2d5IG5v
bnN0b3BfdHNjIGNwdWlkIGFwZXJmbXBlcmYgcG5pIHBjbG11bHFkcSBkdGVzNjQgbW9uaXRvciBk
c19jcGwgdm14IGVzdCB0bTIgc3NzZTMgc2RiZyBmbWEgY3gxNiB4dHByIHBkY20gcGNpZCBzc2U0
XzEgc3NlNF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2
ZSBhdnggZjE2YyByZHJhbmQgbGFoZl9sbSBhYm0gM2Rub3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBl
cGIgc3NiZCBpYnJzIGlicGIgc3RpYnAgaWJyc19lbmhhbmNlZCB0cHJfc2hhZG93IGZsZXhwcmlv
cml0eSBlcHQgdnBpZCBlcHRfYWQgZnNnc2Jhc2UgdHNjX2FkanVzdCBzZ3ggYm1pMSBhdngyIHNt
ZXAgYm1pMiBlcm1zIGludnBjaWQgbXB4IHJkc2VlZCBhZHggc21hcCBjbGZsdXNob3B0IGludGVs
X3B0IHhzYXZlb3B0IHhzYXZlYyB4Z2V0YnYxIHhzYXZlcyBkdGhlcm0gaWRhIGFyYXQgcGxuIHB0
cyBod3AgaHdwX25vdGlmeSBod3BfYWN0X3dpbmRvdyBod3BfZXBwIHZubWkgcGt1IG9zcGtlIHNn
eF9sYyBtZF9jbGVhciBmbHVzaF9sMWQgYXJjaF9jYXBhYmlsaXRpZXMKdm14IGZsYWdzCTogdm5t
aSBwcmVlbXB0aW9uX3RpbWVyIHBvc3RlZF9pbnRyIGludnZwaWQgZXB0X3hfb25seSBlcHRfYWQg
ZXB0XzFnYiBmbGV4cHJpb3JpdHkgYXBpY3YgdHNjX29mZnNldCB2dHByIG10ZiB2YXBpYyBlcHQg
dnBpZCB1bnJlc3RyaWN0ZWRfZ3Vlc3QgdmFwaWNfcmVnIHZpZCBwbGUgc2hhZG93X3ZtY3MgcG1s
IGVwdF9tb2RlX2Jhc2VkX2V4ZWMKYnVncwkJOiBzcGVjdHJlX3YxIHNwZWN0cmVfdjIgc3BlY19z
dG9yZV9ieXBhc3Mgc3dhcGdzIGl0bGJfbXVsdGloaXQgc3JiZHMgbW1pb19zdGFsZV9kYXRhIHJl
dGJsZWVkIGVpYnJzX3BicnNiIGdkcwpib2dvbWlwcwk6IDU3OTkuNzcKY2xmbHVzaCBzaXplCTog
NjQKY2FjaGVfYWxpZ25tZW50CTogNjQKYWRkcmVzcyBzaXplcwk6IDM5IGJpdHMgcGh5c2ljYWws
IDQ4IGJpdHMgdmlydHVhbApwb3dlciBtYW5hZ2VtZW50OgoKcHJvY2Vzc29yCTogMTUKdmVuZG9y
X2lkCTogR2VudWluZUludGVsCmNwdSBmYW1pbHkJOiA2Cm1vZGVsCQk6IDE2NQptb2RlbCBuYW1l
CTogSW50ZWwoUikgQ29yZShUTSkgaTctMTA3MDBGIENQVSBAIDIuOTBHSHoKc3RlcHBpbmcJOiA1
Cm1pY3JvY29kZQk6IDB4ZjgKY3B1IE1IegkJOiA4MDAuMDAyCmNhY2hlIHNpemUJOiAxNjM4NCBL
QgpwaHlzaWNhbCBpZAk6IDAKc2libGluZ3MJOiAxNgpjb3JlIGlkCQk6IDcKY3B1IGNvcmVzCTog
OAphcGljaWQJCTogMTUKaW5pdGlhbCBhcGljaWQJOiAxNQpmcHUJCTogeWVzCmZwdV9leGNlcHRp
b24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiAyMgp3cAkJOiB5ZXMKZmxhZ3MJCTogZnB1IHZtZSBkZSBw
c2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNl
MzYgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bSBwYmUgc3lzY2Fs
bCBueCBwZHBlMWdiIHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJ0IGFyY2hfcGVyZm1vbiBwZWJz
IGJ0cyByZXBfZ29vZCBub3BsIHh0b3BvbG9neSBub25zdG9wX3RzYyBjcHVpZCBhcGVyZm1wZXJm
IHBuaSBwY2xtdWxxZHEgZHRlczY0IG1vbml0b3IgZHNfY3BsIHZteCBlc3QgdG0yIHNzc2UzIHNk
YmcgZm1hIGN4MTYgeHRwciBwZGNtIHBjaWQgc3NlNF8xIHNzZTRfMiB4MmFwaWMgbW92YmUgcG9w
Y250IHRzY19kZWFkbGluZV90aW1lciBhZXMgeHNhdmUgYXZ4IGYxNmMgcmRyYW5kIGxhaGZfbG0g
YWJtIDNkbm93cHJlZmV0Y2ggY3B1aWRfZmF1bHQgZXBiIHNzYmQgaWJycyBpYnBiIHN0aWJwIGli
cnNfZW5oYW5jZWQgdHByX3NoYWRvdyBmbGV4cHJpb3JpdHkgZXB0IHZwaWQgZXB0X2FkIGZzZ3Ni
YXNlIHRzY19hZGp1c3Qgc2d4IGJtaTEgYXZ4MiBzbWVwIGJtaTIgZXJtcyBpbnZwY2lkIG1weCBy
ZHNlZWQgYWR4IHNtYXAgY2xmbHVzaG9wdCBpbnRlbF9wdCB4c2F2ZW9wdCB4c2F2ZWMgeGdldGJ2
MSB4c2F2ZXMgZHRoZXJtIGlkYSBhcmF0IHBsbiBwdHMgaHdwIGh3cF9ub3RpZnkgaHdwX2FjdF93
aW5kb3cgaHdwX2VwcCB2bm1pIHBrdSBvc3BrZSBzZ3hfbGMgbWRfY2xlYXIgZmx1c2hfbDFkIGFy
Y2hfY2FwYWJpbGl0aWVzCnZteCBmbGFncwk6IHZubWkgcHJlZW1wdGlvbl90aW1lciBwb3N0ZWRf
aW50ciBpbnZ2cGlkIGVwdF94X29ubHkgZXB0X2FkIGVwdF8xZ2IgZmxleHByaW9yaXR5IGFwaWN2
IHRzY19vZmZzZXQgdnRwciBtdGYgdmFwaWMgZXB0IHZwaWQgdW5yZXN0cmljdGVkX2d1ZXN0IHZh
cGljX3JlZyB2aWQgcGxlIHNoYWRvd192bWNzIHBtbCBlcHRfbW9kZV9iYXNlZF9leGVjCmJ1Z3MJ
CTogc3BlY3RyZV92MSBzcGVjdHJlX3YyIHNwZWNfc3RvcmVfYnlwYXNzIHN3YXBncyBpdGxiX211
bHRpaGl0IHNyYmRzIG1taW9fc3RhbGVfZGF0YSByZXRibGVlZCBlaWJyc19wYnJzYiBnZHMKYm9n
b21pcHMJOiA1Nzk5Ljc3CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2FsaWdubWVudAk6IDY0CmFk
ZHJlc3Mgc2l6ZXMJOiAzOSBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1YWwKcG93ZXIgbWFu
YWdlbWVudDoKCg==
--0000000000009026a806138dbef9--

