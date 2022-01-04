Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30440484691
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiADRFU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8972 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235662AbiADRE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:59 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GmuaG014924;
        Tue, 4 Jan 2022 17:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2e5kltLlwm6VClPMLb4K6puHLM+7rur5HCvqK+JuRho=;
 b=E1+N8502iKNO5wBRPILlwVx8EJ2xHiKm1OGntf2qjxpfS3mi3HV+S2LRPdkEFjeG/Je7
 Ha9dLtdZZzn9AvNoYP2uRykInETfEonn3zEAvf7ht88yqqKeK8yPBoQfEetZAI0lWDJz
 d+KDrBpN9atUkio7W+A0a9TFDacawW+QJ2Jk6wkz/I1AnpG42Bn7KSyJV1W+nrqGxeWn
 /Wetp4lBjSc8KdazQ8VjYkLpBVVobnHbMDf4cBGMhoICvh5adlOaj6YsDqu3zCyH0cR/
 JmDNMiglDqfIoakz5y4iQyW/iWkehMkyqY55VdRe7oO+31GDfh4XMMayhwm32vfJoDF+ 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcqu1ba72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:34 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204GrFAu000535;
        Tue, 4 Jan 2022 17:04:33 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcqu1ba6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H4B8F005250;
        Tue, 4 Jan 2022 17:04:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3daekajerh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:32 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4VtR31326508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CB4FAC05E;
        Tue,  4 Jan 2022 17:04:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF7C7AC05B;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
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
Subject: [PATCH v8 16/19] ima: Enable re-auditing of modified files
Date:   Tue,  4 Jan 2022 12:04:13 -0500
Message-Id: <20220104170416.1923685-17-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: td8VjC4DSQhlYZeFMiAEQ9bIezLdjStS
X-Proofpoint-GUID: yrqrfAfhOTeqbITbJRyPrxAUiUKMoonY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Walk the list of ns_status associated with an iint if the file has
changed and reset the IMA_AUDITED flag, which is part of the
IMA_DONE_MASK. This causes a new audit message to be emitted when the
file is again accessed on either the host or in an IMA namespace.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 99dc984b49c9..bc3ab08f39c6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -153,6 +153,35 @@ static void ima_rdwr_violation_check(struct ima_namespace *ns,
 				  "invalid_pcr", "open_writers");
 }
 
+#ifdef CONFIG_IMA_NS
+
+static void mask_iint_ns_status_flags(struct integrity_iint_cache *iint,
+				      unsigned long mask)
+{
+	struct ns_status *status;
+	unsigned long flags;
+
+	read_lock(&iint->ns_list_lock);
+	list_for_each_entry(status, &iint->ns_list, ns_next) {
+		flags = iint_flags(iint, status) & mask;
+		set_iint_flags(iint, status, flags);
+	}
+	read_unlock(&iint->ns_list_lock);
+}
+
+#else
+
+static void mask_iint_ns_status_flags(struct integrity_iint_cache *iint,
+				      unsigned long mask)
+{
+	unsigned long flags;
+
+	flags = iint_flags(iint, NULL) & mask;
+	set_iint_flags(iint, NULL, flags);
+}
+
+#endif
+
 static void ima_check_last_writer(struct integrity_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
@@ -169,8 +198,10 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 		if (!IS_I_VERSION(inode) ||
 		    !inode_eq_iversion(inode, iint->version) ||
 		    (iint->flags & IMA_NEW_FILE)) {
-			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
+			mask_iint_ns_status_flags(iint,
+					~(IMA_DONE_MASK | IMA_NEW_FILE));
 			iint->measured_pcrs = 0;
+
 			if (update)
 				ima_update_xattr(iint, file);
 		}
-- 
2.31.1

