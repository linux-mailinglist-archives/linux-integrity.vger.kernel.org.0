Return-Path: <linux-integrity+bounces-1165-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF618536F9
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03871F29232
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E015FDAD;
	Tue, 13 Feb 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="TVzNnSir"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833735FB95;
	Tue, 13 Feb 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844494; cv=none; b=TP4A2Bo/P8KPmDF8FK7TrcGhphoZCI/6vz9KQQ3L4/j67IipniH4gvMorBCJiOWwxYnLxZL2AgKs8T35/hGjE82fF80yRKPVYO8nNA5ORHo9OlfMfgtnYszcl5gQL//1RFEucWUD3x5zeA29FQbmWPAbDhPh8yLFXacIroLfF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844494; c=relaxed/simple;
	bh=uVPIF2oQhcvsq6X6zwcDm6UdEypoJBqUv1DEY0DqlPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m85CDjgF+p52MOTKlw9hPwjPMR7DhSZ32HimOR25QfrHp+RtOouF+d26xE1eMcCGv2X1mw+dZ1Wthd+pVaB3n8r9a0uPJVR7FuHZi5GZelLDacpiIDZEpqQwnmwP2v7YUMUZxoQv4YTppVvuwZyjIbao2rqCRxG9dgENaGepevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=TVzNnSir; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844491;
	bh=uVPIF2oQhcvsq6X6zwcDm6UdEypoJBqUv1DEY0DqlPA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=TVzNnSirWCt4dgMEVJQD3enVpTtbU705Tdg0W3YfVFEHbI1U0e7AdviH8cBWGTWlK
	 ciKfB563mB1qXD0jghOt5KEl6TyndpT1A3a6F6uFYnxdWmqIYp/drDYoXphFA67b3C
	 WcLgXKGmYcGpNW/wl0K+SS5DBL2kLYCLBKBZq8FA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1695D1280C16;
	Tue, 13 Feb 2024 12:14:51 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hvs2PoG6QUMX; Tue, 13 Feb 2024 12:14:51 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 38C1D1280BAC;
	Tue, 13 Feb 2024 12:14:50 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 02/21] tpm: Remove tpm_send()
Date: Tue, 13 Feb 2024 12:13:15 -0500
Message-Id: <20240213171334.30479-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

Open code the last remaining call site for tpm_send().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-interface.c          | 25 -----------------------
 include/linux/tpm.h                       |  5 -----
 security/keys/trusted-keys/trusted_tpm1.c | 14 +++++++++++--
 3 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..163ae247bff2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -342,31 +342,6 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 
-/**
- * tpm_send - send a TPM command
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @cmd:	a TPM command buffer
- * @buflen:	the length of the TPM command buffer
- *
- * Return: same as with tpm_transmit_cmd()
- */
-int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	chip = tpm_find_get_ops(chip);
-	if (!chip)
-		return -ENODEV;
-
-	buf.data = cmd;
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command");
-
-	tpm_put_ops(chip);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tpm_send);
-
 int tpm_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6588ca87cf93..d9d645e9c52c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -422,7 +422,6 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
-extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
@@ -443,10 +442,6 @@ static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return -ENODEV;
 }
 
-static inline int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
-{
-	return -ENODEV;
-}
 static inline int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max)
 {
 	return -ENODEV;
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index aa108bea6739..37bce84eef99 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -356,17 +356,27 @@ static int TSS_checkhmac2(unsigned char *buffer,
  */
 int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 {
+	struct tpm_buf buf;
 	int rc;
 
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc)
+		return rc;
+
+	buf.flags = 0;
+	buf.data = cmd;
 	dump_tpm_buf(cmd);
-	rc = tpm_send(chip, cmd, buflen);
+	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
 	dump_tpm_buf(cmd);
+
 	if (rc > 0)
-		/* Can't return positive return codes values to keyctl */
+		/* TPM error */
 		rc = -EPERM;
+
+	tpm_put_ops(chip);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(trusted_tpm_send);
-- 
2.35.3


