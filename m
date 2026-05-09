Return-Path: <linux-integrity+bounces-9507-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC23OTOC/2kw7QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9507-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 20:51:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 523545010BB
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 20:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBE2300F5D1
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B883016FB;
	Sat,  9 May 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdpEEOCL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345761A316E;
	Sat,  9 May 2026 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778352689; cv=none; b=upbjo9j8kbrzBqRfWgp2PAE7dlbHaj5zp3Iy5Y1+NuvdpxqQojYgZ4CC16MPR4BosW3l8GwonPuYwsx1pUOyai4Ed7zOkFR/VxQLf84jL2EL0tXRT56qkcat1IppHJZ0fTj/FSbA/QPyBMOZWYNWTezvljjWVZedmfX1NgMZxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778352689; c=relaxed/simple;
	bh=U/l5ecjWoPA3uBSBClQ6V2t87GiPQTd+0V5zvKq22qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NK7paz9uu2T/+5rQTzUJtgcIQqnMTq/ybRf2NWlfS2SQKteUlFoucOb7YKD4PQKYQaP0u87huM8ZIgoms8LzyV2Ouy3/2DoYCEXnR44c/YXdDmVMCmIhC9/+i5mH3MiPx3HOu95FJssRmZ7p0EoYCQtV9LywF8gU57QMGvYW4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdpEEOCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E7BC2BCB2;
	Sat,  9 May 2026 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778352688;
	bh=U/l5ecjWoPA3uBSBClQ6V2t87GiPQTd+0V5zvKq22qY=;
	h=From:To:Cc:Subject:Date:From;
	b=DdpEEOCLtKpE7Z9TIvZL6g3RB7fQfGVnvKXLljNFilsKy5SgK0/xq1sE4Nkwpl33F
	 ONIlWxKyTDqIFi/GrRM9zCApzOiUKqIS+mJw5kliiU4chb9pNwVhOas8bCWcZnAJQ4
	 tWebG3CMtt1k66ZE56Z/bIiHHPY2Z/vdJx7Uj51hkhq3DxP4SpUJYNhJqaw6qsrhBN
	 F+qursnkI6dXWUqxpORbQlrW1CdY4BceNHD90d90okhr5U7dJ0Xl758ISRXqJgpcwb
	 /NX7LhfQ5cdBIdbPrn4y5qFxBrTO+9Br5C4gkqdBV1GtPuYc84pDHGMdY/xf43G7br
	 wnVp9knuG1EmQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
Date: Sat,  9 May 2026 21:51:07 +0300
Message-ID: <20260509185108.2681198-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 523545010BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.net,gmx.de,ziepe.ca];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9507-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

wait_event_interruptible_timeout() evaluates its condition after setting
the current task state to TASK_INTERRUPTIBLE.

With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
path is used:

    tpm_tis_status()
      tpm_tis_spi_read_bytes()
        tpm_tis_spi_transfer_full()
          spi_bus_lock()
            mutex_lock()

Address this with the following measures:

1. Call wait_tpm_stat_cond() only while tasking is running.
2. Use wait_woken() to wait for changes.

Cc: stable@vger.kernel.org # v4.19+
Cc: Linus Walleij <linusw@kernel.org>
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Closes: https://lore.kernel.org/linux-integrity/6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net/
Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Linus' change only unmasked a pre-existing bug but it is the change
realizes it in tpm_tis_spi.
 drivers/char/tpm/tpm_tis_core.c | 35 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 21d79ad3b164..153a57c79240 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -66,8 +66,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		bool check_cancel)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	unsigned long stop;
-	long rc;
 	u8 status;
 	bool canceled = false;
 	u8 sts_mask;
@@ -87,23 +87,30 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	/* process status changes with irq support */
 	if (sts_mask) {
 		ret = -ETIME;
+		add_wait_queue(queue, &wait);
 again:
+		if (wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
+					   &canceled)) {
+			ret = canceled ? -ECANCELED : 0;
+			goto out;
+		}
+
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -ETIME;
-		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
-					       &canceled),
-			timeout);
-		if (rc > 0) {
-			if (canceled)
-				return -ECANCELED;
-			ret = 0;
-		}
-		if (rc == -ERESTARTSYS && freezing(current)) {
-			clear_thread_flag(TIF_SIGPENDING);
-			goto again;
+			goto out;
+
+		if (signal_pending(current)) {
+			if (freezing(current)) {
+				clear_thread_flag(TIF_SIGPENDING);
+				goto again;
+			}
+			goto out;
 		}
+
+		wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
+		goto again;
+out:
+		remove_wait_queue(queue, &wait);
 	}

 	if (ret)
--
2.47.3


