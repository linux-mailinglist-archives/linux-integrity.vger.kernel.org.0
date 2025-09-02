Return-Path: <linux-integrity+bounces-6980-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2759B40C04
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600F41B658AD
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3E9343D93;
	Tue,  2 Sep 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="mV0lFytm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235D3451AE;
	Tue,  2 Sep 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834034; cv=none; b=Tq4/nwhcxVJnGRb34J5erhKvkVa9XiY99dvkgRKm/rKMgu2MbIflBkfC1qRt/y8BA3ZekwMEBv5h/6kpMt/rAYDLdGTPradt5/actWHOVBe4x/a/9/PG5HJzGtL2mr+0NRSMNinP/VJL2GRgFtz/S9M3qiNFQLDR6CuJqtdcM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834034; c=relaxed/simple;
	bh=Pykzr7v20oT7m5PgeYG08jZppuSDFEoQPqN8H3jl76c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWyDQpKaWPB9uajxOroqa6QBB+Ha5OeBqOfWaf75LCPj87O72v0k7XcbPFVvbugb9lXfDruzWwGwOUtAcHSmLBM9u9Awuw76cxvgYUKbJeMT7YNuhyEKzwLk4r+BM7LFIKClM3QLLh2ynomZeKBSjh6HmPflIEFyH22NpTMHRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=mV0lFytm; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+Z3bwbqwmO+TKWf2OnsfoSTQRywbLFP7Yyzwd3uSbhY=; b=mV0lFytmIA7Z9n3dZf/QCzlll8
	pIbYAoDB54PqI4EZvjTjdQ9J7M7ynAzjrgdM63pkmfTqh8A7Oo4cI/v5txC/kU2HbDXfiCEKoC+pQ
	jrxU/8VgAIC137XWfmSS85QJc+uoywVyO1WsvyPDOAuc1GoF4Sc/dKBTvYKqzRvZ/5y+Rp7ZbDVHJ
	Skj7/+ykJlyrQ1zZo1dQGyfsjydo6mKu8VpKJ+YeDatMm5ehLCx2ACJW8nobvR/eHvOeupPz2R1Sp
	2Ed4Qg3IRoN+0bvTMOUM2XDlGmdObanhzdzD8GnosmAHCfJ7t6rHgfuHUPMdqn6XjhS1OgAilzFri
	OVLlrGNA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1utUmk-002QaJ-1b;
	Tue, 02 Sep 2025 18:27:10 +0100
Date: Tue, 2 Sep 2025 18:27:10 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <37c3349265f9b9ef834a996fa6808a7512875376.1756833527.git.noodles@meta.com>
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
 drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
 drivers/char/tpm/tpm-dev-common.c |  8 ++---
 drivers/char/tpm/tpm.h            |  2 ++
 drivers/char/tpm/tpm2-space.c     |  5 ++-
 4 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ba906966721a..3d69ccff4c2a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
 EXPORT_SYMBOL_GPL(tpm_chip_stop);
 
 /**
- * tpm_try_get_ops() - Get a ref to the tpm_chip
+ * tpm_internal_try_get_ops() - Get a ref to the tpm_chip
  * @chip: Chip to ref
  *
  * The caller must already have some kind of locking to ensure that chip is
@@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
  *
  * Returns -ERRNO if the chip could not be got.
  */
-int tpm_try_get_ops(struct tpm_chip *chip)
+int tpm_internal_try_get_ops(struct tpm_chip *chip)
 {
 	int rc = -EIO;
 
@@ -185,22 +185,57 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 	put_device(&chip->dev);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(tpm_try_get_ops);
 
 /**
- * tpm_put_ops() - Release a ref to the tpm_chip
+ * tpm_internal_put_ops() - Release a ref to the tpm_chip
  * @chip: Chip to put
  *
- * This is the opposite pair to tpm_try_get_ops(). After this returns chip may
- * be kfree'd.
+ * This is the opposite pair to tpm_internal_try_get_ops(). After this returns
+ * chip may be kfree'd.
  */
-void tpm_put_ops(struct tpm_chip *chip)
+void tpm_internal_put_ops(struct tpm_chip *chip)
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
+	return tpm_internal_try_get_ops(chip);
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
+	tpm_internal_put_ops(chip);
+
+	up_read(&chip->open_lock);
+}
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
 /**
@@ -644,10 +679,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 #ifdef CONFIG_TCG_TPM2_HMAC
 	int rc;
 
-	rc = tpm_try_get_ops(chip);
+	rc = tpm_internal_try_get_ops(chip);
 	if (!rc) {
 		tpm2_end_auth_session(chip);
-		tpm_put_ops(chip);
+		tpm_internal_put_ops(chip);
 	}
 #endif
 
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index f2a5e09257dd..7cd0617844ed 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -65,7 +65,7 @@ static void tpm_dev_async_work(struct work_struct *work)
 
 	mutex_lock(&priv->buffer_mutex);
 	priv->command_enqueued = false;
-	ret = tpm_try_get_ops(priv->chip);
+	ret = tpm_internal_try_get_ops(priv->chip);
 	if (ret) {
 		priv->response_length = ret;
 		goto out;
@@ -73,7 +73,7 @@ static void tpm_dev_async_work(struct work_struct *work)
 
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
-	tpm_put_ops(priv->chip);
+	tpm_internal_put_ops(priv->chip);
 
 	/*
 	 * If ret is > 0 then tpm_dev_transmit returned the size of the
@@ -220,14 +220,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * lock during this period so that the tpm can be unregistered even if
 	 * the char dev is held open.
 	 */
-	if (tpm_try_get_ops(priv->chip)) {
+	if (tpm_internal_try_get_ops(priv->chip)) {
 		ret = -EPIPE;
 		goto out;
 	}
 
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
-	tpm_put_ops(priv->chip);
+	tpm_internal_put_ops(priv->chip);
 
 	if (ret > 0) {
 		priv->response_length = ret;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 9c158c55c05f..1c34c10421c9 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -272,6 +272,8 @@ struct tpm_chip *tpm_chip_alloc(struct device *dev,
 				const struct tpm_class_ops *ops);
 struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
 				 const struct tpm_class_ops *ops);
+int tpm_internal_try_get_ops(struct tpm_chip *chip);
+void tpm_internal_put_ops(struct tpm_chip *chip);
 int tpm_chip_register(struct tpm_chip *chip);
 void tpm_chip_unregister(struct tpm_chip *chip);
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..853acaf3d10f 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -58,10 +58,9 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
 
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
-
-	if (tpm_try_get_ops(chip) == 0) {
+	if (tpm_internal_try_get_ops(chip) == 0) {
 		tpm2_flush_sessions(chip, space);
-		tpm_put_ops(chip);
+		tpm_internal_put_ops(chip);
 	}
 
 	kfree(space->context_buf);
-- 
2.51.0


