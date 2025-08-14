Return-Path: <linux-integrity+bounces-6849-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54497B272A6
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B44B61318
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539AD28504D;
	Thu, 14 Aug 2025 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VvLDY7Jx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E72857CA
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212104; cv=none; b=KcLX86S+BDOxPBowfcNxdz/8jK7UlBvYYQXLW3dTV/lIeozgDCz28QujS8hhypGymdK3osZflJprgMo7VqVdlifObxAxQ4bYxfTMd27B0KZLIbIuoOKa0zO/B+7Vs8YAD2mktp6uLIWY5L6EvoTpohhClTS8rIO3wnbQm4AGE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212104; c=relaxed/simple;
	bh=5ePB1z1LHpqcu5bUggxBp8iGK8/pZ3MulZuVWVNh2Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Day/7ngTaDlj60a5RXwn0KZM1iGM7tBEq+Q9pKwhzcnIb/ILBypF0Silts/NODsr4WDxKAACv4mqC9B6XCg5wLfZDgOqmpO40s1Jp+MCItS+yyIpJKBErpc7v+1GlzwCl0llBktLKiU7LmALnmUflm9ztr141iPfqZP7x2CErgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VvLDY7Jx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b1098f9ed9so10052161cf.0
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212101; x=1755816901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFpPicRcqPRHR+SQPgLiIX1xx0gbGO8ikejKEmnVBDU=;
        b=VvLDY7JxTJQEdene23y16ncWBD6kDzKbCbwjwdd8RYKzEjZya5h+ljwW+Psao6boeU
         QYyaD8Yaag34kqcJLImDnNSmrPNWXtiC00mQg7Hi9C+auF4CDXjlO7W6MhrvFAHY3L1s
         59tbks78J1PBJfV8nMuEVxb/bxIxySRuw8/EBNZ8SXvuoM6QY/iYe/4xSY5b4aWK1AN5
         Si5UcpyDPWYw35CFUNwWxx/4bjlgmJLjL2SOtKGDhUDRdj7XZVsIYpt2wyK1hsQhbvSo
         czYcOI5yFLAXQZc5c6l4d80Y/6Kd9Zu+8gMVV9qPI3vISWW8acGuguq2XC9fUOsobMFe
         66OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212101; x=1755816901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFpPicRcqPRHR+SQPgLiIX1xx0gbGO8ikejKEmnVBDU=;
        b=dVCnrLaKFSo0az9JrM/gWNfWSRN6b5QpwT/KAqMPbv1O93gHThhLHQomhpi2gM8rxH
         RzOaIviH4SGwooRhbJpJBD4WBmjwKhHu1P7JsjPdIOtWKRQLEImxeKtuBd9T1fcp4AKU
         ZNPxXZzPBOiU1FkmO56V4I/Airf4NTXmrqMbaxC8zQtlEr1HHxtnq/WldWe2K2UdQ5qT
         r2c7PJK+0mGBxdrSY6Wu5jJ81sfvuoxsQM5VUbSBr4tnQX0t+8/NF1OzKLgRMqEMKVy4
         B1Qim2RskErbQqXMblMj2PRwoaB2PuWT/2eJgMUPLMtBZF7tbKdZYgdkCoGkWdxnvz3V
         +tuA==
X-Forwarded-Encrypted: i=1; AJvYcCVbc71H6HNr4zzrdSAweupB8dIMGhN061e4VHwalrB35E0v/N606/jFLDdBIY9bgZLzqgToBezRPurp5C7Y+Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllGyVw33tBS/lA+nz7MfhlVGCnbBHnLthlJgIqJ3PcVCIXBLi
	3amuo4on8JC6Ccw0KE2xgucGFXMeDXous2GJyQ4TOknry9XWUKWoplzUnVz1zp5tVw==
X-Gm-Gg: ASbGncstjKhOxj8V1ip+Vp48/feplMr7M2cFHV0smLFLVYx5RLSAMtCKOFuQIHFIaTS
	CZxbBirEudWqpyRqqLJMjVehJoA96/tUFHGP+i6zp15HkQVigRgQ9KQ2dAFZljc9liUuUhOqA4h
	2LiXvMI2M3Aa/9zHgnHcvmhqfQ/FLo48T2IZ770my8qBpHrjxznoKde3NrKqHuaxKCywaljDi4K
	H72fMdiFhCM1xvN+LJm271F3VEFDVZThuC1WqFUxghgLg/pOWbLdsfZIMLc+LNLzNK/IiMs11xW
	2m2SPtou64tl0EX8FtxP5KSx6XPnUqPagYmvDTFUim2rioWmMkwd9bg/6AmY8bPGPEsXTKmNBXs
	46LlIvRc3dyHsw2R2RBcsttmpH450iNRpGiIssu32a7qvbsLAJjCsEmLlLJZXQuCj1hk=
X-Google-Smtp-Source: AGHT+IFH5dzKkU7yWdy46pzimsh9GBBStW9L5OVdb2n8/NAg21qKxVr07gBX/93WaT0YVxi9JAASUA==
X-Received: by 2002:ad4:576f:0:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-70af5b055aemr87250166d6.16.1755212101407;
        Thu, 14 Aug 2025 15:55:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5c0d80fsm18581586d6.80.2025.08.14.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:55:00 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:40 -0400
Message-ID: <20250814225159.275901-67-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5807; i=paul@paul-moore.com; h=from:subject; bh=5ePB1z1LHpqcu5bUggxBp8iGK8/pZ3MulZuVWVNh2Zk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjxJlObw7mncXL+i3yW6XPsYVkZ6OoSHvRgt 28PYlPUYoyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o8QAKCRDqIPLalzeJ c0ZoD/0TlWf5epuF/m+VeiJx0pcTh7L7tjBRzJFkG1h2HzbpTqQQuAtOgqZz44i3iHuPaGGsy+7 E6yJYTbe7iXIu5eKvciE0XEBfaUSuFmdA8PPn+ddsbhzMZhHwmgWtzQVuvGPdO/oSJvhCBW5PXx rKjnqha2JmEy4fMu6Tt3TYxbvBLvUF/Vt/sVOIAr9/wa7utNkcDWUUPpqX+CbrBZRS39q8Fs9zx sMrckdPvM3a97nbXI8VNT1XpWEhJo3nZtEeKeUkCgEamev9t9QRF4wBe1oagT9fgnaTzK/5qdEV BBCy1+fBnvFtUANZds+3ECYkjku8ta5jqMb4mEayr61afT32FHjuOQcbiHt1wYTgngwRKR3m7Gh y4+b/+8FzAPnl87GAHut79DOLLNsSoKsqqvdFIkFtVXlzbmCulviAn6L5e4n/T19qWIInU+wfpz 7sKOFvEu1MiTj1gjCczg0SOGgmlXDH+X5xOfyVEHeVLPYp05GzQimvqDM5utj4Lfaam3UlGH5J5 yzkXWJ4pYHeQlPRJvoY7F0eJgo/PMiOfir7DN8Ue8sQfv5xUB704BYRDO1aMtuO04ai0vDOi8at Zg+MmeKeZBM5YArYEQaXntKywb0z7Y2zaMIN8CxrDScDzW8EOTkxAFVaxbqIyjWJdpK7L1hICml uwlZjR9kxrpPoLA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This patch converts IMA and EVM to use the LSM frameworks's initcall
mechanism.  There was a minor challenge in this conversion that wasn't
seen when converting the other LSMs brought about by the resource
sharing between the two related, yes independent IMA and EVM LSMs.
This was resolved by registering the same initcalls for each LSM and
including code in each registered initcall to ensure it only executes
once during each boot.

It is worth mentioning that this patch does not touch any of the
"platform certs" code that lives in the security/integrity/platform_certs
directory as the IMA/EVM maintainers have assured me that this code is
unrelated to IMA/EVM, despite the location, and will be moved to a more
relevant subsystem in the future.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/Makefile       |  2 +-
 security/integrity/evm/evm_main.c |  6 ++---
 security/integrity/iint.c         |  4 +--
 security/integrity/ima/ima_main.c |  6 ++---
 security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
 security/integrity/initcalls.h    | 28 +++++++++++++++++++++
 6 files changed, 78 insertions(+), 9 deletions(-)
 create mode 100644 security/integrity/initcalls.c
 create mode 100644 security/integrity/initcalls.h

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 92b63039c654..6ea330ea88b1 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_INTEGRITY) += integrity.o
 
-integrity-y := iint.o
+integrity-y := iint.o initcalls.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index db8e324ed4e6..823573bcaa27 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -25,6 +25,7 @@
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
 #include <crypto/utils.h>
+#include "../initcalls.h"
 #include "evm.h"
 
 int evm_initialized;
@@ -1112,7 +1113,7 @@ void __init evm_load_x509(void)
 }
 #endif
 
-static int __init init_evm(void)
+int __init init_evm(void)
 {
 	int error;
 	struct list_head *pos, *q;
@@ -1179,6 +1180,5 @@ DEFINE_LSM(evm) = {
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &evm_blob_sizes,
+	.initcall_late = integrity_late_init,
 };
-
-late_initcall(init_evm);
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 068ac6c2ae1e..a4b88d67ff43 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -11,6 +11,7 @@
  */
 #include <linux/security.h>
 #include "integrity.h"
+#include "initcalls.h"
 
 struct dentry *integrity_dir;
 
@@ -42,7 +43,7 @@ void __init integrity_load_keys(void)
 		evm_load_x509();
 }
 
-static int __init integrity_fs_init(void)
+int __init integrity_fs_init(void)
 {
 	integrity_dir = securityfs_create_dir("integrity", NULL);
 	if (IS_ERR(integrity_dir)) {
@@ -58,4 +59,3 @@ static int __init integrity_fs_init(void)
 	return 0;
 }
 
-late_initcall(integrity_fs_init)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index eade8e1e3cb1..06ae59cd77f4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,6 +28,7 @@
 #include <linux/iversion.h>
 #include <linux/evm.h>
 #include <linux/crash_dump.h>
+#include "../initcalls.h"
 
 #include "ima.h"
 
@@ -1202,7 +1203,7 @@ static int ima_kernel_module_request(char *kmod_name)
 
 #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
 
-static int __init init_ima(void)
+int __init init_ima(void)
 {
 	int error;
 
@@ -1283,6 +1284,5 @@ DEFINE_LSM(ima) = {
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
+	.initcall_late = integrity_late_init,
 };
-
-late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/initcalls.c b/security/integrity/initcalls.c
new file mode 100644
index 000000000000..6afa411068f2
--- /dev/null
+++ b/security/integrity/initcalls.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IMA/EVM initcalls
+ *
+ */
+
+#include <linux/init.h>
+
+#include "initcalls.h"
+
+/**
+ * integrity_late_init - late_initcalls for IMA/EVM
+ *
+ * This helper function wraps all of the late_initcalls for both IMA and EVM.
+ * It can be called multiple times, e.g. once from IMA and once from EVM,
+ * without problem as it maintains an internal static state variable which
+ * ensures that any setup/initialization is only done once.
+ */
+int __init integrity_late_init(void)
+{
+	int rc = 0, rc_tmp;
+	static bool setup = false;
+
+	if (setup)
+		return 0;
+	setup = true;
+
+	rc_tmp = integrity_fs_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = init_ima();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = init_evm();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	return rc;
+}
diff --git a/security/integrity/initcalls.h b/security/integrity/initcalls.h
new file mode 100644
index 000000000000..b56e9c576505
--- /dev/null
+++ b/security/integrity/initcalls.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _INTEGRITY_INITCALLS_H
+#define _INTEGRITY_INITCALLS_H
+
+int integrity_fs_init(void);
+
+#ifdef CONFIG_IMA
+int init_ima(void);
+#else
+static inline int init_ima(void)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_EVM
+int init_evm(void);
+#else
+static inline int init_evm(void)
+{
+	return 0;
+}
+#endif
+
+int integrity_late_init(void);
+
+#endif
-- 
2.50.1


