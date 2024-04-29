Return-Path: <linux-integrity+bounces-2259-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92998B6380
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C041C22005
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9813AD2F;
	Mon, 29 Apr 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pPL41kRr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7413AA5D;
	Mon, 29 Apr 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422518; cv=none; b=Ye9m9mxE3gSo82ou5JZwlGsQfz30xrd2W3ZqanWj/7v4LgYjI1Vq291MgsQQ/+IqESeyiye9+G9paPDv8Uw/+jvNJV6nKoKbEmwrSBr4hByLnla/pZYP37bPNzXGkHHHbs8zJ/iufC21qhMd0o1dY9i4tIKH1nJzBI/URpheILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422518; c=relaxed/simple;
	bh=Wyr9ED2k1aUHQpzYMoWHKIOFQOSaFOeR+LbNUxV2M34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXUQaY2XjlFnhxfX9qxZG+3lt+6qQb/eRjiHw0zmrh5LIb86vl5/ZEdyvsxxRJtqG4HP5e5FCU16l5f0LupDRx6X6PJXG+StT//sJ/CjtghoQshRcYBKsh7/Up5atln9KjjYhU81S4RkLoAp1NHG+c/E4MKoWixnQO+dN7OBdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=pPL41kRr; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422516;
	bh=Wyr9ED2k1aUHQpzYMoWHKIOFQOSaFOeR+LbNUxV2M34=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=pPL41kRrTjK68lUz4vYG+a7nqwuamXRFFya4XyyAXwYi143gr7QpFNBpHi8Rg5ScX
	 dSQsbXC4K/x3Zzqxcyo4urfZbGBrva9oIIUmxHF0sffHKa/ywT7DdkhOefhhjkA8nH
	 sLbD2VZ1kSi1RdNZxJZOCuNaEyX6oRBK88M3gCkg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C80A71281D87;
	Mon, 29 Apr 2024 16:28:36 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5ToJYGgs_Si0; Mon, 29 Apr 2024 16:28:36 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 33D1612819F3;
	Mon, 29 Apr 2024 16:28:35 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 02/22] tpm: Remove tpm_send()
Date: Mon, 29 Apr 2024 16:27:51 -0400
Message-Id: <20240429202811.13643-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
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
index 757336324c90..f940045a014e 100644
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


