Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304DC46DE39
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 23:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbhLHWW6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 17:22:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240640AbhLHWWO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 17:22:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8LSn2p012748;
        Wed, 8 Dec 2021 22:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z69muX35ZlpobS3w1nUqcim7JCLDXKuabnrT4KTs25c=;
 b=F8tl392e5URV0dtY8331aiEi+S82ZopVsnuFU7mGH1WIKvHidcMwPtNpc8VjmJigZmYC
 rI8UJ9gDrqaU6ykzEP35BrdI/dwdLP8aCF4NMox39tB72g3P02eJui8kfzHyLTr/S+NH
 Y22H4sVBEMHjjHupEtEVQzz78gYrudjuofSqAApCHfXNW0yD4iBs8mjBf3urzK8FYi9K
 dTXHBDgjvKCkxBZ87OySGw+lWi9A5IcKyAtSP2k/vbyByrDnvqL434+RmtBfOucQ3VXW
 lIS/1F2R6GmkVs1HZLOR4YhFbeU0TYHVAMYcPIKTOfGIYqxvPhs0a8hjUAlqlwrgSLPM bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cu4n8rs76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:27 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8MHcF8019153;
        Wed, 8 Dec 2021 22:18:27 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cu4n8rs70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:27 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MCSgD026184;
        Wed, 8 Dec 2021 22:18:26 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3cqyybbhj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:26 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8MIOn619268004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 22:18:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06572806D;
        Wed,  8 Dec 2021 22:18:24 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5F032805C;
        Wed,  8 Dec 2021 22:18:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 22:18:24 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 09/16] ima: Only accept AUDIT rules for IMA non-init_ima_ns namespaces for now
Date:   Wed,  8 Dec 2021 17:18:11 -0500
Message-Id: <20211208221818.1519628-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208221818.1519628-1-stefanb@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kp63ZwRyZxl-pQkUUFDVgvj1liMFxCoU
X-Proofpoint-GUID: tF9MeZTyNAwaqOQiYJh0e3xdlHFPLADK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Only accept AUDIT rules for non-init_ima_ns namespaces rejecting all rules
that require support for measuring, appraisal, and hashing.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_policy.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4d6d3a39f65e..747dca6131d6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1787,6 +1787,16 @@ static int ima_parse_rule(struct ima_namespace *ns,
 			result = -EINVAL;
 			break;
 		}
+
+		/* IMA namespace only accepts AUDIT rules */
+		if (ns != &init_ima_ns) {
+			switch (entry->action) {
+			case MEASURE:
+			case APPRAISE:
+			case HASH:
+				result = -EINVAL;
+			}
+		}
 	}
 	if (!result && !ima_validate_rule(entry))
 		result = -EINVAL;
-- 
2.31.1

