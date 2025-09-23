Return-Path: <linux-integrity+bounces-7251-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DEB96F72
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD5719C70F4
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082927934B;
	Tue, 23 Sep 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="X93kTL2h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233F27A446;
	Tue, 23 Sep 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647433; cv=none; b=VO0A/fkoTib91osp40fV1eUWi3IVQqPsrJRV30hfSWxxN3xFy5MWIRIjaPWzbZsu4udzWc4hUWkhXZ2DZkH1unH5Y2mXz21gKXwETf5A0Qlz9gJe4KwPT/51HmDwZIMX9Z0IpWj4jkKYL+aKb7uYZU4F6tv8pwzYTdVMYxlc9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647433; c=relaxed/simple;
	bh=epzen24Lm8XzZMpzLT7sc1zAzVAnYPLwQkRE282JBxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHmDKmMXcQNhgTFbECU2KLQ1MZt4jN1IsUxTzfn9IRh7WKhd2DDJvNU5eMXppvjKu7TuWn9+mikziRIZuZIVYQCx7JYqwBWC3ptMBJDpW1Tf5loYvpjhqSKgjp/ewviSKJPlpFrHQ5QpOR1ENIf6+nc6rCl5J8vcnKe+JIcUx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=X93kTL2h; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/AClO5jmdv6vuid5xiiEBjr0hK793sZbq2gbKxWSDR0=; b=X93kTL2hChVR0+wDn6jAJ2b55t
	Qe8OTtnj4H5jmhy+7/M0BQbDQW1pUQbZyQV1WVzWuhgNZakEAeBGnpEN6M9OPmYEQizaEDxkBrHTd
	IRYYurViR2bMw01MFxVCv29FGW37+80M0faOgatpnGvpCYxdoeior0XVk8xkI+WEC6f5/DyLv+vOb
	0wzYeEfQMitcfqobDxfsYNvBZEwlhBb1gUOnrKi6BIKLezFMmUfSDu1NaPNMxn4aN86eKrhw8p77o
	z5/m/3XBY81wfXanGR13DMZDG3isOicwaqVOoNmyeoiazovbFm8K+qSkf4FX3Bhx7PUKqhiY/04fP
	vfp/RRvw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v16X6-00CZpf-2E;
	Tue, 23 Sep 2025 18:10:28 +0100
Date: Tue, 23 Sep 2025 18:10:28 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] tpm: Require O_EXCL for exclusive /dev/tpm access
Message-ID: <83a323d597819d928da45b5b3914b37375c67869.1758646791.git.noodles@meta.com>
References: <cover.1758646791.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758646791.git.noodles@meta.com>

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


