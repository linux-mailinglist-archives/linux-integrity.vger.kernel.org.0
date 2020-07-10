Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0C21BA33
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGJQBU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgGJQBU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFVxiU031715;
        Fri, 10 Jul 2020 12:01:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpesgwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:17 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFX9PG038791;
        Fri, 10 Jul 2020 12:01:16 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpesgur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:16 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AFw9Gf030245;
        Fri, 10 Jul 2020 16:01:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 326bcj8cmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG1BeQ30670880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAD5F42041;
        Fri, 10 Jul 2020 16:01:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D1DD42054;
        Fri, 10 Jul 2020 16:01:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:11 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 8/8] ima-evm-utils: update README to reflect "--pcrs", "--verify" and "--validate"
Date:   Fri, 10 Jul 2020 12:00:59 -0400
Message-Id: <1594396859-9232-9-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_10:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=1 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

"--pcrs" compares the re-calculate PCRs against a file containing TPM 1.2 pcrs.
"--validate" ignores ToMToU measurement violations.
"--verify" verifies the template data digest based on the template data.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 README | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 374b748c59bf..64b9da508d8d 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement [--verify-sig [--key "key1, key2, ..."]] file
+ ima_measurement [--validate] [--verify] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs file] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
@@ -59,6 +59,9 @@ OPTIONS
       --m32          force EVM hmac/signature for 32 bit target system
       --m64          force EVM hmac/signature for 64 bit target system
       --engine e     preload OpenSSL engine e (such as: gost)
+      --pcrs         file containing TPM 1.2 pcrs
+      --validate     ignore ToMToU measurement violations
+      --verify       verify the template data digest
       --verify-sig   verify the template data file signature
   -v                 increase verbosity level
   -h, --help         display this help and exit
-- 
2.7.5

