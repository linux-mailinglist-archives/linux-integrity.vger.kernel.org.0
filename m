Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841FF8574B
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 02:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfHHAna (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Aug 2019 20:43:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729624AbfHHAna (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Aug 2019 20:43:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x780fXOR164358;
        Wed, 7 Aug 2019 20:43:25 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u88ke9py8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 20:43:25 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x780Q2h5013670;
        Thu, 8 Aug 2019 00:43:25 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 2u51w645ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 00:43:25 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x780hOWG60358964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 00:43:24 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 378587805F;
        Thu,  8 Aug 2019 00:43:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8C777805E;
        Thu,  8 Aug 2019 00:43:22 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.230.139])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Aug 2019 00:43:22 +0000 (GMT)
References: <201908072140.Qep3jWIW%lkp@intel.com> <2ee96e49ade2e30a44fa14840610b432@lip6.fr>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        kbuild-all@01.org
Subject: [PATCH] ima: Fix use after free in ima_read_modsig()
In-reply-to: <2ee96e49ade2e30a44fa14840610b432@lip6.fr>
Date:   Wed, 07 Aug 2019 21:43:18 -0300
Message-ID: <8736ico5ax.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080002
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Julia Lawall <Julia.Lawall@lip6.fr> writes:

> This looks risky. See lines 80 and 81.

That is indeed a bug. Thanks for spotting it!

Here's the fix:

From 445e9ab15f61dc3b1fa1a30495d233bd2d2ecdaa Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Wed, 7 Aug 2019 21:29:53 -0300
Subject: [PATCH] ima: Fix use after free in ima_read_modsig()

If we can't parse the PKCS7 in the appended modsig, we will free the modsig
structure and then access one of its members to determine the error value.

Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima_modsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index c412e31d1714..d106885cc495 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -91,8 +91,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
 	if (IS_ERR(hdr->pkcs7_msg)) {
+		rc = PTR_ERR(hdr->pkcs7_msg);
 		kfree(hdr);
-		return PTR_ERR(hdr->pkcs7_msg);
+		return rc;
 	}
 
 	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
