Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6778C12F52E
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 09:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgACIDF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 03:03:05 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:1906 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgACIDE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 03:03:04 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2020 03:03:04 EST
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0037rYgJ004685;
        Fri, 3 Jan 2020 07:57:51 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2xa0m1gc17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jan 2020 07:57:51 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 583DF59;
        Fri,  3 Jan 2020 07:57:51 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 44A3E45;
        Fri,  3 Jan 2020 07:57:48 +0000 (UTC)
From:   clayc@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        Clay Chang <clayc@hpe.com>
Subject: [PATCH] ima: Add a space after printing a LSM rule for readability
Date:   Fri,  3 Jan 2020 15:51:03 +0800
Message-Id: <1578037863-7102-1-git-send-email-clayc@hpe.com>
X-Mailer: git-send-email 1.8.3.1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_01:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=786
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001030074
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Clay Chang <clayc@hpe.com>

When reading ima_policy from securityfs, there is a missing
space between output string of LSM rules.

Signed-off-by: Clay Chang <clayc@hpe.com>
---
 security/integrity/ima/ima_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ef8dfd47c7e3..1a266e4f99bc 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1496,6 +1496,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 					   (char *)entry->lsm[i].args_p);
 				break;
 			}
+			seq_puts(m, " ");
 		}
 	}
 	if (entry->template)
-- 
2.18.1

