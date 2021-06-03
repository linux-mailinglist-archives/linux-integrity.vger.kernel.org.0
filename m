Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7CC39A459
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhFCPUf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 11:20:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231213AbhFCPUf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 11:20:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153F2muj002452;
        Thu, 3 Jun 2021 11:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YGVTvtZ2197bMJsi30kXLH9UGy+Hm2FqxQc/5o4GYmE=;
 b=ULzVfajkIBV6o59QcLEsHXqd7o6JVsxpNL8VgrrmnwctUHguCAWKz+0ihLMjNa04Kkmf
 U8nkrOF4tM2KrrNRc0v7xwmAYtg1SFmaCrvVzEedtQxY41/ZMkFdntd6ZOa2S+YvL0qU
 8GMAS7HDaLqgsuLqJC4L2eDfFUB1CoPATYcvXn1ydyYM95EoX1SYcww9vAc3tCWXmMkF
 43Hc9ZnQoY6y7pKbc511PLJwpLiAqaQxXmSdwnna4qCTzt7r6Qn7zbg7eiwGQBu0mRil
 7eIvAUv9CMd9On/yWT614BGxAyQdv3If0eZ/zj7pLx35T7rYGO/FoECVJLpxCt01mVGj Qw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38y0tx9yyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 11:18:37 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 153FI0c2032678;
        Thu, 3 Jun 2021 15:18:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 38w413s22q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 15:18:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 153FIW5j22348260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 15:18:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FEBDA4057;
        Thu,  3 Jun 2021 15:18:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57EDFA4053;
        Thu,  3 Jun 2021 15:18:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.13.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 15:18:31 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 1/2] ima: differentiate between EVM failures in the audit log
Date:   Thu,  3 Jun 2021 11:18:18 -0400
Message-Id: <20210603151819.242247-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210603151819.242247-1-zohar@linux.ibm.com>
References: <20210603151819.242247-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vHnxOp7GvK0wnTVcOt4uc-MEyHpP8Bvg
X-Proofpoint-GUID: vHnxOp7GvK0wnTVcOt4uc-MEyHpP8Bvg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_09:2021-06-02,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=989 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Differenatiate between an invalid EVM portable signature failure
from other EVM HMAC/signature failures.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 940695e7b535..ef9dcfce45d4 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -422,7 +422,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 		goto out;
 	case INTEGRITY_FAIL_IMMUTABLE:
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-		fallthrough;
+		cause = "invalid-fail-immutable";
+		goto out;
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
 		cause = "invalid-HMAC";
 		goto out;
-- 
2.27.0

