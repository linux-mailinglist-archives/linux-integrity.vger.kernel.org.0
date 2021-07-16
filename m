Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A813CB869
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 16:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhGPOI6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 10:08:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhGPOI6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 10:08:58 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GE63bg083115
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 10:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=R1MlYflbXimauDrpWivqL9bNY2A+y+SCJxjUOsos+Ns=;
 b=OnBmts9lk29+17euoY9EawcLNFetANdPcTed0A5dz4FshQ1LKPiYxgGwBOVz0iNLQyCC
 bF0R5seNc/U644pRKgg7yjmds36xRn0VtH6vyZD4CZkJ5a2ooqTDbEZDW5X892tbJY6/
 TVPRhfr5k0EHcsVEwDYZQ7Wv9qGHClmWd2QHGBrXDJeM1IXT4+eLMhhlA40k0zQyhiFq
 qUojEHzZaTVz8wU1xpEce7iPPc63MNWJs8O8U/EVDZwz9un0XsHKEO3dy7tLI26E+1Pd
 H54JjuEjrNjKwPM6hGLNKSqpDWBO4N2hPM7hEZ0WiKCZ0wfn5FlHfpsFoumpnpLsDeKM tQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39twha6c8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 10:05:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GE3pmc006777
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 14:05:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 39s3p78w82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 14:05:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GE3Ott35127658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 14:03:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5EAE52057;
        Fri, 16 Jul 2021 14:05:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.55.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3848652050;
        Fri, 16 Jul 2021 14:05:36 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils 1/3] Fix out-of-bounds read
Date:   Fri, 16 Jul 2021 10:05:29 -0400
Message-Id: <20210716140531.945013-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jLkjiYMz26YtYcnr0ZxCvxnz-mYsqxl8
X-Proofpoint-GUID: jLkjiYMz26YtYcnr0ZxCvxnz-mYsqxl8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107160086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Coverity reported "overrunning an array".  Properly clear only the
remaining unused buffer memory.

Fixes: 874c0fd45cab ("EVM hmac calculation")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 04f14af9ab29..e1464ade4837 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1108,7 +1108,8 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 	/* EVM key is 128 bytes */
 	memcpy(evmkey, key, keylen);
-	memset(evmkey + keylen, 0, sizeof(evmkey) - keylen);
+	if (keylen < sizeof(evmkey))
+		memset(evmkey + keylen, 0, sizeof(evmkey) - keylen);
 
 	if (lstat(file, &st)) {
 		log_err("Failed to stat: %s\n", file);
-- 
2.27.0

