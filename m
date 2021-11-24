Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5445CE65
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbhKXUvC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Nov 2021 15:51:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239935AbhKXUu6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Nov 2021 15:50:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOKOfSY028373;
        Wed, 24 Nov 2021 20:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Olqx2dPYfi/jKklnVsU8+gBQIyA5OZzYIiWpir1aT1c=;
 b=pGgZZKRNooM1zUSugSdzlL0m0kfDy0CeysoUBXYojfD90p2eRW4wtqyQ7GjXBWcgfQ5o
 m8jKdudlYngarnIexwr8cN3++o9MtRzoJ9Q2TqNugHRZIyQqbNEDWrXyfDerUrbjaFf7
 v5FIFxylcVlWdbKr88UFleUCi/6IEK7/ik7BLZRO53Yj+r3H+4och6sB4Ff5XGnFt4q5
 wFecPBao99t3yg8ya8W17hg/E81cteN5xPIrjzuhVRqC/R345G1GDSle2bFqtg2Gyix+
 jEAqG17eIHzIq26AV4k5RqFYtbjuMKJ08HJwQ8P3a2GIVzgbiZTwTa5MAxUzVwTxvU2I Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3chthtjjfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 20:47:45 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AOKOgFD028500;
        Wed, 24 Nov 2021 20:47:44 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3chthtjjf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 20:47:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOKcpNN006551;
        Wed, 24 Nov 2021 20:47:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3cern9upyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 20:47:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AOKeRBZ56033636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 20:40:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A70952052;
        Wed, 24 Nov 2021 20:47:39 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.59.116])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A7F895204E;
        Wed, 24 Nov 2021 20:47:36 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Seth Forshee <seth@forshee.me>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v5 2/2] integrity: support including firmware ".platform" keys at build time
Date:   Wed, 24 Nov 2021 15:47:14 -0500
Message-Id: <20211124204714.82514-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211124204714.82514-1-nayna@linux.ibm.com>
References: <20211124204714.82514-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EOB5NYZ5A9i_vVxxgAtM61pEq8C6DgW0
X-Proofpoint-ORIG-GUID: RRY8SFIAj8LOTltzaae7Gu8q46xJVv7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new function load_builtin_platform_cert() is defined to load compiled
in certificates onto the ".platform" keyring.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 security/integrity/Kconfig                    | 10 +++++++
 security/integrity/Makefile                   | 17 +++++++++++-
 security/integrity/digsig.c                   |  2 +-
 security/integrity/integrity.h                |  6 +++++
 .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
 .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
 6 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/platform_certs/platform_cert.S

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..9fccf1368b8a 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+config INTEGRITY_PLATFORM_KEYS
+        string "Builtin X.509 keys for .platform keyring"
+        depends on KEYS
+        depends on ASYMMETRIC_KEY_TYPE
+        depends on INTEGRITY_PLATFORM_KEYRING
+        help
+          If set, this option should be the filename of a PEM-formatted file
+          containing X.509 certificates to be loaded onto the ".platform"
+          keyring.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..46629f5ef4f6 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -3,13 +3,18 @@
 # Makefile for caching inode integrity data (iint)
 #
 
+quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
+      cmd_extract_certs  = scripts/extract-cert $(2) $@
+$(eval $(call config_filename,INTEGRITY_PLATFORM_KEYS))
+
 obj-$(CONFIG_INTEGRITY) += integrity.o
 
 integrity-y := iint.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
-integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
+						  platform_certs/platform_cert.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
@@ -19,3 +24,13 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
                                      platform_certs/keyring_handler.o
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
+
+
+$(obj)/platform_certs/platform_cert.o: $(obj)/platform_certs/platform_certificate_list
+
+targets += platform_certificate_list
+
+$(obj)/platform_certs/platform_certificate_list: scripts/extract-cert $(INTEGRITY_PLATFORM_KEYS_FILENAME) FORCE
+	$(call if_changed,extract_certs,$(CONFIG_INTEGRITY_PLATFORM_KEYS))
+
+clean-files := platform_certs/platform_certificate_list
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..0ea40ed8dfcb 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -38,7 +38,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
 
-static struct key *integrity_keyring_from_id(const unsigned int id)
+struct key *integrity_keyring_from_id(const unsigned int id)
 {
 	if (id >= INTEGRITY_KEYRING_MAX)
 		return ERR_PTR(-EINVAL);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..feb84e1b1105 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -167,6 +167,7 @@ int __init integrity_init_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
 int __init integrity_load_cert(const unsigned int id, const char *source,
 			       const void *data, size_t len, key_perm_t perm);
+struct key *integrity_keyring_from_id(const unsigned int id);
 #else
 
 static inline int integrity_digsig_verify(const unsigned int id,
@@ -194,6 +195,11 @@ static inline int __init integrity_load_cert(const unsigned int id,
 {
 	return 0;
 }
+
+static inline struct key *integrity_keyring_from_id(const unsigned int id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
diff --git a/security/integrity/platform_certs/platform_cert.S b/security/integrity/platform_certs/platform_cert.S
new file mode 100644
index 000000000000..20bccce5dc5a
--- /dev/null
+++ b/security/integrity/platform_certs/platform_cert.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
+#include <linux/init.h>
+
+	__INITRODATA
+
+	.align 8
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	.globl platform_certificate_list
+platform_certificate_list:
+__cert_list_start:
+	.incbin "security/integrity/platform_certs/platform_certificate_list"
+__cert_list_end:
+#endif
+
+	.align 8
+	.globl platform_certificate_list_size
+platform_certificate_list_size:
+#ifdef CONFIG_64BIT
+	.quad __cert_list_end - __cert_list_start
+#else
+	.long __cert_list_end - __cert_list_start
+#endif
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index bcafd7387729..b45de142c5f5 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -12,8 +12,12 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <keys/system_keyring.h>
 #include "../integrity.h"
 
+extern __initconst const u8 platform_certificate_list[];
+extern __initconst const unsigned long platform_certificate_list_size;
+
 /**
  * add_to_platform_keyring - Add to platform keyring without validation.
  * @source: Source of key
@@ -37,6 +41,28 @@ void __init add_to_platform_keyring(const char *source, const void *data,
 		pr_info("Error adding keys to platform keyring %s\n", source);
 }
 
+static __init int load_platform_certificate_list(void)
+{
+	const u8 *p;
+	unsigned long size;
+	int rc;
+	struct key *keyring;
+
+	p = platform_certificate_list;
+	size = platform_certificate_list_size;
+
+	keyring = integrity_keyring_from_id(INTEGRITY_KEYRING_PLATFORM);
+	if (IS_ERR(keyring))
+		return PTR_ERR(keyring);
+
+	rc = load_certificate_list(p, size, keyring);
+	if (rc)
+		pr_info("Error adding keys to platform keyring %d\n", rc);
+
+	return rc;
+}
+late_initcall(load_platform_certificate_list);
+
 /*
  * Create the trusted keyrings.
  */
-- 
2.27.0

