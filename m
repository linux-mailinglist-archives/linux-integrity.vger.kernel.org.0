Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E70288D57
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbgJIPw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 11:52:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50122 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388745AbgJIPw6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 11:52:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099FglGn171372
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 11:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=/mjPZYxrXDv+TKKuBOCyCArxDeKMNQontADYbn80Mk8=;
 b=TiWN0vVjNUCZI/CNd/pyGOI8+fLDHqhrbKOgsSRI4ddkNev6t8NQHIgGVY8//X+IUY5u
 XIGMqRx4YAqbRtn8/76R0JWDARwBcWwkcLDGCPaOIcbwOb0B+XrbJRqIB7UqUtGJc7hJ
 LsRC8nWix6J1IwWI3kSaXy9IJaA5RkDD4401HX3JwEzN4CYYS2di04w9OxrxICgvuBfC
 RgJ6YrkKECGcBbgu4Xpf1nUwDfoEM2QzKabwFCoAgYM3NZ4nGxmbMPWDpMeQOCBLxqlv
 uoYah54qzLynbBgnW8ckYDKgrTN/3XdZhFWAYzzRE7Tm/6pqkm8GxHopabq/XZxulZOj yA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342tr9r9je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 11:52:57 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099FlbZd012333
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:52:57 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3429hq00hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 15:52:57 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099Fqpuw56164716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:52:51 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0171CC6057
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:52:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3EEBC605D
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:52:55 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:52:55 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 5/5] ima-evm-utils: Expand the INSTALL instructions.
Message-ID: <f0f70e6c-ca65-1c00-c6b9-4d0439ceb512@linux.ibm.com>
Date:   Fri, 9 Oct 2020 11:52:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=914 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090112
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

