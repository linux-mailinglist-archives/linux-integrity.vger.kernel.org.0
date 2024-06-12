Return-Path: <linux-integrity+bounces-2855-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231790482F
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2024 03:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5FFB20F0E
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2024 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6803A21;
	Wed, 12 Jun 2024 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KXM7ZUOG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4E15C9
	for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2024 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718154854; cv=none; b=gn+CToX9wJQvKPqoRkN4sYPOSeYThXZiusCHHpRwyc6a2H5ZlgZhLVjK/l0LgqyIRz1wivuWDLL8g7Ft6nIjvHn2OjFRjOnY18i4IGr133TAgmHmzc8Xx8W1jGb4qarnV/Ws/5KbLiHif41i8nFh6YC1RLItFyHPpdIWblvmwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718154854; c=relaxed/simple;
	bh=IikKDHkoHWntmqY/dLBV8XUv+R26hd+jl1ntJJKqZAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb+/FWWDU2BGJ4w1tCdbItu+3SyLyfE8Fu9QxJ0NP5WwqtoqAA5eGc6QE/SDyRntY8GIFa1JQFX5T7rOc4qmM9AssGKGVQ/+rSk4Ebit5qjqo6y3rkzRJfd3g9b1cdR+hplrTaKuSHrHj56TG7jUXkmGlR3xku499rYfDxL5+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KXM7ZUOG; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2c2f6b47621so332703a91.1
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2024 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718154852; x=1718759652; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RixUhrZoJxC5ZGEX/bQjHSbR4r7wmqVUu8WN9NYTkWY=;
        b=KXM7ZUOG8a8gVe+FyG7ibVMqzsUrn43jkBGn5Vj9+KaGNmYWs+mVZuR7NBrhy0QS1w
         TjW+b16h3RIz4h+E7Bmn2Fqxwf0EdJZrXCAUUszgANIXXmIMbnFO8WQyheBu6M1jIE+F
         Qe5ostjELugrgAI7399FwQijHQILsuJLQiQDNmB07TgCcvyTJa0wUQCHLcUD1/8JY04W
         p9txzwZDbOy0xsTZnXU3GxckYJt8+YqqmlczJt6xlgWzYxFxu2ERdhOM5UYHbZM9gaNu
         8xbkph2EZMp1o0PbXcIuCbHuQHnawACWgKbijGAJqpfwR0Xo72v96qlQQr/YNT4iX3Ry
         dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718154852; x=1718759652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RixUhrZoJxC5ZGEX/bQjHSbR4r7wmqVUu8WN9NYTkWY=;
        b=Y4mcQzthB/C50PJeupzhqdH2eIwCKctZB6e4bGZRNk6Xe9qNzDOMdyRom/bpKT+NNo
         mCT08WFWzS71YaW7nJnVx0lWquUb9wHhXz2KvTNjGgsE8wOIjZMtLCEYKaKuGJc1eS+r
         0H636S4PBtprfTSGf+CFCiq0pYNNYxSdyTTeIAJaO79ocyXn1H16Lr4scF0nkvsOqMxY
         JBJMUEHJvrWcaqraSy2NVtb9jcd6f8son+SVmFycErAJUIQkGngMYj2ZcyaJF/QQiFEc
         1i54yS4fhv6p+/+HGi47EBlJq1vstPOYHtlzZR+0SoFFcCvEBq2zteKXq+1tsPBS1xwG
         NpMw==
X-Forwarded-Encrypted: i=1; AJvYcCU8lfpeSSoVLzZvu/2Qq/Aabq5CMHMo8LSnlWTi9QJn5DXYRW6XXZbHNeFaqXcrIHRJ5kZEzlAyDKEVHiMNY8xlCW9UKBvWQn3wZn4u+O5N
X-Gm-Message-State: AOJu0Yy5YJcO9MAGmylnby7obo2rvjjPFBWCdYjeD/uI8FYWQqTo3PxU
	FvKwGukX+RT+C/iEUSM5x0U9Cqsmc1crAlR2VCW1P4//diaojqXFk8gSgXziMfU=
X-Google-Smtp-Source: AGHT+IGF51D4VT4G+qj5isutxZ0m3CIQ8ZVOQw0Bg96UP6NMuvy7PKS/jrM6h3+XPzYshYm0pRw4Ow==
X-Received: by 2002:a17:90a:5b15:b0:2c2:264a:a021 with SMTP id 98e67ed59e1d1-2c32b4894f4mr5761692a91.10.1718154852182;
        Tue, 11 Jun 2024 18:14:12 -0700 (PDT)
Received: from nuoska ([2405:6580:800:9800:b841:9d1f:6a68:11b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a76aa11fsm272362a91.47.2024.06.11.18.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 18:14:11 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:14:02 +0900
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Manuel Traut <manut@mecka.net>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <Zmj2Wg_YqdebN3xO@nuoska>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
 <Zl2Ibey9Qck-VLWE@manut.de>
 <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com>
 <Zme-NMa3Bvp2h7aL@nuoska>
 <CAFA6WYPYSfrDtnLPRs7_0h5Hf01oPfOpqmt4c7_Twxv-re87xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA6WYPYSfrDtnLPRs7_0h5Hf01oPfOpqmt4c7_Twxv-re87xQ@mail.gmail.com>

Hi,

Adding TPM maintainers and linux-integrity since discussion relates to firmware TPM
driver tpm_ftpm_tee

On Tue, Jun 11, 2024 at 04:13:21PM +0530, Sumit Garg wrote:
> On Tue, 11 Jun 2024 at 08:32, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> >
> > Hi,
> >
> > On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> > > Hi Manuel,
> > >
> > > On Mon, Jun 3, 2024 at 11:10 AM Manuel Traut <manut@mecka.net> wrote:
> > > >
> > > > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > @@ -7,6 +7,7 @@
> > > > >
> > > > >  #include <linux/arm_ffa.h>
> > > > >  #include <linux/errno.h>
> > > > > +#include <linux/rpmb.h>
> > > > >  #include <linux/scatterlist.h>
> > > > >  #include <linux/sched.h>
> > > > >  #include <linux/slab.h>
> > > > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > > >       optee->ffa.bottom_half_value = U32_MAX;
> > > > >       optee->rpc_param_count = rpc_param_count;
> > > > >
> > > > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > > > +             optee->in_kernel_rpmb_routing = true;
> > > >
> > > > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the moment.
> > > > If I remove this check here, the series works for me.
> > >
> > > You're right, I missed pushing those flags to optee_os. I've pushed them now.
> >
> > Thanks! Tested with optee 4.1 and your patches from
> > https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
> > in Trusted Substrate uefi firmware
> > ( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
> > and this series and a bunch of dependencies backported to
> > our Trusted Reference Stack
> > ( https://trs.readthedocs.io/en/latest/ )
> > 6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
> > the optee side fTPM TA device used to create an encrypted rootfs with
> > systemd. Kernel side RPMB routing is in use and works for the TPM use cases.
> >
> 
> Glad to see that you can get fTPM to work without tee-supplicant after
> this patch-set.

Sorry but the fTPM TA only works with tee-supplicant in userspace. It's needed
for RPC setup. For RPMB it is not needed or used with these patches applied.

> > Full boot and test log (with unrelated test failures)
> > https://ledge.validation.linaro.org/scheduler/job/88692
> >
> > root@trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
> > ...
> > kernel
> 
> So coming back to the real question, do we really need this new
> rpmb_routing_model ABI? Did systemd still need it with no
> tee-supplicant dependency? IMHO, a user-space ABI requires use-case
> justification otherwise it's just going to add on maintenance burden.

Currently it is not needed, because tee-supplicant is still required to
setup RPC with fTPM. If the RPC setup were also done in kernel directly and
tee-supplicant need is removed, then this kind of ABI is important so that
userspace init knows if it needs to queue startup of tee-supplicant or not.

On a related note, the kernel tpm_ftpm_tee driver for fTPM TA really has
a hard dependency to tee-supplicant in userspace. If tee-supplicant is stopped,
restarted etc without unloading the kernel module (or otherwise disabling the TPM device),
then all TPM device actions done without tee-supplicant running will fail ane keep
failing until next reboot. The kernel driver is not crashing but all functionality
breaks.

The availability of tpm_ftpm_tee should be tied much harder to the tee-supplicant
running in userspace, e.g. optee should be in charge to start and bring tpm_ftpm_tee down
based on tee-supplicant userspace daemon availability. Or the needed tee-supplicant code
should be moved to kernel side. Currently systemd side init scripts have issues switching
from initrd to main rootfs since they need to disable tpm_ftpm_tee driver, built in or a module,
before shutting down tee-supplicant. A suspend or other inactive state in the ftpm driver
needs to be triggered, which AFAIK is not currently possible, at least from userspace
(I'd happy be proven wrong here).

An alternative for tpm_fptm_tee driver is to use optee APIs so that the calls
wait for tee-supplicant in userspace if needed:

--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -237,6 +237,9 @@ static int ftpm_tee_probe(struct device *dev)
                return PTR_ERR(pvt_data->ctx);
        }
 
+       /* wait for tee-supplicant in userspace, fTPM TA really depends on it */
+       pvt_data->ctx->supp_nowait = false;
+
        /* Open a session with fTPM TA */
        memset(&sess_arg, 0, sizeof(sess_arg));
        export_uuid(sess_arg.uuid, &ftpm_ta_uuid);

This works pretty well for the tee-supplicant initrd to main rootfs switch but currently
breaks for example reboot (just hangs), and Jens doesn't approve of this as a
real solution.

So as an alternative, userspace needs to be very careful in initrd and rootfs
to start tee-supplicant earlier than loading tpm_ftpm_tee driver which can
only be supported as module and removed before shutting down tee-supplicant.
In other use cases, TPM drivers are only supported if driver is built into
the kernel (or ACPI table entry for a TPM device exists) which I'm trying
to change with

[PATCH] efi: expose TPM event log to userspace via sysfs

https://lore.kernel.org/lkml/20240422112711.362779-1-mikko.rapeli@linaro.org/

where userspace init can check if it should wait longer for the tpm device to appear,
e.g. let udev load optee etc drivers which eventually start also tee-supplicant and
thus load tpm_ftpm_tee driver (fTPM TA enumration is tied to tee-supplicant in userspace
https://git.yoctoproject.org/meta-arm/tree/meta-arm/recipes-security/optee-ftpm/optee-ftpm/0001-add-enum-to-ta-flags.patch )

Cheers,

-Mikko

