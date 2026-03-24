Return-Path: <linux-integrity+bounces-9059-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B09A7azwmkvlAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9059-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 16:54:30 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9653186EC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 16:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42186300187A
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E167402459;
	Tue, 24 Mar 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=trunixcodes@zohomail.com header.b="NeMQ5eW3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB03F661D;
	Tue, 24 Mar 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367062; cv=pass; b=NDjEE0X99iBzKDY00AkXG4vX8ph8y9+bUdVfPtmmUf7tDQZ+aARUV7j5CaGCYmRf2hOa1Hk0suyI9AYrhp+/8PK0mBD6r/JbESviLHk5LQmWyShAkN0KC8NDjmuKX9o/EXU5cG1RNbOlcbNGZinCuQBLCvjJ2VNMvtFaQPwWmxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367062; c=relaxed/simple;
	bh=GuHj6Eiic+06gWlzIz+dMJjHXMX3nnTQ36S6qVt0JZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN1B8TIFqSUOjrvPnXf+47Q6xZommAWd22vMFoEwQb4HfiktlM0QB1Nc7seR52c1dCOXn5w9962bM+AqmEQwdnMY8s2saJYhVxT5jph/AVv5MuglucPGF162BKKnj3KchTI/Nsd420yT000zxIy3MmmCIaxaT+FYgSmqGfk0VQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=trunixcodes@zohomail.com header.b=NeMQ5eW3; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1774367049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Blp/UJoXI172pbZdvmEIK05VbZv2zruec5pshAWWqMnPazuKziYduXgdZo3FhuNtH4MngV0mZvA05h1jXsXynF7p8SoIu1QSayn8hEnII8qFwBK4aZmfKeTpHcXdFne9WMgJ32gzX3/rFEY8smX3Ytjl3rBSD+Mtb9sKaaB+CeA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774367049; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q4yFcdfLoMycK9iVMeBa6vV12EYRDZRmWmYAs97jeLQ=; 
	b=RdOYcfhscAgFPTxY5+WSXXJeIXUBxlsxc+HTH9tSUmXY8/8EQa6dRgSe11Ic9qOdEk2ifEATtTBi9Vhqh0uYXoF2klIrWqgp/DAPr49ujJ9VTS0vM4lizPOCVOTuXKGQbLnzjGGQmDRcGy1RyJnyqQEbdJgDRrXuDt1jWtW4Ul8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=trunixcodes@zohomail.com;
	dmarc=pass header.from=<trunixcodes@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774367049;
	s=zm2022; d=zohomail.com; i=trunixcodes@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=q4yFcdfLoMycK9iVMeBa6vV12EYRDZRmWmYAs97jeLQ=;
	b=NeMQ5eW3RNvZicBqF+3c1OklOIDc6o5AkDzvjU5r7Fmvo4URvhch2jPOQVmvKsUf
	sOq0TSuvYxI1fIKhhWdQOPsJnualnnFN1SADSyYU7ggzZfS3XX6OLjMqk24VXztoq8A
	iYtmTmNEp9pjfye5iUynoaQzVs6PJITn0sjgLKXo=
Received: by mx.zohomail.com with SMTPS id 1774367047799293.29233390284094;
	Tue, 24 Mar 2026 08:44:07 -0700 (PDT)
From: Ethan Luna <trunixcodes@zohomail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] tpm: i2c: atmel: fix block comment formatting
Date: Tue, 24 Mar 2026 08:39:49 -0700
Message-ID: <20260324154354.6268-1-trunixcodes@zohomail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227bdff1a87741d6709db5417dd00007eedcf7322d31ae1c5a34cc6c3bd9219f07974fcc15b1ee4de:zu080112272e0c313d4a7e07d895724df10000a6a1bd546eab8626b83cada607efcf8f59a215f912017407a9:rf0801122cb8c3cf8ada706d2083c6e60c0000db61e0e54f3a3b7f1d26843295d99223e8c6da0d3ac33d90fefd91b4e187:ZohoMail
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9059-lists,linux-integrity=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trunixcodes@zohomail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[zohomail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D9653186EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple block comments in tpm_i2c_atmel.c placed the closing '*/' on the
same line as the comment text. This violates the kernel's preferred
comment style, which requires the closing delimiter to appear on its
line.

Fix the formatting to improve readability and resolve checkpatch
warnings.

Signed-off-by: Ethan Luna <trunixcodes@zohomail.com>
---

V1 -> V2: Fixed block comment formatting consistently across all multi-line comments
V2 -> V3: Fixed trailing whitespaces consistently across all multi-line comments

v1: https://lore.kernel.org/all/20260322193112.27010-1-trunixcodes@zohomail.com/
v2: https://lore.kernel.org/all/20260323134200.7766-1-trunixcodes@zohomail.com/

 drivers/char/tpm/tpm_i2c_atmel.c | 34 +++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 4f229656a8e2..9fd73049821f 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -31,9 +31,11 @@
 
 struct priv_data {
 	size_t len;
-	/* This is the amount we read on the first try. 25 was chosen to fit a
+	/*
+	 * This is the amount we read on the first try. 25 was chosen to fit a
 	 * fair number of read responses in the buffer so a 2nd retry can be
-	 * avoided in small message cases. */
+	 * avoided in small message cases.
+	 */
 	u8 buffer[sizeof(struct tpm_header) + 25];
 };
 
@@ -58,7 +60,9 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	if (status < 0)
 		return status;
 
-	/* The upper layer does not support incomplete sends. */
+	/*
+	 * The upper layer does not support incomplete sends.
+	 */
 	if (status != len)
 		return -E2BIG;
 
@@ -76,9 +80,11 @@ static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	if (priv->len == 0)
 		return -EIO;
 
-	/* Get the message size from the message header, if we didn't get the
+	/*
+	 * Get the message size from the message header, if we didn't get the
 	 * whole message in read_status then we need to re-read the
-	 * message. */
+	 * message.
+	 */
 	expected_len = be32_to_cpu(hdr->length);
 	if (expected_len > count)
 		return -ENOMEM;
@@ -111,15 +117,19 @@ static u8 i2c_atmel_read_status(struct tpm_chip *chip)
 	struct i2c_client *client = to_i2c_client(chip->dev.parent);
 	int rc;
 
-	/* The TPM fails the I2C read until it is ready, so we do the entire
+	/*
+	 * The TPM fails the I2C read until it is ready, so we do the entire
 	 * transfer here and buffer it locally. This way the common code can
-	 * properly handle the timeouts. */
+	 * properly handle the timeouts.
+	 */
 	priv->len = 0;
 	memset(priv->buffer, 0, sizeof(priv->buffer));
 
 
-	/* Once the TPM has completed the command the command remains readable
-	 * until another command is issued. */
+	/*
+	 * Once the TPM has completed the command the command remains readable
+	 * until another command is issued.
+	 */
 	rc = i2c_master_recv(client, priv->buffer, sizeof(priv->buffer));
 	dev_dbg(&chip->dev,
 		"%s: sts=%d", __func__, rc);
@@ -172,9 +182,11 @@ static int i2c_atmel_probe(struct i2c_client *client)
 
 	dev_set_drvdata(&chip->dev, priv);
 
-	/* There is no known way to probe for this device, and all version
+	/*
+	 * There is no known way to probe for this device, and all version
 	 * information seems to be read via TPM commands. Thus we rely on the
-	 * TPM startup process in the common code to detect the device. */
+	 * TPM startup process in the common code to detect the device.
+	 */
 
 	return tpm_chip_register(chip);
 }
-- 
2.53.0


