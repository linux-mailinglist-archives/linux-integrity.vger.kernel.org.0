Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E340535A12E
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhDIOfq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 10:35:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233856AbhDIOfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 10:35:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139EYNcP019510;
        Fri, 9 Apr 2021 10:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7Yh9kdqpn94db50l9LluGBM9TDwVjqitryvjxzReWf8=;
 b=ZmBJXM+QNrAcJzfqdARNhrs+HViC6I9yc5OzvpeKBJoiNMWlq2AtNA8oHJCirh/iaq6k
 F9sDSOtxK8ZzVGgI00dCwTxzxQ0b54l+0fzMqxHaKIjOLFZYjfUvNst9gUbw8Ze7/U5z
 82zNJ1wkX8/dUe2pesclFIX2Zrqt6OY7o337HR7iVrfVmqXRTRqLbT20Ka2Cx6Wnn7Lp
 dPKsESq1NXG1yr+mEBmCLsDKmF0ehklcKMGiIcpO1FMnsnX4tM/316IQssbuvDu4GBUi
 QeCpA0WJ+YFH/1cfxtWSzyKuyJMCSf0roSZQKHD3QwkaAouNT4KWBlP7bGhjxp1utyJz NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37t4dyu9s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:22 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139EYXa9020242;
        Fri, 9 Apr 2021 10:35:22 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37t4dyu9rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:22 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139EZKv2026054;
        Fri, 9 Apr 2021 14:35:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 37rvbw1bya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:35:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139EYuXC18153910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 14:34:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51DE24C050;
        Fri,  9 Apr 2021 14:35:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF33D4C046;
        Fri,  9 Apr 2021 14:35:14 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.63.3])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 14:35:14 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v4 1/3] keys: cleanup build time module signing keys
Date:   Fri,  9 Apr 2021 10:35:05 -0400
Message-Id: <20210409143507.191443-2-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409143507.191443-1-nayna@linux.ibm.com>
References: <20210409143507.191443-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zt_06Nj6vJIojrwF9Qc9WSsX_Ioz-F8P
X-Proofpoint-ORIG-GUID: W5t3HNhSu8twDyZJJOg3Ot9oCwZ1kW2y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_06:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090110
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index cc77fd45ca64..d64c94f41edb 100644
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

