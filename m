Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9562C28C55D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbgJLXoc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 19:44:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54972 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388855AbgJLXoc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 19:44:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CNV19t139472
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/mjPZYxrXDv+TKKuBOCyCArxDeKMNQontADYbn80Mk8=;
 b=f3yntxBGWFBIB9P7nyWUuSFBDTtTWSz70qpc+u+Z58/NFYTeV+3lie+DUxtDgV8pfp8p
 z0GLYdGbBSSNc9pURtYN3kr1xfqq0WhFu8WgW4Np3c7d/x6jlZ+qsC8F68nKJ5MSbpY9
 RiBNI+C92a4zJ1V8zrO98AguYl6GUNz5+cDMGZsBAMveDiaUjuuy5UYWg/ukx11qZK02
 DYsPTWwVAtaYlug/cGfuoP/1tkB7sYLrnWQMeNSi0Rkaw6+7G1YOW236m57DQLG7h4cx
 nBqzrFHOrMt1bPkC625Vlfi/Cz6AAJeme2Atdu9yGEpUkb8vYmQphWqSfJeEU7BTMaSe 9g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344xdc3f5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:31 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CNgu9u006275
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:30 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3434k8u79d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CNiTEL57540878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 23:44:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAB16B205F;
        Mon, 12 Oct 2020 23:44:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4AF1B2064;
        Mon, 12 Oct 2020 23:44:29 +0000 (GMT)
Received: from eve.home (unknown [9.85.142.21])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 23:44:29 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v2 5/5] ima-evm-utils: Expand the INSTALL instructions.
Date:   Mon, 12 Oct 2020 19:44:16 -0400
Message-Id: <20201012234416.20995-6-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012234416.20995-1-kgoldman@us.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=847 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120167
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add some of the less obvious package, TPM, and TSS prerequisites.

autoreconf -i is required before ./configure

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
 INSTALL | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 007e939..58a1f46 100644
--- a/INSTALL
+++ b/INSTALL
@@ -9,10 +9,31 @@ are permitted in any medium without royalty provided the copyright
 notice and this notice are preserved.  This file is offered as-is,
 without warranty of any kind.
 
+Prerequisites
+=============
+
+This project has the following prerequisites:
+
+(Ubuntu package names)
+	libkeyutils-dev
+	libtasn1-dev
+	libgmp-dev
+	libnspr4-dev
+	libnss3-dev
+
+These software TPMs are supported:
+      https://github.com/stefanberger/swtpm
+      https://sourceforge.net/projects/ibmswtpm2/
+      https://github.com/stefanberger/libtpms
+
+Supported TSSes include these.  Both are included in some distros.
+	  IBM TSS https://sourceforge.net/projects/ibmtpm20tss/
+	  Intel TSS
+
 Basic Installation
 ==================
 
-   Briefly, the shell commands `./configure; make; make install' should
+   Briefly, the shell commands `autoreconf -i; ./configure; make; make install' should
 configure, build, and install this package.  The following
 more-detailed instructions are generic; see the `README' file for
 instructions specific to this package.  Some packages provide this
@@ -51,7 +72,7 @@ of `autoconf'.
    The simplest way to compile this package is:
 
   1. `cd' to the directory containing the package's source code and type
-     `./configure' to configure the package for your system.
+     `autoreconf -i' and then `./configure' to configure the package for your system.
 
      Running `configure' might take a while.  While running, it prints
      some messages telling which features it is checking for.
-- 
2.25.1

