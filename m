Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812514D6A18
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Mar 2022 00:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiCKWxr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 17:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiCKWxa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 17:53:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936F2E4087;
        Fri, 11 Mar 2022 14:29:25 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BKcAX9022137;
        Fri, 11 Mar 2022 21:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YkYGmfeYZMf+8hugmF5odKW/SoWqd7Itn5m4OyORHmQ=;
 b=USY9GIwIkSfgzDBx94LZkA9T9R5K1U0OeEejoPYdxbJA7nvRv/4RWpdP2wU9MmmOYYoX
 KvLmbqRbz0X1XUbOeTMJY2zJPQxHgzOlxo8yI/AQWQsVttTqut1O/4u/Bva2GDtTnxud
 uMQ9LfR3RDJ4grpJY3OjQlBu0SvfgddHWQw/5HO4UqcNX/hZeWGtVaLmToBipAH/yIXk
 fi01sC+LvETBLSjyZLQQbdWC7ozcEgXVIfZpTvPlcIRno46x7ENQGCjXwC2YrxM8vzCg
 zq2GcyeDHotl9kBTXYNPQqZLNmicEqn3vldFlKWl2/zGfAuf6NsYeHZHQwgy/6oVcK3e 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqm1bdkdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:04:14 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22BL0puh027697;
        Fri, 11 Mar 2022 21:04:13 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqm1bdkdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:04:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22BL3qcs003063;
        Fri, 11 Mar 2022 21:04:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg97smh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:04:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22BKqpaN45482458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 20:52:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B954C040;
        Fri, 11 Mar 2022 21:04:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06D0B4C044;
        Fri, 11 Mar 2022 21:04:05 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.110.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 21:04:04 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com, masahiroy@kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v12 4/4] integrity: support including firmware ".platform" keys at build time
Date:   Fri, 11 Mar 2022 16:03:44 -0500
Message-Id: <20220311210344.102396-5-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311210344.102396-1-nayna@linux.ibm.com>
References: <20220311210344.102396-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nLVnCLBubX1QQ1byyP1hD16iL_mMTain
X-Proofpoint-GUID: DO8PiVkQRPNpIlXFc3t7ctO_2pSvozgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_09,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203110103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow firmware keys to be embedded in the Linux kernel and loaded onto
the ".platform" keyring on boot.

The firmware keys can be specified in a file as a list of PEM encoded
certificates using new config INTEGRITY_PLATFORM_KEYS. The certificates
are embedded in the image by converting the PEM-formatted certificates
into DER(binary) and generating
security/integrity/platform_certs/platform_certificate_list file at
build time. On boot, the embedded certs from the image are loaded onto
the ".platform" keyring at late_initcall(), ensuring the platform keyring
exists before loading the keys.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 scripts/Makefile                              |  1 +
 security/integrity/Kconfig                    | 10 ++++++++
 security/integrity/Makefile                   | 15 +++++++++++-
 security/integrity/integrity.h                |  3 +++
 .../integrity/platform_certs/platform_cert.S  | 23 +++++++++++++++++++
 .../platform_certs/platform_keyring.c         | 23 +++++++++++++++++++
 6 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/platform_cert.S

diff --git a/scripts/Makefile b/scripts/Makefile
index cedc1f0e21d8..c569594af4a6 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -15,6 +15,7 @@ hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_TRUSTED_KEYRING)	+= extract-cert
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_SYSTEM_REVOCATION_LIST)	+= extract-cert
+hostprogs-always-$(CONFIG_INTEGRITY_PLATFORM_KEYRING)	+= extract-cert
 
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTLDLIBS_sorttable = -lpthread
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 599429f99f99..77b2c22c0e1b 100644
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
 config INTEGRITY_MACHINE_KEYRING
 	bool "Provide a keyring to which Machine Owner Keys may be added"
 	depends on SECONDARY_TRUSTED_KEYRING
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index d0ffe37dc1d6..4154bf4996a9 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -3,13 +3,17 @@
 # Makefile for caching inode integrity data (iint)
 #
 
+quiet_cmd_extract_certs  = CERT  $@
+      cmd_extract_certs  = scripts/extract-cert $(2) $@
+
 obj-$(CONFIG_INTEGRITY) += integrity.o
 
 integrity-y := iint.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
-integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
+						  platform_certs/platform_cert.o
 integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
@@ -20,3 +24,12 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
                                      platform_certs/keyring_handler.o
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
+
+$(obj)/platform_certs/platform_cert.o: $(obj)/platform_certs/platform_certificate_list
+
+targets += platform_certificate_list
+
+$(obj)/platform_certs/platform_certificate_list: $(CONFIG_INTEGRITY_PLATFORM_KEYS) scripts/extract-cert FORCE
+	$(call if_changed,extract_certs,$(if $(CONFIG_INTEGRITY_PLATFORM_KEYS),$<,""))
+
+clean-files := platform_certs/platform_certificate_list
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 76e9a9515f99..219da29fecf7 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -282,6 +282,9 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 #endif
 
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+extern __initconst const u8 platform_certificate_list[];
+extern __initconst const unsigned long platform_certificate_list_size;
+
 void __init add_to_platform_keyring(const char *source, const void *data,
 				    size_t len);
 #else
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
index bcafd7387729..c2368912fd1b 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -12,6 +12,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <keys/system_keyring.h>
 #include "../integrity.h"
 
 /**
@@ -37,6 +38,28 @@ void __init add_to_platform_keyring(const char *source, const void *data,
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
2.34.1

