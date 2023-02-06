Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FC68BF81
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjBFOGI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjBFOEw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:04:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D427D71;
        Mon,  6 Feb 2023 06:04:08 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqL27023107;
        Mon, 6 Feb 2023 14:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OmRU9QIUfGWsG+XYHf1BUPHoEfhoNdlcxOo3W+m/pjg=;
 b=CtECoaLIMMCC1eN8I1jsPTZwhjCRWfy1SmEe7Qwnpwj42WvEtUDKJjzwXSjWf13avP0v
 Ev8cHAOlHPppOCpg9JORtaPo0U3K3L1eZ4SbVWweB7G8gNqPNiBA3ESy+Uv05LkDAuJu
 x/nD1so8s0rImiDHVZ/tu5LNJZZr+33o/gPVvufaLk7e4T5KHFhBhecVSknENl1zcbJw
 ovCgM/6e2IR0RV7MsQ9ZWsuheNq5Xy7Px6qYltuAFqcDF820YRjo8iUMXf4A6dSaubag
 Z8jLGDj5maV0uhbv1+6bInnodJT9mB9kwinoYzpn1EzJRbpChrXkVA270gnGQ5rMNs3P Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkjsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:57 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316Dqav1024650;
        Mon, 6 Feb 2023 14:03:56 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1abkjqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:56 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316COOhZ002578;
        Mon, 6 Feb 2023 14:03:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3nhf07dqdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3q456161114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E1FF58058;
        Mon,  6 Feb 2023 14:03:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E2485805D;
        Mon,  6 Feb 2023 14:03:50 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:50 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v15 25/26] ima: Restrict informational audit messages to init_ima_ns
Date:   Mon,  6 Feb 2023 09:02:52 -0500
Message-Id: <20230206140253.3755945-26-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lh7CBLD44-plBPr2zp8vK_OgFrvN8M-b
X-Proofpoint-GUID: -K0H3dfiRP2wnIDouCjoa8iqVgHBVGHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 450e7ec0a9d7..a2bb7cbd41be 100644
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
index 89c38ce0039e..950f1353c6a1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -601,7 +601,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 /*
  * ima_update_xattr - update 'security.ima' hash value
  */
-void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
+void ima_update_xattr(struct ima_namespace *ns,
+		      struct integrity_iint_cache *iint, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
 	int rc = 0;
@@ -614,7 +615,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
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
index 3bae652142f5..61442eb8339c 100644
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
@@ -375,7 +376,8 @@ static int __process_measurement(struct ima_namespace *ns,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
+	rc = ima_collect_measurement(ns, iint, file, buf, size, hash_algo,
+				     modsig);
 	if (rc == -ENOMEM)
 		goto out_locked;
 
@@ -622,7 +624,7 @@ static int __ima_inode_hash(struct ima_namespace *ns, struct inode *inode,
 		tmp_iint.inode = inode;
 		mutex_init(&tmp_iint.mutex);
 
-		rc = ima_collect_measurement(&tmp_iint, file, NULL, 0,
+		rc = ima_collect_measurement(ns, &tmp_iint, file, NULL, 0,
 					     ima_hash_algo, NULL);
 		if (rc < 0) {
 			/* ima_hash could be allocated in case of failure. */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cdcc2a1506ab..05ffd7b03ee3 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1442,15 +1442,16 @@ static unsigned int ima_parse_appraise_algos(char *arg)
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
@@ -1988,8 +1989,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 
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
 
@@ -1998,9 +2001,10 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
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
2.37.3

