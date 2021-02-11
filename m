Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06A319394
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 20:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBKT4I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 14:56:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231428AbhBKTzn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 14:55:43 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BJhAoo067513;
        Thu, 11 Feb 2021 14:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rhqRtAo60Pe+xMPALLJ2Iflts1unIMdYD0lHnemZeOc=;
 b=hnQuC7xNB1tTOR+0bhXHlGdqEjsOn/jKuflRTaCCFTDVu6td9C3H68u5rg9KbaXgbYMg
 vriO8zQ4Y4Z7WL2nX2si8LM6U32RXmvGqnXMQ43D+WXZibqD/BKQqUjHCS9jhun+lU4M
 69ZQFL0eNmUhNOWIkoNlHm6Oq/A1M8vqrJPlw3FogARkzner1FmrHMSxCrS+d4i7pTp0
 aXdpC3MZbm5lDV1XFg3TYjGxcdqq8EF7Co9qz69EsfMHjhtcSpOiwv9VIApsNEV3L0JK
 56Oo/1ZiFwATwxKbwlouD3IUgSExGuhI11xI9Q/FXuSlWmNnt1mfRsnB/n8O+bo1YaGk XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nayyg8h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:01 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BJhGuv067904;
        Thu, 11 Feb 2021 14:55:01 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nayyg8fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:55:01 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BJrI0n015417;
        Thu, 11 Feb 2021 19:54:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 36m1m2t7js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 19:54:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BJsu6135193290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:54:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27CE242047;
        Thu, 11 Feb 2021 19:54:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E920742041;
        Thu, 11 Feb 2021 19:54:53 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.160.81.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 19:54:53 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 1/5] keys: cleanup build time module signing keys
Date:   Thu, 11 Feb 2021 14:54:31 -0500
Message-Id: <20210211195435.135582-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211195435.135582-1-nayna@linux.ibm.com>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110151
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "mrproper" target is still looking for build time generated keys
in the old path instead of certs/ directory.
This patch fixes the path as well removes the names of the files which
are no longer generated.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Fixes: 28a68f828266 ("modsign: Use single PEM file for autogenerated key")
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ade44ac4cc2f..af18aab6bbee 100644
--- a/Makefile
+++ b/Makefile
@@ -1472,9 +1472,9 @@ MRPROPER_FILES += include/config include/generated          \
 		  debian snap tar-install \
 		  .config .config.old .version \
 		  Module.symvers \
-		  signing_key.pem signing_key.priv signing_key.x509	\
-		  x509.genkey extra_certificates signing_key.x509.keyid	\
-		  signing_key.x509.signer vmlinux-gdb.py \
+		  certs/signing_key.pem certs/signing_key.x509 \
+		  certs/x509.genkey \
+		  vmlinux-gdb.py \
 		  *.spec
 
 # Directories & files removed with 'make distclean'
-- 
2.18.1

