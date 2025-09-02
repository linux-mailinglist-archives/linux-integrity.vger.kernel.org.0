Return-Path: <linux-integrity+bounces-6981-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18F9B40C08
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2EB3B3BD2
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B859343D77;
	Tue,  2 Sep 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="PcGb4HNQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AC343D84;
	Tue,  2 Sep 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834042; cv=none; b=V0v+DdWoYSdUPLQPv7XaSh0LutisU46mwIIRcgmT2S3Qn7Mz/4O0Xv3YW7TXc0d0S5TcpJ8Au1cZQH57GWiYDhBRIhq2XFLlk3lxU5H3UnjnuRShxNjc6m+eLlkasFs8MACbZ7xT/NJqu9zzgaAYXmr0c3l2OW6+VnFqxf2yYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834042; c=relaxed/simple;
	bh=epzen24Lm8XzZMpzLT7sc1zAzVAnYPLwQkRE282JBxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd6CVy0ZLJjPrjXrBh49Jgvxx0ICqZvoPuAaXgGpPQ8Up9fJnnsMg85Muku/k65q13/zLUR57Vn7896qPuZgLciKTwK9afiURCBJDTCxx1VxjhHXinGgLkcgytGXf9hb/bbsoprdMXMsoiUZ66oN465G3txIaS0SdVrjuB0FgKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=PcGb4HNQ; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/AClO5jmdv6vuid5xiiEBjr0hK793sZbq2gbKxWSDR0=; b=PcGb4HNQPHs+M9mf19zJECnsZw
	DarBiCOIAExFMyW6wicgZKajx5KGdQEdRYMvgdNQ+E1kpEdcHKmIRqTR4SIxze98NGAooQSMtPUHR
	eDf/eCWbrFp2UPgx5KbtZI2jz4vVCHR56VTPife3OjkMbqxFUvGIzs0J8pjreBKBwGkpZmiMwpnAI
	iUPPzlPqV8ZtpZv38I/Kq/+5qYKMCAUpLZpwoJb5GFnb0JMa03gP9auTiLejYMMregT6g0EfgSMEF
	YtiSG30B8z1cMM94VGRRz5b7nzvjarwHlTtOjUoxW/+W4MExO/aSbB0jsPXSS+3PAg7ixdCKzdGIu
	kDy9F9Bg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1utUmr-002QbR-2z;
	Tue, 02 Sep 2025 18:27:17 +0100
Date: Tue, 2 Sep 2025 18:27:17 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] tpm: Require O_EXCL for exclusive /dev/tpm access
Message-ID: <aad903683a912d6e36904c2d4ad1230a224e0780.1756833527.git.noodles@meta.com>
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

Given that /dev/tpm has not had exclusive access to the TPM since the
existence of the kernel resource broker and other internal users, stop
defaulted to exclusive access to the first client that opens the device.
Continue to support exclusive access, but only with the use of the
O_EXCL flag on device open.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm-dev.c | 25 +++++++++++++++++++------
 drivers/char/tpm/tpm-dev.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 80c4b3f3ad18..8921bbb541c1 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -19,15 +19,21 @@ static int tpm_open(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip;
 	struct file_priv *priv;
+	int rc;
 
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
 
 	/*
-	 * Only one client is allowed to have /dev/tpm0 open at a time, so we
-	 * treat it as a write lock. The shared /dev/tpmrm0 is treated as a
-	 * read lock.
+	 * If a client uses the O_EXCL flag then it expects to be the only TPM
+	 * user, so we treat it as a write lock. Otherwise we do as /dev/tpmrm
+	 * and use a read lock.
 	 */
-	if (!down_write_trylock(&chip->open_lock)) {
+	if (file->f_flags & O_EXCL)
+		rc = down_write_trylock(&chip->open_lock);
+	else
+		rc = down_read_trylock(&chip->open_lock);
+
+	if (!rc) {
 		dev_dbg(&chip->dev, "Another process owns this TPM\n");
 		return -EBUSY;
 	}
@@ -35,13 +41,17 @@ static int tpm_open(struct inode *inode, struct file *file)
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
 		goto out;
+	priv->exclusive = (file->f_flags & O_EXCL);
 
 	tpm_common_open(file, chip, priv, NULL);
 
 	return 0;
 
  out:
-	up_write(&chip->open_lock);
+	if (file->f_flags & O_EXCL)
+		up_write(&chip->open_lock);
+	else
+		up_read(&chip->open_lock);
 	return -ENOMEM;
 }
 
@@ -53,7 +63,10 @@ static int tpm_release(struct inode *inode, struct file *file)
 	struct file_priv *priv = file->private_data;
 
 	tpm_common_release(file, priv);
-	up_write(&priv->chip->open_lock);
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
-- 
2.51.0


