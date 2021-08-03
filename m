Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D023DF67F
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 22:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhHCUku (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 16:40:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhHCUkt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 16:40:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173KYUJM018489
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=NSHfizskoDBwTETKKmvv9Jo8YHiD8ypvmM8mmz4v1fg=;
 b=sJi94HewRqKkLaocB3GNlcqnbeuPnVyUDzR8dd+T4DBSZjfKNXNfQbz0DPgqX2O7ZdXO
 Nuejh3hQaffHh1Qa7Msx9WcHZP7FQPERM5dZqXv6Qsn1jx6UGFEfJLXSQlvp4XTBfOtI
 CfMXprYBqHEEOCjK7UJLkJyr4nRqHX4S+QwtfG3o/bQmwLzsqIZ23UwnioruqibRLHAd
 9jMawM+NKSGt8Ludt067A+yWyIGdJ49i5CQ0itkSfZr10cwS8x74/y8tkPT0yQKq7FGy
 WnXzQgi5vkIBNM0YXW0zUv9n/YX7AUlNN9Sq9z+A4pjKW/w6XL68IabnWiobKCnZTfgQ Ww== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a73423hgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 16:40:38 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173KdDX4015930
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 20:40:37 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3a4x5cfv2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 20:40:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173KeabJ14811462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 20:40:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 482A4B2064;
        Tue,  3 Aug 2021 20:40:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D00BB2065;
        Tue,  3 Aug 2021 20:40:35 +0000 (GMT)
Received: from eve.home (unknown [9.211.130.149])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 20:40:35 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     zohar@linux.ibm.com, maroon@lists.linux.ibm.com,
        linux-integrity@vger.kernel.org
Cc:     kgold@linux.ibm.com, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v5 ima-evm-utils 1/3] Expand the INSTALL instructions.
Date:   Tue,  3 Aug 2021 16:40:06 -0400
Message-Id: <20210803204008.29612-2-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803204008.29612-1-kgoldman@us.ibm.com>
References: <20210803204008.29612-1-kgoldman@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7nOmp-2i669UiXsqFVF-TkYM0dn7P-h5
X-Proofpoint-GUID: 7nOmp-2i669UiXsqFVF-TkYM0dn7P-h5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=978
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add some of the less obvious package, TPM, and TSS prerequisites.

autoreconf -i is required before ./configure

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
 INSTALL | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 007e939..052652d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -9,10 +9,33 @@ are permitted in any medium without royalty provided the copyright
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
+      https://sourceforge.net/projects/ibmswtpm2/
+      https://github.com/stefanberger/swtpm
+
+      swtpm depends upon
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
@@ -51,7 +74,7 @@ of `autoconf'.
    The simplest way to compile this package is:
 
   1. `cd' to the directory containing the package's source code and type
-     `./configure' to configure the package for your system.
+     `autoreconf -i' and then `./configure' to configure the package for your system.
 
      Running `configure' might take a while.  While running, it prints
      some messages telling which features it is checking for.
-- 
2.25.1

