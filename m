Return-Path: <linux-integrity+bounces-5446-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E78A71B3E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 16:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8154818821E7
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C41F4736;
	Wed, 26 Mar 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNw5vBUN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195091F472E;
	Wed, 26 Mar 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004713; cv=none; b=Lv4XnsMDQKBJpW8vmgTpIZNA1Nznf61/PvqJLRAZuezMUq63TfYhhmKwwC8NABu6NC9VKADUtYW2xCAxNnqJd2VcOUH7sTFbica1U5/oYkmJGDmDR/aLt9PVAZb7FZiB3M53WonQIyxqFV5fdarXbg54zfVGFz7qR2uDs1BlJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004713; c=relaxed/simple;
	bh=9m9MReJ7JJiilrI+wNCXRHg87GEezlJxw8QAA1k6d3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzIpXjPsk4sgRkHcFcg1aCe5HbAdiaULngyBGiA8OGuCAmi6ACxlcw8Emd/jsX/c1nX6vZmHx4yFwyXbfL+qsXWzJo/aIcJQ2WfuxYE2sxwcqo/uC4PTj4zxX55EFGLthxlPkZx/hlyF7/C16tzPhOpFy6eZU+mv8nUSx4AGZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNw5vBUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B53BC4CEE2;
	Wed, 26 Mar 2025 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743004712;
	bh=9m9MReJ7JJiilrI+wNCXRHg87GEezlJxw8QAA1k6d3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNw5vBUNulOOnb7EWs1jDQByEuTMcL1NnpfdZftLTaEPlMwZGVfO8wsYB3yoI2djX
	 gyZbY/RASyhK2nkkmyAu5DwOVz0aSjxSVj4iG4raR6INcUQwxf/WpdVUb8ZT+z1Xux
	 m4/YpIcd9+vGh5LyyvvyPTotZY7ehi4iPPRykir/tINJiDJ0X/ILRU/ItpsJ/+zjif
	 E3sFg8u4ER4HMx6kzD95eKY2F/vPj98NXd819B6JaN8lXIar9q91cuECVDKnG26ltR
	 8Dft+ou6o78s2lgLwjIZiuZab7wNZqS3nbPHv2LhO+DjC+J+53qLYHiN4gcqZpzpi7
	 5JjzLSOWqL+IQ==
Date: Wed, 26 Mar 2025 17:58:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z-QkGUenPAMid63l@kernel.org>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
 <Z-I86tWMcD6b_YeM@sumit-X1>
 <Z-Pu4FhcntnKii61@kernel.org>
 <Z+QQWe/upJuVpU8r@ziepe.ca>
 <Z-QV5y1JGBDpsPuH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tV7JfXtZF8fCdQbj"
Content-Disposition: inline
In-Reply-To: <Z-QV5y1JGBDpsPuH@kernel.org>


--tV7JfXtZF8fCdQbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 04:57:47PM +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 26, 2025 at 11:34:01AM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 26, 2025 at 02:11:12PM +0200, Jarkko Sakkinen wrote:
> > 
> > > Generally speaking I don't see enough value in complicating
> > > callback interface. It's better to handle complications in
> > > the leaves (i.e. dictatorship of majority ;-) ).
> > 
> > That is very much not the way most driver subsystems view the
> > world. We want to pull logical things into the core code and remove
> > them from drivers to make the drivers simpler and more robust.
> > 
> > The amount of really dumb driver boiler plate that this series
> > obviously removes is exactly the sort of stuff we should be fixing by
> > improving the core code.
> > 
> > The callback interface was never really sanely designed, it was just
> > built around the idea of pulling the timout processing into the core
> > code for TIS hardware. It should be revised to properly match these
> > new HW types that don't have this kind of timeout mechanism.
> 
> Both TIS and CRB, which are TCG standards and they span to many
> different types of drivers and busses. I don't have the figures but
> probably they cover vast majority of the hardware.
> 
> We are talking about 39 lines of reduced complexity at the cost
> of complicating branching at the top level. I doubt that there
> is either any throughput or latency issues.
> 
> What is measurable benefit? The rationale is way way too abstract
> for me to cope, sorry.

E.g., here's how you can get rid of extra cruft in tpm_ftpm_tee w/o
any new callbacks.

BR, Jarkko

--tV7JfXtZF8fCdQbj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tpm-Make-chip-status-cancel-req_canceled-opt.patch"

From 1125e80ea274a5ec5d5dba32bfce716ce62c5e4a Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Wed, 26 Mar 2025 17:55:49 +0200
Subject: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt

tpm_ftpm_tee does not require chip->status, chip->cancel and
chip->req_canceled. Make them optional.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 31 ++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm_ftpm_tee.c  | 18 ------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f62f7871edbd..10ba47a882d8 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -58,6 +58,30 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
 
+static void tpm_chip_cancel(struct tpm_chip *chip)
+{
+	if (!chip->ops->cancel)
+		return;
+
+	chip->ops->cancel(chip);
+}
+
+static u8 tpm_chip_status(struct tpm_chip *chip)
+{
+	if (!chip->ops->status)
+		return 0;
+
+	return chip->ops->status(chip);
+}
+
+static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
+{
+	if (!chip->ops->req_canceled)
+		return false;
+
+	return chip->ops->req_canceled(chip, status);
+}
+
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 {
 	struct tpm_header *header = buf;
@@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	ssize_t len = 0;
 	u32 count, ordinal;
 	unsigned long stop;
+	u8 status;
 
 	if (bufsiz < TPM_HEADER_SIZE)
 		return -EINVAL;
@@ -104,12 +129,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 
 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
 	do {
-		u8 status = chip->ops->status(chip);
+		status = tpm_chip_status(chip);
 		if ((status & chip->ops->req_complete_mask) ==
 		    chip->ops->req_complete_val)
 			goto out_recv;
 
-		if (chip->ops->req_canceled(chip, status)) {
+		if (tpm_chip_req_canceled(chip, status)) {
 			dev_err(&chip->dev, "Operation Canceled\n");
 			return -ECANCELED;
 		}
@@ -118,7 +143,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		rmb();
 	} while (time_before(jiffies, stop));
 
-	chip->ops->cancel(chip);
+	tpm_chip_cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
 	return -ETIME;
 
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 8d9209dfc384..3732f3623537 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -164,30 +164,12 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	return 0;
 }
 
-static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
-{
-	/* not supported */
-}
-
-static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
-{
-	return 0;
-}
-
-static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
-{
-	return false;
-}
-
 static const struct tpm_class_ops ftpm_tee_tpm_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.recv = ftpm_tee_tpm_op_recv,
 	.send = ftpm_tee_tpm_op_send,
-	.cancel = ftpm_tee_tpm_op_cancel,
-	.status = ftpm_tee_tpm_op_status,
 	.req_complete_mask = 0,
 	.req_complete_val = 0,
-	.req_canceled = ftpm_tee_tpm_req_canceled,
 };
 
 /*
-- 
2.39.5


--tV7JfXtZF8fCdQbj--

