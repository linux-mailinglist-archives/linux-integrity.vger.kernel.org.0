Return-Path: <linux-integrity+bounces-7502-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16045BF0D83
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 560694EBB20
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D8257427;
	Mon, 20 Oct 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="kqJpudP8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA3241CA2;
	Mon, 20 Oct 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959878; cv=none; b=RXMPM6UAdd9MUrxhKAZAiLjcYbdHexe4LYr3oHNPb0g30o2oZFUi17pDkGGFrs+mYuZpbnjuFrIcdwCfQ/6HBpev7kRO5lV5oo+B3995vK3BkUWsryIV7j6/UMBgbj27Y/uvhuT3T31e7o6kDfvcPDBZ1G1toJoeLA9KSLLTIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959878; c=relaxed/simple;
	bh=xaBRgqhjD0RsHV1Moml6Ob+3CaY34dxtSbjQGYCKG8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDhetJh/me0u94Ef7AA+HB4urgT2+renxk9BnS4JYcZ2hc4N8gtx7v4JEGLG2sm6Bw7LbciVMDafrVnsbxmP6/4HY+5rQfT/84j+UaAaYP5bLS1T0Irqa0eFjYjW3mS4+D2akTGLyhRl9r+7Ctm7ePkhEo0iDDdRRy3/Z8dSikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=kqJpudP8; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pm4nmT2XDkE/3z3ULWt/r52c6A4Pu3rHrdw+GZ3Tx1Q=; b=kqJpudP8t27VPg1nw213BtNRSL
	pDzZ7vNDaj+49EVykNiT9jIEO6B/WvTsbLM14B1mSpI40gzeSQtv3Kel4DJ5tPftopJoWLPkJwwks
	w+mVbHkXYGO7yLNQWPHhPegwEkj9B0p8DSar4aVjOUf6nKNjI6ubuk4fJNyzdnaAyzHItLUmmwGEX
	2QGBkEtFamoFPnSGSBsarVauP+UE+weaqS6IDk2dwACcLtVsUbz9Oljdad+v6O31Tps9ZHip6D52Y
	jOA/3pYI+MQBQBeUQGUm28VzWDguAUc2QejRRqBMC1gbT+n2MX6SFhu9yVD7vl0bSmBcvsf1zdt/T
	javRpthQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vAo6a-0018jz-18;
	Mon, 20 Oct 2025 12:31:12 +0100
Date: Mon, 20 Oct 2025 12:31:12 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <61049f236fe1eaf72402895cea6892b52ce7e279.1760958898.git.noodles@meta.com>
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

There are situations where userspace might reasonably desire exclusive
access to the TPM, or the kernel's internal context saving + flushing
may cause issues, for example when performing firmware upgrades. Extend
the locking already used for avoiding concurrent userspace access to
prevent internal users of the TPM when /dev/tpm<n> is in use.

The few internal users who already hold the open_lock are changed to use
tpm_internal_(try_get|put)_ops, with the old tpm_(try_get|put)_ops
functions changing to obtain read access to the open_lock.  We return
-EBUSY when another user has exclusive access, rather than adding waits.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
v2: Switch to _locked instead of _internal_ for function names.
v3: Move to end of patch series.

 drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
 drivers/char/tpm/tpm-dev-common.c |  8 ++---
 drivers/char/tpm/tpm.h            |  2 ++
 drivers/char/tpm/tpm2-space.c     |  5 ++-
 4 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ba906966721a..687f6d8cd601 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
 EXPORT_SYMBOL_GPL(tpm_chip_stop);
 
 /**
- * tpm_try_get_ops() - Get a ref to the tpm_chip
+ * tpm_try_get_ops_locked() - Get a ref to the tpm_chip
  * @chip: Chip to ref
  *
  * The caller must already have some kind of locking to ensure that chip is
@@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
  *
  * Returns -ERRNO if the chip could not be got.
  */
-int tpm_try_get_ops(struct tpm_chip *chip)
+int tpm_try_get_ops_locked(struct tpm_chip *chip)
 {
 	int rc = -EIO;
 
@@ -185,22 +185,57 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 	put_device(&chip->dev);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(tpm_try_get_ops);
 
 /**
- * tpm_put_ops() - Release a ref to the tpm_chip
+ * tpm_put_ops_locked() - Release a ref to the tpm_chip
  * @chip: Chip to put
  *
- * This is the opposite pair to tpm_try_get_ops(). After this returns chip may
- * be kfree'd.
+ * This is the opposite pair to tpm_try_get_ops_locked(). After this returns
+ * chip may be kfree'd.
  */
-void tpm_put_ops(struct tpm_chip *chip)
+void tpm_put_ops_locked(struct tpm_chip *chip)
 {
 	tpm_chip_stop(chip);
 	mutex_unlock(&chip->tpm_mutex);
 	up_read(&chip->ops_sem);
 	put_device(&chip->dev);
 }
+
+/**
+ * tpm_try_get_ops() - Get a ref to the tpm_chip
+ * @chip: Chip to ref
+ *
+ * The caller must already have some kind of locking to ensure that chip is
+ * valid. This function will attempt to get the open_lock for the chip,
+ * ensuring no other user is expecting exclusive access, before locking the
+ * chip so that the ops member can be accessed safely. The locking prevents
+ * tpm_chip_unregister from completing, so it should not be held for long
+ * periods.
+ *
+ * Returns -ERRNO if the chip could not be got.
+ */
+int tpm_try_get_ops(struct tpm_chip *chip)
+{
+	if (!down_read_trylock(&chip->open_lock))
+		return -EBUSY;
+
+	return tpm_try_get_ops_locked(chip);
+}
+EXPORT_SYMBOL_GPL(tpm_try_get_ops);
+
+/**
+ * tpm_put_ops() - Release a ref to the tpm_chip
+ * @chip: Chip to put
+ *
+ * This is the opposite pair to tpm_try_get_ops(). After this returns
+ * chip may be kfree'd.
+ */
+void tpm_put_ops(struct tpm_chip *chip)
+{
+	tpm_put_ops_locked(chip);
+
+	up_read(&chip->open_lock);
+}
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
 /**
@@ -644,10 +679,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 #ifdef CONFIG_TCG_TPM2_HMAC
 	int rc;
 
-	rc = tpm_try_get_ops(chip);
+	rc = tpm_try_get_ops_locked(chip);
 	if (!rc) {
 		tpm2_end_auth_session(chip);
-		tpm_put_ops(chip);
+		tpm_put_ops_locked(chip);
 	}
 #endif
 
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index f2a5e09257dd..0f5bc63411aa 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -65,7 +65,7 @@ static void tpm_dev_async_work(struct work_struct *work)
 
 	mutex_lock(&priv->buffer_mutex);
 	priv->command_enqueued = false;
-	ret = tpm_try_get_ops(priv->chip);
+	ret = tpm_try_get_ops_locked(priv->chip);
 	if (ret) {
 		priv->response_length = ret;
 		goto out;
@@ -73,7 +73,7 @@ static void tpm_dev_async_work(struct work_struct *work)
 
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
-	tpm_put_ops(priv->chip);
+	tpm_put_ops_locked(priv->chip);
 
 	/*
 	 * If ret is > 0 then tpm_dev_transmit returned the size of the
@@ -220,14 +220,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * lock during this period so that the tpm can be unregistered even if
 	 * the char dev is held open.
 	 */
-	if (tpm_try_get_ops(priv->chip)) {
+	if (tpm_try_get_ops_locked(priv->chip)) {
 		ret = -EPIPE;
 		goto out;
 	}
 
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
-	tpm_put_ops(priv->chip);
+	tpm_put_ops_locked(priv->chip);
 
 	if (ret > 0) {
 		priv->response_length = ret;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 02c07fef41ba..57ef8589f5f5 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -272,6 +272,8 @@ struct tpm_chip *tpm_chip_alloc(struct device *dev,
 				const struct tpm_class_ops *ops);
 struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
 				 const struct tpm_class_ops *ops);
+int tpm_try_get_ops_locked(struct tpm_chip *chip);
+void tpm_put_ops_locked(struct tpm_chip *chip);
 int tpm_chip_register(struct tpm_chip *chip);
 void tpm_chip_unregister(struct tpm_chip *chip);
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..0ad5e18355e0 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -58,10 +58,9 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
 
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
-
-	if (tpm_try_get_ops(chip) == 0) {
+	if (tpm_try_get_ops_locked(chip) == 0) {
 		tpm2_flush_sessions(chip, space);
-		tpm_put_ops(chip);
+		tpm_put_ops_locked(chip);
 	}
 
 	kfree(space->context_buf);
-- 
2.51.0


