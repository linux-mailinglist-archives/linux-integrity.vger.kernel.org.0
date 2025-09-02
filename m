Return-Path: <linux-integrity+bounces-6978-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B190AB40BFD
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE71B6444C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22463431ED;
	Tue,  2 Sep 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="G6L8QC5G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841B2FE599;
	Tue,  2 Sep 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834014; cv=none; b=mLwNMQM6XzjKuzkA5+6BD+Swwq5TnRqBeVThnT16nFhiezBpF/pkAk6mWm5+x3mDZ30jy/UYdOPRHtmBQiLVi59B1czYbciJhIvt8wngW5SZbjZu3OughObIqGdXj1bpyTStQyj6e4av4cTZkE+KYdTi4pDI9n6uv6gfDyjTyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834014; c=relaxed/simple;
	bh=VUFAHETmyPVVIH5kKTf1KYQYuBfkGZul6nMtw7ZUut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEw43nMd12YkvJn54YDmdwQ8NAQS8upvjjmUEOFwek+W5FWcNVH38QzPXNbSuAJqlIE9EdsIlreyRCQUeNGKYAUD9c3kzWlnTXN0nNVfaXdKNVSl+GWpiQpagesvMq9Oi466ogeVFhFwvhEncW8tQEWLne+IUhNs9KIK3YJRVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=G6L8QC5G; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7o/7fzYTuHTinewS6cxGH2CO5LBLHrKHNUohg8xB6yQ=; b=G6L8QC5GM0S+OqhxUw2lz6fy9+
	asNcyKhmN0/Gz+eFlUJGZHXHVsTIW/5uAcHZ/6IpYAmGEsMBIAnxSgq9Q9P2NnusB68Jd6QNIik9G
	eUpqOHUVu/hJokx8z1sn7X4MF9ws0klrU3T9Lvu/fA0EtiAkAJZ8jQ9jjageQLAdxx7rnspgV66H5
	yZYfmfHo0johdqHIHHD4IVeWE2olZfNPlNG8isxfHP0E4fBPEuMhTI2bpH+zJYNovoqp/20THQP8U
	Oga89b+XI2e0TBER3ChEh9USuZohxPvh0ziKSV8RWfBV/dnn2HQdP9GQ3vVSVAhVQ9yqEMoTxllyJ
	GSxx3d5w==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1utUmP-002QXD-1T;
	Tue, 02 Sep 2025 18:26:49 +0100
Date: Tue, 2 Sep 2025 18:26:49 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] tpm: Ensure exclusive userspace access when using
 /dev/tpm<n>
Message-ID: <d2d7c8105a73e43866f23c88b188ee6e83562726.1756833527.git.noodles@meta.com>
References: <cover.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756833527.git.noodles@meta.com>

From: Jonathan McDowell <noodles@meta.com>

There is an is_open lock on /dev/tpm<n> that dates back to at least
2013, but it only prevents multiple accesses via *this* interface. It is
perfectly possible for userspace to use /dev/tpmrm<n>, or the kernel to
use the internal interfaces, to access the TPM.

This can cause problems with userspace expecting exclusive access and
something changing state underneath it, for example while performing a
TPM firmware upgrade.

Close the userspace loophole by changing the simple bit lock to a full
read/write mutex. Direct /dev/tpm<n> access needs an exclusive write
lock, the resource broker continues to allow concurrent access *except*
when /dev/tpm<n> is open.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm-chip.c  |  1 +
 drivers/char/tpm/tpm-dev.c   | 14 ++++++++------
 drivers/char/tpm/tpmrm-dev.c | 20 ++++++++++++++++++--
 include/linux/tpm.h          |  3 ++-
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e25daf2396d3..8c8e9054762a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -338,6 +338,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 
 	mutex_init(&chip->tpm_mutex);
 	init_rwsem(&chip->ops_sem);
+	init_rwsem(&chip->open_lock);
 
 	chip->ops = ops;
 
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 97c94b5e9340..80c4b3f3ad18 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -22,10 +22,12 @@ static int tpm_open(struct inode *inode, struct file *file)
 
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
 
-	/* It's assured that the chip will be opened just once,
-	 * by the check of is_open variable, which is protected
-	 * by driver_lock. */
-	if (test_and_set_bit(0, &chip->is_open)) {
+	/*
+	 * Only one client is allowed to have /dev/tpm0 open at a time, so we
+	 * treat it as a write lock. The shared /dev/tpmrm0 is treated as a
+	 * read lock.
+	 */
+	if (!down_write_trylock(&chip->open_lock)) {
 		dev_dbg(&chip->dev, "Another process owns this TPM\n");
 		return -EBUSY;
 	}
@@ -39,7 +41,7 @@ static int tpm_open(struct inode *inode, struct file *file)
 	return 0;
 
  out:
-	clear_bit(0, &chip->is_open);
+	up_write(&chip->open_lock);
 	return -ENOMEM;
 }
 
@@ -51,7 +53,7 @@ static int tpm_release(struct inode *inode, struct file *file)
 	struct file_priv *priv = file->private_data;
 
 	tpm_common_release(file, priv);
-	clear_bit(0, &priv->chip->is_open);
+	up_write(&priv->chip->open_lock);
 	kfree(priv);
 
 	return 0;
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index c25df7ea064e..40c139a080b6 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -17,19 +17,34 @@ static int tpmrm_open(struct inode *inode, struct file *file)
 	int rc;
 
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdevs);
+
+	/*
+	 * Only one client is allowed to have /dev/tpm0 open at a time, so we
+	 * treat it as a write lock. The shared /dev/tpmrm0 is treated as a
+	 * read lock.
+	 */
+	if (!down_read_trylock(&chip->open_lock)) {
+		dev_dbg(&chip->dev, "Another process owns this TPM\n");
+		return -EBUSY;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
-		return -ENOMEM;
+		goto out;
 
 	rc = tpm2_init_space(&priv->space, TPM2_SPACE_BUFFER_SIZE);
 	if (rc) {
 		kfree(priv);
-		return -ENOMEM;
+		goto out;
 	}
 
 	tpm_common_open(file, chip, &priv->priv, &priv->space);
 
 	return 0;
+
+out:
+	up_read(&chip->open_lock);
+	return -ENOMEM;
 }
 
 static int tpmrm_release(struct inode *inode, struct file *file)
@@ -40,6 +55,7 @@ static int tpmrm_release(struct inode *inode, struct file *file)
 	tpm_common_release(file, fpriv);
 	tpm2_del_space(fpriv->chip, &priv->space);
 	kfree(priv);
+	up_read(&fpriv->chip->open_lock);
 
 	return 0;
 }
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b0e9eb5ef022..548362d20b32 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/rwsem.h>
 #include <crypto/hash_info.h>
 #include <crypto/aes.h>
 
@@ -168,7 +169,7 @@ struct tpm_chip {
 	unsigned int flags;
 
 	int dev_num;		/* /dev/tpm# */
-	unsigned long is_open;	/* only one allowed */
+	struct rw_semaphore open_lock;
 
 	char hwrng_name[64];
 	struct hwrng hwrng;
-- 
2.51.0


