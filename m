Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0416319395
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 20:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhBKT4L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 14:56:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231322AbhBKTzt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 14:55:49 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BJX6Nn073148;
        Thu, 11 Feb 2021 14:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7/wkJ01FAVeHcpEgJJy5JPj3Hy1lw1pR58cXjBlc7ck=;
 b=LeTGjvzvg1jPxYOXC3YkrhYR1roiEhavxPzGt3RBrWJIOZtfXfui9mMOUA5Vz0kACAlp
 9etOZxr77uTm+UJRWam6DE5Zj/5/IBHtCEuJ3cP277b0Qom5guuMy/0yaZjdaiQPn9r9
 kYhAAcMCXn9ekxtpQ0feq7FdxuAmxBg3oQZSMPlcqSuNTW72tszvxmLiEbKxPimzFdTO
 8suVksSe9nTgPGszyJIkipdTuM5Eh9GvsILI0XGiQRWQffPwnHYivMLmnjJe1NEwc4IE
 yv7dnOJq2rivCAZQIvUYXnL6eIRZptjRR4yT3XCIAPU6PZfaEmDRCwlqfKvyZsh/p8xD hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36n9nvths0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:08 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BJXDCB073539;
        Thu, 11 Feb 2021 14:55:07 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36n9nvthr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:07 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BJrnp0020343;
        Thu, 11 Feb 2021 19:55:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 36j94wnady-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 19:55:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BJt21X63767000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:55:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30E1642041;
        Thu, 11 Feb 2021 19:55:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FE8D4203F;
        Thu, 11 Feb 2021 19:55:00 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.160.81.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 19:55:00 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 2/5] keys: generate self-signed module signing key using CSR
Date:   Thu, 11 Feb 2021 14:54:32 -0500
Message-Id: <20210211195435.135582-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211195435.135582-1-nayna@linux.ibm.com>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110153
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Loading a key on the IMA trusted keyring requires the key be signed
by an existing key on the builtin or secondary trusted keyring.
Creating a Certificate Signing Request (CSR) allows the certificate
to be self-signed or signed by a CA.

This patch generates a self-signed module signing key using CSR.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 Makefile       |  3 ++-
 certs/Makefile | 15 +++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index af18aab6bbee..9c87fdd600d8 100644
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
2.18.1

