Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C413A3646A2
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhDSPCi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:02:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10361 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239385AbhDSPCg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:36 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEXc3d031709
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PocZSNSrd5aC5XSaQGO6Ljd88Qn0lMq94yGVHaL4PjA=;
 b=oPHaYGvu5+7cg1hmvX0+S4gK02T4kcA5IwaWvI7uDY1av2dacp9xeHGPGvBeEfwgfBlt
 q30Ls7FZUUW8V8bgVAT0650YZ26Ux29GROlS9h4f6U3z72PnZ9fhOqjnjcxFoxdhU8Sl
 snBLpdP5cgIa/8+XkfYuQjuvJ04K616eKbRjcMn9FWqLRZ13sm8AFx496A5IEh56Y+QC
 iujpslsBv3MTbeAIJ1ufeI4TPhS7sDsI3KtPyAvxSCLZBS/4LkgtDKPH9TQCrJlypAGG
 HZ8eVU4JUSAw0soZY5i0tJDekB4vgMmD4o3WXpQ2HZD1wOfsSyoIkuWb3pvpEKPw4RfA wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cwxva0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:01 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JEY5WL034801
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:00 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cwxv9yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:02:00 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JErNJC028269;
        Mon, 19 Apr 2021 15:01:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 37yqa9yc4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:01:59 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JF1v2Q26083820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:01:57 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB366136051;
        Mon, 19 Apr 2021 15:01:57 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47032136053;
        Mon, 19 Apr 2021 15:01:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:01:57 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 4/6] libimaevm: Rename variable from cr to newline
Date:   Mon, 19 Apr 2021 11:01:49 -0400
Message-Id: <20210419150151.236409-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419150151.236409-1-stefanb@linux.ibm.com>
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F9R1zyoYe9fLCGL5eI_09xOjtErrSVUo
X-Proofpoint-GUID: O_Xd-7HvcdHRPyTR_y_tjbK84w5lYKIK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rename function variable from cr (carriage return, '\r') to
newline, because this is what it is.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 9a6739b..b40b6d8 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -90,14 +90,14 @@ struct libimaevm_params imaevm_params = {
 
 static void __attribute__ ((constructor)) libinit(void);
 
-void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr)
+void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool newline)
 {
 	int i;
 	uint8_t *data = (uint8_t *) ptr;
 
 	for (i = 0; i < len; i++)
 		fprintf(fp, "%02x", data[i]);
-	if (cr)
+	if (newline)
 		fprintf(fp, "\n");
 }
 
-- 
2.30.2

