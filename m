Return-Path: <linux-integrity+bounces-8310-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBXxInhudmneQgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8310-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:26:48 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4682198
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B453018BE8
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FC2F3612;
	Sun, 25 Jan 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpLG/fV0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FF2F12A5;
	Sun, 25 Jan 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369148; cv=none; b=Qy6i4dtbDHljYchZZNbuetIGIGA11Gh+1/E39DvQ//ADxuQnS3DNxwspsMSLhNrauMWd54JMpFexltTyNpplgvFts6Scbfjz13PG6r5u8qB+KtZwxSnc/dlj/MRnMZnoCG176hp/nAsRJ3VpFURezey5E2OR+ILvCpPCHHgN9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369148; c=relaxed/simple;
	bh=8pp+fW6JLbhqi+9zPhmUF2VbrqvhQc+UaIFr3qgiAlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvtu7bkoVedKirWQEVWEXX0ckzNUa2r5aH0Bx/mKT4T/wEDqGfs12Gyd62/mkaakKwHzQRNj3H0FXSLSx1E9PUCHHkIKDLjBnavkhwwYf+WRhHTdXP/XHrOlE7WMItH3YGDRUapAwOfDtBGkC8FfqcyLQnMXrRjzr4Z7mZtgn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpLG/fV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00E8C4CEF1;
	Sun, 25 Jan 2026 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369148;
	bh=8pp+fW6JLbhqi+9zPhmUF2VbrqvhQc+UaIFr3qgiAlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpLG/fV07zyT+sqqUhkTdKAGXL4uFH/XW4PSZRgMRPr7aeUaE27UmQLCk8ZyFZuGB
	 TOK3Iu3zc35mGPYpN9pYsA+cSNJkTvkxVHKJUWvdPG6FOkRHyQL2s86ny+ZEYBhURD
	 KxZp9gnV+zyjXg09zftS5MvRzCEoEqKfLEExEd1UAT8ElaSmTVeSJzO9ojcrk3/EM1
	 6Q8Hh8lUJKocbkTfVAYajh4WWGzzrt5/6ZotNfVn/YrKZlA/knA+SedpeCH3Qy2fOi
	 +ox2CRGcs3jxyuyV+a+pjmRecwg3LPywAqpL8JtXpY5W2PSkvtkWNKEhMHkKsKCVPC
	 FYPKwqcunjPGA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@meta.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 02/11] KEYS: trusted: Use get_random_bytes_wait() instead of tpm_get_random()
Date: Sun, 25 Jan 2026 21:25:12 +0200
Message-ID: <20260125192526.782202-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125192526.782202-1-jarkko@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8310-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35F4682198
X-Rspamd-Action: no action

Substitute the remaining tpm_get_random() calls in trusted_tpm1.c with
get_random_bytes_wait() thus aligning random number generation for TPM 1.2
with the removal of '.get_random' callback.

Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm1.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 7ce7e31bcdfb..3d75bb6f9689 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -371,13 +371,10 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 	unsigned char ononce[TPM_NONCE_SIZE];
 	int ret;
 
-	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
+	ret = get_random_bytes_wait(ononce, TPM_NONCE_SIZE);
 	if (ret < 0)
 		return ret;
 
-	if (ret != TPM_NONCE_SIZE)
-		return -EIO;
-
 	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OSAP);
 	tpm_buf_append_u16(tb, type);
 	tpm_buf_append_u32(tb, handle);
@@ -464,15 +461,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	memcpy(td->xorwork + SHA1_DIGEST_SIZE, sess.enonce, SHA1_DIGEST_SIZE);
 	sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
 
-	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
+	ret = get_random_bytes_wait(td->nonceodd, TPM_NONCE_SIZE);
 	if (ret < 0)
 		goto out;
 
-	if (ret != TPM_NONCE_SIZE) {
-		ret = -EIO;
-		goto out;
-	}
-
 	ordinal = htonl(TPM_ORD_SEAL);
 	datsize = htonl(datalen);
 	pcrsize = htonl(pcrinfosize);
@@ -575,14 +567,10 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
-	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
+	ret = get_random_bytes_wait(nonceodd, TPM_NONCE_SIZE);
 	if (ret < 0)
 		return ret;
 
-	if (ret != TPM_NONCE_SIZE) {
-		pr_info("tpm_get_random failed (%d)\n", ret);
-		return -EIO;
-	}
 	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
 			   enonce1, nonceodd, cont, sizeof(uint32_t),
 			   &ordinal, bloblen, blob, 0, 0);
-- 
2.52.0


