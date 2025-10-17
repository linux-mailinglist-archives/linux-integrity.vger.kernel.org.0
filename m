Return-Path: <linux-integrity+bounces-7443-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE73DBE71EC
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 10:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD941AA01CB
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F527EC80;
	Fri, 17 Oct 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="rREVEToM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761A2741BC;
	Fri, 17 Oct 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689088; cv=none; b=WJ3BNVLxiKreiXxWCq4KWK+Pg1xy40IA4n8ET+MnUxDrwYE0uhw87JBPb5TWrznqc6C2nhCFdhAHVvD63Lf/smMlWcoX10egwWP09DaXFQFM8v2PmWEf39bmJwMwhGdAwucjNVh8J1Uaz7YlmdVk40TTjpbwZhj1+nfOwQ/hmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689088; c=relaxed/simple;
	bh=HKN0UlynFpDeOnQgRavKv0UJJ04IINksu/6qhDLHy4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCbG72LPhXq5PWK7ALtfWQ6b//0vJCyw5mWH4hkMlStMrli4x70MwPmNGz5y+bc6G4sg7yxHoZpC3FPOpHMG/FhnUBNeEsVXgNyJlPwVZkNr6sM61Vx5Ftx8tf3m355r/bEOZQ8DD3zoICYVbxEiBJPuNpUgX/OzkX6spkGAK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=rREVEToM; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=9FMkFwTqxvxu5xj8ecWFlPV+5JF+fZgYk1Hq9u7el+g=; 
	b=rREVEToM4l5hyvskaSSqLgFQNghwmzVHHoqmJes1TK0povm4Qfuf6GvKxDW2xzU/VkEaGarcMUH
	Lq4Od1YyqZJqH76FzNi4kgMIp9UzgymJr9puqmvkyoysBVorseyjU754KUFe9/MvTwMtVKx9aSgwy
	0EGdtt8QZaVLSrwJlKpGj3shgLu/JJubU9UzomhWtCVGGjM3ub6uH1/O0X9NAn0fp4krxIuqevMiG
	+DedTUb3YUtPkNwRvVx5LOFiPTzAIvJEvIOdxr4OdgBpfFWnk+EGL1BX3m9P0fAx6eUPHoReJ14+u
	S3W5rfHqYSCXEk2+WeTfJxNPPROsYV7whj/w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v9fes-00DN0a-2W;
	Fri, 17 Oct 2025 16:17:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Oct 2025 16:17:54 +0800
Date: Fri, 17 Oct 2025 16:17:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jonathan McDowell <noodles@earth.li>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aPH7smwx9VFNztsM@gondor.apana.org.au>
References: <aLWltVMmuYQn8Pwa@earth.li>
 <aMg4h_WeJb9bHeNb@earth.li>
 <aNKhkberbgFJph6R@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNKhkberbgFJph6R@earth.li>

On Tue, Sep 23, 2025 at 02:33:05PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> The HW RNG core allows for manual selection of which RNG device to use,
> but does not allow for no device to be enabled. It may be desirable to
> do this on systems with only a single suitable hardware RNG, where we
> need exclusive access to other functionality on this device. In
> particular when performing TPM firmware upgrades this lets us ensure the
> kernel does not try to access the device.
> 
> Before:
> 
> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0
> /sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
> /sys/devices/virtual/misc/hw_random/rng_quality:1024
> /sys/devices/virtual/misc/hw_random/rng_selected:0
> 
> After:
> 
> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
> /sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
> /sys/devices/virtual/misc/hw_random/rng_quality:1024
> /sys/devices/virtual/misc/hw_random/rng_selected:0
> 
> root@debian-qemu-efi:~# echo none > /sys/devices/virtual/misc/hw_random/rng_current
> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
> /sys/devices/virtual/misc/hw_random/rng_current:none
> grep: /sys/devices/virtual/misc/hw_random/rng_quality: No such device
> /sys/devices/virtual/misc/hw_random/rng_selected:1
> 
> (Observe using bpftrace no calls to TPM being made)
> 
> root@debian-qemu-efi:~# echo "" > /sys/devices/virtual/misc/hw_random/rng_current
> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
> /sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
> /sys/devices/virtual/misc/hw_random/rng_quality:1024
> /sys/devices/virtual/misc/hw_random/rng_selected:0
> 
> (Observe using bpftrace that calls to the TPM resume)
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
> v3: Always set cur_rng_set_by_user if user forces no HW RNG.
> v2: If the user manually forces the HWRNG to none do not override this
>     when a new driver is loaded. Pointed out by Herbert Xu.
>  drivers/char/hw_random/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

