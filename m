Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F444D6AB9
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Mar 2022 00:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiCKWt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 17:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiCKWtY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 17:49:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8E02BF58E;
        Fri, 11 Mar 2022 14:23:27 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BJ2j2P028836;
        Fri, 11 Mar 2022 21:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tUuIbU4R/Z1Dmi/RYXF3Nz5NzEiaowUxd4Hx0D2yxq4=;
 b=kqZWRTBCZpXCawFUfnjZgnSdHqGQXYAmIErWmZZM6OTasMlAEDLC/D8aSQxpjVufqbO/
 nDOIrUTq1z+WLhDH8qI/Kz45rWjLxk19qfYhxt/N1X2qca2p49yeucbdLks8nfAOSgxA
 g1toSl/S+leAdMTNOWM7wKxP80ysrfcSn0EKyBw6i6BlxA0jFLsQog/xB8h3Zg3cRqKb
 lnigcwYoMUH2xT389ogE13Q9i3sSKyUlr4YC/HCnzbonfwPdLVkJN5gMiofEyhu7Pj52
 mtp5LzIHhH5HttiT5zCFTQ3QVHNKwomocCsbICv742xcmUpWmq3YsuhnJABb3qy98Vyf Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqf3p65jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:04:03 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22BKaTHI027032;
        Fri, 11 Mar 2022 21:04:02 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqf3p65j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:04:02 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22BL3nHR011519;
        Fri, 11 Mar 2022 21:04:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3ep8c3y136-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:04:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22BL3uUc32768348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 21:03:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98EA04C040;
        Fri, 11 Mar 2022 21:03:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DFC24C052;
        Fri, 11 Mar 2022 21:03:53 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.110.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 21:03:52 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com, masahiroy@kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v12 1/4] certs: export load_certificate_list() to be used outside certs/
Date:   Fri, 11 Mar 2022 16:03:41 -0500
Message-Id: <20220311210344.102396-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311210344.102396-1-nayna@linux.ibm.com>
References: <20220311210344.102396-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d8xPg5-iqVQE4dULk1MQR9m2X5elnmIh
X-Proofpoint-GUID: l0uZVR-pKjUeuhADkL5sVg5NfLnQOQvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_09,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 3ea7fe60823f..b92b6ff339d5 100644
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
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
diff --git a/certs/blacklist.c b/certs/blacklist.c
index c9a435b15af4..b95e9b19c42f 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -17,7 +17,6 @@
 #include <linux/uidgid.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
-#include "common.h"
 
 static struct key *blacklist_keyring;
 
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
index 2419a735420f..35babdc45689 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -10,6 +10,12 @@
 
 #include <linux/key.h>
 
+#ifdef CONFIG_KEYS
+int load_certificate_list(const u8 cert_list[],
+			  const unsigned long list_size,
+			  const struct key *keyring);
+#endif
+
 #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
 
 extern int restrict_link_by_builtin_trusted(struct key *keyring,
-- 
2.34.1

