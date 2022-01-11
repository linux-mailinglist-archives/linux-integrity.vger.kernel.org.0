Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DFE48B5C9
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiAKShf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 13:37:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241327AbiAKShf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 13:37:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BIW38o030891;
        Tue, 11 Jan 2022 18:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yEwxUZ4jn+S1t9sYR7A5vcLwn3X55mq4KnWFiwh1HPk=;
 b=QWfrr/ia3CnrQGrvhwq0n1o0MFPWHqM1nR3Ju5Psx6j77Db9dv5gWyPXMN9i2TDO5Aqx
 IL7ZzxHIXrOrnnvs/ApE/EnM2Ohq0NHKMwlPW4XnyJvEN98Q4CD/knYh3/mo0oBID2Lk
 gjl7XnY2880UHSUBgbJELbmu/5807iVenyLT4et+CNyFDaWLO3mLo75OnMBghWwX1kC7
 +HmJW5otQfMjMCsvjc0qXF90xHaT7Xy2hqpysIbSBF7lhMKVWpXaigkCmWVHCVT8Zc+T
 jb6BV4H9ynDUYtEuxnegK71eDbLog7U9A0q2HPj5zq7hSWsOfDsQyUmdUC3HOvarqoMI gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dhd08ccgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 18:37:30 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20BIWCiG031124;
        Tue, 11 Jan 2022 18:37:30 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dhd08ccfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 18:37:30 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BIRxQU007776;
        Tue, 11 Jan 2022 18:37:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3df28a1p2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 18:37:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BIbPTC40370440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:37:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8387D11C050;
        Tue, 11 Jan 2022 18:37:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE79E11C052;
        Tue, 11 Jan 2022 18:37:22 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.85.241])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 18:37:22 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v8 1/3] certs: export load_certificate_list() to be used outside certs/
Date:   Tue, 11 Jan 2022 13:36:45 -0500
Message-Id: <20220111183647.977037-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220111183647.977037-1-nayna@linux.ibm.com>
References: <20220111183647.977037-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D2A-cde8YBee6Tmf3msoZvEVH1EXSeV8
X-Proofpoint-GUID: KoX8bEAipzKGm4RAEYpByGNTpbNqx17b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201110100
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
index 279433783b10..6f26c93ff56b 100644
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
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
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
index 692365dee2bd..d130d5a96e09 100644
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
index 6acd3cf13a18..d3f914d9a632 100644
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
2.27.0

