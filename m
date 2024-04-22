Return-Path: <linux-integrity+bounces-2200-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E113B8AD004
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Apr 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AB11C2166A
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Apr 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671F152199;
	Mon, 22 Apr 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVUZcvki"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DB1514FC
	for <linux-integrity@vger.kernel.org>; Mon, 22 Apr 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797868; cv=none; b=YVjJMbovMODpetPsynf6QH0kDlaWZprmDVgBHNHtDiwaGQ5F3r5p5i1v916nYY6PjpOkaYNorVvdg1Gty1EGgCPuRET0NOs/rqv7NLO065d9Z9F+/CJ8C1yyd61QksFPC/2kNyLa5+g9dfmHM9pJkAfeGqO93Orn31jwhS4EJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797868; c=relaxed/simple;
	bh=3QukAxF9x8keggcmZ5JAuzjKsHOe0olr9mzjfn/llzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fczwntZaKfvXT7xlH9A55X7SAxW9E9EhmPfe9nePq4SII9aN0pDXjXvGPDVmexUkHihXAP/ASHpKhQHpDMQP1UTeRkYQx35BGXO1BJANzdrr0UTWdAf4qIIAgDz7GtjcIBURmJche6TbhPD646/VqY+h4Bp2qm344ojgCOTKd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xVUZcvki; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso4676856e87.3
        for <linux-integrity@vger.kernel.org>; Mon, 22 Apr 2024 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713797865; x=1714402665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7LF7mBQJYuNlCsuT9TW9nCR6m2MZVtuZsBkk99+oIw=;
        b=xVUZcvki08f2NL9yp6+QU9OsQ7te4ID17/Dnm75BpMZn/zSskt6To3DIChWOX3B1OH
         ho7dZPxgvywoOquhYOFwmoelyJostLA8r57l8GRLQeVcrvrrnJJqplS5+6DbNX9BSk3h
         QFu4Y1ObswuwlArFLFX5KHAWitgRv3o7faByvfPWOTcO4QgH9q1wNBs/mqLy7ZWuGzKQ
         JxYAvq50w2hyfkiJphQPk6FWlOMf4l8VQAohEX++5gY/f1GmE6T1saTLjAP3govExoiJ
         JKHbvUSO8DsLthNnlxxcNP5PPPGpj2BMuWqmaTEu+YfW3bpKHzWKR0a1a1IaI0ezF71n
         l8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713797865; x=1714402665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7LF7mBQJYuNlCsuT9TW9nCR6m2MZVtuZsBkk99+oIw=;
        b=XvhwusCaS5J2Z0oaIq7FGe40UP3e3TDc5CGURvu9YlH71qdrIx9VmCtGwFrs9SwdTr
         evoouPrRkyVL8wGsD3193R7qhwlX67ILhC31rEj8f3bkjOajLrlbBS7odEjXvzGc65ih
         aj3JxfscEd4fVJQRh4ZjB3AN9NyW4qjOeDmsJR9Q72uS/MWlh3dshk6Nn60ju54kD6Lg
         TeFeRyT2RaRIsloUgpsOm+NU/oLhh9XQFNf11gmmXuGW6B7qSsYLgWX5Zwtn2/PmC+tJ
         VuN/d6QDPFdFTahxUCTiwS0OhP5+oTwuHNDYx14+jrb+xhWerlFQQN7bw5GEh4BW0U+e
         4UgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhdnNwXx3wuGudgl59xfMcCUBP7eBO1nqcSEdiFQM2DhNTiUUrNjtdrCg1ogn856QnvBZ6irWnJc1oopPoXc7i9GwD9f1tiac1xZo+XZVb
X-Gm-Message-State: AOJu0Ywjs3trso92cdbt/SS+jIcIiBwB/hL+QJF3VmGllKkyt7dsQO0k
	vsU+METaGt2cL6d0av8D2ItrGEwNUjYNwBdiXHJwHyXbp9yCdJqYHV3daZd9bvs=
X-Google-Smtp-Source: AGHT+IGyLLZrNulj0xRkuSIpQWr5bZVAAgmHvz84R+mSTI2YxA6Fg1grf9bNCHLRK7MCUJYHh4p7+w==
X-Received: by 2002:a05:6512:908:b0:519:5a3c:e468 with SMTP id e8-20020a056512090800b005195a3ce468mr5350547lft.12.1713797864753;
        Mon, 22 Apr 2024 07:57:44 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id k8-20020a192d08000000b0051ac9a297aasm1262211lfj.141.2024.04.22.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:57:44 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:57:42 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZiZ65rEN8b9Ufmlr@nuoska>
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska>
 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>

Hi,

On Mon, Apr 22, 2024 at 04:54:26PM +0300, Ilias Apalodimas wrote:
> Hi James
> 
> On Mon, 22 Apr 2024 at 16:38, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Mon, 2024-04-22 at 16:32 +0300, Ilias Apalodimas wrote:
> > > Hi all,
> > >
> > > On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli <mikko.rapeli@linaro.org>
> > > wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley wrote:
> > > > > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > > > > Userspace needs to know if TPM kernel drivers need to be loaded
> > > > > > and related services started early in the boot if TPM device
> > > > > > is used and available.
> > > > >
> > > > > This says what but not why.  We already have module autoloading
> > > > > that works correctly for TPM devices, so why is this needed?
> > > > >
> > > > > We do have a chicken and egg problem with IMA in that the TPM
> > > > > driver needs to be present *before* any filesystem, including the
> > > > > one the TPM modules would be on, is mounted so executions can be
> > > > > measured into IMA (meaning that if you use IMA the TPM drivers
> > > > > must be built in) but this sounds to be something different.
> > > > > However, because of the IMA problem, most distributions don't end
> > > > > up compiling TPM drivers as modules anyway.
> > > > >
> > > > > Is what you want simply that tpm modules be loaded earlier?
> > > >
> > > > Yes, ealier is the problem. In my specific testing case the machine
> > > > is qemu arm64 with swtpm with EFI firmware for secure boot and TPM
> > > > support.
> > > >
> > > > Firmware uses TPM and does measurements and thus TPM event log is
> > > > available on this machine and a bunch of other arm64 boards.
> > > > Visible in early boot dmesg as TPMEventLog lines like:
> > > >
> > > > [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040
> > > > RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040
> > > > INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
> > > >
> > > > Different boards use different TPM HW and drivers so compiling all
> > > > these in is possible but a bit ugly. systemd recently gained
> > > > support for a specific tpm2.target which makes TPM support modular
> > > > and also works with kernel modules for some TPM use cases but not
> > > > rootfs encryption.
> > > >
> > > > In my test case we have a kernel+initramfs uki binary which is
> > > > loaded by EFI firmware as a secure boot binary. TPM support on
> > > > various boards is visible in devicetree but not as ACPI table
> > > > entries. systemd currently detect TPM2 support either via ACPI
> > > > table /sys/firmware/acpi/tables/TPM2 or TPM entry or via firmware
> > > > measurement via /sys/kernel/security/tpm0/binary_bios_measurements
> > > > .
> > >
> > > One corner case worth noting here is that scanning the device tree
> > > won't always work for non-ACPI systems... The reason is that a
> > > firmware TPM (running in OP-TEE) might or might not have a DT entry,
> > > since OP-TEE can discover the device dynamically and doesn't always
> > > rely on a DT entry.
> > >
> > > I don't particularly love the idea that an EventLog existence
> > > automatically means a TPM will be there, but it seems that systemd
> > > already relies on that and it does solve the problem we have.
> >
> > Well, quite. That's why the question I was interested in, perhaps not
> > asked as clearly as it could be is: since all the TPM devices rely on
> > discovery mechanisms like ACPI or DT or the like which are ready quite
> > early, should we simply be auto loading the TPM drivers earlier?
> 
> This would be an elegant way to solve this and on top of that, we have
> a single discovery mechanism from userspace -- e.g ls /dev/tpmX.
> But to answer that we need more feedback from systemd. What 'earlier'
> means? Autload it from the kernel before we go into launching the
> initrd?

This is sort of what already happens, but the question is when
does init/systemd wait for the TPM device discovery and setup
of related service so that rootfs can be mounted?

Currently the answer is, for device auto discover: when ACPI TPM2 table
exists or TPM kernel driver interface for firmware measurement is available.

Or as policy, when the kernel command line includes something or services
in initramfs are hard coded.

Parsing devicetree is really hard in userspace but it may contain the TPM details.
But the TPM can also be on some other discoverable bus, firmware TPM optee trusted
application. These both get discovered via the TPM Event Log if firmware
has TPM support on the arm64 boards we have.

Cheers,

-Mikko

