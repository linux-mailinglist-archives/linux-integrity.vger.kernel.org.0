Return-Path: <linux-integrity+bounces-9556-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OfgI8+OB2rF8gIAu9opvQ
	(envelope-from <linux-integrity+bounces-9556-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:23:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F35F1557EB8
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 221A7303FFFA
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20040629F;
	Fri, 15 May 2026 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbS/LYf2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DE48035B
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879714; cv=none; b=IO78t8SvMG5/b+WPR1Dzu+OhGWJyARhAmyHkRehD/m9XAodAl9Ywp1kXLjoCPsLlMM3mXSiwvmx992jAJWfJ5AJnG8N77J5g0KLKrJrZ/acEEaQseWpBseN5DPxQ+yDjbEe8a+aBqVs/kisUWdNZMYiwXpfdVZZb6fBj4HWnxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879714; c=relaxed/simple;
	bh=9qOiZjuMb85ewhTujam6wtmPKlWhsGUjRgHlaJ5hOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpLQO8WKtiGJ2Z87LqRnb+0oVeNXxaTVvPpmGDe58D7sN1so0DXJK/QCy8MmC0Hp7wXbd4ncRfFkBh04lik6ZjJ9oeBgrysIU1fp4NL5Qqer94SuzP59zN8ZJOJDrbdA7GAoCk+XQthJSlrVzZKvf3CcZ4NxB8Ru9zU/gtlhHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbS/LYf2; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3025d725a05so926273eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879712; x=1779484512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EseM1chjBypSoW0cp1ToXZvQ5KcO5EkTarmMMC63WUM=;
        b=hbS/LYf2dD1jw9aPBJqPXtrlyu6t+yl4dboWGs4zK1tvEQi2kZV761lDWhXi9oqxw0
         LNnhI6Sy7QZcjjWWYFWuIdyhAFkaA3nrxxjFNi7qNxEkKRTQ2ey/HdhWvQ4ibAQ+TECl
         82EVN3y6kfnl0qtvHMP1N92u42OmIb3325YRnwq4IiX45yedpdB//tKR8L1ZCZRE9o60
         AffvmAizY573rtdjdT/VDLfMPJAaG8NCM3KhKh7K18UD2Qv2f4pOJ59SI4OfkA3F64cK
         fxRnpyaanO93DB50OAou6rWfvNG5Y/qTtjqt51dmW5FsRtx4Yef0RtxYOT/qa24UJRdN
         0Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879712; x=1779484512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EseM1chjBypSoW0cp1ToXZvQ5KcO5EkTarmMMC63WUM=;
        b=Sko5ppHPxTmiBtduugvXyyS3nl+n4JuOqbXrMPIfK5uxgpGUGSyleT/QaNowJgxsGF
         t/NfRjpyKbU2mst8FD89y+sw41igw7gijyZPzQw2lDA0S+Bj8xO+P8gpRkq4ompdYt8s
         SOTzwF8EewBkOho2C5RQrRFuAJ6dTqVa6p2X0G1CrSm/ADELyr14DRXZn92yuzpHGoBU
         0Kjno5zyT9KyhTRMtuINO1pWy8Ku/tH97CoIZEdWGSKEEHJG/BKUt33TJKSbZjmOfynY
         zMXOr1S9GiJY66TxHdaryRRchET0RE39sPq0YxDYufPi+yDxj2EcrY3DujG13ertHdpU
         EO6g==
X-Forwarded-Encrypted: i=1; AFNElJ9TT4iD56hhWZrfPYgDxblWnih1YZEVp+f4zx4Ewgxn+HuU4n1pnP7XCgF+5L6Hud46AWN+BTb/86Jqh6X23OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hXP+3fVAliOH/4ad4J2E+l1mndHiqI1RA58N7ibx3ZmxkDVX
	T0BJm/E0BJ1l1r6eHo6b/o3uU9q7kkQnCqhGiwuEo/jY99myEV8Db4nE
X-Gm-Gg: Acq92OFhPdszZNM3KoJaDRwVXg5I9nH3FRPeeUWATR1Eku29K7+UkVd/IwjB+RPmUHp
	RpqK437r2O2CD2rsGBuvu9g3cD2nbFN/mIMndLccCCLM+s+b+9+dGixC93AZIZnXLMRY3aO4PHU
	n0aLnpwraAATzr7Fluy21p0pF23tf0OjcoEs0E6Ithlu0FwioTunDf02e8DpA4vMEnUFo61OtIv
	Tvordll0pJs9dLHXt1MYqGS1dc4qnWgrJf/zpDm4qoraoyWKrs0sk4xtCOR8w6IIHQpELt/cfPU
	NzvP/3XISp2pORV4tg7vRQu/sKznT78g7RCoYRISLz0qWZ6Ki78P+ZcR1+xN/yP6fjNi8N0SFmK
	2eChin7fFQZOKrTkRM59Cvr8d+tpgHUzopMc2lkJF7knMiZklDv7ZQHkMJGCeCVwiNBUhtQIdOb
	jdLPB/QUIwlRpqFlGAXuCowd1BlCtacb8=
X-Received: by 2002:a05:7301:19a5:b0:2ed:e17:d50d with SMTP id 5a478bee46e88-3039868c8bcmr2807177eec.32.1778879712290;
        Fri, 15 May 2026 14:15:12 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm8003129eec.26.2026.05.15.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:11 -0700 (PDT)
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
Subject: [PATCH v16 21/38] lib/crypto: Add SHA1 support for pre-boot environments
Date: Fri, 15 May 2026 14:13:53 -0700
Message-ID: <20260515211410.31440-22-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: F35F1557EB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9556-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Allow the SHA1 library code in lib/crypto/sha1.c to be used in
pre-boot environments. Use the __DISABLE_EXPORTS macro to disable
function exports and define the proper values for that environment
as was done earlier for SHA256.

Acked-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 lib/crypto/sha1.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index daf18c862fdf..f30b5ff3b31e 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -125,7 +125,7 @@ static void __maybe_unused sha1_blocks_generic(struct sha1_block_state *state,
 	memzero_explicit(workspace, sizeof(workspace));
 }
 
-#ifdef CONFIG_CRYPTO_LIB_SHA1_ARCH
+#if defined(CONFIG_CRYPTO_LIB_SHA1_ARCH) && !defined(__DISABLE_EXPORTS)
 #include "sha1.h" /* $(SRCARCH)/sha1.h */
 #else
 #define sha1_blocks sha1_blocks_generic
@@ -207,6 +207,12 @@ void sha1(const u8 *data, size_t len, u8 out[SHA1_DIGEST_SIZE])
 }
 EXPORT_SYMBOL_GPL(sha1);
 
+/*
+ * Pre-boot environments (as indicated by __DISABLE_EXPORTS being defined)
+ * don't need the SHA1 HMAC support code.
+ */
+#ifndef __DISABLE_EXPORTS
+
 static void __hmac_sha1_preparekey(struct sha1_block_state *istate,
 				   struct sha1_block_state *ostate,
 				   const u8 *raw_key, size_t raw_key_len)
@@ -302,6 +308,8 @@ void hmac_sha1_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 }
 EXPORT_SYMBOL_GPL(hmac_sha1_usingrawkey);
 
+#endif /* !__DISABLE_EXPORTS */
+
 #if defined(sha1_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha1_mod_init(void)
 {
-- 
2.47.3


