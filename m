Return-Path: <linux-integrity+bounces-5720-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050EEA82F7F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98368461E88
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A8278168;
	Wed,  9 Apr 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="clA59IMI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7D278149
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224836; cv=none; b=e+L/RHifiZS33UtdeYYunmP0Nwxq5DI/y4CS1Z67x+Zfb0iRaeUYkzkbF1/PRfa+boZDCwYuqq5QUdoIQ9rysmp6LcLKlc4flXPOe5PqtsWDEFTnC+kxpqCY6xtlNDCxSXJpVUEqR+RbARMXMA6DCDeCcJi3HOJDwlo8qLjO3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224836; c=relaxed/simple;
	bh=qSinNT/tx+AFMXq4mOAmrQ6OXexHwQ1Obc6kW4yKz08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAg5l7JxrY+UeE7e4b9dEd0uzFXSMddnyUBtpBLNPp3YxbiC87Re4y9s/PVOdtpOudtxZbuJ2oKa0RnaZIqHPIyt1emZamA2RvJwrFro0P5mjQlA9GLwepGw75KC/7x0NQKb3dCZC/21Vcf1tLueYOJT6Hve5rdmtiHIAdHWlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=clA59IMI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774d68c670so97084241cf.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224833; x=1744829633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7F+J7CLv0Q7TKcdsCSnDPPpdWK10ZRyc/PbHcMRk/Y=;
        b=clA59IMIgKYjNos5GixO2LJYlqJetGzTF/hrk4AB51BarPU6I/c9yhJS4W18YI3sP/
         WnNH/HN1C79cnJbiRG8H3hobHJTbeTJ7M3IzQ+7OFiRJrJOrUSDfYAgHI5SPzmOXgYQ8
         blfTgS0FPP9IW4s7BOLyx8R2P7zp2iR/jVRVGQGRSpIBMz2nW0V54HIiY2W/lXpUc8R0
         zC53Sc97pfWO6r+rqr0EgO/1oVHMV4oea62fl7YliUdK8ct4NXBmlj2FQkLOv01kxO52
         18enDS+JEmTUGNSh2xLvvEIfXEOW1ffMaLmAJ4iQ4K/CYMVgFr0gqwV3g2uqMeI9c/if
         hPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224833; x=1744829633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7F+J7CLv0Q7TKcdsCSnDPPpdWK10ZRyc/PbHcMRk/Y=;
        b=Z332xpDgsgRa+A5jlSKpBGscjtScz+NX1M/QvJS0kNr1uHK98+J43h+jHEtU7W8sfp
         g45e3Wr74Bv5C/fmY1bYSUNF5Ch370jQMaOTgQslUxCDQmjXjXztbQc6zxhyteR8g5Q1
         Mx1nGh1EkuvsLwDkARnqg+Oa+mBvTZdf6kxqUpWni3CDnLEWELNwuxgFDuVoBv7gOPnw
         1cpWVLDlBWEVfl9jLALBeEAC/7bu9Kinkb/MpiSaYO8ySscz6u6BujT4A1/AwoO1dzPT
         mcIIcFjHaM++ps31mN/OwFSkKyR+m5v1P2KeainQhVPckY8lMg7YzznZE2iPqg1YAVD6
         Vd4A==
X-Forwarded-Encrypted: i=1; AJvYcCWmWhvcAOmtd3B6jPgMDqFOt1teiBvmHViw8c/w1C0uYTFruB8q5Ulm7yhSYgn8Edet2Oa5ZeAUl3z42tvDIGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymf1pi2OzTmPKpPar2YB85hEmwPPh2jURB0rkXMzau5Qkk4NyO
	x2W5UIS2kn+tY8Hpc6WYe2JYDQ4Wl27hhoPiUyvWBxwpK2RhFbkCmcsZ7Ay5+g==
X-Gm-Gg: ASbGncsz7dFDlZS3vzIrZMm9MIEsicLr+4s2FYrrGB+jL+T43JbiBOgELWHdgUwyvNH
	deVTiRd77GEWHJLzQbz1Ugq/bQqtBTg/wgPkkrc9nL1dhz7m1NyWMkaSsbnf+OCqREzW8cn6S1I
	YdH65cgMUcR4R3g4PcTGNiPO2RFzKCoxdgMi1Ul/qo0Uo4Q3tg9nGAtaH+Ys9yNgbX77hVfj5Qp
	3mwiA4n2lTF7ePff8WCopFR+ZZnVn2NoWYFoZNjgvm0xhx3x27G0w4M2pGwvQso1uO8ZpMgQqJw
	m/zZjMT8ZIJXiR6v+4HMEfUGawABQIcOv46as81Ir1CwCgX5W0Fe3q/JKnMkBdCDmZ4krGXF+cE
	EdAJwYc8CCA==
X-Google-Smtp-Source: AGHT+IH8j+L3/WyowCHdZ+Lpg6i+z+njJlPi3PEm69Uk5bk5N1/ViqjQ2L4JUW0jWazX/KM5DcXLPw==
X-Received: by 2002:ac8:7dd1:0:b0:476:aa36:d674 with SMTP id d75a77b69052e-479600c0adamr57068541cf.28.1744224832898;
        Wed, 09 Apr 2025 11:53:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964ef799csm10296181cf.77.2025.04.09.11.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:52 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:10 -0400
Message-ID: <20250409185019.238841-56-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13008; i=paul@paul-moore.com; h=from:subject; bh=qSinNT/tx+AFMXq4mOAmrQ6OXexHwQ1Obc6kW4yKz08=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sIBY2NMysmrJycfEVkky+9RGdUyFZimt4PfU HcMklsmSqGJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bCAQAKCRDqIPLalzeJ cynREACJKuiuDtFmEhBelYW8gr2pM/SehiGMWVwHzORAOnCmMiu9oHKiCqLsa5CakgfcyHC9tcb 28T4o0cS7gxWQpppRBSy43MKe2KDxz656x77UztAuHhOYubdyvSlC+ReR+8TXwQr25NIYR/nX9N v6DkWGCjAHKNsi1rYzDq1E3CDuuwLAUp20gFA3UjTI1e8wPXxSsGPu+i6z8vVMKkNOkQRr9mfBJ zU1G4sOVPH76SThD1rR7foAq9i4n5pjTHrKF9Ym4Chk7wx8yAOB5nyOQRTKVB7ocPB8hdHRMAQG PvKPK/Rmd9XaLmjSrixc9Wh9/0B4xVE7WoOZfuTx+LJupJV0hbFSjh2nO2ie78NMtdN5XiIUlRB qBYZyPqBM7rYt8Eze12OTDnJVXX1IzxWgz61JW9iVIAmVojR0fVb2Ya83L1Nvl2hROX1ERtg8fk 3vvMD2s9gIFEm8dbKVRDVKiXisVASvkyfO8/RPFis5T8ETeKRUMhKMeq7EZ8lVVdtzKj+CtedM/ Dnud8+m82aiIH4V3mMaqLgQiEH/xeaxQT2LFaxnv+bgfFfo+bMbmcNyRIu4+LvVfkoPiVhTWa2H ydhBe1wcsqFQEKtxUUB4m1x9wx3rPn4eu5L7IsEmN6zQYtP3IpR7mFCoHVPYo50NkbeDfr6NywE TW+wngHjRR/U5kw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This patch converts IMA and EVM to use the LSM frameworks's initcall
mechanism.  There were two challenges to doing this conversion: the
first simply being the number of initcalls across IMA and EVM, and the
second was the number of resources shared between the two related,
yet independent LSMs.

The first problem was resolved by the creation of two new functions,
integrity_device_init() and integrity_late_init(), with each focused on
calling all of the various IMA/EVM initcalls for a single initcall type.
The second problem was resolved by registering both of these new
functions as initcalls for each LSM and including code in each
registered initcall to ensure it only executes once.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/Makefile                   |  2 +-
 security/integrity/evm/evm_main.c             |  7 +-
 security/integrity/iint.c                     |  4 +-
 security/integrity/ima/ima_main.c             |  7 +-
 security/integrity/ima/ima_mok.c              |  4 +-
 security/integrity/initcalls.c                | 97 +++++++++++++++++++
 security/integrity/initcalls.h                | 23 +++++
 .../integrity/platform_certs/load_ipl_s390.c  |  4 +-
 .../integrity/platform_certs/load_powerpc.c   |  4 +-
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../platform_certs/machine_keyring.c          |  4 +-
 .../platform_certs/platform_keyring.c         | 14 ++-
 12 files changed, 147 insertions(+), 27 deletions(-)
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
index db8e324ed4e6..770d0411da2b 100644
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
@@ -1179,6 +1180,6 @@ DEFINE_LSM(evm) = {
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &evm_blob_sizes,
+	.initcall_device = integrity_device_init,
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
index 55a4f08a2565..1687badafb48 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/evm.h>
+#include "../initcalls.h"
 
 #include "ima.h"
 
@@ -1180,7 +1181,7 @@ static int ima_kernel_module_request(char *kmod_name)
 
 #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
 
-static int __init init_ima(void)
+int __init init_ima(void)
 {
 	int error;
 
@@ -1255,6 +1256,6 @@ DEFINE_LSM(ima) = {
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
+	.initcall_device = integrity_device_init,
+	.initcall_late = integrity_late_init,
 };
-
-late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 95cc31525c57..4374fb6cc66d 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <keys/system_keyring.h>
+#include "../initcalls.h"
 
 
 struct key *ima_blacklist_keyring;
@@ -21,7 +22,7 @@ struct key *ima_blacklist_keyring;
 /*
  * Allocate the IMA blacklist keyring
  */
-static __init int ima_mok_init(void)
+int __init ima_mok_init(void)
 {
 	struct key_restriction *restriction;
 
@@ -46,4 +47,3 @@ static __init int ima_mok_init(void)
 		panic("Can't allocate IMA blacklist keyring.");
 	return 0;
 }
-device_initcall(ima_mok_init);
diff --git a/security/integrity/initcalls.c b/security/integrity/initcalls.c
new file mode 100644
index 000000000000..de39754a1c2c
--- /dev/null
+++ b/security/integrity/initcalls.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Platform certificate / keyring initcalls
+ *
+ */
+
+#include <linux/init.h>
+
+#include "initcalls.h"
+
+/**
+ * integrity_device_init - device_initcalls for IMA/EVM
+ *
+ * This helper function wraps all of the device_initcalls for both IMA and EVM.
+ * It can be called multiple times, e.g. once from IMA and once from EVM,
+ * without problem as it maintains an internal static state variable which
+ * ensures that any setup/initialization is only done once.
+ */
+int __init integrity_device_init(void)
+{
+	int rc = 0, rc_tmp;
+	static bool setup = false;
+
+	if (setup)
+		return 0;
+	setup = true;
+
+#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING)
+	rc_tmp = platform_keyring_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING)
+	rc_tmp = machine_keyring_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+#if defined(CONFIG_IMA_BLACKLIST_KEYRING)
+	rc_tmp = ima_mok_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+	return rc;
+}
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
+#if defined(CONFIG_LOAD_UEFI_KEYS)
+	rc_tmp = load_uefi_certs();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+#if defined(CONFIG_LOAD_IPL_KEYS)
+	rc_tmp = load_ipl_certs();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+#if defined(CONFIG_LOAD_PPC_KEYS)
+	rc_tmp = load_powerpc_certs();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
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
index 000000000000..dce16abb3b8a
--- /dev/null
+++ b/security/integrity/initcalls.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PLATFORM_CERTS_INITCALLS_H
+#define PLATFORM_CERTS_INITCALLS_H
+
+int machine_keyring_init(void);
+int platform_keyring_init(void);
+
+int load_uefi_certs(void);
+int load_ipl_certs(void);
+int load_powerpc_certs(void);
+
+int integrity_fs_init(void);
+
+int init_ima(void);
+int init_evm(void);
+
+int ima_mok_init(void);
+
+int integrity_device_init(void);
+int integrity_late_init(void);
+
+#endif
diff --git a/security/integrity/platform_certs/load_ipl_s390.c b/security/integrity/platform_certs/load_ipl_s390.c
index c7c381a9ddaa..3bf91d925614 100644
--- a/security/integrity/platform_certs/load_ipl_s390.c
+++ b/security/integrity/platform_certs/load_ipl_s390.c
@@ -10,12 +10,13 @@
 #include <keys/system_keyring.h>
 #include <asm/boot_data.h>
 #include "../integrity.h"
+#include "../initcalls.h"
 
 /*
  * Load the certs contained in the IPL report created by the machine loader
  * into the platform trusted keyring.
  */
-static int __init load_ipl_certs(void)
+int __init load_ipl_certs(void)
 {
 	void *ptr, *end;
 	unsigned int len;
@@ -33,4 +34,3 @@ static int __init load_ipl_certs(void)
 	}
 	return 0;
 }
-late_initcall(load_ipl_certs);
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index c85febca3343..2904559e485b 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -14,6 +14,7 @@
 #include <asm/secvar.h>
 #include "keyring_handler.h"
 #include "../integrity.h"
+#include "../initcalls.h"
 
 #define extract_esl(db, data, size, offset)	\
 	do { db = data + offset; size = size - offset; } while (0)
@@ -56,7 +57,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
  * keyring and the blacklisted X.509 cert SHA256 hashes into the blacklist
  * keyring.
  */
-static int __init load_powerpc_certs(void)
+int __init load_powerpc_certs(void)
 {
 	void *db = NULL, *dbx = NULL, *data = NULL;
 	void *trustedca;
@@ -156,4 +157,3 @@ static int __init load_powerpc_certs(void)
 
 	return rc;
 }
-late_initcall(load_powerpc_certs);
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index d1fdd113450a..52c180704674 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -12,6 +12,7 @@
 #include <keys/system_keyring.h>
 #include "../integrity.h"
 #include "keyring_handler.h"
+#include "../initcalls.h"
 
 /*
  * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
@@ -157,7 +158,7 @@ static int __init load_moklist_certs(void)
  * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
  * keyring.
  */
-static int __init load_uefi_certs(void)
+int __init load_uefi_certs(void)
 {
 	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
 	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
@@ -235,4 +236,3 @@ static int __init load_uefi_certs(void)
 
 	return rc;
 }
-late_initcall(load_uefi_certs);
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index a401640a63cd..b49eb2bab7a2 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -7,8 +7,9 @@
 
 #include <linux/efi.h>
 #include "../integrity.h"
+#include "../initcalls.h"
 
-static __init int machine_keyring_init(void)
+int __init machine_keyring_init(void)
 {
 	int rc;
 
@@ -19,7 +20,6 @@ static __init int machine_keyring_init(void)
 	pr_notice("Machine keyring initialized\n");
 	return 0;
 }
-device_initcall(machine_keyring_init);
 
 void __init add_to_machine_keyring(const char *source, const void *data, size_t len)
 {
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index bcafd7387729..84a8e4309f06 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include "../integrity.h"
+#include "../initcalls.h"
 
 /**
  * add_to_platform_keyring - Add to platform keyring without validation.
@@ -37,10 +38,12 @@ void __init add_to_platform_keyring(const char *source, const void *data,
 		pr_info("Error adding keys to platform keyring %s\n", source);
 }
 
-/*
- * Create the trusted keyrings.
+/**
+ * platform_keyring_init - Create the trusted keyrings.
+ *
+ * Must be initialised before we try and load the keys into the keyring.
  */
-static __init int platform_keyring_init(void)
+int __init platform_keyring_init(void)
 {
 	int rc;
 
@@ -51,8 +54,3 @@ static __init int platform_keyring_init(void)
 	pr_notice("Platform Keyring initialized\n");
 	return 0;
 }
-
-/*
- * Must be initialised before we try and load the keys into the keyring.
- */
-device_initcall(platform_keyring_init);
-- 
2.49.0


