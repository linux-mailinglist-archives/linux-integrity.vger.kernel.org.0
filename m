Return-Path: <linux-integrity+bounces-7501-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05789BF0D74
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADCA18A3173
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D72DF122;
	Mon, 20 Oct 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="CwxXRUEz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EAA1A23AC;
	Mon, 20 Oct 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959864; cv=none; b=M0I7mFm1TUY3ozf9pYak21nJXLPDBI+HllHx/chORbjntSIEMxsymmNx5xIl0yNVDhQ1ibOclZEq8SsU6VReUhSrCNSluj/R4navrDS0Gjvbvg1kahUFNMgKgSDEBgOsnQvqj0YbhsTV7cpAzkws+Xuxb57LJ5uGZwn+2vkbkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959864; c=relaxed/simple;
	bh=Y6DVARd5TLUUMVptZLcNrFDp38SCHQt6VzjbeB6jwQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxiGpxYWiZGSYEpt+k9yMF4aPJGJfGptpmRQpATU7Q/aqYQUNH8DwAdTPgeqXG0fMNTDgdMK8zvWzprLlt/05bAd7vIlXRW6VYsWFKg2DgEu8rPFcdm5qOFwd4qzyX8VJErhQ+USQQzWgPrIy8tH70Xzf4UB6nsec9fOxt3rQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=CwxXRUEz; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZWln54Xn4JgTYr3X6k8FCnK+46730tKxOqtam13CWHA=; b=CwxXRUEzF6J2Zbo8ht1LBlQ37g
	Vffw+qK4ss4k42mwlPN/dRlmekhJ2oPXDxVi2QWP+Dc4ZCbba9s5nCO19lSsKR4SuzTDebvgcPFFb
	xlSVTrq7C3eLK/+0PdPH91/VzAfWWIuMatsUJ1ztnTCn6K6ysdFtJ0MWe6dZD+TPpU6AXG1ySJpdQ
	e0p+qNEZh1mXubD24DRdydu6nWs/ZGWBx+aWyPCOo1r7ZesIPg/CBm8IG6C+MaKjdUvDLBlybXpZV
	ovFcEm4T2FeqF75xXEdVLQZw3gZLfjJEVG7qgEc2EZ4l4gQCHCguPbysXv19xZeux22oIIJSfXsTN
	os9Vm6Eg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vAo6N-0018SR-00;
	Mon, 20 Oct 2025 12:30:59 +0100
Date: Mon, 20 Oct 2025 12:30:58 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] tpm: Include /dev/tpmrm<n> when checking exclusive
 userspace TPM access
Message-ID: <dd1b5d2efa5484550117cb04dea175f03d043079.1760958898.git.noodles@meta.com>
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

The locking on /dev/tpm<n> that dates back to at least 2013, but it only
prevents multiple accesses via *that* interface. It is perfectly
possible for userspace to use /dev/tpmrm<n>, or the kernel to use the
internal interfaces, to access the TPM. For tooling expecting exclusive
access, such as firmware updates, this can cause issues.

Close the userspace loophole by including /dev/tpmrm<n> in the
read/write mutex, as a reader. That way it gets factored in when a
client wants exclusive access to /dev/tpm<n> but otherwise operates as
usual.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
v2: Change error path label to err instead of out. Rework commit
    message.
v3: Rework based on O_EXCL patch being moved earlier in the series.


 drivers/char/tpm/tpmrm-dev.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index c25df7ea064e..780a17454088 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -17,19 +17,34 @@ static int tpmrm_open(struct inode *inode, struct file *file)
 	int rc;
 
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdevs);
+
+	/*
+	 * A client can choose to have exclusive access to the TPM by opening
+	 * /dev/tpm0 with O_EXCL set, in which case we treat it as a write
+	 * lock. All other opens get treated as a read lock.
+	 */
+	if (!down_read_trylock(&chip->open_lock)) {
+		dev_dbg(&chip->dev, "Another process owns this TPM\n");
+		return -EBUSY;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
-		return -ENOMEM;
+		goto err;
 
 	rc = tpm2_init_space(&priv->space, TPM2_SPACE_BUFFER_SIZE);
 	if (rc) {
 		kfree(priv);
-		return -ENOMEM;
+		goto err;
 	}
 
 	tpm_common_open(file, chip, &priv->priv, &priv->space);
 
 	return 0;
+
+err:
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
-- 
2.51.0


