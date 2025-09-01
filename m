Return-Path: <linux-integrity+bounces-6956-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E278B3E63E
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Sep 2025 15:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638761A8565A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Sep 2025 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A333A02D;
	Mon,  1 Sep 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="bI1H6DX0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC173375C0;
	Mon,  1 Sep 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734915; cv=none; b=tdJkONqyDS5mtIJ24158j20iAYS2s5k06foafBWylFy1o6/wpVBxKp7zSRw5WAsxT8kEislGxYFKDQ1d5hvl487Pdc2UGT6zgjI4qg4SdfzZEbz4YVHDrET0VajssdquQPe4LseSfQcWh2RuRkEMaISUHipCmCsy6U8jhfQ1LqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734915; c=relaxed/simple;
	bh=Hu+c6rv0csMU95g7qZ5UJ5/ehArkvEhm6tNJ5QPIu+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OzQFAvKDaoXXrmeBxl+6cbt8bGObkiQtpqOmNIT3fyuioGeyDLMcCq4fw/VEhLzYwQmA/G/BtFYmYxKebJDnTJtt0mq4N7CEmfnKLGXTDKo53dCWW9n1LKldMe3iYsk+Xf1wXA6oS+ZlCWYqNOmOM3xLvCpN5+7bO9+pAO57NQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=bI1H6DX0; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=o2KlfMtYJOXTBJxydKNIgfLxf521SMTWeaOeZjZSynY=; b=b
	I1H6DX0RYnnQ+pDQT0kVy6PO+puj824jh1UI57t4nsqJU+ofiCUWnDNqw/sYHTBUJTY8SlNz19b6x
	iWssDq/AGp8uQ6Rumi1pCZHqALbXyWCfMpY6TDlVFeSpmmD0eIO5ofNUJnvOA3XEolqEoY3sLA2nW
	f5IKP5IhebFA4IjxA5aUyWtOioTmUw+LmWvUNdZBbMYrR5MG+QeN9XpnqqS4+Pc3RUZjoyVK/g8qG
	6IXAZUNR3YJI/qTSLDvnSQFO+KpyUwBMVPka79sMQzKOKP2UlxpCQK59rIV9vJ0AgxgV547Ob8+4y
	L4YuWZEPaU9WSClhT1gUn7NbBOuuOHs/Q==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1ut4zu-0001XA-01;
	Mon, 01 Sep 2025 14:55:02 +0100
Date: Mon, 1 Sep 2025 14:55:01 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aLWltVMmuYQn8Pwa@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
 drivers/char/hw_random/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 018316f54621..11c8077b792b 100644
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
-- 
2.51.0


