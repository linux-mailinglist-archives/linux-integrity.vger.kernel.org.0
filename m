Return-Path: <linux-integrity+bounces-9560-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGsCCwOPB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9560-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A792F557F74
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8BF30C54E4
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53A3EFFB3;
	Fri, 15 May 2026 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfxRkan2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590103F5BF5
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879726; cv=none; b=lxzlbRwfYtFBw6M2n6mneMLCWMv7j1+OX2IX8oCxTFdNqXTFc5yHHSeZP3BHlSpejgLaLzyJwyUtJ+JPdNF6zR2ZocCPRzO4XOKIZrYugUD8hWeQKEga13INlWSTzjS4ljjB/XWw5nBZ8s8Z8CEF+AYrlNgGdiKhUCfxMPm6Qj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879726; c=relaxed/simple;
	bh=DULLarGA3N2WbmTOoIAH6Z6cAJNNwTwfc+oSbMTDbH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADWLd8wGDrkEFjdQMcA1+/gqXHukfs5qDG9K2el6NshuM6gZAfa32NCVZoMq43VK/EigCuMRhm80trM4TMU6NNtGrXkC8/7g38QEnNHwPuyX7UF0NGoideY3pJI/Hlx2lX+7w1D9EXu52kI1mN0QV+nfXh7R6Wg4mPP3aSNqJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfxRkan2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f3c623322bso1045197eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879723; x=1779484523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER4IWQsMKw/HNZSo0sHiz6UgahZlpRSMvCUCrr/URAk=;
        b=GfxRkan2jXb/hDtBDF0b2sCZ9HhiKP1Jj/yCjehZ+FkCiZlTYroSSQI6ZCBGNx/FBH
         nB/APZdgfAjcUw2LfZ3ELWjaOwm/EVaIrw6+uWbd46OCgIH2/r/rsmi8lFGVmYlCYmz5
         iihILkrwP8lqd2Dn4bjCqFt+vijLcekhje43yv4KJ8blEx7Jga1xd2AM5HfyT9v3Etfa
         aBW7LDioHVaE1M7oNwRvB5TxwC+2TRLlsekBab0tgxFWaCbgvF+FxIoX0AAFL6kw9CJV
         rm/gWOxfdEdyOeJakpFiJ9XLMAElhxeMRQzo54xa/6YGBaLUk0AH3FHDfgIQiVMNwZMb
         i+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879723; x=1779484523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ER4IWQsMKw/HNZSo0sHiz6UgahZlpRSMvCUCrr/URAk=;
        b=X8ozwj6EAOyZkcDvOOu5g0ZjpPTwYmpdsG8l8tRI1d4nWaPhZPr/z9M/sdwTkLBrcG
         My9CykoESTYQ6rbCE5TNgiDROMqNdBESH2cQN4sLFxsIvqCS+At/k8IHNg0gbujVMZpF
         x7G+OIb8PQo+B9ASdxPYUgdSP94oRptSDdFOzf/fgWOCcgGj5RZakTgR5abWw4RYCpMX
         dBwN9ZIGq2FJzGdsbjP+toiDI5eLwkfpfYPgA0OmDwRq4TroOT/SUmdNXY6ly2rv9XQA
         63cP8vLn0X/7ml49MrR+FofgzcmHgZ5G3WSL1SZsy8VVJoznrFzeD9nAEzKTqQpYfPYN
         +hzg==
X-Forwarded-Encrypted: i=1; AFNElJ/6rG+NAMgTArH2F9DGtDw7Q+HZS61Max1T3pfN8yIdZAsbNBIyrZChUGd9UbGM+33CGI8FfnP3rexAMVGIq28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwidYlB3ELhJWh1pqXLZwdwTYImstCBSHHJ9DhYxY5v0RfnYH
	9q+/IJr1qa6ngyaL9GZ6d9EoCUAr2xbC345g42NPXKBG+Pl8QCL6x/uM
X-Gm-Gg: Acq92OGhP8dyIrYMKSfHZEScYpdP5wm20skgcUHcUcyr2LbGrPSzywPxV5GO4nyZA08
	fV92YmYpmV/zP2BDrufTahMG2hCV5ir1LS1K3BMFEzGf8P0afSdCs6ZdhKAMkE+uFxfEMpRsKyq
	IzEoNfR7SkQnrMFtc4QNPCC3GUNuzu02z6d+/Y2Gvyu0eNrCs1+aLuULxxytZqNNuyA4Iy4R90m
	I8avgh/vR3L9gp9h1U7GbSXp82/S+A47QW7qBUqqEi/NVHdLV8zO8pavEeO3Q1R3qaYagmWaX/R
	ygPK36sNSNm3jpMGloSEU9PKIzMY63/Stg5ptVFWhgrP1653gUu4f9mwEFGdI7hXzJahrxP1q6i
	xkRBzyFglRgbitYLED7CRHdnPgolxWAe0XXfbQJ3vXGYKSxRp6iTpeIuOtfeheZajHUaaPdB2oO
	p/cS33nWqbBqflZWbFbWLt5frzCG7Q9Dsrw69p+OyXaw==
X-Received: by 2002:a05:7301:4184:b0:2f4:3a9c:818c with SMTP id 5a478bee46e88-303986b1521mr2959973eec.29.1778879723496;
        Fri, 15 May 2026 14:15:23 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm10736508c88.2.2026.05.15.14.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:23 -0700 (PDT)
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
Subject: [PATCH v16 25/38] x86/boot: Slight refactor of the 5 level paging logic
Date: Fri, 15 May 2026 14:13:57 -0700
Message-ID: <20260515211410.31440-26-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: A792F557F74
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
	TAGGED_FROM(0.00)[bounces-9560-lists,linux-integrity=lfdr.de];
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

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for adding Secure Launch support, which will require that
the number of paging levels remains untouched, tweak the logic slightly
so that the slaunch check can be inserted easily.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 0e89e197e112..3e9d651da73e 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -102,6 +102,7 @@ static unsigned long find_trampoline_placement(void)
 
 asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 {
+	bool l5_enabled = native_read_cr4() & X86_CR4_LA57;
 	void (*toggle_la57)(void *cr3);
 	bool l5_required = false;
 
@@ -118,10 +119,12 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 *     + CPUID leaf 7 is supported
 	 *     + the leaf has the feature bit set
 	 */
-	if (!cmdline_find_option_bool("no5lvl") &&
-	    native_cpuid_eax(0) >= 7 && (native_cpuid_ecx(7) & BIT(16))) {
-		l5_required = true;
+	if (native_cpuid_eax(0) < 7 || !(native_cpuid_ecx(7) & BIT(16)))
+		return;
+
+	l5_required = !cmdline_find_option_bool("no5lvl");
 
+	if (l5_required) {
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
 		pgdir_shift = 48;
@@ -132,7 +135,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 * The trampoline will not be used if the paging mode is already set to
 	 * the desired one.
 	 */
-	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+	if (l5_required == l5_enabled)
 		return;
 
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
-- 
2.47.3


