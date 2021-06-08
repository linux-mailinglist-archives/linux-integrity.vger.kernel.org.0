Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D433039F7DB
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhFHNcL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 09:32:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12952 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232867AbhFHNcL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 09:32:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158DJuYc177626;
        Tue, 8 Jun 2021 09:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ewg39RdWcRakcpCx0JAhYRihEnzRCKT9T1J4uuAKVL8=;
 b=IlPJP6PHRNzfJrKxK7OYaYHm8wBc+yaM9jas1YqTV5N+y8JEvPS7Otvf9Ms5hyaEoE6X
 IgI5vjXaQSEW0DXoobi+QrOGUd0yZ3hZrHVGrZcrbi+rSNHKNNb129Su9ezIDl3sof3g
 S21ZQ1tqAgxjhYCdm0SkJ3F59vTp+m5tEysqY3rC6bvbK+tikC8H7HyEPXvpzQqflKro
 jAyADzjlFfc/ulOYfj3P6YE0zj101tb/ub17PLKCqwHqQafDdMZcn26E1deFZsGbvdki
 0Ce73CibXSw5Y72vM2RiIFQ/WX2HSh8iAEir1TbZwcY9fAe6S+9253nXascvOJDX205Z 2g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39290es30u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 09:30:08 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 158DS5v5020870;
        Tue, 8 Jun 2021 13:30:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3900w88v1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 13:30:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 158DU1hr34210280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jun 2021 13:30:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D92EA4068;
        Tue,  8 Jun 2021 13:30:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CF11A405C;
        Tue,  8 Jun 2021 13:30:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.43.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jun 2021 13:29:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/2] ima: differentiate between EVM failures in the audit log
Date:   Tue,  8 Jun 2021 09:29:49 -0400
Message-Id: <20210608132950.424148-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210608132950.424148-1-zohar@linux.ibm.com>
References: <20210608132950.424148-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8zjHj96S4jeZVct3MArFLOcSl-CLjEgf
X-Proofpoint-GUID: 8zjHj96S4jeZVct3MArFLOcSl-CLjEgf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_09:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=986 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Differentiate between an invalid EVM portable signature failure
from other EVM HMAC/signature failures.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
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

