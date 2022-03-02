Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F524CA665
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiCBNv3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242429AbiCBNv2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653A6EB24;
        Wed,  2 Mar 2022 05:50:25 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Cm7Za022498;
        Wed, 2 Mar 2022 13:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4Hj6KHyJgmyWtoSeNDoo0k7byA34SUS1H0SAt8gbgxA=;
 b=U0oBED9QfYCvvfBRGSHhC7Ztw5U9ZHDmw4ihBXL4kzdQa85fUwMVhnnD5mvw8xPtBI3L
 tTdRsgGU43NeM416rJ4j+XWmwPjqmUl0zyiBDgi0riV5kItIyxjWwW6CnabeUUQ3Pnuu
 K89g6GV81baDjGAc6AJEPWEJKxW3fVjbfONjsGLJnR+wmyCHTTHnOrmHVmfVOQDRxYlA
 qnT+8QzSqh6Mw2UVPOTqk9K/IDW8eRbKultmoW9bJEZuAG+xrWXRy1Pg4GDA2IwdpM1Q
 vAbV2vJvZ4Xg2kcOJn2HdL5qt9irVcLVpuKTRc40KEsF+SLNTElDEiuDBppFNTGqsq70 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej8wh970c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:03 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DkN9f018060;
        Wed, 2 Mar 2022 13:50:02 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej8wh96yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:02 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222DnBVR031242;
        Wed, 2 Mar 2022 13:50:02 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3efbua4v75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Do0tk13107826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ECF111206B;
        Wed,  2 Mar 2022 13:50:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81A5B112075;
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
Subject: [PATCH v11 26/27] ima: Restrict informational audit messages to init_ima_ns
Date:   Wed,  2 Mar 2022 08:47:01 -0500
Message-Id: <20220302134703.1273041-27-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HkcIq1N8ksU3v8uVA7pesvU7AfnQfoVJ
X-Proofpoint-GUID: -HEYkZkiKp2RjL0q5ekblQBjgpecTBdW
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

Since non-root users can create an IMA namespace they have indirect access
to the host's audit log. To avoid abuse, restrict the creation of those
informational audit messages that can currently be caused by IMA
namespacings to init_ima_ns.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  6 ++++--
 security/integrity/ima/ima_api.c      | 10 ++++++----
 security/integrity/ima/ima_appraise.c |  6 ++++--
 security/integrity/ima/ima_fs.c       |  6 ++++--
 security/integrity/ima/ima_main.c     | 10 ++++++----
 security/integrity/ima/ima_policy.c   | 20 ++++++++++++--------
 6 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2cc286f9e839..efb6ad05ff9e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -305,7 +305,8 @@ int ima_get_action(struct ima_namespace *ns,
 		   struct ima_template_desc **template_desc,
 		   const char *func_data, unsigned int *allowed_algos);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
-int ima_collect_measurement(struct integrity_iint_cache *iint,
+int ima_collect_measurement(struct ima_namespace *ns,
+			    struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig);
 void ima_store_measurement(struct ima_namespace *ns,
@@ -373,7 +374,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 int ima_must_appraise(struct ima_namespace *ns,
 		      struct user_namespace *mnt_userns, struct inode *inode,
 		      int mask, enum ima_hooks func);
-void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
+void ima_update_xattr(struct ima_namespace *ns,
+		      struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   enum ima_hooks func);
 enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4284c216ee7b..3f8b512f33f6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -159,8 +159,9 @@ void ima_add_violation(struct ima_namespace *ns,
 	if (result < 0)
 		ima_free_template_entry(entry);
 err_out:
-	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-			    op, cause, result, 0);
+	if (ns == &init_ima_ns)
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
+				    op, cause, result, 0);
 }
 
 /**
@@ -215,7 +216,8 @@ int ima_get_action(struct ima_namespace *ns,
  *
  * Return 0 on success, error code otherwise
  */
-int ima_collect_measurement(struct integrity_iint_cache *iint,
+int ima_collect_measurement(struct ima_namespace *ns,
+			    struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig)
 {
@@ -276,7 +278,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	if (!result)
 		iint->flags |= IMA_COLLECTED;
 out:
-	if (result) {
+	if (result && ns == &init_ima_ns) {
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f1b99b895c68..666cf0e77e1f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -494,7 +494,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 /*
  * ima_update_xattr - update 'security.ima' hash value
  */
-void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
+void ima_update_xattr(struct ima_namespace *ns,
+		      struct integrity_iint_cache *iint, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
 	int rc = 0;
@@ -507,7 +508,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 	    !(iint->flags & IMA_HASH))
 		return;
 
-	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo, NULL);
+	rc = ima_collect_measurement(ns, iint, file, NULL, 0, ima_hash_algo,
+				     NULL);
 	if (rc < 0)
 		return;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 8254c4e683d5..e618fc3d3109 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -420,8 +420,10 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	}
 
 	pr_info("policy update %s\n", cause);
-	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !ns->valid_policy, 0);
+	if (ns == &init_ima_ns)
+		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+				    "policy_update", cause, !ns->valid_policy,
+				    0);
 
 	if (!ns->valid_policy) {
 		ima_delete_rules(ns);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fa12080b8b94..c872cb09b9f6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -174,7 +174,8 @@ static void mask_iint_ns_status_flags(struct integrity_iint_cache *iint,
 	read_unlock(&iint->ns_list_lock);
 }
 
-static void ima_check_last_writer(struct integrity_iint_cache *iint,
+static void ima_check_last_writer(struct ima_namespace *ns,
+				  struct integrity_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
 	fmode_t mode = file->f_mode;
@@ -196,7 +197,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 			iint->measured_pcrs = 0;
 
 			if (update)
-				ima_update_xattr(iint, file);
+				ima_update_xattr(ns, iint, file);
 		}
 	}
 	mutex_unlock(&iint->mutex);
@@ -221,7 +222,7 @@ void ima_file_free(struct file *file)
 	if (!iint)
 		return;
 
-	ima_check_last_writer(iint, inode, file);
+	ima_check_last_writer(ns, iint, inode, file);
 }
 
 static int __process_measurement(struct ima_namespace *ns,
@@ -373,7 +374,8 @@ static int __process_measurement(struct ima_namespace *ns,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
+	rc = ima_collect_measurement(ns, iint, file, buf, size, hash_algo,
+				     modsig);
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5ea1549bf601..47bba02652d1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1366,15 +1366,16 @@ static unsigned int ima_parse_appraise_algos(char *arg)
 static int ima_parse_rule(struct ima_namespace *ns,
 			  char *rule, struct ima_rule_entry *entry)
 {
-	struct audit_buffer *ab;
+	struct audit_buffer *ab = NULL;
 	char *from;
 	char *p;
 	bool eid_token; /* either euid or egid */
 	struct ima_template_desc *template_desc;
 	int result = 0;
 
-	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
-				       AUDIT_INTEGRITY_POLICY_RULE);
+	if (ns == &init_ima_ns)
+		ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
+					       AUDIT_INTEGRITY_POLICY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->gid = INVALID_GID;
@@ -1880,8 +1881,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
-		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
-				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
+		if (ns == &init_ima_ns)
+			integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
+					    NULL, op, "-ENOMEM", -ENOMEM,
+					    audit_info);
 		return -ENOMEM;
 	}
 
@@ -1890,9 +1893,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 	result = ima_parse_rule(ns, p, entry);
 	if (result) {
 		ima_free_rule(entry);
-		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
-				    NULL, op, "invalid-policy", result,
-				    audit_info);
+		if (ns == &init_ima_ns)
+			integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
+					    NULL, op, "invalid-policy", result,
+					    audit_info);
 		return result;
 	}
 
-- 
2.31.1

