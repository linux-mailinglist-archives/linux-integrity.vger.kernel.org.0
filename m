Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F9031F1F1
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBRWBY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:01:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhBRWBW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:01:22 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11ILVfZu092239;
        Thu, 18 Feb 2021 17:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qhOhmOSlRHu/QFvy8AKYzEzboyP7R3nJYWj++xCcRQw=;
 b=UMNzUAQtb8ZL45oxgvT9bIFWgPy+3rUN3B4/2/xcFWqj/cCSb5KFg69q7tx7cGOY+/zY
 AwW0amnESpnc69EOoLguIUFW/oC17Kq1ihnLmhLYrEjzM5yo3I9lL6DThl7aJ1xC+QWi
 gbSCKxyk9JbwImYV86LEAWZQ+D3XqWnwaOLSzuYJEQK6z+Tx/rjT1tRn/3tDOZSGy+Vc
 gWs0t0ZDskcExxlFWCMq1QmDoq38qg84tkDTcW5POC0/kNQTx4tMhPD+bGOxedbljtiJ
 zDkQquAUZZ8bi9wE2ERKsamyb+O2GabcC1d76shY4dytn+JyD+qw17CdFhjXX7k2SeoI 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0790p0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:41 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11ILhejK001773;
        Thu, 18 Feb 2021 17:00:40 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0790ny8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:40 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ILtfNK009800;
        Thu, 18 Feb 2021 22:00:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 36p6d8amgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 22:00:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IM0Yd161145568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:00:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 882064C058;
        Thu, 18 Feb 2021 22:00:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81C974C052;
        Thu, 18 Feb 2021 22:00:32 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.90.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 22:00:32 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 1/5] keys: cleanup build time module signing keys
Date:   Thu, 18 Feb 2021 17:00:07 -0500
Message-Id: <20210218220011.67625-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210218220011.67625-1-nayna@linux.ibm.com>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180176
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "mrproper" target is still looking for build time generated keys in
the old path instead of certs/ directory. Fix the path and remove the
names of the files which are no longer generated.

Fixes: fb1179499134 ("modsign: Use single PEM file for autogenerated key")
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index de1acaefe87e..004163a4e6b3 100644
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
2.29.2

