Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81831F1F5
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBRWBf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:01:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhBRWB0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:01:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11ILXJr3055315;
        Thu, 18 Feb 2021 17:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UV7AB5KnmxKreuN8XfOrjaI1Hgg2jOAmH5AzwtIRD2E=;
 b=cNai9womXs30Iw0ntnLqJwwdvIjPBbCGvNYuuXPpyUlZWlwqE3U+Owazf/Kd4BGnhcX5
 N4xlt4D4fVfgBw+iSVISIzdWd+Q3qKpfUnjffGGjfP3w5rRifSBtlq03TTXhgwz1o+wP
 tL/fM0PD1Xu1NIIVLZi3uT9qn+pSzkAQxLTsu7PvO+ca6Jni61kAZ+LHb5oN/slOApr8
 wtLhQ3qr8wDBLa1btICQAdtqGWB/Q/Ya5tbp6tePqqjWB+cymvVKi5ppeV5PDw22C9Dn
 qJlWv/jx+XWk4HlzWSlSNIMYAU/VfcG2+80ZziDJ6IecGviYYc/QR7od+47qsxmJp7gf VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sy3atj71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:45 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11ILYNTm060120;
        Thu, 18 Feb 2021 17:00:44 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sy3atj5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:44 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ILpcd8025889;
        Thu, 18 Feb 2021 22:00:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 36rw3u9n68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 22:00:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IM0d6A45613470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:00:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 660974C044;
        Thu, 18 Feb 2021 22:00:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 684624C052;
        Thu, 18 Feb 2021 22:00:37 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.90.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 22:00:37 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 2/5] keys: generate self-signed module signing key using CSR
Date:   Thu, 18 Feb 2021 17:00:08 -0500
Message-Id: <20210218220011.67625-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210218220011.67625-1-nayna@linux.ibm.com>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180178
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Loading a key on the IMA trusted keyring requires the key be signed
by an existing key on the builtin or secondary trusted keyring.
Creating a Certificate Signing Request (CSR) allows the certificate
to be self-signed or signed by a CA.

Generate a self-signed module signing key using CSR.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 Makefile       |  3 ++-
 certs/Makefile | 15 +++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 004163a4e6b3..a971d4ae40bd 100644
--- a/Makefile
+++ b/Makefile
@@ -1473,7 +1473,8 @@ MRPROPER_FILES += include/config include/generated          \
 		  .config .config.old .version \
 		  Module.symvers \
 		  certs/signing_key.pem certs/signing_key.x509 \
-		  certs/x509.genkey \
+		  certs/x509.genkey certs/signing_key.key \
+		  certs/signing_key.crt certs/signing_key.csr \
 		  vmlinux-gdb.py \
 		  *.spec
 
diff --git a/certs/Makefile b/certs/Makefile
index f4c25b67aad9..b2be7eb413d3 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -60,11 +60,18 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "### needs to be run as root, and uses a hardware random"
 	@$(kecho) "### number generator if one is available."
 	@$(kecho) "###"
-	$(Q)openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
-		-batch -x509 -config $(obj)/x509.genkey \
-		-outform PEM -out $(obj)/signing_key.pem \
-		-keyout $(obj)/signing_key.pem \
+	$(Q)openssl req -new -nodes -utf8 \
+		-batch -config $(obj)/x509.genkey \
+		-outform PEM -out $(obj)/signing_key.csr \
+		-keyout $(obj)/signing_key.key -extensions myexts \
 		$($(quiet)redirect_openssl)
+	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
+		-outform PEM -out $(obj)/signing_key.crt \
+		-signkey $(obj)/signing_key.key \
+		-$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
+		-extfile $(obj)/x509.genkey \
+		$($(quiet)redirect_openssl)
+	@cat $(obj)/signing_key.key $(obj)/signing_key.crt >> $(obj)/signing_key.pem
 	@$(kecho) "###"
 	@$(kecho) "### Key pair generated."
 	@$(kecho) "###"
-- 
2.29.2

