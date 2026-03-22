Return-Path: <linux-integrity+bounces-9027-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tMfYHaJDwGmyFQQAu9opvQ
	(envelope-from <linux-integrity+bounces-9027-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 20:31:46 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA62EA7F0
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 20:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2884030022F2
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 19:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A923BD06;
	Sun, 22 Mar 2026 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=trunixcodes@zohomail.com header.b="bpvhWdoB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B36309EEC;
	Sun, 22 Mar 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774207902; cv=pass; b=HbH40IKD9UjEw3+gshYCvNhgZ7uvZyRaC7BLvg9nXcWcJnyll4l1gWoBu57Q4q/07Q575WWcoTA0M3HD8CzbYpIREzz/umXAPDQS40aj3G1ebe3Do2wi35jnZVFj1XtZT/tgNNiy6TVZmF+yXWQfBA8h4TU9ks3+YggkocFWysY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774207902; c=relaxed/simple;
	bh=OTI8+vDsZvX3aK1H28ES2uepJ3ym4OmJcN8oDKjKTRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6z5UUmBVb7vRL5APB1/mKaXOuN8a/MiLT4sSCcpqCv00rymfT/dhoGWfBkNlg47/2S6JWTC+6GPnJQHCtC3jpDNikFf5zwteAY+w2dYt8LQ/87W4bee+7yeYoYgzPyrlMv/2JzQBYpxVqQN6bblCTr/1SxR1Y7i1tJwNuPkGmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=trunixcodes@zohomail.com header.b=bpvhWdoB; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1774207890; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J3cDix5VB1py9kf2wIZuA7ibG4u1c/vG38kcOOlEseCN1Bm03Gt2KdkX9XfA4rMkpnhg7Ko+gIiduMXzJMaeCBdj1xpzmbSudz08qsE0UvyujkUjF7XNAlPP0pl1efDNrRVtWSH2pjQa7MB4I2/e/+3RCjlDdqT/C1mIFCqQyDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774207890; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=irObMARTu7OYKbVotrsF13+CshxCWsyGdlJ7aH8njPs=; 
	b=NPrQ0JLb2tlmxuuaUJ/52d85+soHFXg4Uezmf7Heoj9rfqzvRVxDfO8JTwMCPgQ1tL3r94/6O6Fx+64aPrWOdFZxXX1CxqRItIxRqTDKvAlcFlDTHzbJvdEW9ocVhfDoQF4l5ZE303dAP64HEJGQwl5nuSraxrucbGuIwT20zSk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=trunixcodes@zohomail.com;
	dmarc=pass header.from=<trunixcodes@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774207890;
	s=zm2022; d=zohomail.com; i=trunixcodes@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=irObMARTu7OYKbVotrsF13+CshxCWsyGdlJ7aH8njPs=;
	b=bpvhWdoBoEs4ZJAF2cZGbYp9V4iX04t4gWQHfBULkUvZamwk5kM/Dgpq54C6Uc09
	QpBpuB/oBJ01hOU6LXAW8Xdw6kLqI332DGFrJB+AixFngbJEwMe733mMnuSlsOUc6i3
	X4YrD8rRHyFO9Y9iv93kGb37fK7CaaNCEh/n8VLo=
Received: by mx.zohomail.com with SMTPS id 1774207888060202.5064995328131;
	Sun, 22 Mar 2026 12:31:28 -0700 (PDT)
From: Ethan Luna <trunixcodes@zohomail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: i2c: atmel: fix block comment formatting
Date: Sun, 22 Mar 2026 12:30:53 -0700
Message-ID: <20260322193112.27010-1-trunixcodes@zohomail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227ea8742baf121abc909a485a900003ec67e16a58d3c7f0ec29c376718cc3cd5cf2f6cf5bde7621d:zu08011227862303805a5ef1e3198b1aae0000d0675014352d9e765290464e412216665ef2944e3e8c4eb1a5:rf0801122cb2892a739f674a0a6256272f0000ccfed82642d4b85ccd12da2497b88c075a7e024eaf7995cdc3ecfefdacd4:ZohoMail
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9027-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zohomail.com:dkim,zohomail.com:email,zohomail.com:mid]
X-Rspamd-Queue-Id: 0CFA62EA7F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple block comments in tpm_i2c_atmel.c placed the closing '*/' on the
same line as the comment text. This violates the kernel's preferred
comment style, which requires the closing delimiter to appear on it's
line.

Fix the formatting to improve readability and resolve checkpatch
warnings.

Signed-off-by: Ethan Luna <trunixcodes@zohomail.com>
---
 drivers/char/tpm/tpm_i2c_atmel.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 4f229656a8e2..702b3c9191dc 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -33,7 +33,8 @@ struct priv_data {
 	size_t len;
 	/* This is the amount we read on the first try. 25 was chosen to fit a
 	 * fair number of read responses in the buffer so a 2nd retry can be
-	 * avoided in small message cases. */
+	 * avoided in small message cases.
+	 */
 	u8 buffer[sizeof(struct tpm_header) + 25];
 };
 
@@ -58,7 +59,9 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	if (status < 0)
 		return status;
 
-	/* The upper layer does not support incomplete sends. */
+	/*
+	 * The upper layer does not support incomplete sends.
+	 */
 	if (status != len)
 		return -E2BIG;
 
@@ -78,7 +81,8 @@ static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 
 	/* Get the message size from the message header, if we didn't get the
 	 * whole message in read_status then we need to re-read the
-	 * message. */
+	 * message.
+	 */
 	expected_len = be32_to_cpu(hdr->length);
 	if (expected_len > count)
 		return -ENOMEM;
@@ -113,13 +117,15 @@ static u8 i2c_atmel_read_status(struct tpm_chip *chip)
 
 	/* The TPM fails the I2C read until it is ready, so we do the entire
 	 * transfer here and buffer it locally. This way the common code can
-	 * properly handle the timeouts. */
+	 * properly handle the timeouts.
+	 */
 	priv->len = 0;
 	memset(priv->buffer, 0, sizeof(priv->buffer));
 
 
 	/* Once the TPM has completed the command the command remains readable
-	 * until another command is issued. */
+	 * until another command is issued.
+	 */
 	rc = i2c_master_recv(client, priv->buffer, sizeof(priv->buffer));
 	dev_dbg(&chip->dev,
 		"%s: sts=%d", __func__, rc);
@@ -174,7 +180,8 @@ static int i2c_atmel_probe(struct i2c_client *client)
 
 	/* There is no known way to probe for this device, and all version
 	 * information seems to be read via TPM commands. Thus we rely on the
-	 * TPM startup process in the common code to detect the device. */
+	 * TPM startup process in the common code to detect the device.
+	 */
 
 	return tpm_chip_register(chip);
 }
-- 
2.53.0


