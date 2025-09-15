Return-Path: <linux-integrity+bounces-7083-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E9B5816E
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 18:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B573B8FEB
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4DE21770A;
	Mon, 15 Sep 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="VjUeatuy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07460EAD7;
	Mon, 15 Sep 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952149; cv=none; b=I5IGTlu0qwJ9HeEHpO/N0wQDN7pe2r3g8sJyv6P37ZGTFF4wLVos/ChKHOBtij1+QUuBGvwk3uHcPvS/IPJUwf5ZXNDLHAr7HkOD0EZ9YWcPOcsPAwjK9XkivSQBiw7cFzMrqz60d6/WZ6r3+5nF200brUTZT2j4tyLH17CIma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952149; c=relaxed/simple;
	bh=ZavVOFy7p+aHN0BEwnntQn4rJME9Ova625rXkE4ZN0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xae6Bws0xS18qPMPf40d58QVdGrknpi5ovmlMg9BY5E5x6vW+9zleLrUzLbyGF2cxPGPjJfiedA+10usSWblj0eRW9PXtt0G5k9Vk/8B4DiRkVxRGRx5KyG1bKoL5k8siqtVBsInwoazO+aWfnQWbznmtXouaEY0lzTuZ2yGynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=VjUeatuy; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=D7IggKGhPyJUcmIjxEeQlKJOLgaxFMcl0GgywU9PiEM=; b=VjUeatuyBytE5yZDdsZ66OeJtZ
	bQ7I0FmfIYBuxaqKWSCqEtCwSoYRB06jOaued2BkwLAHjU+AzMx9cHHQC/1pR17hq6iDC/xay7Muc
	0qdjjK4uNSUGqNCHNtYMAgCHCBcPl7asCXl0MvFiGieojYF/7q83lqCTimfjl/nq7YFdhpFkKM7nq
	TlzlP/MqK1eK8IJAUycdXi74T6ktB8JM6Tprnq4pDFr4VfRIn89c+Md/OY7a9qMkkoWVyX//j8yHp
	aEyuH4Nf0fO/1hrtcTKHgAS//lvldpEjgAmgCLK91jgGMJgcEViGQ43XYclkaGB+3ogbvaVQ1KVur
	cTRjzomQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uyBeh-0045wj-2f;
	Mon, 15 Sep 2025 17:02:15 +0100
Date: Mon, 15 Sep 2025 17:02:15 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aMg4h_WeJb9bHeNb@earth.li>
References: <aLWltVMmuYQn8Pwa@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aLWltVMmuYQn8Pwa@earth.li>

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
v2: If the user manually forces the HWRNG to none do not override this
     when a new driver is loaded. Pointed out by Herbert Xu.

  drivers/char/hw_random/core.c | 10 +++++++---
  1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 018316f54621..1682a9f1b28c 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -341,6 +341,10 @@ static ssize_t rng_current_store(struct device *dev,
  
  	if (sysfs_streq(buf, "")) {
  		err = enable_best_rng();
+	} else if (sysfs_streq(buf, "none")) {
+		if (current_rng)
+			cur_rng_set_by_user = 1;
+		drop_current_rng();
  	} else {
  		list_for_each_entry(rng, &rng_list, list) {
  			if (sysfs_streq(rng->name, buf)) {
@@ -392,7 +396,7 @@ static ssize_t rng_available_show(struct device *dev,
  		strlcat(buf, rng->name, PAGE_SIZE);
  		strlcat(buf, " ", PAGE_SIZE);
  	}
-	strlcat(buf, "\n", PAGE_SIZE);
+	strlcat(buf, "none\n", PAGE_SIZE);
  	mutex_unlock(&rng_mutex);
  
  	return strlen(buf);
@@ -544,8 +548,8 @@ int hwrng_register(struct hwrng *rng)
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


