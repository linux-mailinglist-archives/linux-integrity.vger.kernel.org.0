Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C07130566
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 02:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgAEBYu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Jan 2020 20:24:50 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:52344 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727152AbgAEBYn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Jan 2020 20:24:43 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0051OFPK028216;
        Sun, 5 Jan 2020 01:24:29 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2xb423rdgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Jan 2020 01:24:29 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 7AC319D;
        Sun,  5 Jan 2020 01:24:28 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id E05BE3B;
        Sun,  5 Jan 2020 01:24:25 +0000 (UTC)
From:   Clay Chang <clayc@hpe.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, Clay Chang <clayc@hpe.com>
Subject: [PATCH v2] ima: Add a space after printing LSM rules for readability
Date:   Sun,  5 Jan 2020 09:18:13 +0800
Message-Id: <20200105011813.13249-1-clayc@hpe.com>
X-Mailer: git-send-email 2.16.6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-04_06:2020-01-02,2020-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=590
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001050012
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When reading ima_policy from securityfs, there is a missing
space between output string of LSM rules and the remaining
rules.

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
2.16.6

