Return-Path: <linux-integrity+bounces-7281-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9388BA66A5
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Sep 2025 05:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758F717D651
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Sep 2025 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97119CC0A;
	Sun, 28 Sep 2025 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPZbDQpD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FB54F81
	for <linux-integrity@vger.kernel.org>; Sun, 28 Sep 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028648; cv=none; b=UrE9roN7BI8bMDOjbSPJqnWxCCuFNi5/H2azjPKNsO4UCclZxPJqPwzp3AlzcgJbqbOdoBsv2N1ibjJwZlsrSHblGhVnEPjHemK2ggf9iLEKp655maTIBhYX3QYPKn547kOQJJ6dg/NUwJdnu1bw+ickyi17zyTV5CBRjeR02HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028648; c=relaxed/simple;
	bh=VBcvsRhMgO/muYeWFgejs0y+LouNQ+vYo1QbX/Y+XRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqcDo1LgqMN4xptvKD1cCYj/fUkKOFUzAuuD9/fdCSZtpynlfsiXMZvfAzEcWBGzfE5UYSobUlDT/71miqMb9Oy/E7Auy4WJoErm/qoShkE4Wen3iOzJeMCDRfV7UjMe09j4sumHBkLgHR2dJHS2Rc1QwNMrTvt7aiRPUuXTXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPZbDQpD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759028645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEw52ze8SdcNH5GneUi5j01Dzu2Pu+0KVOCFzVwvrUY=;
	b=aPZbDQpDuvGV3cRuM4W5lURdNVxNcz0h6czpLBYeD4vL40WMCijfg9dQD3ICZvcsSR+EVR
	a9XVnI3TiVvJ9RFiZT5ynnHAYR3bgbYMuuGVULswKXqNxt74hiH+icPB+LTKLdugjicgqz
	TAzDTshX5oGfOokwAUc53VWZ/fAhK5c=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Hu4OrPTFNTqMf1fmGiJkBA-1; Sat, 27 Sep 2025 23:04:04 -0400
X-MC-Unique: Hu4OrPTFNTqMf1fmGiJkBA-1
X-Mimecast-MFC-AGG-ID: Hu4OrPTFNTqMf1fmGiJkBA_1759028643
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-781253de15aso2241956b3a.2
        for <linux-integrity@vger.kernel.org>; Sat, 27 Sep 2025 20:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759028643; x=1759633443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEw52ze8SdcNH5GneUi5j01Dzu2Pu+0KVOCFzVwvrUY=;
        b=QQ8D+lzYEXo+ibWFaEhfjIOcJbGS8LkEK+M5pw0v3Z20NCZRXyeqISDXBmVfs50EZi
         q96EPxIp255spK+tEQzopih4v9l5j8ibEE7+ZkvutNiLddZXgsQTsNdPiDkq5B8ClSHZ
         eK5XiS4xElEO+mSgYZgMx2hcAXpENZ05LMVg8DWKDlLw/Eu/Twn10CP3uwNjdkM1iYNT
         sqdx/1HucfvP/8FUkwqIg81RqzkRTQPeelnJ3OfMCfF6iwamseFu4akc9OYrdh+B4qlF
         V9ZOBL99MDfVIDeB8/wAuEc8n3yBHzu+qhaGdnuwkdKSXWKq/2H1fstNFDGrwtnyMMxU
         BiRA==
X-Gm-Message-State: AOJu0YxDAe21OnAIHiucHd5c28/HosYlrSERkk3IIQT/jZC63QHJ7gj+
	kbnlzRDS0ygM6Gqd1Kqr1iqJ06JW/mtU8zQnVirnZRSAX9vMTVFvxx8ppSh/AEQa6GAh6mvf8jj
	IeMWyV/K8UlG3GBP8A3IWs8SvkqJdU3ekyNUuMEpceEKuYTuIN5SoYVugB1NgkhxHR3wHBi2YRK
	yA3ANRC5xRcGA1rkxSFn7VRrQgW399cXf62sBEfpdbQFQ9GUH/Nrk=
X-Gm-Gg: ASbGncubuWcYsdD4KySpY+BX936JSNg9NnI3eySQfe2aqcpSxijh2VADjxfkooHsjy/
	t28mp4xYpP7YOQCMbjVrGnPNxtbA+JXmdzwTXpDV8LVsg/F5OvSJywJlgVhM93f4x1kZyPpxHsx
	4Whvf2VrNg1GZ9Cr8rJpntG59vThFAoIlJWbcRDXeBHZ8m0xxvO+VbXxDYSA5sHwLx1AsBBTCRy
	rmvpJ7eCcTbbXb1qf+RYS2ulUaWxRPvX52JyvRCb1V02hLv8PadFhtY3ekTeMUUCQBXa3mQRXov
	MqMHWXOv7SlCs5Q/18RIgn6ReRMu3hk=
X-Received: by 2002:a05:6a00:8d6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-780fcdd2cb1mr13863869b3a.6.1759028642833;
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrlGFESxb4zyWUKxHw78NUwK96T66HWHGPWOIZ8CPuMROnTHK9D2/BRaau3akM7vrrkSoTGQ==
X-Received: by 2002:a05:6a00:8d6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-780fcdd2cb1mr13863837b3a.6.1759028642348;
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm7854159b3a.92.2025.09.27.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karel Srot <ksrot@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: Fall back to default kernel module signature verification
Date: Sun, 28 Sep 2025 11:03:58 +0800
Message-ID: <20250928030358.3873311-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, for any IMA policy that requires appraisal for kernel modules
e.g. ima_policy=secure_boot, PowerPC architecture specific policy,
booting will fail because IMA will reject a kernel module which will
be decompressed in the kernel space and then have its signature
verified.

This happens because when in-kernel module decompression
(CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
syscall instead of init_module to load a module. And IMA mandates IMA
xattr verification for finit_module unless appraise_type=imasig|modsig
is specified in the rule.  However currently initramfs doesn't support
xattr. And IMA rule "func=MODULE_CHECK appraise_type=imasig|modsig"
doesn't work either because IMA will treat to-be-decompressed kernel
module as not having module signature as it can't decompress kernel
module to check if signature exists.

So fall back to default kernel module signature verification when we have
no way to verify IMA xattr.

Reported-by: Karel Srot <ksrot@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
Another approach will be to make IMA decompress the kernel module to
check the signature. This requires refactoring kernel module code to
make the in-kernel module decompressing feature modular and seemingly
more efforts are needed. A second disadvantage is it feels
counter-intuitive to verify the same kernel module signature twice. And
we still need to make ima_policy=secure_boot allow verifying appended
module signature.

Anyways, I'm open to suggestions and can try the latter approach if
there are some benefits I'm not aware of or a better approach.

 security/integrity/ima/ima_appraise.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..fcc75dd1486f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -502,9 +502,10 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
+	bool enforce_module_sig = iint->flags & IMA_DIGSIG_REQUIRED && func == MODULE_CHECK;
 
-	/* If not appraising a modsig, we need an xattr. */
-	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
+	/* If not appraising a modsig or using default module verification, we need an xattr. */
+	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !enforce_module_sig)
 		return INTEGRITY_UNKNOWN;
 
 	/*
@@ -517,8 +518,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	if (is_bprm_creds_for_exec(func, file))
 		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
 
-	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
+	/* If reading the xattr failed and there's no modsig or module verification, error out. */
+	if (rc <= 0 && !try_modsig && !enforce_module_sig) {
 		if (rc && rc != -ENODATA)
 			goto out;
 
@@ -549,8 +550,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	case INTEGRITY_UNKNOWN:
 		break;
 	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
-		/* It's fine not to have xattrs when using a modsig. */
-		if (try_modsig)
+		/* Fine to not have xattrs when using a modsig or default module verification. */
+		if (try_modsig || enforce_module_sig)
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
@@ -580,6 +581,18 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     rc == -ENOKEY))
 		rc = modsig_verify(func, modsig, &status, &cause);
 
+	/* Fall back to default kernel module signature verification */
+	if (rc && enforce_module_sig) {
+		rc = 0;
+		set_module_sig_enforced();
+		/* CONFIG_MODULE_SIG may be disabled */
+		if (is_module_sig_enforced()) {
+			rc = 0;
+			status = INTEGRITY_PASS;
+			pr_debug("Fall back to default kernel module verification for %s\n", filename);
+		}
+	}
+
 out:
 	/*
 	 * File signatures on some filesystems can not be properly verified.

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
-- 
2.51.0


