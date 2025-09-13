Return-Path: <linux-integrity+bounces-7066-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EACB55E2C
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Sep 2025 05:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C2178F2F
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Sep 2025 03:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F601DED53;
	Sat, 13 Sep 2025 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="QPtKmzZM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF326290;
	Sat, 13 Sep 2025 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757735806; cv=none; b=rHPB5JgrSe4nd62Zm1GaeyT5t8bGh7gEAqtKA7N9xBgZk/h+6vyPfHvTSgKUJ/1CwtyQ3yGWvQQB5Cu03nkQPj35YcZeAGGXeLuJS7qVwseQUlMadmIiWxDh1r8Ya0zhK1RYM9vf0hSX1X5FsSZvlUPdfOFd/gxa9n2kxmNjeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757735806; c=relaxed/simple;
	bh=mYvWyyZaBbGor0A60kVcHbc38K2M2ajjYNslJyZmHEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb+us7TIM2sRH3ojHZw2qZgRGcHFcesL5hMOlRPqk2OhTCIZIApr8qfr6wIPUgi60axqm4lQ7vBYSdvRUHOHdlfghjpOXKI4P3feKQXZmkk3gk9y8GJTevPYOOw9sDnLGtJyZItkjqyBdSlUHOZq2y4uqFcksNHxtNM1qu08fjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=QPtKmzZM; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WLmYVqGmFrzsHw7vn69TnalxcG7p2lkJTyh4HjR608k=; b=QPtKmzZMTomvBoL+huYUQ7vFRO
	V7x9T1qiHnWamZseWJAqZ1SznQnB+WATCOGcMpDNZIkpyX51EK/LPrHrBk/x/tuHnpehEB7J9aj25
	Cc7v+m/aDBnT0t7UQFQcWrDh+5OFKSFk5tq2W3yXhfHmbrT88yQtD1xHUxwnvX5cxUrZD7tkqPafF
	LagX0eZyF7+Ti27hN4qjpPclZiiFyzCe9BoHp7wJKxayShGoow8ja7GqP1uaRGouLdYxil7sE0xuY
	HsJ1xXQjR2B6uXraxNtqdqgrrZ9yogZf22h+dJafcYYyPz9J9nKOCSlGreRLACdjVLErmyC7Mz5fE
	lr0g1NIA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxH7m-0053bQ-2q;
	Sat, 13 Sep 2025 11:56:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Sep 2025 11:56:27 +0800
Date: Sat, 13 Sep 2025 11:56:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jonathan McDowell <noodles@earth.li>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aMTra7C-CayEcaCY@gondor.apana.org.au>
References: <aLWltVMmuYQn8Pwa@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLWltVMmuYQn8Pwa@earth.li>

On Mon, Sep 01, 2025 at 02:55:01PM +0100, Jonathan McDowell wrote:
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
>  drivers/char/hw_random/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 018316f54621..11c8077b792b 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -341,6 +341,10 @@ static ssize_t rng_current_store(struct device *dev,
>  
>  	if (sysfs_streq(buf, "")) {
>  		err = enable_best_rng();
> +	} else if (sysfs_streq(buf, "none")) {
> +		if (current_rng)
> +			cur_rng_set_by_user = 1;
> +		drop_current_rng();

Is this setting supposed to be sticky?

Because as it stands, if another HWRNG is registered after setting
it to none, it would still become the default RNG which seems to be
surprising.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

