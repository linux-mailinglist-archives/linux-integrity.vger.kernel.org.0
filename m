Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0F58E84
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 01:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0X0p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 19:26:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbfF0X0o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 19:26:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RNQcIC037296
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 19:26:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2td4fef2j3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 19:26:43 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 28 Jun 2019 00:26:42 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 00:26:39 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RNQbRX59703622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 23:26:38 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22737805E;
        Thu, 27 Jun 2019 23:26:37 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89E317805C;
        Thu, 27 Jun 2019 23:26:36 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.218.134])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 23:26:36 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH] ima: Update MAX_TEMPLATE_NAME_LEN to fit largest reasonable definition
Date:   Thu, 27 Jun 2019 20:25:46 -0300
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062723-0012-0000-0000-00001749BB66
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011343; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224213; UDB=6.00644313; IPR=6.01005401;
 MB=3.00027497; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 23:26:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062723-0013-0000-0000-000057DBE90C
Message-Id: <20190627232546.28746-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270272
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

MAX_TEMPLATE_NAME_LEN is used when restoring measurements carried over from
a kexec. It should be set to the length of a template containing all fields
except for 'd' and 'n', which don't need to be accounted for since they
shouldn't be defined in the same template description as 'd-ng' and 'n-ng'.

That length is greater than the current 15, so update using a sizeof() to
show where the number comes from and also can be visually shown to be
correct. The sizeof() is calculated at compile time.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima_template.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index a01a17e5c581..7343e8e0ae2f 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -47,7 +47,13 @@ static const struct ima_template_field supported_fields[] = {
 	{.field_id = "buf", .field_init = ima_eventbuf_init,
 	 .field_show = ima_show_template_buf},
 };
-#define MAX_TEMPLATE_NAME_LEN 15
+
+/*
+ * Used when restoring measurements carried over from a kexec. 'd' and 'n' don't
+ * need to be accounted for since they shouldn't be defined in the same template
+ * description as 'd-ng' and 'n-ng' respectively.
+ */
+#define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf")
 
 static struct ima_template_desc *ima_template;
 

