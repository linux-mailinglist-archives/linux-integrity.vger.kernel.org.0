Return-Path: <linux-integrity+bounces-7235-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A0B96058
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7ED819C3ADD
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2873218DB;
	Tue, 23 Sep 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="P4Y+X9ZX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32A10F1;
	Tue, 23 Sep 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634392; cv=none; b=Xm8Uxv58IqCWYzcprViA4EBN88thmNLLvsnPgzEENEbaVXcHOkstHWHIdME40ZUAUZlmQfw58OCdE4g0sbpx/Z99RA1nLRm4NRNh7qk3u6/lRK6p4eylbGywd/8s7JlNyiWk51mPq7AZkugiECQP563R2TdaOg5ozYG5PV8YHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634392; c=relaxed/simple;
	bh=azb97KMaRv34ptK9JMNaTWje53j1dLKvcxvsqcmzZ38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIX4GtJLJLKV5zS7sVzsoV5kxKRX45wgPaBq/xNOxUUdesKKMAkqQh2cgxN0M89IToXnMj9IJgBexqTIZSO7mT7D6D08yug8TpOkGVt/nENaBDl9hdg7vAAI3sJSnn3K81JWJ7QVjQAdiEfmouOcrV7Z9ThiXGVDYBZBLfZw8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=P4Y+X9ZX; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e9n2QxSNrJgGs39S1sWFpobmYhIig6CP3rUBvSSxiYo=; b=P4Y+X9ZXk6BiOMF7i53xuvjQ+8
	F8HDvO+MZ3BnoV8R5UU0/YrhP8KOuBQAlTBrgfvo/ZelUfOesVAUVOr/v4F/Iy5Ey5htWubBfbMi4
	6wwvYUSwoMECMojxeKiI2nHqnrhLamzWpcbEwPkLi1Oa9rpnB0Nk32nhidGZ28Oluk2m5cIvU6EIK
	3dKi7Xa0YzXC0i/KSe9IFv5ribloTlZwOICKT/yjchSpRS08vdkz/bcfY4cllsUITOjOYvjbEJsw5
	MxeXCeDLWZEVl2R5g4q400cWWjQ6hdy/iyLTY2pQ3j1KfO9R60JxKtpYQSZaB0Di5NaQPpPGyg60S
	jomvxXKA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v138j-00CF0u-0s;
	Tue, 23 Sep 2025 14:33:05 +0100
Date: Tue, 23 Sep 2025 14:33:05 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aNKhkberbgFJph6R@earth.li>
References: <aLWltVMmuYQn8Pwa@earth.li>
 <aMg4h_WeJb9bHeNb@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aMg4h_WeJb9bHeNb@earth.li>

From: Jonathan McDowell <noodles@meta.com>

The HW RNG core allows for manual selection of which RNG device to use,
but does not allow for no device to be enabled. It may be desirable to
do this on systems with only a single suitable hardware RNG, where we
need exclusive access to other functionality on this device. In
particular when performing TPM firmware upgrades this lets us ensure the
kernel does not try to access the device.

Before:

root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_quality:1024
/sys/devices/virtual/misc/hw_random/rng_selected:0

After:

root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
/sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_quality:1024
/sys/devices/virtual/misc/hw_random/rng_selected:0

root@debian-qemu-efi:~# echo none > /sys/devices/virtual/misc/hw_random/rng_current
root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
/sys/devices/virtual/misc/hw_random/rng_current:none
grep: /sys/devices/virtual/misc/hw_random/rng_quality: No such device
/sys/devices/virtual/misc/hw_random/rng_selected:1

(Observe using bpftrace no calls to TPM being made)

root@debian-qemu-efi:~# echo "" > /sys/devices/virtual/misc/hw_random/rng_current
root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
/sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_quality:1024
/sys/devices/virtual/misc/hw_random/rng_selected:0

(Observe using bpftrace that calls to the TPM resume)

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
v3: Always set cur_rng_set_by_user if user forces no HW RNG.
v2: If the user manually forces the HWRNG to none do not override this
     when a new driver is loaded. Pointed out by Herbert Xu.
  drivers/char/hw_random/core.c | 9 ++++++---
  1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 018316f54621..56d888bebe0c 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -341,6 +341,9 @@ static ssize_t rng_current_store(struct device *dev,
  
  	if (sysfs_streq(buf, "")) {
  		err = enable_best_rng();
+	} else if (sysfs_streq(buf, "none")) {
+		cur_rng_set_by_user = 1;
+		drop_current_rng();
  	} else {
  		list_for_each_entry(rng, &rng_list, list) {
  			if (sysfs_streq(rng->name, buf)) {
@@ -392,7 +395,7 @@ static ssize_t rng_available_show(struct device *dev,
  		strlcat(buf, rng->name, PAGE_SIZE);
  		strlcat(buf, " ", PAGE_SIZE);
  	}
-	strlcat(buf, "\n", PAGE_SIZE);
+	strlcat(buf, "none\n", PAGE_SIZE);
  	mutex_unlock(&rng_mutex);
  
  	return strlen(buf);
@@ -544,8 +547,8 @@ int hwrng_register(struct hwrng *rng)
  	/* Adjust quality field to always have a proper value */
  	rng->quality = min_t(u16, min_t(u16, default_quality, 1024), rng->quality ?: 1024);
  
-	if (!current_rng ||
-	    (!cur_rng_set_by_user && rng->quality > current_rng->quality)) {
+	if (!cur_rng_set_by_user &&
+	    (!current_rng || rng->quality > current_rng->quality)) {
  		/*
  		 * Set new rng as current as the new rng source
  		 * provides better entropy quality and was not
-- 
2.51.0


