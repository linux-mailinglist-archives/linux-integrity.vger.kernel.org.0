Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5784CA677
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiCBNvh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242381AbiCBNvI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758CC559E;
        Wed,  2 Mar 2022 05:50:25 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Cm7L4022460;
        Wed, 2 Mar 2022 13:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mSKD+dycBa1y0C46NJVVN6YMiGZ4TSgWrEy/0RgPo5w=;
 b=aaMPY7ws0gt1XZZhjQxiH/L4HdbU49hleUkHUNt3lP4JjAwxV2ggURjHwQ8VD9zdKMyg
 A83Q38Y7KrMXPFHY208r12ia83CggopOPJX6nkRtWPIr2EH1lHCW0qdcZzIQ3DUPZpc/
 Jd0yzvx+IcsdZ/CWWjgkj9z86aQlE+dqpPeD1xv1LWFXWiwFoWmrXVW+L41PyfIk+i0H
 5MFbUFeWP0YX1lhJcc0dt9lAHZHOXk7Xr8j/Bq6HnuYN3QsLWEMXpyykawk46Yh+07v0
 R156boZtlo7hhqlhaLNyq3s/d+dnaiHbe5EQLMU9tPUwYjUsk9qDLzZQizMlDNmd4L+/ +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej8wh970y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:04 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222CmI2N023219;
        Wed, 2 Mar 2022 13:50:03 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej8wh970j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:03 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222DnBVS031242;
        Wed, 2 Mar 2022 13:50:03 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3efbua4v79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:03 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Do0qE14287676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DC8211206B;
        Wed,  2 Mar 2022 13:50:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A792112071;
        Wed,  2 Mar 2022 13:50:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:50:00 +0000 (GMT)
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
Subject: [PATCH v11 24/27] ima: Show owning user namespace's uid and gid when displaying policy
Date:   Wed,  2 Mar 2022 08:46:59 -0500
Message-Id: <20220302134703.1273041-25-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T2VGRr-o3yS3O0YC7G-ab2J8LXGr-E-Z
X-Proofpoint-GUID: -r6yXn26Ps4pkNt91ibqHxQL_-6APtdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Show the uid and gid values relative to the user namespace that is
currently active. The effect of this changes is that when one displays
the policy from the user namespace that originally set the policy,
the same uid and gid values are shown in the policy as those that were
used when the policy was set.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

---
v9:
  - use seq_user_ns and from_k{g,u}id_munged()
---
 security/integrity/ima/ima_policy.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 50c7bdec5109..0f697a475882 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -2019,6 +2019,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
 
 int ima_policy_show(struct seq_file *m, void *v)
 {
+	struct user_namespace *user_ns = seq_user_ns(m);
 	struct ima_rule_entry *entry = v;
 	int i;
 	char tbuf[64] = {0,};
@@ -2104,7 +2105,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_UID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_uid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2115,7 +2117,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EUID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_euid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2126,7 +2129,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_GID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_gid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2137,7 +2141,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EGID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_egid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2148,7 +2153,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FOWNER) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->fowner));
 		if (entry->fowner_op == &uid_gt)
 			seq_printf(m, pt(Opt_fowner_gt), tbuf);
 		else if (entry->fowner_op == &uid_lt)
@@ -2159,7 +2165,8 @@ int ima_policy_show(struct seq_file *m, void *v)
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

