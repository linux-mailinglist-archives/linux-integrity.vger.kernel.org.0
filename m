Return-Path: <linux-integrity+bounces-7500-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3688BF0D7A
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AAEA4F3782
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8C72459F8;
	Mon, 20 Oct 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="p+kFuQzK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81C1A23AC;
	Mon, 20 Oct 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959855; cv=none; b=WuHVdXPnaicpKg09ttkxMo6yoAdL4DaVthBMnSmyRcHlGzFJRNPJ9eq6AUaqL2l7vBuaqLFU9uQCOBm4A5b95+iiC4nYceKAw59A4V0EYfhQknjaoPZmVdTBoPGES87sLV43/pnurDDtyenu1DT90t/lPdd6oRqBM6Ef35yJqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959855; c=relaxed/simple;
	bh=h/gMN2udSHr2DLLD0ZPi9OPx7y3lFehRWe69LWD6akI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2icaGba9MjMu5VvmM1Kr3eLvhzJQCuC/D+F2Bq+IXTam/2M61693qRPHmAclLxgqweY9htuC9Aj0rW6//10Ce2rbfHgmaA4VQ8we6sFRsAwvrREzM49WNt7/Bf0didTh8HNuBe+z0wJYEOA7MLntBi8BoiY+rudcEkTJmT6t38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=p+kFuQzK; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sUhX2FuGfYS8QgSzitcQ5P61LZZZqlq70/6Q/h1wOsU=; b=p+kFuQzK9RAQsBayOmD6/S9ar2
	F1/OXgOT8iJ1Gy7j1zpbAsddBb8zuZuJubDfuYU2baQx/q/9upsyp2m0D5kX+JqnNuksyFMTPGOA4
	LOHdmULmfK7qbMJyON/78MK8tsuhI1FvxtNDActh5/qASinOPcUttCPZStDTr/H5EMY+zBpWPropu
	W3n5/DjIkMvBNF6aMQNec5aCIGJUgBVhTe/RAajpyltN3Q3rhGrtrfUenmb9Irj94Dwl3K3CrB2dh
	4KBgzYS9TSXO4dpuvPot6lfBE3fU5VdZM4CLcQnflJ+9lJR74aFbeZtrUeKY/pHdRnnFcV2WFAAor
	61WAILrg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vAo6D-0018GC-0e;
	Mon, 20 Oct 2025 12:30:49 +0100
Date: Mon, 20 Oct 2025 12:30:49 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] tpm: Add O_EXCL for exclusive /dev/tpm access
Message-ID: <336248d0ab90787d209906526bdbfd5238902509.1760958898.git.noodles@meta.com>
References: <cover.1760958898.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760958898.git.noodles@meta.com>

From: Jonathan McDowell <noodles@meta.com>

The /dev/tpm interface allows for only a single user, but does not
prevent access to the TPM via other paths (either internal kernel
interfaces or the /dev/tpmrm interface). Pave the way to being to able
request fully exclusive access by supporting the use of the O_EXCL flag
on device open.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
v2: No changes.
v3: Move earlier in series to prevent bisection breakage.
    Check for O_RDWR as well as O_EXCL to guard against clients doing
    odd things.
    Retain single /dev/tpm# user even without O_EXCL.

 drivers/char/tpm/tpm-chip.c |  1 +
 drivers/char/tpm/tpm-dev.c  | 35 ++++++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm-dev.h  |  1 +
 include/linux/tpm.h         |  4 +++-
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 30d00219f9f3..ba906966721a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -302,6 +302,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 
 	mutex_init(&chip->tpm_mutex);
 	init_rwsem(&chip->ops_sem);
+	init_rwsem(&chip->open_lock);
 
 	chip->ops = ops;
 
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 97c94b5e9340..819f3e1546da 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -19,20 +19,41 @@ static int tpm_open(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip;
 	struct file_priv *priv;
+	int rc;
 
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
 
-	/* It's assured that the chip will be opened just once,
-	 * by the check of is_open variable, which is protected
-	 * by driver_lock. */
+	/*
+	 * It's assured that the chip will be opened just once via the direct
+	 * /dev/tpm# interface by the check of is_open variable, which is
+	 * protected by driver_lock.
+	 */
 	if (test_and_set_bit(0, &chip->is_open)) {
 		dev_dbg(&chip->dev, "Another process owns this TPM\n");
 		return -EBUSY;
 	}
 
+	/*
+	 * If a client uses the O_EXCL flag then it expects to be the only TPM
+	 * user across all access paths, so we treat it as a write lock.
+	 * Otherwise we use a read lock, allowing for concurrent openers.
+	 * We make sure the client is opening the device for reading + writing;
+	 * opening for exclusive access doesn't make sense if not.
+	 */
+	if ((file->f_flags & (O_ACCMODE|O_EXCL)) == (O_RDWR|O_EXCL))
+		rc = down_write_trylock(&chip->open_lock);
+	else
+		rc = down_read_trylock(&chip->open_lock);
+
+	if (!rc) {
+		dev_dbg(&chip->dev, "Another process owns this TPM\n");
+		return -EBUSY;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
 		goto out;
+	priv->exclusive = (file->f_flags & O_EXCL);
 
 	tpm_common_open(file, chip, priv, NULL);
 
@@ -40,6 +61,10 @@ static int tpm_open(struct inode *inode, struct file *file)
 
  out:
 	clear_bit(0, &chip->is_open);
+	if (file->f_flags & O_EXCL)
+		up_write(&chip->open_lock);
+	else
+		up_read(&chip->open_lock);
 	return -ENOMEM;
 }
 
@@ -52,6 +77,10 @@ static int tpm_release(struct inode *inode, struct file *file)
 
 	tpm_common_release(file, priv);
 	clear_bit(0, &priv->chip->is_open);
+	if (priv->exclusive)
+		up_write(&priv->chip->open_lock);
+	else
+		up_read(&priv->chip->open_lock);
 	kfree(priv);
 
 	return 0;
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index f3742bcc73e3..0ad8504c73e4 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -17,6 +17,7 @@ struct file_priv {
 	ssize_t response_length;
 	bool response_read;
 	bool command_enqueued;
+	bool exclusive;
 
 	u8 data_buffer[TPM_BUFSIZE];
 };
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dc0338a783f3..3bd3da5cb97e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/rwsem.h>
 #include <crypto/hash_info.h>
 #include <crypto/aes.h>
 
@@ -168,7 +169,8 @@ struct tpm_chip {
 	unsigned int flags;
 
 	int dev_num;		/* /dev/tpm# */
-	unsigned long is_open;	/* only one allowed */
+	unsigned long is_open;  /* only one tpm# allowed */
+	struct rw_semaphore open_lock;
 
 	char hwrng_name[64];
 	struct hwrng hwrng;
-- 
2.51.0


