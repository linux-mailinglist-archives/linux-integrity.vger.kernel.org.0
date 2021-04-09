Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4468435A129
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhDIOfn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 10:35:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3916 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233813AbhDIOfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 10:35:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139EWvLD130831;
        Fri, 9 Apr 2021 10:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WESK2G7jlHHHaYOae2oJwIHrXW65k3PvtnqXRGrZnKY=;
 b=aBBpuX5W1kShCvQ7Zjyj4aAxewqL8BBg4l2iOq9ioQSLLAu4OCUAQLYyqtZTPxuENriz
 M5gtBBj5kY62pyjylzrlDB4FyxSYPaM/XTZBIBvBDLw+8WEK3fakRnMmR54V8N9l54Hm
 hvdT7gNi6WU9covkZPBjNwB4+6XsmW3RG6PG6cuYUgOiNG7Zvqs5YDN48GYISG0rtQIX
 rKs7Jyv7sIVVkQ+qzUBLya4wyQU1GfXuDsZ1n1aiirraSdvtqw+S3cy0YP4Hy0ohJrLv
 G+dsowSwIFPlIQV4AzmCUYMBT4FULGu5c2yitaOtxN7XJNZAdtwGCY7u/Lq3LDcJkcZ/ uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37s5xuft20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:25 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139EYn6I140621;
        Fri, 9 Apr 2021 10:35:24 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37s5xuft15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:24 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139EXV99021420;
        Fri, 9 Apr 2021 14:35:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbwahfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:35:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139EZJYS41812266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 14:35:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD1CC4C04E;
        Fri,  9 Apr 2021 14:35:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3ECA4C044;
        Fri,  9 Apr 2021 14:35:17 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.63.3])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 14:35:17 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 2/3] ima: enable signing of modules with build time generated key
Date:   Fri,  9 Apr 2021 10:35:06 -0400
Message-Id: <20210409143507.191443-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409143507.191443-1-nayna@linux.ibm.com>
References: <20210409143507.191443-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gzucSY3CX3ehCghTqPCbJ5bAOmh-BGy7
X-Proofpoint-ORIG-GUID: PcTa-JpQydClvy39DRdOWx_FHne1EkQK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_06:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel build process currently only signs kernel modules when
MODULE_SIG is enabled. Also, sign the kernel modules at build time when
IMA_APPRAISE_MODSIG is enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Stefan Berger <stefanb@linux.ibm.com>
---
 certs/Kconfig  | 2 +-
 certs/Makefile | 8 ++++++++
 init/Kconfig   | 6 +++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index c94e93d8bccf..48675ad319db 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -4,7 +4,7 @@ menu "Certificates for signature checking"
 config MODULE_SIG_KEY
 	string "File name or PKCS#11 URI of module signing key"
 	default "certs/signing_key.pem"
-	depends on MODULE_SIG
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
          Provide the file name of a private key/certificate in PEM format,
          or a PKCS#11 URI according to RFC7512. The file should contain, or
diff --git a/certs/Makefile b/certs/Makefile
index f4c25b67aad9..e3185c57fbd8 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -32,6 +32,14 @@ endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 clean-files := x509_certificate_list .x509.list
 
 ifeq ($(CONFIG_MODULE_SIG),y)
+	SIGN_KEY = y
+endif
+
+ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
+	SIGN_KEY = y
+endif
+
+ifdef SIGN_KEY
 ###############################################################################
 #
 # If module signing is requested, say by allyesconfig, but a key has not been
diff --git a/init/Kconfig b/init/Kconfig
index 5f5c776ef192..85e48a578f90 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2164,7 +2164,7 @@ config MODULE_SIG_FORCE
 config MODULE_SIG_ALL
 	bool "Automatically sign all modules"
 	default y
-	depends on MODULE_SIG
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
 	  Sign all modules during make modules_install. Without this option,
 	  modules must be signed manually, using the scripts/sign-file tool.
@@ -2174,7 +2174,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 
 choice
 	prompt "Which hash algorithm should modules be signed with?"
-	depends on MODULE_SIG
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
 	  This determines which sort of hashing algorithm will be used during
 	  signature generation.  This algorithm _must_ be built into the kernel
@@ -2206,7 +2206,7 @@ endchoice
 
 config MODULE_SIG_HASH
 	string
-	depends on MODULE_SIG
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	default "sha1" if MODULE_SIG_SHA1
 	default "sha224" if MODULE_SIG_SHA224
 	default "sha256" if MODULE_SIG_SHA256
-- 
2.29.2

