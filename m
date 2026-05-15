Return-Path: <linux-integrity+bounces-9557-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B+1MneQB2rQ8wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9557-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:30:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA355822A
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67FCF30BA268
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437AB3EEADE;
	Fri, 15 May 2026 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNLKh2Ja"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCE4C6F1C
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879718; cv=none; b=L+x6GCWoHHZVvH3te1tIQatKNOciUvYFoHGlMZUxncNoeI0XugeoBICNmO6Cw9ZebEol1UWSxpQywikaWF8wldbTcdcoV8kyAA+9DOcEB0KJgaYACmZkH7s04tW7uEHXwG1sK1N+xi+NIjd6ILhFtLgrlfeRmWDKiYX1yvgPd6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879718; c=relaxed/simple;
	bh=7BAv62SCJAZd+nbTYMXdF5QJlgc01qXtbND56r+tijw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRlqERjG/1dRWFemxG1++RdrTBjCJz3pVckjmm1PYQGEn3T873nvVrxXZt4XnxBYH/TYrIKNnQFC3aWlP3Sln8Kzi1szrDIn46UJVunvjWY69eJphWUfTzW6ZviGNxKB0PxCPpmbLoa3w76ZIcJpY0kM6uYGsFxoqESMKjMOr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNLKh2Ja; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30246cfd41aso1512868eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879715; x=1779484515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpW1a/fScKIJOJjIsuP4+bGqNlbA4fQX64i8+rdO0zg=;
        b=NNLKh2Ja78Xg7YtTOJnXXrJO3+1web4zIBvPZyZZjN3nXzCs5iNssEUVficdqe3NQq
         2Ch+FsviA0JHGUNEUHj+op4que+AYQY/kcO4XMy8ivf7STGAi/zNN7UAI1WDYx2IpkP+
         1zR5mNKwxB8V3nOiJEX9J+BtjNGEaIHEG61Dx+niQlhjaLnEuIvtCbpsgAKmOhjjN0IG
         D6TQMwFOq+D1z/OZiCdR6jvuxrrutyZQw+tIvLXkxIG4SMJSnB6TDS+xa4qiKGC36DCW
         oFs+Vt1gpdouFFwNzklH2Q1Dw2UlB/cUvflsjn2gEjePUqb2JIt1EPxSjNxsOp3LTwGZ
         IU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879715; x=1779484515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpW1a/fScKIJOJjIsuP4+bGqNlbA4fQX64i8+rdO0zg=;
        b=fKFCkYtjQWFUSFC/lDFUNxaLKPcyESJ1fgmFdrBXRBjfa5nc8a2abKM19U1TJngWHx
         GHk/reYo+5yFdA+QipdD1De8URYKJI/sebkLOG+7l1kZvXY26czQqEzaYB9CJF1MLQ5A
         61NJQXhcEg7JdhEMkOEAy9hTClW1VNBnhoFMOB3R1WEcs+jEv0WZMcK4a5ecM/oz2Ate
         mrcanqC9TgoRGLi6AVNO7+/LnOv5KsDwXcLSdmdxc+NJpByWUEpEHDCS/VfJNT70SPai
         jZLjtFNcEENeJvHf5J2Iuws5jHvaROG+WH/AOofYQreCiSv25VFUP/NdOW7ppovY20ss
         IOiA==
X-Forwarded-Encrypted: i=1; AFNElJ8iuyqJOZDfWaM4nZ4TSq7OwsaiN9Z+rTmvrGPbPJbVizXj/JhCeQS0XvTABrCMBb7GLM3N+Io46JB/QsB70hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8Ox4hTiu2ttK+OGSOVZ1JmSkDXbcT4DoY+jyK13wlr3ULceD
	/RuUbDw2JO7nnndqynJMQLl96dPrY18Mg2NUn0Gqah7Hcu5hLxqPpeP9
X-Gm-Gg: Acq92OENjo2pPf9l+WIQwFWriYMDjyVDH8Si6ZvHEB2VAkjADP2pWBz06s0PPycZ8gp
	4NRXn4Ap0OiOJGQtBmk1TwrIcxe/+g5U0qTg1g8ct/hIPq94nJnfDPxgjbrNtQvh/e+NSD77DkQ
	WZSErcXnsaGYQcUJggONuCbD90FsN66W8AT+KeFHZ8ZlseMzFJTqwXvUYd+i/lXBRs70QaWgNJt
	/jaR6WMK9X7M2TjPrAxdBwZAW2/T32eVMnT788rKlGlaPfsQkyLOXn2PfTym1QTOCYIHsC8ZU6M
	f+KncdplhrSDtdPUVUatYdzj5tlT+o+HVEedx1B77QMBoPsx/DAQIXVlmweiQQphXvTSOs82v+d
	PZJ40KHMWGKZ8+KGmKqp0uiIRrM/3HWqe/N5CvyUZGAyJnrtsaxP/nZINMSjouHMoXLwNrhCi4w
	wcJUjvpbZZbdIhRXF1JtZS7oRuwYsIKPM=
X-Received: by 2002:a05:7300:a94b:b0:2be:142f:d499 with SMTP id 5a478bee46e88-30398678a39mr2873251eec.16.1778879715061;
        Fri, 15 May 2026 14:15:15 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm8003208eec.26.2026.05.15.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:14 -0700 (PDT)
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
Subject: [PATCH v16 22/38] lib/crypto: Add SHA512 support for pre-boot environments
Date: Fri, 15 May 2026 14:13:54 -0700
Message-ID: <20260515211410.31440-23-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 33EA355822A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9557-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Allow the SHA512 library code in lib/crypto/sha512.c to be used in
pre-boot environments. Use the __DISABLE_EXPORTS macro to disable
function exports and define the proper values for that environment
as was done earlier for SHA256.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 lib/crypto/sha512.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/sha512.c b/lib/crypto/sha512.c
index 605eab51aabd..160e81d86da6 100644
--- a/lib/crypto/sha512.c
+++ b/lib/crypto/sha512.c
@@ -133,7 +133,7 @@ sha512_blocks_generic(struct sha512_block_state *state,
 	} while (--nblocks);
 }
 
-#ifdef CONFIG_CRYPTO_LIB_SHA512_ARCH
+#if defined(CONFIG_CRYPTO_LIB_SHA512_ARCH) && !defined(__DISABLE_EXPORTS)
 #include "sha512.h" /* $(SRCARCH)/sha512.h */
 #else
 #define sha512_blocks sha512_blocks_generic
@@ -250,6 +250,12 @@ void sha512(const u8 *data, size_t len, u8 out[SHA512_DIGEST_SIZE])
 }
 EXPORT_SYMBOL_GPL(sha512);
 
+/*
+ * Pre-boot environments (as indicated by __DISABLE_EXPORTS being defined)
+ * don't need the SHA2 HMAC support code.
+ */
+#ifndef __DISABLE_EXPORTS
+
 static void __hmac_sha512_preparekey(struct sha512_block_state *istate,
 				     struct sha512_block_state *ostate,
 				     const u8 *raw_key, size_t raw_key_len,
@@ -406,6 +412,8 @@ void hmac_sha512_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 }
 EXPORT_SYMBOL_GPL(hmac_sha512_usingrawkey);
 
+#endif /* !__DISABLE_EXPORTS */
+
 #if defined(sha512_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha512_mod_init(void)
 {
-- 
2.47.3


