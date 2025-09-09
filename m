Return-Path: <linux-integrity+bounces-7039-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC0B4A095
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 06:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8313A7972
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC022E1747;
	Tue,  9 Sep 2025 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itXIm1sE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E80281375
	for <linux-integrity@vger.kernel.org>; Tue,  9 Sep 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391605; cv=none; b=AHTG902WJs+KghzTE1S6YySutbA6S9dScdGpkIK+Md9GymikLMSSsmEWU4y3xc/dV1csQT3+xdZvc/e3XyRmh2IaTPVNIMAuMHFtJBtbe8i0fp4OzJ8SOANHb9bvY0PLS0C4mVuyX9d3a8DR0VwF5E662Q2UrTr20eR1B7+/dSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391605; c=relaxed/simple;
	bh=kcJMNEpEeX4hcspzTai+arozdN7w9isGuN5jMeekjZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIZvPSusHQUpdTLSanaSchtKVgwjBq4z8cTOhYRnrPUmlGdcto9qDOkqHa+poW3o1aKbyD1cppgnYSlXy1oyWOFmzdJgaknsEORxBxfPIYX6wCIsExV8x0oYL1Lla1o5T2ITUqj+8+1FLlBF/SNddSDA8eFSUcfS04xYsHEecDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itXIm1sE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757391601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54MsxNCmmlAlcM5f+BHWGLYP6L+NuEk1hd/wbu7HmzE=;
	b=itXIm1sE7Wsw/T2sTwg/lSrMp/cna6MZ6tO99hGCLeKLgDiZa0h8ViBIHN9OTqPYhaY+XN
	7YH1Cpms3ATfLvMvR891g/PfovoJNaYois9xQwHk8WcHebT8tDaSaW7b2wJxYQTVKSpG4L
	UKV268n7sCZLGvMczUD5jliuPL8EPGU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-jE7ZPdMEMPi3XWLBMnr7ig-1; Tue, 09 Sep 2025 00:19:59 -0400
X-MC-Unique: jE7ZPdMEMPi3XWLBMnr7ig-1
X-Mimecast-MFC-AGG-ID: jE7ZPdMEMPi3XWLBMnr7ig_1757391599
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174b3427so4177752a12.2
        for <linux-integrity@vger.kernel.org>; Mon, 08 Sep 2025 21:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391598; x=1757996398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54MsxNCmmlAlcM5f+BHWGLYP6L+NuEk1hd/wbu7HmzE=;
        b=A8lMuVoU6A2bjGRvNQFDZcG124QPfqw/lrASOhujkYd/eb5f0gyTYtM4jEtoRkjozW
         lVcXf2J9TBmtjUmKGcJ6dTmEdOPtHNw+QMdEgkOMxJQ/Dg3AFQX2df4wdcYIguZHUA26
         N1LMrSi/4twAmS7AFE8EqtQzpduTtOSnG98bHeFu9jcluf5CYNI7BJ7L6y2OY1gwkoM8
         3IRo6LSPZUZHSTi50AVGcAxmph9Li/OgZUC9ISDf2kjP+9KVK24RSHGhL8KW5LqWez+0
         RB9PlLrAgWpcDyBIGX+SGl/IsvtM7sAsRnPgdR7YUb40Xwu7Gb/Ce0L0EDVGuzfePf8E
         dWjg==
X-Gm-Message-State: AOJu0YzpQFaPjuRx+juFz5BE6IyWaeL5O79WwBsUqOAsPe8PmcEP+SCl
	7/R3TyF1sboazU8muaJWd2694goFysx4RPXzKZayAjyZqJmRTYbl0dqY4/HOir1S3TIV9G/fmcg
	MjeBFNTSIIQKOUQORLSHh3TLQFWmcvQhJIzHv77iYALFYgaPlV0nqgzuAfVKf/FJxjUnne5oF1a
	9RO8vHq7G4pRTkc7nyZMY8cO4twsTXH0TCCh6As7qjETJtMlauFustzg==
X-Gm-Gg: ASbGncvSoo1v+1DQ7LGUTzUPBElMn8vJDUMWH4SMyp+s1c1+oJ/5fep75zHxTS5g5GL
	ECsNR+mIt7Q6MuDMBKCceSGQQj3zqeq3ZaMl4T5qvMohv4HWlp+zKlHwt1TRyonQUnQlHXIv8zj
	6NwMCzUBqO2mkcbPIrqf1s5YHbNNjiUTzuLFEtLhGyv8aSz6VqngRQuvujBgpDw79AifO60APlt
	+PJdTXACP9IINMZjWCRXGpWyNHX9/xPyAo90IPnUG1JsncCcnOeIVu6djsXvUf5a0A8xiRM5RHf
	SSUK/hvi6y+ihM8dq0kdSFlcYnZhnP8=
X-Received: by 2002:a17:903:b0e:b0:258:fa62:ab17 with SMTP id d9443c01a7336-258fa62ac03mr15850515ad.29.1757391598484;
        Mon, 08 Sep 2025 21:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv36p9UxA54Z3porfTlTxG7LAGzqKIDTmwybjkcWmGH9oQOVl5p8+shON8WpdrhlHXD9O2lQ==
X-Received: by 2002:a17:903:b0e:b0:258:fa62:ab17 with SMTP id d9443c01a7336-258fa62ac03mr15850235ad.29.1757391597940;
        Mon, 08 Sep 2025 21:19:57 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9952bccasm157077385ad.105.2025.09.08.21.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:19:57 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: setting security.ima to fix security.evm for a file with IMA signature
Date: Tue,  9 Sep 2025 12:19:53 +0800
Message-ID: <20250909041954.1626914-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both IMA and EVM fix modes are enabled, accessing a file with IMA
signature won't cause security.evm to be fixed. But this doesn't happen
to a file with correct IMA hash already set because accessing it will
cause setting security.ima again which triggers fixing security.evm
thanks to security_inode_post_setxattr->evm_update_evmxattr.

Let's use the same mechanism to fix security.evm for a file with IMA
signature.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..18c3907c5e44 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
-		/* Fix mode, but don't replace file signatures. */
-		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
-		    (!xattr_value ||
-		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
-			if (!ima_fix_xattr(dentry, iint))
-				status = INTEGRITY_PASS;
+		/*
+		 * Fix mode, but don't replace file signatures.
+		 *
+		 * When EVM fix mode is also enabled, security.evm will be
+		 * fixed automatically when security.ima is set because of
+		 * security_inode_post_setxattr->evm_update_evmxattr.
+		 */
+		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
+			if (!xattr_value ||
+			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
+				if (ima_fix_xattr(dentry, iint))
+					status = INTEGRITY_PASS;
+			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
+				   evm_revalidate_status(XATTR_NAME_IMA)) {
+				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
+							   dentry,
+							   XATTR_NAME_IMA,
+							   xattr_value,
+							   xattr_len, 0))
+					status = INTEGRITY_PASS;
+			}
 		}
 
 		/*

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.51.0


