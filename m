Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C934E8C3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhC3NRc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 09:17:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232147AbhC3NRD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 09:17:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UD5cBN063901;
        Tue, 30 Mar 2021 09:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZQkd2Ct+Icr0gv9shTuyQc3B/gEceCSmgfsacoNIPEg=;
 b=eg6/N2ttOYu697NKHgAEGv73sY9MmHPt8Ip3P5IVr4fUEy8zSBLEsqcm8WtyQljUEbCj
 EagM/QzMBPPtcT/XCKFaNfYqHD7eYF5JP7e0uQKqT2HId6nbxIDZKoylWJicKEknPjlR
 0cZ9DBGNTqLynwpYSkjfG/tus+T8tkpsu5dLlAhN9OvY/64VmGRkc6Q/B5syZMTwWVUO
 R4PoRe/mZXGGzeyAAN8Cl74C+cq1dFXeyNF9cDZNof9IES3sqmY8L/DCElwl8ujzoaye
 b636GIOI/NFuDlnorbXC+oQ9opqiXi8KclZOw84SBCCghDnjCO74zKW84/C+ivLauiWw 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhsss0f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:16:58 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12UD5nkW064549;
        Tue, 30 Mar 2021 09:16:58 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhsss0dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:16:58 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UDCgZx027242;
        Tue, 30 Mar 2021 13:16:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 37hvb8ar9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 13:16:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UDGrXH42533284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 13:16:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16E3F4C040;
        Tue, 30 Mar 2021 13:16:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B51F34C044;
        Tue, 30 Mar 2021 13:16:50 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.103.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 13:16:50 +0000 (GMT)
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
Subject: [PATCH v3 1/3] keys: cleanup build time module signing keys
Date:   Tue, 30 Mar 2021 09:16:34 -0400
Message-Id: <20210330131636.21711-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330131636.21711-1-nayna@linux.ibm.com>
References: <20210330131636.21711-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GxdNIn23z6Q5Qju96rqU2xb8QCLJxsjQ
X-Proofpoint-ORIG-GUID: DV7vImdVqXsffT1PYROL9no5OKHhBo3n
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_04:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "mrproper" target is still looking for build time generated keys in
the kernel root directory instead of certs directory. Fix the path and
remove the names of the files which are no longer generated.

Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d4784d181123..b7c2ed2a8684 100644
--- a/Makefile
+++ b/Makefile
@@ -1523,9 +1523,9 @@ MRPROPER_FILES += include/config include/generated          \
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

