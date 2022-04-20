Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44CC508A2B
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379539AbiDTOLx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379380AbiDTOKN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D4D443E5;
        Wed, 20 Apr 2022 07:07:18 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KBmOJq005891;
        Wed, 20 Apr 2022 14:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1bCmtM3PkF52IMaKSyyI1ZVU1tABDO70rpEWfzNwsCA=;
 b=pa4pEzWmckNhPel4G4/MwiHx6tD8KB4zR4uFDKgoxu5hl6sDHbjeJAT6hIB5e0XCXHe1
 Wl0ftHiD457K6BhfYRIYq1mOaVn2Fr9lY6JCvf5FnlcbFt4jBHaZ6hfJMzYzD0Smayxl
 TRU3CEyG9gp8wPbmGLAAlLTwK3o3eRDMvXIfol1iWHqqxvbbVGtiF7hY2Ww0M7jn7xBU
 BygMKhucXkEil3bPVqtU/vk37HLs28y/LE6mMDjfGyT+/19OLKpJZ9doUvAdqNgbHoB7
 LtIKqPiGlGoT8ES8Tuq5yeJRAdhb2kGR66GcwkCzYdAVYXttJMhOL9SWCMm8p0boPNr1 wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7rg44b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:47 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KE02LF035895;
        Wed, 20 Apr 2022 14:06:47 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7rg44a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:47 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE3H0f006676;
        Wed, 20 Apr 2022 14:06:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 3fg2xw1aqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6ilJ25821664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:44 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BE88AE05F;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22A36AE05C;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
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
Subject: [PATCH v12 23/26] ima: Show owning user namespace's uid and gid when displaying policy
Date:   Wed, 20 Apr 2022 10:06:30 -0400
Message-Id: <20220420140633.753772-24-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k2L8nAPpfMiCo9lqaxYXcSP74sT2p8-D
X-Proofpoint-ORIG-GUID: z4jsHbBq0x9EDHIsUd1TuUrRfDKBn6e4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index eb10d895923d..4f8c50ddb777 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -2018,6 +2018,7 @@ static void ima_policy_show_appraise_algos(struct seq_file *m,
 
 int ima_policy_show(struct seq_file *m, void *v)
 {
+	struct user_namespace *user_ns = seq_user_ns(m);
 	struct ima_rule_entry *entry = v;
 	int i;
 	char tbuf[64] = {0,};
@@ -2103,7 +2104,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_UID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_uid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2114,7 +2116,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EUID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->uid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->uid));
 		if (entry->uid_op == &uid_gt)
 			seq_printf(m, pt(Opt_euid_gt), tbuf);
 		else if (entry->uid_op == &uid_lt)
@@ -2125,7 +2128,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_GID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_gid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2136,7 +2140,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_EGID) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->gid));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->gid));
 		if (entry->gid_op == &gid_gt)
 			seq_printf(m, pt(Opt_egid_gt), tbuf);
 		else if (entry->gid_op == &gid_lt)
@@ -2147,7 +2152,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FOWNER) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kuid_val(entry->fowner));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kuid_munged(user_ns, entry->fowner));
 		if (entry->fowner_op == &uid_gt)
 			seq_printf(m, pt(Opt_fowner_gt), tbuf);
 		else if (entry->fowner_op == &uid_lt)
@@ -2158,7 +2164,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 
 	if (entry->flags & IMA_FGROUP) {
-		snprintf(tbuf, sizeof(tbuf), "%d", __kgid_val(entry->fgroup));
+		snprintf(tbuf, sizeof(tbuf),
+			 "%d", from_kgid_munged(user_ns, entry->fgroup));
 		if (entry->fgroup_op == &gid_gt)
 			seq_printf(m, pt(Opt_fgroup_gt), tbuf);
 		else if (entry->fgroup_op == &gid_lt)
-- 
2.34.1

