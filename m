Return-Path: <linux-integrity+bounces-2204-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298518AD082
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Apr 2024 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD151C224AF
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Apr 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B37153503;
	Mon, 22 Apr 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rv/fe9Jv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8711534E4
	for <linux-integrity@vger.kernel.org>; Mon, 22 Apr 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799363; cv=none; b=mhyh4BuFiBAjj5a7mHZgb8yiMfiM4zsKeBy+suWjD43JyDly0Vh3W4AoYHNZnlbuJZ106O4MtEDKG1Lok1t+yyVi8WAp0muic72VxSbtlyWUffDfXhrtEldyBAgVL1y/2hSCD1mGI/h6+CZae1puC8qYf05YX9pEeUvfZB7jK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799363; c=relaxed/simple;
	bh=Ci2yuDBlgoa8ozNJQ5jJq2jE33en1qoK9mqBxDfTgV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QB0GrDMb5Whwi+hR2OLPM5LkxDwt88Ai5sH2L7PlyAIUZ9FTDKSnYeApFACYeAi011cTjGjT1SIA2eMtIwQ8NEzqexO8fVnhm2vd5UCsOG0eQ5CWhfTcnjEC2PVJM1cEuwlkxSwNFa3yARZ+qiR87aaxY2Y9qcSGjjWzKbEhkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rv/fe9Jv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a55911bff66so323789266b.0
        for <linux-integrity@vger.kernel.org>; Mon, 22 Apr 2024 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713799360; x=1714404160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U1Ry9k3u4r/ZH6YfxckAiW911VK5SE+gAAnPQnrkQA8=;
        b=Rv/fe9Jv6vm4YT8PeA+StwjzA8/uv4dfyooe3dihDRDxbvy1w373RmCh5LXT6upceI
         a6jzh/+w5wNSeiWM0C85ate9+nMDNJUiBY4YLqo3ezNYjIui0zgiNGPwAcnTrnqZzG4R
         TRH2MOYl/9IED5Mhll1lE7KMhBS8yLr6qcms+OQMD8Jm0TeaC3hPOphmp6V9+k1K9Zyy
         pwVicE0WuQrr5FAy/rDgGEOfC57Ee+eCHqLMBhOZkEs1v26oklsT2Nb3DRIkygt+b8gl
         i/pT3hy9k1w1GC5WuApJsOUiDJo8TZt8GfNkwci/vhqo9FgOh9AtDi5KyRVnCc+w1XO5
         29Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799360; x=1714404160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1Ry9k3u4r/ZH6YfxckAiW911VK5SE+gAAnPQnrkQA8=;
        b=RB+IJ6nozlZ8kBLXdWMeou4kNQAZa1Ms7tZEVdBAbiBfRk5CL+LkaHGQuPszdf74Fd
         Su4Zg6ZuaAWFFxmynnxJpLpxccVWZkXPfoiibz+RVhLuUEt9J+E6z5n/WDEXMrE7zLBb
         Nas0F6J9O8pQlaUHHxGzEJJ1glkis/wvlOS+JclF+/HdKXPpyWLQURuPrw0SozWBkzwA
         Y7SG37Ie3BoCwwDhp6plPaVB1cLmIUTTB9hMr+KvtsE+Iuba/bSfB3OOl2y7EUFMuP1y
         kcDyolLeQO8vJzS0uWiNAt64xrjjYgO5l86jzw8D+lS/hkkM9PCgoIBENSGASGHwx16S
         p4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6cTim3AaP/34zDY3DwzNOWgAeVze9HSZe1FnSKQKiPZNiyCtX2rKjENKdi/5rSHMnnCSpOnNtGCXzJY3kCl0iUDIXAaXNkV0W7wyqpDT+
X-Gm-Message-State: AOJu0YyQVKni6aY2YVBYpSrTxf1pjfZTc2nsUAppb/wYPkLjorp8XdQK
	sG9TKJeaxhQ8szcAIMedyrSyZuoU0qgYftavZ2LY8P+VZb1/TiFzBPh5obVe04ZS9WRywcmV3Eb
	n+rf0jVAb77Nf0I5Mb1dz3Z7d50e1C6tc1TXgqQ==
X-Google-Smtp-Source: AGHT+IF7tlD0zygVG9NWdr4X2DqIV3+l7wtVQTW7JN1Fu86rCV2xydnxXx4bO+KERuw/RRypbzRNGaCUDPBeYj269Ho=
X-Received: by 2002:a17:906:f74b:b0:a58:7470:21f3 with SMTP id
 jp11-20020a170906f74b00b00a58747021f3mr183241ejb.28.1713799359973; Mon, 22
 Apr 2024 08:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska> <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com> <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
In-Reply-To: <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Apr 2024 18:22:03 +0300
Message-ID: <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 17:31, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2024-04-22 at 16:54 +0300, Ilias Apalodimas wrote:
> > Hi James
> >
> > On Mon, 22 Apr 2024 at 16:38, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Mon, 2024-04-22 at 16:32 +0300, Ilias Apalodimas wrote:
> > > > Hi all,
> > > >
> > > > On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli
> > > > <mikko.rapeli@linaro.org>
> > > > wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley
> > > > > wrote:
> > > > > > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > > > > > Userspace needs to know if TPM kernel drivers need to be
> > > > > > > loaded and related services started early in the boot if
> > > > > > > TPM device is used and available.
> > > > > >
> > > > > > This says what but not why.  We already have module
> > > > > > autoloading that works correctly for TPM devices, so why is
> > > > > > this needed?
> > > > > >
> > > > > > We do have a chicken and egg problem with IMA in that the TPM
> > > > > > driver needs to be present *before* any filesystem, including
> > > > > > the one the TPM modules would be on, is mounted so executions
> > > > > > can be measured into IMA (meaning that if you use IMA the TPM
> > > > > > drivers must be built in) but this sounds to be something
> > > > > > different. However, because of the IMA problem, most
> > > > > > distributions don't end up compiling TPM drivers as modules
> > > > > > anyway.
> > > > > >
> > > > > > Is what you want simply that tpm modules be loaded earlier?
> > > > >
> > > > > Yes, ealier is the problem. In my specific testing case the
> > > > > machine is qemu arm64 with swtpm with EFI firmware for secure
> > > > > boot and TPM support.
> > > > >
> > > > > Firmware uses TPM and does measurements and thus TPM event log
> > > > > is
> > > > > available on this machine and a bunch of other arm64 boards.
> > > > > Visible in early boot dmesg as TPMEventLog lines like:
> > > > >
> > > > > [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040
> > > > > RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040
> > > > > INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
> > > > >
> > > > > Different boards use different TPM HW and drivers so compiling
> > > > > all these in is possible but a bit ugly. systemd recently
> > > > > gained support for a specific tpm2.target which makes TPM
> > > > > support modular and also works with kernel modules for some TPM
> > > > > use cases but not rootfs encryption.
> > > > >
> > > > > In my test case we have a kernel+initramfs uki binary which is
> > > > > loaded by EFI firmware as a secure boot binary. TPM support on
> > > > > various boards is visible in devicetree but not as ACPI table
> > > > > entries. systemd currently detect TPM2 support either via ACPI
> > > > > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via
> > > > > firmware measurement via
> > > > > /sys/kernel/security/tpm0/binary_bios_measurements
> > > > > .
> > > >
> > > > One corner case worth noting here is that scanning the device
> > > > tree won't always work for non-ACPI systems... The reason is that
> > > > a firmware TPM (running in OP-TEE) might or might not have a DT
> > > > entry, since OP-TEE can discover the device dynamically and
> > > > doesn't always rely on a DT entry.
> > > >
> > > > I don't particularly love the idea that an EventLog existence
> > > > automatically means a TPM will be there, but it seems that
> > > > systemd already relies on that and it does solve the problem we
> > > > have.
> > >
> > > Well, quite. That's why the question I was interested in, perhaps
> > > not asked as clearly as it could be is: since all the TPM devices
> > > rely on discovery mechanisms like ACPI or DT or the like which are
> > > ready quite early, should we simply be auto loading the TPM drivers
> > > earlier?
> >
> > This would be an elegant way to solve this and on top of that, we
> > have a single discovery mechanism from userspace -- e.g ls /dev/tpmX.
> > But to answer that we need more feedback from systemd. What 'earlier'
> > means? Autload it from the kernel before we go into launching the
> > initrd?
>
> Right, so this is another timing problem: we can't autoload modules
> *before* they appear in the filesystem and presumably they're on the
> initrd, so auto loading must be post initrd mount (and init execution)
> but otherwise quite early?

Exactly. But is that enough?

>
> This might be quite a bit of work.  Logically, just moving the matching
> and loading code earlier might work, but we used to have a
> load_default_modules() at the end of init/main.c and it got removed
> (because it only eventually loaded elevator modules) everything is now
> loaded in it's various init routines, so to get, say, TPM ACPI modules
> loaded earlier, we'd have to run the ACPI device matching code earlier
> and so on for every other subsystem ...

Being the devil's advocate here and as I stated I don't love this but ...
The kernel isn't technically doing anything wrong. We just expose an
*existing* EFI config table. The kernel also exposes filesystems so
people are free to do rm -rf *.
The fact that applications might use it as a means of "oh there's
probably a TPM" shouldn't be the end of the world. On top of that,
since it's an EFI config table we can keep it around and never break
any ABIs we create to userspace. If in the future we find a better
way, userspace can use that?

So perhaps this is ok as long as make sure we understand why systemd
needs it that early?

Thanks
/Ilias
>
> James
>

