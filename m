Return-Path: <linux-integrity+bounces-9551-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAYkAI+OB2rF8gIAu9opvQ
	(envelope-from <linux-integrity+bounces-9551-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:22:23 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58263557E27
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED30303716C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456C3F86F6;
	Fri, 15 May 2026 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAUkQYe1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C233F86FC
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879701; cv=none; b=ncFRvmmTxDPcAL0lQTWpongIAbeZgca1tJJx0PKTLL2uouY/swYyTBdhXkrHt8aryfybN7T6EgaVJkewRNX8oFjyOkBlqcrIkK9/EhE340exAI3eVELCPtYgKhHBwcS69sQnoJfkdO5b6iImnHZSbie57yEquE+3T+sJ+jh8zzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879701; c=relaxed/simple;
	bh=/w4xIQd+FodWBf21xbEabPQcoqxxR+rnVAOAKm/PKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndl16D8FAAaYLgj3Fr0JrPorchM+XjkVCDXAvzXtVeJ8DxHS7/n6e8RjewVB1orwxnrhDpN1X9mfb1aOBBIiP6omflVLFFyNKGl/8dDLsrJ9KLbzTlqSNZyrugkmfJzY2pmNyPoE7zrkyKd42JqOpEe0UPyLwuNYahxGYTjWngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAUkQYe1; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30246cfd41aso1511250eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879698; x=1779484498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFOHDGCsOHbtZzrbMRrMDpLy4uq6fKhTRLiSKMVovBw=;
        b=NAUkQYe17YCwOkozqdU8CpMHWdUFgHS6zfI0Ca2ILTLzMf2tiipFVvSkcGZcm/Vgv9
         f8KEgse7WVm8d40kJddfU5qHJ7TbmtZZ9ZkaGR+rzkMct56vQpK5+h3Fsjqf42Di81AP
         zXblzjiLSj9yR7kZYhaSZlfFC+m78FgXqQNMD2x7IUyePyMWN5Ejv6UozaIP747+A4Af
         olt8sJ2zM8qz67HNBxVo8J3K33CGhOndM/yfhuS40Pm3WRAfEiYHCe+zPCzvX2U0wWSz
         ZRjNUNmR1iPXSD1f82xgt6JlXOYaYMNiuh0+zcrN7zOI6ZQzCGbFqcQipX9Qf8piThzb
         ybFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879698; x=1779484498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFOHDGCsOHbtZzrbMRrMDpLy4uq6fKhTRLiSKMVovBw=;
        b=dw9yD/XNOsMKxSf8uEy6VmCPq/lk8V04T03PMnaduYEU+KeddqnK4M3QzZ2Yse1x2o
         PFpbW+LPKAHGsbRtpMUhdDnLpDQEz7Zrx4PhNfPkhjE5KcrKrT5ZKTXoy2WyCUNFZ2aT
         tyO8Nb3XRGGpXhN6UJS+7FocUCYJ49DL7a+j0siVPExseT1k3hitCn3cYQwPsKVnMVJ+
         4T3/cr0m7RZwoftcdxR3rdgVw5Sy5jFShLZFaYlDRQ297nF+ZKp3V88GIPCFZGoC1jyv
         oh/XtfcjJU7EmnUFW94Jpzggoej6b9ki+6ab6QPVda3njrA2Qsr+RXTwM93jfdz4oQS4
         UK7g==
X-Forwarded-Encrypted: i=1; AFNElJ+xNQyd0o3OGXZB3TEq/t7bqTB80g1j6fROvtdLOwrLls5E3bQQ7M0n17z6D+zgxWYLrhjbLh41lw8fYtEX8BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+ihrCfWlraqMv7sRw2VWVtsNvN3DJzukpt0leL2za2A1rghx
	HCs3VB9PdLzPP2ffNkJd8rWPQd711fvqfSuHssBTxq+wWALDc2W2lBVb
X-Gm-Gg: Acq92OFOFbp9Z5GzVQ04XeiCxM6Yc4WVzAK0TrFpSeeCJooRlX+xy2H2LJ+aNxQVBbS
	ppSRjW0cWm981nWJapdxFXKOgpYefCsoQ5hPIux8wuGoZ89Omb3cLN+U8RhkIYo/lF1xzv72eJG
	Jkx5rMaSJ6VHJ7OW0XfTnCIJGLein9jLQojzFKMppjispkdFh1CZhkoWXG0FLNIjTXQ2cA/6lzn
	0PVrXg/JbLj27RlOEZGNQH4FtQlMvsR3/MaH2+mn0Cf8K9Uxb2KJwyyLBEVkQfkX/AzFoGm4I5g
	5CA0LkgFKLG1kWOTCgYLwJCk+nZw/AnP9DHj8pT3lo7+nlGsza9W0cSGFl/EpgDROKDGUaOhyy3
	11pgyH8YztXWplSHOS/OVrDXgiBYOOa8UKYC1J1rRkwuGYxmo+F9SBdwkaRbyvyNfnMjSQY1mUQ
	kgtQ4D4S3wt36EIxSEY+qpzcydKOEey10jhrPpfkWBZA==
X-Received: by 2002:a05:693c:8386:20b0:2df:919f:ce59 with SMTP id 5a478bee46e88-30398678a48mr2108609eec.19.1778879698427;
        Fri, 15 May 2026 14:14:58 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm7961724eec.20.2026.05.15.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:58 -0700 (PDT)
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
Subject: [PATCH v16 16/38] x86: Secure Launch Kconfig
Date: Fri, 15 May 2026 14:13:48 -0700
Message-ID: <20260515211410.31440-17-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 58263557E27
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
	TAGGED_FROM(0.00)[bounces-9551-lists,linux-integrity=lfdr.de];
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

Add an x86 Kconfig option for compiling in/out the Secure Launch feature.
Secure Launch is controlled by a single on/off boolean.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..fd9edb0651d9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1989,6 +1989,21 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config SECURE_LAUNCH
+	bool "Secure Launch DRTM support"
+	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB
+	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_SHA512
+	help
+	  The Secure Launch feature allows a kernel to be launched directly
+	  through a vendor neutral DRTM (Dynamic Root of Trust for Measurement)
+	  solution, with Intel TXT being one example. The DRTM establishes an
+	  environment where the CPU measures the kernel image, employing the TPM,
+	  before starting it. Secure Launch then continues the measurement chain
+	  over kernel configuration information and other launch artifacts (e.g.
+	  any initramfs image).
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_KEXEC
-- 
2.47.3


