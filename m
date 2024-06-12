Return-Path: <linux-integrity+bounces-2856-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D41904C08
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2024 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2761F22997
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2024 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615816C457;
	Wed, 12 Jun 2024 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHMb1Jq7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC11649BE
	for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175383; cv=none; b=bKe8GQUHu2aZ6Yll/59E79BDR4A1vYy5IQlz5kKHhFdF6z7z7sFnJ/z72gib9lNN6KqrWU4XKYz5V8EPvF44Sv9iBEytJbW2gvuLeJ85fmm1felhbgE8jDA0bTwB3HQyYMjr/L4VO4J1Gk6dVD4n/arpsOZ/JBQBKuUPnyfwNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175383; c=relaxed/simple;
	bh=2Ua0nGG0EAK9OtUoDrHzQ2WSgUsgITqxokxmviplgzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIsZaYJfPTYCszGvhoLq2Ka3Xh3V+fPjVKdDvR6ybKmW1Io3WwjD4X0W1WQ6qvvtnQacqZiN7mzP0LuaMInm5KhLWRl3z9l2+fX4rawVMdNHuQIODVGQHHkTmlHyvchnh8bIgbDhAivoigPhZW/96+cFCKVbM1CQJ4R/idHx37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHMb1Jq7; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-254c22faf4cso1323783fac.2
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2024 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718175379; x=1718780179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz+vtmXVQrksH83NPuXPvwENKWM7qR/JOFyTm8EoID8=;
        b=oHMb1Jq7aW9IwmNtGLrM2cJX4GuzcjcqGFY6Mlna/5GK3cEO8Nl09PIP5d7dMhB7zG
         o68aTn/xLA+N4oSR9tVXTdSJ9Or3RV+oPRGRFzPontSGGETXeUUGG1YOVN7cJ/wPjl2K
         mO04zHn8oGfdo0reRRfY/cPoOunkgLOZoS0gVwmwD90yYx+lKrWRYZHuQH2RsQ6A9ULd
         ObqmnM935LT/g1m9yEKxMqsl66f8XCrBfh4Ivvws0M0dXfGiLf/oAutdTQedKsGuswkI
         seRBYangONDG3UhTWsNGSGDXPqilyr3JBnnefHXq6d+Vv1WCgD45EilePQoIhsKiGxPQ
         XE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175379; x=1718780179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz+vtmXVQrksH83NPuXPvwENKWM7qR/JOFyTm8EoID8=;
        b=mzMy68Rx+vm4OnWVj635R4NUhYtE+/RIhiTohe3x92ppl7VjUByjVZW9wn9AA6UtzP
         BWYX9+o9lc/orIxzpJqpcj2Xhy4C7+1EPK4jQjXbXAOAPLfWSwFzkXGXDKXkSNzPv8xp
         FSIY0EmPDa0wyJR3uu0j337F1LG8484e61NMLpVCUzNXAq/DbNmN+Fjg+A5/xVSks06T
         nLZhEvE1meTgjMqoY8syYHGHgAZJV94pjL7QCFByHp76T/qo969lG1FumZtA5QSvakmq
         mO+4gLHDmqvMxA+QB1cfpLsIn7UOo4g1uKCNlTH9aHnEq5iXDXZwSZ83MdGzVR/D2NmX
         535A==
X-Forwarded-Encrypted: i=1; AJvYcCXd5vhIUHO/nI/l9vZv2J1687zCVnGzk0HjmS3j8RZPAPUHMWPWcmv113ze/KuQay/ENt5BleOSDU43sIoSLnyEDlF2o9v6jQKXdIpWXR8m
X-Gm-Message-State: AOJu0YzV2hSN1l8LDj+WoMExfGUX7k9kMcEu6WgNlBrTOGVSlV/ZijXS
	WXAqtOEjrnEQHHBsPdwJE9NBxKTV+Z/3V9Sblj7x784m0Bi0G6U9bACGoEWN9+ujTy53oYVXgBX
	W0CAmlZohK2wpl7bfgVczOZtaXndHHOyinHsvMA==
X-Google-Smtp-Source: AGHT+IHEbPnS3vGWtKgLg5y/Xl1GQNVn/cBKHYQZbPYu2bxiWaoRaiZv7DNixRQUCHror/nc1b+hktM0NXzAqzsf+kE=
X-Received: by 2002:a05:6870:ce88:b0:24f:e09d:3c83 with SMTP id
 586e51a60fabf-25514e367d7mr1089220fac.36.1718175379100; Tue, 11 Jun 2024
 23:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <Zl2Ibey9Qck-VLWE@manut.de>
 <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com>
 <Zme-NMa3Bvp2h7aL@nuoska> <CAFA6WYPYSfrDtnLPRs7_0h5Hf01oPfOpqmt4c7_Twxv-re87xQ@mail.gmail.com>
 <Zmj2Wg_YqdebN3xO@nuoska>
In-Reply-To: <Zmj2Wg_YqdebN3xO@nuoska>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 12 Jun 2024 08:56:07 +0200
Message-ID: <CAHUa44FP_eN+S4QBWJWmZ6PLptYg1+9iackz9P4Q1_Yc5EK3tQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, Manuel Traut <manut@mecka.net>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:14=E2=80=AFAM Mikko Rapeli <mikko.rapeli@linaro.o=
rg> wrote:
>
> Hi,
>
> Adding TPM maintainers and linux-integrity since discussion relates to fi=
rmware TPM
> driver tpm_ftpm_tee
>
> On Tue, Jun 11, 2024 at 04:13:21PM +0530, Sumit Garg wrote:
> > On Tue, 11 Jun 2024 at 08:32, Mikko Rapeli <mikko.rapeli@linaro.org> wr=
ote:
> > >
> > > Hi,
> > >
> > > On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> > > > Hi Manuel,
> > > >
> > > > On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.n=
et> wrote:
> > > > >
> > > > > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >
> > > > > >  #include <linux/arm_ffa.h>
> > > > > >  #include <linux/errno.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/scatterlist.h>
> > > > > >  #include <linux/sched.h>
> > > > > >  #include <linux/slab.h>
> > > > > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_devi=
ce *ffa_dev)
> > > > > >       optee->ffa.bottom_half_value =3D U32_MAX;
> > > > > >       optee->rpc_param_count =3D rpc_param_count;
> > > > > >
> > > > > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > > > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > > > > +             optee->in_kernel_rpmb_routing =3D true;
> > > > >
> > > > > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at th=
e moment.
> > > > > If I remove this check here, the series works for me.
> > > >
> > > > You're right, I missed pushing those flags to optee_os. I've pushed=
 them now.
> > >
> > > Thanks! Tested with optee 4.1 and your patches from
> > > https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
> > > in Trusted Substrate uefi firmware
> > > ( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
> > > and this series and a bunch of dependencies backported to
> > > our Trusted Reference Stack
> > > ( https://trs.readthedocs.io/en/latest/ )
> > > 6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
> > > the optee side fTPM TA device used to create an encrypted rootfs with
> > > systemd. Kernel side RPMB routing is in use and works for the TPM use=
 cases.
> > >
> >
> > Glad to see that you can get fTPM to work without tee-supplicant after
> > this patch-set.
>
> Sorry but the fTPM TA only works with tee-supplicant in userspace. It's n=
eeded
> for RPC setup. For RPMB it is not needed or used with these patches appli=
ed.

I've never been able to find out what fTPM is trying to do with
tee-supplicant at this stage. I guess the RPC is a shared memory
allocation preparing for another request.

>
> > > Full boot and test log (with unrelated test failures)
> > > https://ledge.validation.linaro.org/scheduler/job/88692
> > >
> > > root@trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
> > > ...
> > > kernel
> >
> > So coming back to the real question, do we really need this new
> > rpmb_routing_model ABI? Did systemd still need it with no
> > tee-supplicant dependency? IMHO, a user-space ABI requires use-case
> > justification otherwise it's just going to add on maintenance burden.
>
> Currently it is not needed, because tee-supplicant is still required to
> setup RPC with fTPM. If the RPC setup were also done in kernel directly a=
nd
> tee-supplicant need is removed, then this kind of ABI is important so tha=
t
> userspace init knows if it needs to queue startup of tee-supplicant or no=
t.
>
> On a related note, the kernel tpm_ftpm_tee driver for fTPM TA really has
> a hard dependency to tee-supplicant in userspace. If tee-supplicant is st=
opped,
> restarted etc without unloading the kernel module (or otherwise disabling=
 the TPM device),
> then all TPM device actions done without tee-supplicant running will fail=
 ane keep
> failing until next reboot. The kernel driver is not crashing but all func=
tionality
> breaks.
>
> The availability of tpm_ftpm_tee should be tied much harder to the tee-su=
pplicant
> running in userspace, e.g. optee should be in charge to start and bring t=
pm_ftpm_tee down
> based on tee-supplicant userspace daemon availability. Or the needed tee-=
supplicant code
> should be moved to kernel side. Currently systemd side init scripts have =
issues switching
> from initrd to main rootfs since they need to disable tpm_ftpm_tee driver=
, built in or a module,
> before shutting down tee-supplicant. A suspend or other inactive state in=
 the ftpm driver
> needs to be triggered, which AFAIK is not currently possible, at least fr=
om userspace
> (I'd happy be proven wrong here).
>
> An alternative for tpm_fptm_tee driver is to use optee APIs so that the c=
alls
> wait for tee-supplicant in userspace if needed:
>
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -237,6 +237,9 @@ static int ftpm_tee_probe(struct device *dev)
>                 return PTR_ERR(pvt_data->ctx);
>         }
>
> +       /* wait for tee-supplicant in userspace, fTPM TA really depends o=
n it */
> +       pvt_data->ctx->supp_nowait =3D false;
> +
>         /* Open a session with fTPM TA */
>         memset(&sess_arg, 0, sizeof(sess_arg));
>         export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
>
> This works pretty well for the tee-supplicant initrd to main rootfs switc=
h but currently
> breaks for example reboot (just hangs), and Jens doesn't approve of this =
as a
> real solution.

Yes, the hang part is my main concern.

>
> So as an alternative, userspace needs to be very careful in initrd and ro=
otfs
> to start tee-supplicant earlier than loading tpm_ftpm_tee driver which ca=
n
> only be supported as module and removed before shutting down tee-supplica=
nt.

Unbind/bind via sysfs might be an option. But that's still only a
workaround since getting rid of the tee-supplicant dependency in
initrd should avoid the problem entirely.

Cheers,
Jens

> In other use cases, TPM drivers are only supported if driver is built int=
o
> the kernel (or ACPI table entry for a TPM device exists) which I'm trying
> to change with
>
> [PATCH] efi: expose TPM event log to userspace via sysfs
>
> https://lore.kernel.org/lkml/20240422112711.362779-1-mikko.rapeli@linaro.=
org/
>
> where userspace init can check if it should wait longer for the tpm devic=
e to appear,
> e.g. let udev load optee etc drivers which eventually start also tee-supp=
licant and
> thus load tpm_ftpm_tee driver (fTPM TA enumration is tied to tee-supplica=
nt in userspace
> https://git.yoctoproject.org/meta-arm/tree/meta-arm/recipes-security/opte=
e-ftpm/optee-ftpm/0001-add-enum-to-ta-flags.patch )
>
> Cheers,
>
> -Mikko

