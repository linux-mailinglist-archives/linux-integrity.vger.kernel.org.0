Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F08034E8C7
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhC3NRd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 09:17:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232166AbhC3NRF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 09:17:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UD3uiG053284;
        Tue, 30 Mar 2021 09:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0FE6QV8fRwrto/suhw4y73defG5u+8c9hKcbJaEbyyM=;
 b=lhU81LIq8icTk8qyR9137L8l2nuEq1Kpnd5e6b0pACJQg9IHy9C4qjFIPxeccPVGCiJD
 G1abhSTc3dxj3gdMVFvt8MFEjGoNIJQ7NHsIt0Sh7lgO0YbJ1UJ43ZoLNfND7nBWCsHO
 R+Xb8vlBhaqrWCs7nSeD/S/Js59lNHiggGIZlge2saVmxr0XudxK6W3/fCuHb8AJpwCz
 PTFxSA2jrEvk/8T1JNQFXinEEGYcY+yr0hdSBpgC1oDt/odsoXXEGFSzVs/GDg8cvEDO
 ROe7fwwp1LVpZTldFsD1Fu2V3sO8QJ0M9ZGd5VOodMv2ecM2dHONhOg0vW1E+jH16/wC VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37juyp12u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:17:02 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12UD4DaL056983;
        Tue, 30 Mar 2021 09:17:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37juyp12s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:17:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UDBr50012208;
        Tue, 30 Mar 2021 13:16:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37hvb8jqqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 13:16:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UDGtSo35389714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 13:16:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A72194C05A;
        Tue, 30 Mar 2021 13:16:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9E04C046;
        Tue, 30 Mar 2021 13:16:53 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.103.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 13:16:53 +0000 (GMT)
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
Subject: [PATCH v3 2/3] ima: enable signing of modules with build time generated key
Date:   Tue, 30 Mar 2021 09:16:35 -0400
Message-Id: <20210330131636.21711-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330131636.21711-1-nayna@linux.ibm.com>
References: <20210330131636.21711-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nhSccJ3rEukCWVDcnSo8xLhS8QVIo_BL
X-Proofpoint-GUID: PjWfczEbCaQWISztLEhlnAiokKJw8qXe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_03:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel build process currently only signs kernel modules when
MODULE_SIG is enabled. Also, sign the kernel modules at build time when
IMA_APPRAISE_MODSIG is enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
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

