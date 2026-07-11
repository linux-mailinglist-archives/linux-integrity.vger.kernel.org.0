Return-Path: <linux-integrity+bounces-9916-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rTzKYJpUmoKPgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9916-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:04:18 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AB07421AE
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:04:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="bb3GS/A3";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9916-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9916-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B16C301F142
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EDB3612EE;
	Sat, 11 Jul 2026 16:01:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64923CE4B9
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 16:01:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785699; cv=none; b=uzSqE86bTBdrSyIfnjoIQswVDWk/P+vzW9pHDFpbFxDXT+rzkGk+7b7t58JyP9MrjK85/Vd05fvXa9dmoKX2AbWrTEPBPnl1Xz98KF/V4Hc7uaMSY19zw0botGjvQrm7rd3h9j9YRpyyNmAHphXvJxpoh7e/qnGLo5yVAykKz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785699; c=relaxed/simple;
	bh=1PD25Skogk+2yRj9Uzijb04l6UX9XacubnQOr/KgGiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxqM/p4rRgMew2JbFsyJpdFqnGNTsXgnttUU+fy/IedU4LXmgFAiWcaToiN5qU+nSm0xhtCjX3EgkYGAbGfWYUnAaLFREnGyqXPDXLf0N8UmnZtzgdYVup+jLpRi80S2wzY8MmWnkRf6a/rHhYMOkEQI5MhpodXYFUB8wV+BXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb3GS/A3; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cca0c5799eso18485175ad.0
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783785697; x=1784390497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6itu2RYS2dJ1iEvAxavewh2t/11TJ7k1bnRtobjHT0c=;
        b=bb3GS/A3GnSbGCXN/qyC40OpAChEnckcB+Lud+A/ZDBdHUKfvy9/+Z1NWmZMBLtg5B
         aUOwPN9MU5tZyqRYPdjZG4z8Qa3GX8gEKhM4S73y7Pgrw+XWn0G5B4mI48JcY+rXAI4t
         18x9QcgFKUdXcyaMtGSJfj9sc165iDqBjv41mB/Wl3otqOgZ/wYo2h60oecP60OO5Op1
         aV82e8iUENIJNDeesrxrtqLfs0OudXiWncIUn1Bav5F32kMO6mvL323vA5MdZe6FGijY
         yQBBRPXIMdCOFbTjmDp2hZTDLqA1Tjgm4tysswDkJ6s4eoBdDxmCB+R9HEdZbIm3YSat
         Xfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785697; x=1784390497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6itu2RYS2dJ1iEvAxavewh2t/11TJ7k1bnRtobjHT0c=;
        b=Jg9FzJvRzPAHO2v2IUkZedVP0L5+1CzyPsRxtWV1rzs0ScIjciw1j8j2bXalZ2piX5
         ifX4cKg+o+Jjn2aTy3fI+6bPVDsa7NjaotJtqghwlGOfB1q7mPpTMAUXjqfF40Td37/y
         QMy1UDYzrcTwowIWV+yQkunwPAjwqlUVGTbLw/pyCq9BSx/Enm5rKJUKwP9235yn/3Dt
         HGXD/KgiLT8evEO+0LddKEDjdt7txElOIoaM4VnOBX1MbPTa3n0ffdC7krhEk/MbtUo8
         BO8bHtLjXoBsoa8X5GIHi5XXFOB6iS5+IxRTUf0ADvpLYtLvdsxSiUJaS05x4yLYnC9t
         0EMg==
X-Forwarded-Encrypted: i=1; AHgh+RqVe4tRy+dGAyYIMxxniwkQCiC/TLEgufK46XrdiOqfJzZSwmAfTpCq4sqa6WdIhq7KCOFVaMPghB6pwTPJR5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHXbYcj5bNXGgc4aLVjVAyywLOsmloDJXvDW8Ts/6iIScNvlY
	duvdkYucZ2svR4sLGObegVxO4lcU6TvIW6dou8ttkqnsYobR2T6voYth
X-Gm-Gg: AfdE7clKKlMegj6NiCzR28sq8S4g0qkumGGymKVJQk2A10bQgvyAPrWHuWytklNCxbz
	YPuRZJLeQJMCYUILRuHOPR6h5PZH+YcY67kc96ryqL7VfsW7/ZPBu0EXyr7LAyN8CI7OTPxmZQS
	dRtWK9RB7J3vcPfz18Tzh9hMA7zN3IOYGtkhsPeneKvxrcUsMBdDZiEFujkv53dhhxnr8Pg+HNp
	8Oqisv+5fVQO3W2FlCFxHfXL/9372DAoiBDsqne74kbqKrybsrset/MgpDxbJ7l7HG7C5C9Oum9
	d/8JYrOMfTCuT18Hu/N7m0QlC+Omh2f4SS/hq4kYfDEFeZsXIyMZCMSlQzzlj+iMUJYgntudMf5
	CEWsAv1zqGVw9ZJWsbA8t0260/meAC0RwdrqZ+d4G61CYdGjLEO+mxYPvo0Mz/QYYtiTL2mFBMN
	1sDZlc4emzzGYF6pnZHGjp
X-Received: by 2002:a05:6a21:398d:b0:3c0:b3f7:e5dd with SMTP id adf61e73a8af0-3c110a74439mr3515794637.42.1783785697121;
        Sat, 11 Jul 2026 09:01:37 -0700 (PDT)
Received: from titan.lan ([2603:8000:df01:38f7:255c:dd03:30a6:e57b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm92579946c88.14.2026.07.11.09.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:01:36 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	luto@amacapital.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v2 07/10] tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
Date: Sat, 11 Jul 2026 09:01:07 -0700
Message-ID: <20260711160110.267780-8-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711160110.267780-1-ross.philipson@gmail.com>
References: <20260711160110.267780-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9916-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-integrity@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-efi@vger.kernel.org,m:ross.philipson@gmail.com,m:dpsmith@apertussolutions.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:hpa@zytor.com,m:dave.hansen@linux.intel.com,m:ardb@kernel.org,m:mjg59@srcf.ucam.org,m:James.Bottomley@hansenpartnership.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:luto@amacapital.net,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:corbet@lwn.net,m:kanth.ghatraju@oracle.com,m:daniel.kiper@oracle.com,m:andrew.cooper3@citrix.com,m:trenchboot-devel@googlegroups.com,m:rossphilipson@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,gondor.apana.org.au,davemloft.net,lwn.net,oracle.com,citrix.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15AB07421AE

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW flags into
the TPM_BUF_INVALID flag, as their behavior is identical (the only
difference being the associated log messages).

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c                | 10 ++++------
 include/linux/tpm.h                       |  8 +++-----
 security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 4c4f450630df..61833b4d81f0 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
 		WARN(1, "tpm_buf: write overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
@@ -176,14 +175,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
 {
 	off_t next_offset;
 
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	next_offset = *offset + count;
 	if (next_offset > buf->length) {
 		WARN(1, "tpm_buf: read out of boundary\n");
-		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3630b2ea6aef..3c6a5bcc138a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -201,12 +201,10 @@ enum tpm_chip_flags {
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
 enum tpm_buf_flags {
-	/* the capacity exceeded: */
-	TPM_BUF_OVERFLOW	= BIT(0),
 	/* TPM2B format: */
-	TPM_BUF_TPM2B		= BIT(1),
-	/* read out of boundary: */
-	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
+	TPM_BUF_TPM2B		= BIT(0),
+	/* The buffer is in invalid and unusable state: */
+	TPM_BUF_INVALID		= BIT(1),
 };
 
 /*
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 29d79c05ed6b..779a2e66ac20 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -312,7 +312,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* creation PCR */
 	tpm_buf_append_u32(&buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
@@ -328,7 +328,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
@@ -441,7 +441,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 	tpm_buf_append(&buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
-- 
2.55.0


