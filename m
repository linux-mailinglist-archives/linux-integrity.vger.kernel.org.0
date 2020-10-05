Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FD28428D
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 00:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgJEWex (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 18:34:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgJEWex (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 18:34:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095MXOlQ044258
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 18:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=/mjPZYxrXDv+TKKuBOCyCArxDeKMNQontADYbn80Mk8=;
 b=n/kw5Pzj3snqiMSQyH9IzaqQNk1HjoCEIXRIkUzhgrjZY5TvUm0WTAMo3RcQMzqvP7SQ
 lQAKgLxAufAx52vYNPL1FAWXOYt0DmU1u3I/rESiS6MVCuhH6+806nAsGyLysLpghRJr
 hlfRLVob95jrXriEZrmOT/SMLjbT/COFXyQigQnaAY58RAN8l/Ywo16j7akinBGiYlGC
 bNFdsYpDq7p7b2AIRI88RjkrnL/5gTIB5wd3l0E5sULLQ9Br/lk/IrYJsuyVEZH0BBHI
 +FDRdDIv2PcW7un5SASesMQBMw/v5VsB3GnhQjm2uNjZhcqHp9SH+XkcsWTM3h+t6vZW 4A== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 340c33gbq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 18:34:52 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095MROmO003771
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:34:51 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 33xgx97mx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 22:34:51 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095MYjUf61800758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:34:45 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8FE2C607B
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:34:49 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF589C607C
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:34:49 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:34:49 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 6/6] ima-evm-utils: Expand the INSTALL instructions.
Message-ID: <1709109b-15e1-a30a-b39b-ccf824902ce1@linux.ibm.com>
Date:   Mon, 5 Oct 2020 18:34:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_16:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=902 spamscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050156
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

