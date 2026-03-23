Return-Path: <linux-integrity+bounces-9041-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMs0BQNFwWnpRwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9041-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 14:49:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EA2F34F7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 14:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C84B43061749
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54353AB295;
	Mon, 23 Mar 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=trunixcodes@zohomail.com header.b="PzeuQvOq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A73AA1BB;
	Mon, 23 Mar 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273355; cv=pass; b=mn9fP985gDcfmjp725dWaSbHJEVwRDra83aD8doCHYTXYcTZr8AEeqk85NE0ShL6835JHX6g+xh4JdPThTMNiSpPxG1yTLP+iJHxzO+7nhjEOryeTP9exLpwL4DDIgLTDBlDK2TfHDEeVB+8hAVPsE9W/3iQBdl2YEhbUBy3ZIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273355; c=relaxed/simple;
	bh=/Zq8pUGdEs2OEJGx8xgc0ULpnnxaadIxF0/6iRXoUTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px70PAW7TxyUSXWm7lWYRul3AABkJ0jxPMW6+R4VYIZ4QpgM4mi+nvqEvXIDTUchmiNWpng5w99YuE/lsFh5GdMBKnJMVPad3Fu4hj5t7L7xVJqh2QvDY4ea5YOXuwBv5CwQ5/kKT5B9BG2YUpnCAqXHzSlpIDIp3vGObZ/BOhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=trunixcodes@zohomail.com header.b=PzeuQvOq; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1774273332; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YWLMt1BESz0MDJjpIIoY7lbYGoBRIuj33ljFEmeSeZqYLKo3+hKwNjGByRc0GRpOi6C2DOzexIDl7KMjdOLpQagFz8cmWDk8Yp4TWCGCdOF8Z/X+J9sJKeZGvXIp74XfN3Dt+sil0cWQ1HMn35Xh3DC1p3KfKpOqyz4SYx+vhfA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774273332; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B/YWoZ3/P7yhoach9i5x35UvO4eHF6OSW5RXxRtkbv8=; 
	b=c+/0LEkWxn8b+GazaZ0hzWuxWGBF3qSJ4foEfi07WkFvuBVYMXQhYQPBpouXxoMXr1R/usFVFG2fa/0urWGN5n1cPzU9TXZ0BLKLjrKybqevlUC4xDRHNDXCYOvkOVi4y9gQ0OLNrDw2FPLS8u55JoG55tUI4Zp9eYmMOu4WXLU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=trunixcodes@zohomail.com;
	dmarc=pass header.from=<trunixcodes@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774273332;
	s=zm2022; d=zohomail.com; i=trunixcodes@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=B/YWoZ3/P7yhoach9i5x35UvO4eHF6OSW5RXxRtkbv8=;
	b=PzeuQvOqP58m2fvoBqtKod2LL54xID/NdzECU7cl/IZ02DOlxfjbzdgcb9ZgGoV8
	n7D4L1P0ON713IQs3iCAKvcRJx82jzMbvr2wI5VFif5J2Fzq2aEYQmPFVthteyGAv/6
	+nHUEZMUBY2RIgxQxUJHGyYedmmGiMDcUnuOUVQQ=
Received: by mx.zohomail.com with SMTPS id 1774273331223815.8540051298768;
	Mon, 23 Mar 2026 06:42:11 -0700 (PDT)
From: Ethan Luna <trunixcodes@zohomail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: i2c: atmel: fix block comment formatting
Date: Mon, 23 Mar 2026 06:40:49 -0700
Message-ID: <20260323134200.7766-1-trunixcodes@zohomail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112276cb5c677688b0b5d5a8bdc4700000e571217a95e1510df44e1961518088c0ac02099ae0364b407:zu0801122744ffdf8d598da53cf7b50c340000fb9598dcb6b536ab228881c1662b59ba53ed999511fea69f49:rf0801122cf7ce3eb0d7f27411f9ae9099000095ac9992e66c5daedf75e7720fa1c9b1866df24cda0360e94f433d2aafd1:ZohoMail
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9041-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zohomail.com:dkim,zohomail.com:email,zohomail.com:mid]
X-Rspamd-Queue-Id: 503EA2F34F7
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

v1: https://lore.kernel.org/all/20260322193112.27010-1-trunixcodes@zohomail.com/

 drivers/char/tpm/tpm_i2c_atmel.c | 34 +++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 4f229656a8e2..c3cdc0d6e61c 100644
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


