Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC1156A615
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiGGOsr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiGGOsh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14E14016;
        Thu,  7 Jul 2022 07:48:34 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267Ej3ex029605;
        Thu, 7 Jul 2022 14:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pfkdYtKsMdG8Reg7fJyvrTKEO+p4Benm9cbjtutReRM=;
 b=SjiWqGhK5A2nTcMqmvlYZEAhRFwjmLU4e/FqJgKUjL7HD4e2giGn8VgGVs2d5VE6v/y5
 esEjXYkrmtdZjvKNR3yIKwVFzCl1VCLqBAQxsAKXA9rRSi3NS4NLIiXwS07SqOYk6ffq
 1hoqY754M9Y3mVlKmPrPBDOIecMUelws4hCAhPudyH7/WS9xXxtjke5rACMcpDoS3z2I
 XFUtALPXMkAGwjjhekUbf0OPOL4hcDjONOlOT+4p7u6pDfZXP7c7MBywxFIlQ4JSJMVB
 7IVOL1wuzrQFurZWcuAicJI8jyEf/fTgosZueAvoS3XHnsH7mwy65t+Z4ARafTXjMkcA DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61hb0422-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EjGq8031150;
        Thu, 7 Jul 2022 14:48:10 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61hb040y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EaJVX018428;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3h4v5veme0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em7ZT21103040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B604F112063;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98B16112062;
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
Subject: [PATCH v13 25/26] ima: Restrict informational audit messages to init_ima_ns
Date:   Thu,  7 Jul 2022 10:47:59 -0400
Message-Id: <20220707144800.828288-26-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sPKsKwceld46ERb0KSQknuTy27Vz9fYW
X-Proofpoint-GUID: _KbYCJRVRMLojXT1pMBj4_N1XXwgHm8y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index fa9f99ad7e69..32184593688f 100644
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
index 6ca68f6cce01..e5c49fc00402 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -160,8 +160,9 @@ void ima_add_violation(struct ima_namespace *ns,
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
@@ -242,7 +243,8 @@ static int ima_get_verity_digest(struct integrity_iint_cache *iint,
  *
  * Return 0 on success, error code otherwise
  */
-int ima_collect_measurement(struct integrity_iint_cache *iint,
+int ima_collect_measurement(struct ima_namespace *ns,
+			    struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig)
 {
@@ -315,7 +317,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	if (!result)
 		iint->flags |= IMA_COLLECTED;
 out:
-	if (result) {
+	if (result && ns == &init_ima_ns) {
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 02b7e74fea62..c73e166a1014 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -600,7 +600,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 /*
  * ima_update_xattr - update 'security.ima' hash value
  */
-void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
+void ima_update_xattr(struct ima_namespace *ns,
+		      struct integrity_iint_cache *iint, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
 	int rc = 0;
@@ -613,7 +614,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
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
index c397d24267b7..f28f4001fb2e 100644
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
 	if (rc == -ENOMEM)
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
index d26765df0dba..2a5d43f31d4f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1395,15 +1395,16 @@ static unsigned int ima_parse_appraise_algos(char *arg)
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
@@ -1941,8 +1942,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 
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
 
@@ -1951,9 +1954,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
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
2.36.1

