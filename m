Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4614CEDCF
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Mar 2022 21:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiCFUwP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Mar 2022 15:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiCFUwN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Mar 2022 15:52:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CE01FA41;
        Sun,  6 Mar 2022 12:51:20 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 226GPcsO003986;
        Sun, 6 Mar 2022 20:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yivuHFjl5zCrtIoVIimnTckNFHZDesyHKE4eTtiHyYU=;
 b=URFQh7k8YREBvoNnnNzyd+4rYWvKV40YljHOYmSuhk9Hm1MqKlquFdzYn/TbR86vwo4D
 wGb1OkIhNH6bNjcWX8W6JDQviJUy27ysvP3anHwKzPaWc/z/d0cPnAwQFN/x3tOHOzcE
 iOAxYn7JjyVCK2zJFBKqAH2pXozFpWGmV0RTiaQ7+QVFgflUACgJzLXELcO4T5nGDRkp
 UlJoHeaOhCUaDgiGPwlTrUlJDzHYJVLly0yd4wBSynV8XXj1E7XQYDYbdGS5lc5P6nYG
 S2h1BFhyj0FY9c4mRlZ2k0PD1PTs53DFSX5VjopYCzxcl3yvKaBfURbbAjX79uS/Ax3y 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emt6teu74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:16 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 226KivUB019452;
        Sun, 6 Mar 2022 20:51:15 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emt6teu6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:15 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 226Kh3NX007990;
        Sun, 6 Mar 2022 20:51:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3ekyg92nf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 226KpAso57016680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Mar 2022 20:51:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0915B11C04A;
        Sun,  6 Mar 2022 20:51:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8CBE11C054;
        Sun,  6 Mar 2022 20:51:07 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.113.126])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Mar 2022 20:51:07 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v10 1/3] certs: export load_certificate_list() to be used outside certs/
Date:   Sun,  6 Mar 2022 15:50:58 -0500
Message-Id: <20220306205100.651878-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220306205100.651878-1-nayna@linux.ibm.com>
References: <20220306205100.651878-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wp-nTCIejczyKGs9DPkPVvfh9CGKhs_-
X-Proofpoint-GUID: Y9brfcWRvkiDhFpqmfSSoij4dvB6DyUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-06_08,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203060140
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

load_certificate_list() parses certificates embedded in the kernel
image to load them onto the keyring.

Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
function)" made load_certificate_list() a common function in the certs/
directory. Export load_certificate_list() outside certs/ to be used by
load_platform_certificate_list() for loading compiled in platform keys
onto the .platform keyring at boot time.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/Makefile                | 5 +++--
 certs/blacklist.c             | 1 -
 certs/common.c                | 2 +-
 certs/common.h                | 9 ---------
 certs/system_keyring.c        | 1 -
 include/keys/system_keyring.h | 6 ++++++
 6 files changed, 10 insertions(+), 14 deletions(-)
 delete mode 100644 certs/common.h

diff --git a/certs/Makefile b/certs/Makefile
index 102e9ec993c7..811706a0824a 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -3,8 +3,9 @@
 # Makefile for the linux kernel signature checking certificates.
 #
 
-obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
-obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
+obj-$(CONFIG_KEYS) += common.o
+obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
+obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o
 obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
 quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
diff --git a/certs/blacklist.c b/certs/blacklist.c
index 486ce0dd8e9c..0d20264fa27c 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -18,7 +18,6 @@
 #include <linux/verification.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
-#include "common.h"
 
 /*
  * According to crypto/asymmetric_keys/x509_cert_parser.c:x509_note_pkey_algo(),
diff --git a/certs/common.c b/certs/common.c
index 16a220887a53..41f763415a00 100644
--- a/certs/common.c
+++ b/certs/common.c
@@ -2,7 +2,7 @@
 
 #include <linux/kernel.h>
 #include <linux/key.h>
-#include "common.h"
+#include <keys/system_keyring.h>
 
 int load_certificate_list(const u8 cert_list[],
 			  const unsigned long list_size,
diff --git a/certs/common.h b/certs/common.h
deleted file mode 100644
index abdb5795936b..000000000000
--- a/certs/common.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#ifndef _CERT_COMMON_H
-#define _CERT_COMMON_H
-
-int load_certificate_list(const u8 cert_list[], const unsigned long list_size,
-			  const struct key *keyring);
-
-#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 05b66ce9d1c9..2ae1b2e34375 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -16,7 +16,6 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
-#include "common.h"
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 91e080efb918..69beb444464a 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -17,6 +17,12 @@ enum blacklist_hash_type {
 	BLACKLIST_HASH_BINARY = 2,
 };
 
+#ifdef CONFIG_KEYS
+int load_certificate_list(const u8 cert_list[],
+			  const unsigned long list_size,
+			  const struct key *keyring);
+#endif
+
 #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
 
 extern int restrict_link_by_builtin_trusted(struct key *keyring,
-- 
2.27.0

