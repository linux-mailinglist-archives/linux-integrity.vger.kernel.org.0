Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37B3CB868
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbhGPOIm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 10:08:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232808AbhGPOIl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 10:08:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GE4Bpo077732
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 10:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qYPgEZPqwTCCMUFMpiyJc1dz88+EcRE48GzLcnLvHh4=;
 b=sTQ7UzODBkJzvqU2BGPPwcSxML7eVL74+S1/ZThOnM7fPPo606M2LximUBl9iSHSFSZV
 eO5RL7vT3rwikJ5QKlPuR1iM3gytpf0jmqb+aHpz9DMTk1/7cq8Poc/ApKZMZftvwrdj
 ErJkgPeB5E6aCTuU6vZXTrOthzKCNT8JPx9fJPvgUVorBt8+RrSwMQWtYPkEsIOD/3K6
 WOqAncoNGAisAIRQCg8JRccbkwPrfRClnW90ulcu/rbqDP9ZLdvG5z5P2Nj5NmkNgyF0
 SGSn74KWOj+MB9W92LCqMzB6NKW/Y/m7zrD/KnPQrWmycC8i4hbm9YHt7u0FvO69BS5h Vw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39tw2rxhgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 10:05:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GE4Nkx017074
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 14:05:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 39q368asap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 14:05:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GE5fbK13041972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 14:05:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D00E5204F;
        Fri, 16 Jul 2021 14:05:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.55.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 42CF652054;
        Fri, 16 Jul 2021 14:05:40 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils 3/3] Remove unnecessary NULL pointer test
Date:   Fri, 16 Jul 2021 10:05:31 -0400
Message-Id: <20210716140531.945013-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210716140531.945013-1-zohar@linux.ibm.com>
References: <20210716140531.945013-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2iwl7EZCcimy-kqh6nWpU-ymmlVJvWcS
X-Proofpoint-ORIG-GUID: 2iwl7EZCcimy-kqh6nWpU-ymmlVJvWcS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107160086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove the "Logically dead code (DEADCODE)" as reported by Coverity.

Fixes: 9c79b7de7231 ("ima-evm-utils: support verifying the measurement list using multiple keys")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 261712717368..925c3cccf964 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -392,8 +392,6 @@ void init_public_keys(const char *keyfiles)
 	keyfiles_free = tmp_keyfiles;
 
 	while ((keyfile = strsep(&tmp_keyfiles, ", \t")) != NULL) {
-		if (!keyfile)
-			break;
 		if ((*keyfile == '\0') || (*keyfile == ' ') ||
 		    (*keyfile == '\t'))
 			continue;
-- 
2.27.0

