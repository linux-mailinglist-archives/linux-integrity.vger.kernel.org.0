Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10B0484687
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiADRFQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49380 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235663AbiADRE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:59 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GvMmX014603;
        Tue, 4 Jan 2022 17:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fzd1vpvQ2F15cLbBAIM8JVRlxWq/V1F9Qz6UnRWKWIA=;
 b=EH3RQGfevP7Nsh8Q/KlWGPhpGbncP+LBSH1NZPZbLr01XtDdKavQiFPHq9SqhstFDd51
 j3693USWt9SyD0Wowf19TfdQCrGyJwi2+eorfpGLvKGZ4vAGncLq1mcXOd8V0KlVMgdG
 HJMHbM+TUFAo6kwFgLnQkXLs88LuB/5L265+cpQo9KLgMpIEM05ykhRuj2lRRiBB0kLc
 +mupEsPPB/qySEiyzWANMHgAcdQehkOafGBwNlXFZTpDqqSOJ7eVRbsnkVcJFYx9TwRT
 y18+CTsafB8AEnRrIR9W1d6dBnXDUiNtkmwY3JjOStatO+MyCcfjHChfyWiDWxca1zx0 FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcqu1ba6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204GAdiV030577;
        Tue, 4 Jan 2022 17:04:33 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcqu1ba6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H2jud031207;
        Tue, 4 Jan 2022 17:04:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3daekaf3n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:32 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4VsT27263306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4756CAC064;
        Tue,  4 Jan 2022 17:04:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35B1AAC05B;
        Tue,  4 Jan 2022 17:04:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:31 +0000 (GMT)
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
Subject: [PATCH v8 18/19] ima: Show owning user namespace's uid and gid when displaying policy
Date:   Tue,  4 Jan 2022 12:04:15 -0500
Message-Id: <20220104170416.1923685-19-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LkPiGbKu-mUflMXnXwIjvLtXwfwJIscq
X-Proofpoint-GUID: 3jcLOzO1vZ6iLa3Y5t2JDYGWp29Ps4Uc
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

Show the uid and gid values of the owning user namespace when displaying
the IMA policy rather than the kernel uid and gid values. Now the same uid
and gid values are shown in the policy as those that were used when the
policy was set.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_policy.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 15c68dc5da9e..b7dbc687b6ff 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1997,6 +1997,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
 
 int ima_policy_show(struct seq_file *m, void *v)
 {
+	struct user_namespace *user_ns = ima_user_ns_from_file(m->file);
 	struct ima_rule_entry *entry = v;
 	int i;
 	char tbuf[64] = {0,};
@@ -2074,7 +2075,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_UID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_uid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2085,7 +2087,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EUID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_euid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2096,7 +2099,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_GID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_gid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2107,7 +2111,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EGID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_egid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2118,7 +2123,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FOWNER) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid(user_ns, entry->fowner));
 		if (entry->fowner_op == &uid_gt)
 			seq_printf(m, pt(Opt_fowner_gt), tbuf);
 		else if (entry->fowner_op == &uid_lt)
@@ -2129,7 +2135,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FGROUP) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid(user_ns, entry->fgroup));
 		if (entry->fgroup_op == &gid_gt)
 			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
 		else if (entry->fgroup_op == &gid_lt)
-- 
2.31.1

