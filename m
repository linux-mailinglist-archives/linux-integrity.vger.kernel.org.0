Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F63368A4F
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Apr 2021 03:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhDWBRK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 21:17:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235302AbhDWBRK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 21:17:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13N12vxV105266;
        Thu, 22 Apr 2021 21:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WCR08HLwwWRb8pAWrXgvI7x6gIayoqqrGOqJvhQPaXI=;
 b=oiFD23uM9GLTJditlSQeklAbH0cdfeD4NMld3eGLhnoHJOHb5PK9kEuQWtfz6joI+3No
 O0+c2p/HLVHNZa6AkxzWsf2rwyc0Ov9E8jS35IV8goWXTa4RoerxIDsX1UikXjsS2vqT
 46fRFC1yvn2D+uMEJMg/KA655TbOpOT6PTjDU8sNyxdmodY0sSvuJ3uiFS04KXpPJ5vE
 Z+leI+aN7MWxICGvCg2nDh6JMMOSxmuda+dmIFL0zd/R8PqbPVvFGspPtlAJVWCdV5Vv
 J5g/efz3w6U13HN9RPEDlW5v4jHXpQd5YAhkafzxO0iNQRV6YFPgPv6hofSzA+hWc8py qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 383bhsxsfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 21:16:15 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13N1Dx1J140114;
        Thu, 22 Apr 2021 21:16:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 383bhsxsey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 21:16:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13N1F8I5020727;
        Fri, 23 Apr 2021 01:16:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 37yqa8k48y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 01:16:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13N1G9ah29688098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 01:16:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95C16A4040;
        Fri, 23 Apr 2021 01:16:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB68CA4055;
        Fri, 23 Apr 2021 01:16:06 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.42.66])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Apr 2021 01:16:06 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH] ima: ensure IMA_APPRAISE_MODSIG has necessary dependencies
Date:   Thu, 22 Apr 2021 21:16:02 -0400
Message-Id: <20210423011602.138946-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: thdCZmDlXiDK3Vmw2OiBe-MAdeKXbqTb
X-Proofpoint-GUID: _XxRXm8PKYLZFsFca0WG19YqSa7Uxfs-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_15:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230003
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA_APPRAISE_MODSIG is used for verifying the integrity of both kernel
and modules. Enabling IMA_APPRAISE_MODSIG without MODULES causes a build
break.

Ensure the build time kernel signing key is only generated if both
IMA_APPRAISE_MODSIG and MODULES are enabled.

Fixes: 0165f4ca223b ("ima: enable signing of modules with build time generated key") 
Reported-by: Randy Dunlap <rdunlap@infradead.org> 
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 certs/Kconfig               | 2 +-
 certs/Makefile              | 2 ++
 certs/system_certificates.S | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 48675ad319db..e4d00348fd73 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -4,7 +4,7 @@ menu "Certificates for signature checking"
 config MODULE_SIG_KEY
 	string "File name or PKCS#11 URI of module signing key"
 	default "certs/signing_key.pem"
-	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
 	help
          Provide the file name of a private key/certificate in PEM format,
          or a PKCS#11 URI according to RFC7512. The file should contain, or
diff --git a/certs/Makefile b/certs/Makefile
index e3185c57fbd8..2f369d6aa494 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -36,8 +36,10 @@ ifeq ($(CONFIG_MODULE_SIG),y)
 endif
 
 ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
+ifeq ($(CONFIG_MODULES),y)
 	SIGN_KEY = y
 endif
+endif
 
 ifdef SIGN_KEY
 ###############################################################################
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index dcad27ea8527..e1645e6f4d97 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -9,7 +9,8 @@
 system_certificate_list:
 __cert_list_start:
 __module_cert_start:
-#if defined(CONFIG_MODULE_SIG) || defined(CONFIG_IMA_APPRAISE_MODSIG)
+#if defined(CONFIG_MODULE_SIG) || (defined(CONFIG_IMA_APPRAISE_MODSIG) \
+			       && defined(CONFIG_MODULES))
 	.incbin "certs/signing_key.x509"
 #endif
 __module_cert_end:
-- 
2.29.2

