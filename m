Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE82C508A31
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379537AbiDTOLv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379384AbiDTOKO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF144758;
        Wed, 20 Apr 2022 07:07:19 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KBiZlL020266;
        Wed, 20 Apr 2022 14:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Noh9Sj0HptJtzFdqxEl5oFork1UXsfG9lhQlrZ3X3+0=;
 b=eyrOlBOxPD12ZHStInhC0vCIVOGAzZkhjOl2jjwn4FR6J8/pUv4tYMdBYbjjy9alWZJd
 54X5G/aik2EGTfCNHDfDwADxTqDWficYeUZL88IBiAQxPpYli+jUxBcMH+lqxnWQrwkQ
 0AHaYwVM1KbTA2vVLgUhSxmPfG3dHPfg1ZPt7Vu9mY9jf3dr7OT+M8JnqHm0B/YuAR/q
 kkvud4pd10CN73FKfpgJOa8mx8CmzKFnAAW1CDaIvmZTxe1wfWSc4ejS2JSXB+HHnawf
 ls6tAhjiRqj8pVJxCHLRBfFBqxykJyjO9A490AQ+wJ1XPzokApo+K3CqQAVV28UJxWBR lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7vpqywf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:47 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KDm26v020763;
        Wed, 20 Apr 2022 14:06:47 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7vpqyvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:47 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE2x9e032403;
        Wed, 20 Apr 2022 14:06:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 3ffne9vr6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6iLh23920910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:44 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D774AE06B;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B07FAE068;
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
Subject: [PATCH v12 25/26] ima: Restrict informational audit messages to init_ima_ns
Date:   Wed, 20 Apr 2022 10:06:32 -0400
Message-Id: <20220420140633.753772-26-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cyEhlJUapeiyDXgO5mB4ng-tedX1w4Ij
X-Proofpoint-GUID: 5ejEDiw_VYhyc2F5o_g_g20jYd2JqCrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v12:
 - Added missing 'struct ima_namespace' to ima_update_xattr() inline func
---
 security/integrity/ima/ima.h          |  9 ++++++---
 security/integrity/ima/ima_api.c      | 10 ++++++----
 security/integrity/ima/ima_appraise.c |  6 ++++--
 security/integrity/ima/ima_fs.c       |  6 ++++--
 security/integrity/ima/ima_main.c     | 12 +++++++-----
 security/integrity/ima/ima_policy.c   | 20 ++++++++++++--------
 6 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2cc286f9e839..78af02e4814e 100644
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
@@ -408,7 +410,8 @@ static inline int ima_must_appraise(struct ima_namespace *ns,
 	return 0;
 }
 
-static inline void ima_update_xattr(struct integrity_iint_cache *iint,
+static inline void ima_update_xattr(struct ima_namespace *ns,
+				    struct integrity_iint_cache *iint,
 				    struct file *file)
 {
 }
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index d179cb41b8c8..ab1ebc37c222 100644
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
@@ -274,7 +276,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
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
index 301c717e029f..14dffeee727d 100644
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
index 194dc4557caa..fc05f0088f79 100644
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
 
@@ -620,7 +622,7 @@ static int __ima_inode_hash(struct ima_namespace *ns, struct inode *inode,
 		tmp_iint.inode = inode;
 		mutex_init(&tmp_iint.mutex);
 
-		rc = ima_collect_measurement(&tmp_iint, file, NULL, 0,
+		rc = ima_collect_measurement(ns, &tmp_iint, file, NULL, 0,
 					     ima_hash_algo, NULL);
 		if (rc < 0)
 			return -EOPNOTSUPP;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a0bd8ffca88e..2a4e37a5a64d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1365,15 +1365,16 @@ static unsigned int ima_parse_appraise_algos(char *arg)
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
@@ -1879,8 +1880,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 
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
 
@@ -1889,9 +1892,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
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
2.34.1

