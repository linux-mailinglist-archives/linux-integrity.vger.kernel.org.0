Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0099931939A
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 20:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBKT4O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 14:56:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230158AbhBKTzy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 14:55:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BJsCHr154301;
        Thu, 11 Feb 2021 14:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6dRyKqGZUHozjXuXF/fjBdyYikmJKTxTNynC9njUecs=;
 b=sN627cxIMcZ4n8oK6mQRXjL1JKtuIzP2hdosj2b1o1C5dZtqiMtModEQb9e46dy6DaVy
 gPt14kofab++4vkCFsr1IUt2qFrjS0kdZc535gSuLs2rSP/HsdnZliYQcpFOlzDVcRb1
 yadVn+Q78Vztv644ybXkT1e5zKSX4NhM5VdUoSP/5yadVmgf+XLeZkPXcASCk+t0QMZh
 NSeZ3ofgEvldCxtoLEXQaUM8O/1FlOcVqRccObgOHlD114+t1RZ70JkVhdxDXCl9/e6r
 CTZhMescejDEvhpiecJgybxpoeLLiU6DwYhPJHCng2o1Ft3UYnpHUUH6n4CH7cgZ9cbs Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb58g0v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:13 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BJsNF5155665;
        Thu, 11 Feb 2021 14:55:12 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb58g0u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:12 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BJrQdq020274;
        Thu, 11 Feb 2021 19:55:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 36j94wnae3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 19:55:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BJt7S446203312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:55:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CE5442045;
        Thu, 11 Feb 2021 19:55:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22E494203F;
        Thu, 11 Feb 2021 19:55:05 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.160.81.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 19:55:04 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 3/5] ima: update kernel module signing process during build
Date:   Thu, 11 Feb 2021 14:54:33 -0500
Message-Id: <20210211195435.135582-4-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211195435.135582-1-nayna@linux.ibm.com>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110151
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
2.18.1

