Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD13531F1F8
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBRWBi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:01:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229874AbhBRWBc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:01:32 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11ILo23l019505;
        Thu, 18 Feb 2021 17:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IfFi8fLJ7u1Cb7FNdn37kV2gkAkhwObdazTKQBMoPWI=;
 b=ZBFFGAf96UbMqP8mrWHUWNhZRilwOrQN/bOnIa896SCLpHNgyPZxmbGX/auuuM38eL/y
 XL0gmHvlxcqaL7ieB3WOk9DcMBVLfuAfWpwuYAJHfEhIyid3eUj00/yYwGokSSN0ZcGv
 IAjSPwsEhB8ZU8sHY9mJFVuHvJP4TpD4ZuTGtLz0fwP+FPzf5QxMA1X/TpW+KxDd5SXO
 XjnucsLtxmW0hyZI1Tt13022w7iQ7Kc9ulNqwqbhht1CPqvEhUZ+ABewVa0XwBsgyKgm
 Hi0iTn6fVk0DqXBmh9hI8avln458tHEcqMCVMpqFDGLCBipdQVIYqJ1So9GJxNewjS5D yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0gj07nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:50 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11ILo7Kk022082;
        Thu, 18 Feb 2021 17:00:50 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0gj07m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:50 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ILqh3T007834;
        Thu, 18 Feb 2021 22:00:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 36p6d8amgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 22:00:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IM0jTJ37290440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:00:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 156164C05A;
        Thu, 18 Feb 2021 22:00:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E6E84C040;
        Thu, 18 Feb 2021 22:00:43 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.90.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 22:00:42 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 3/5] ima: update kernel module signing process during build
Date:   Thu, 18 Feb 2021 17:00:09 -0500
Message-Id: <20210218220011.67625-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210218220011.67625-1-nayna@linux.ibm.com>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180176
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel build process currently only signs kernel modules when
MODULE_SIG is enabled. Also, sign the kernel modules at build time when
IMA_APPRAISE_MODSIG is enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/Kconfig | 2 +-
 init/Kconfig  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/init/Kconfig b/init/Kconfig
index 29ad68325028..68147bbda5f9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2162,7 +2162,7 @@ config MODULE_SIG_FORCE
 config MODULE_SIG_ALL
 	bool "Automatically sign all modules"
 	default y
-	depends on MODULE_SIG
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
 	  Sign all modules during make modules_install. Without this option,
 	  modules must be signed manually, using the scripts/sign-file tool.
@@ -2172,7 +2172,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 
 choice
 	prompt "Which hash algorithm should modules be signed with?"
-	depends on MODULE_SIG
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	help
 	  This determines which sort of hashing algorithm will be used during
 	  signature generation.  This algorithm _must_ be built into the kernel
@@ -2204,7 +2204,7 @@ endchoice
 
 config MODULE_SIG_HASH
 	string
-	depends on MODULE_SIG
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
 	default "sha1" if MODULE_SIG_SHA1
 	default "sha224" if MODULE_SIG_SHA224
 	default "sha256" if MODULE_SIG_SHA256
-- 
2.29.2

