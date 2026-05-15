Return-Path: <linux-integrity+bounces-9542-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK/+DuOMB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9542-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC2557B69
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19731300CBF5
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49BE3EBF3A;
	Fri, 15 May 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2hoNZqg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750B3ED12F
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879677; cv=none; b=oNKz/i7zD/Tqn6QEb1xghwiIflSkv8nxzhcB5isW3ZquTTk3TUd2DFCN1O66n8JVYXMc2ifz+Z9YWbiVf0UD7gFBdqmku3o8EG6fRArr9mP/lzuTiYSvIdPV4PAt3u/s2CSDOs48R5hqMTXYPLbxNQveTJUbnMaoFSh6/35cM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879677; c=relaxed/simple;
	bh=WimTnPb5ErtUQ91diuLvqjTS3pHvP1bJ9GtZuSv1Bf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxpFD3+owsF1YUIZNWm1uzIgvYMkFHNGqMxxtDCwy8EG2q46rc+9+YxLqFDagl7obAkLJHf7TrarxgRS4Ip6f/U/0cB6Wxm1BcRyJZFKpytDdFDs05/MxP9tUXAuPAQfI6Sr7TEgHH21A1vr2zoDYTTGRZe5S4O44mK7nHvQRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2hoNZqg; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f68f3b075fso1100944eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879673; x=1779484473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5U2oXqABMo/EXd3140iU8ar3y05m7m/a9rRtZzhgJM=;
        b=E2hoNZqgN5GeQniAK6QAmAIDiaAQH2EJOxOHeRaH/grCpZD4lI/gu2odWffRqbYJYZ
         1sIxrkPPh+Cnfhx872TUjUmDUxpUkhomW9fyAJ+UJyA+RpKuTXPGEpjA2zSiaF5LExjM
         L9QD5ZvK2t9AykShyNDdayeKU0x/q0ZFgcQJLXjs9nR5IfMq2ZOa6LRR3MmqlG9zoNQy
         1yMhV+f07d+NBwC/0L76ic4bVZ5dMiSgJzi5V6opIBYUhZtKmd0UaMvsOBA3yjyljZp8
         WAixMF0vVZZIOtan39WrvH2P2hKysqizEDojDDAWydGq1X2yeBI2f71KMD8Xsbl1X7tw
         ijuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879673; x=1779484473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5U2oXqABMo/EXd3140iU8ar3y05m7m/a9rRtZzhgJM=;
        b=JfMd5XOGFoV/JdcA1D7GjAv/2cUJyAxmtjXHiseNZqPUR11s77hz3w1PDSEmW3Kybt
         a6jTw6rqS7f4ZM4a2bmKp+MTLQ5QTx7UTLO0Ud75Vi9MYk495RyVhdI7PQf9vG3vufPT
         po1BMgpv4fsYIZ6muMYQWeLDx0eEfBDwIgBoHIK0YeokSBC9c9FGRFRIzSWnmpkKlgBa
         MQwY44kvBd4arkBUjxIk6t8SeH8e9lRFtAgcS820DG8qxUyDuyMD6ElQJX9q1+uSrjbG
         PjFtwhlzLD8iivLCx3lie/0okiUso4pz8h27BMs26hzNhh9ZM9b+IpAC5lsRrgGZstfx
         B1Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/c+qNUNXoZxtDxaBtT5Mh801xXHzEiUf2SJ96CyOR1dDYdDTyTIN+F9TSRM3eV2iSkle05/tJFirBaqBNcaso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxduh2PFHga8caEqU4Cg2tExZAMKEMvsvibkbIDRIt4Q2+jNg/0
	Z2JKzj0qrqc01YK9KsL49Jln9+b4uZD99Hn6PU5vr/7+oLaQOnb9OTc5
X-Gm-Gg: Acq92OFCY1aX5ets2n+Y66UlaXflkDzYh1TaWKZYExGYixLSFy5Tr+2dtr7UWzPFPt7
	bIQI4p0kF5c0vT+njGKSXFrj650xrtiWZxrtH9e/XvDADq7JO0Vq7qvRX5n//sacVmbXwmK5hhZ
	ltq3j9EWw8DjVa5a6d3p171zNUoTeBp1vsH2viScE3eNFUNuCvIEtjW3V8TJwgK1UX3Dmw9H/Zc
	im87f26c/Ug1BthI00Xjx13v/iUMtjM3WVHmc1cYPe9no5z/ES95Dzzw6XicTmoZdhtXWT7a96q
	Uytcuh1xkeDJ48lz6K/LM1MF1JUiEKQwdK1KxmP8uESTiONY5RRX02TpA76yTmTMKGIFtRIcrHD
	CnKacClTFUWabkdSufSsrycEEVRzumeYqjyQz7gRx3AUseTQFePtG8k5QkBAgbwx1cJICootR1M
	0PICJLgutkntcyYBgilrUFBX1zwlZfcmg=
X-Received: by 2002:a05:7300:b913:b0:2f4:3a9c:8193 with SMTP id 5a478bee46e88-3039862655amr2733579eec.16.1778879672589;
        Fri, 15 May 2026 14:14:32 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc8ddsm7829907eec.21.2026.05.15.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:32 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
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
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 07/38] tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
Date: Fri, 15 May 2026 14:13:39 -0700
Message-ID: <20260515211410.31440-8-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44CC2557B69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9542-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opinsys.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Action: no action

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW into TPM_BUF_INVALID,
given that they are identical (the only difference being the associated
log messages).

In addition, add a missing TPM_BUF_INVALID check to tpm_buf_append_handle()
following the pattern from other functions in tpm-buf.c.

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
2.47.3


