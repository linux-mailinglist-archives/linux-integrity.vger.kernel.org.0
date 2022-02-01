Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD004A660D
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbiBAUjB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:39:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240565AbiBAUiS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Js1Bi028559;
        Tue, 1 Feb 2022 20:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8U3EOA3os6p6cu09AXtXgLhjI4QxiRPkGnUn+kJvQDQ=;
 b=ElwnD2wHpXMRy8RSDW0czSFTduEGaOlQ/mlDfMSxEeaxd4qkTxpWkXvXM6EqELsiUWCo
 LdKq+uXpV+0KslyD7ZfpdeLeLTxU4yi0ucOw94TL0Fvm89/Yavx5CH2FzaU+uXTgreRs
 JP1fQoZ9h01vblrQxLoiVUxzlhfH7csYt6o/Ol0Ookq32tSk0/cw2Lv5IA+gijc5VCqK
 oOIPX7Nw6+93SLyTHj6JFMmfGUWo9KMPsBcv2UW+/UgR1J3ob+YnrEfbSv4q2i/sRZjw
 2h4twq0cE5LShSTBSG78gOO1xUes3xDe5GUbVvLp/vz5gVdp4fJ0081BNyTchIpTBars 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe58px8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:55 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KbsEP029603;
        Tue, 1 Feb 2022 20:37:55 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dybe58pwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KWjOR015893;
        Tue, 1 Feb 2022 20:37:54 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3dvw7b724v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KbqWn42533152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 977A3B2068;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DF52B2073;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
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
Subject: [PATCH v10 25/27] ima: Show owning user namespace's uid and gid when displaying policy
Date:   Tue,  1 Feb 2022 15:37:33 -0500
Message-Id: <20220201203735.164593-26-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8Mz-LL-hC9WGBT7hXadyW9Ec93gRym2F
X-Proofpoint-ORIG-GUID: S0lCOgY6TLPrNvcB4q-7c0kZ2ZHFdrlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Show the uid and gid values relative to the user namespace that is
currently active. The effect of this changes is that when one displays
the policy from the user namespace that originally set the policy,
the same uid and gid values are shown in the policy as those that were
used when the policy was set.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v9:
  - use seq_user_ns and from_k{g,u}id_munged()
---
 security/integrity/ima/ima_policy.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fe3dce8fb939..acb4c36e539f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -2000,6 +2000,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
 
 int ima_policy_show(struct seq_file *m, void *v)
 {
+	struct user_namespace *user_ns = seq_user_ns(m);
 	struct ima_rule_entry *entry = v;
 	int i;
 	char tbuf[64] = {0,};
@@ -2085,7 +2086,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_UID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_uid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2096,7 +2098,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EUID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_euid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2107,7 +2110,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_GID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_gid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2118,7 +2122,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EGID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_egid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2129,7 +2134,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FOWNER) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->fowner));
 		if (entry->fowner_op == &uid_gt)
 			seq_printf(m, pt(Opt_fowner_gt), tbuf);
 		else if (entry->fowner_op == &uid_lt)
@@ -2140,7 +2146,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FGROUP) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->fgroup));
 		if (entry->fgroup_op == &gid_gt)
 			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
 		else if (entry->fgroup_op == &gid_lt)
-- 
2.31.1

