Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3070456A625
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiGGOtn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiGGOsi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505C32042;
        Thu,  7 Jul 2022 07:48:37 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMiNQ025948;
        Thu, 7 Jul 2022 14:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rnaBHwWsozhrkNPR/NBB2RlHrgwsEHZubX6huSo6mJM=;
 b=hETmk7vDSUYu5w+Bz2a8UTfZL64zFX721TNLo+EWtayrHGBV8vYxvD4GFXmaQRiBaJEB
 Jd0vZwrFl9NqIEVdPS+Rx0vbrUpbLqO5k66yqlSMthGPc9dj1mPdbnI/9NKe/NP76LQC
 8xemF7oip5XHQ9mImlph4l33iPtaR+c444zTYmrvMiJBc/+3SkIPYbdHikR7PQ+FrRYk
 AbKPZNV53b2577/qNOQT1lsC6UnjkDUQCXklzNGGzZoBV8G2tjXEeZQkKqhkOb3sCxPg
 N2RXCs1Wj7z7hoy1wVU5jVtYPEkbLfUez02mB+Omxy6cyl49+gGeDVwXoPnCMK7NAqSX dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h612ps928-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EOFmJ000708;
        Thu, 7 Jul 2022 14:48:10 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h612ps91b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EaI0c018418;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3h4v5vemdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em7gg24445304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E3B8112069;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C67E112061;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v13 23/26] ima: Show owning user namespace's uid and gid when displaying policy
Date:   Thu,  7 Jul 2022 10:47:57 -0400
Message-Id: <20220707144800.828288-24-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFKqdsizujM9z7caJj2O6PdTdXOiszWF
X-Proofpoint-GUID: g_E1pPN5VsVRjD1FjpcLf7WXxv_U0iVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Show the uid and gid values relative to the user namespace that opened
the IMA policy file. The effect of this change is that when one displays
the policy from the user namespace that originally set the policy,
the same uid and gid values are shown in the policy as those that were
used when the policy was set.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>

---
v13:
  - Rephrased commit message following Serge's suggestion

v9:
  - use seq_user_ns and from_k{g,u}id_munged()
---
 security/integrity/ima/ima_policy.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f5997f5a8f5b..181340678844 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -2080,6 +2080,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
 
 int ima_policy_show(struct seq_file *m, void *v)
 {
+	struct user_namespace *user_ns = seq_user_ns(m);
 	struct ima_rule_entry *entry = v;
 	int i;
 	char tbuf[64] = {0,};
@@ -2165,7 +2166,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_UID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_uid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2176,7 +2178,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EUID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_euid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2187,7 +2190,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_GID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_gid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2198,7 +2202,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EGID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_egid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2209,7 +2214,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FOWNER) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->fowner));
 		if (entry->fowner_op == &uid_gt)
 			seq_printf(m, pt(Opt_fowner_gt), tbuf);
 		else if (entry->fowner_op == &uid_lt)
@@ -2220,7 +2226,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FGROUP) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->fgroup));
 		if (entry->fgroup_op == &gid_gt)
 			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
 		else if (entry->fgroup_op == &gid_lt)
-- 
2.36.1

