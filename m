Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC39546C461
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhLGUZr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 15:25:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241243AbhLGUZp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 15:25:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7JeiRV031735;
        Tue, 7 Dec 2021 20:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=du/FPgwh0G86yGWU94cNZQOyQr5s6qD4r4AdyELNrSQ=;
 b=BLEUz2Wd3UwJWSRYOx3sxamC5vFbbf1SveGuoC6JNfdnnLS6XS66raGFVLTFM2LZ+Y9t
 IhPYDFO+ezuJODaf+6+UPxBGUyEd5fyIawzeoA7FL9JyDi6YZnDLkdzSDtREf6HYVp12
 fk8pd4uMwkJMWY6G8EVwco5UHkBxw5PKYTv/py/6SdFgQUTWgmFSU1SdQrgWfnvInZmg
 pUlUZEzUXfhDE2rphzIzRy+kSo3INppFKmp1yj4Fqz7P0bhXCgLhqz/mdMl4VX3sgKGr
 XQnm1C83/sU7TJ8JBvfuTRoh9iHSKXUC1+ak1jbxKPqsmPLX9t6R6NaBfysdq5vzNSJk 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctcdbtx7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:02 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7K0biF025617;
        Tue, 7 Dec 2021 20:22:02 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctcdbtx7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:01 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7K7qRD018345;
        Tue, 7 Dec 2021 20:22:01 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyyb2dfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:01 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7KLxgu26411328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 20:21:59 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F1D1136059;
        Tue,  7 Dec 2021 20:21:59 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD0B213605D;
        Tue,  7 Dec 2021 20:21:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 20:21:56 +0000 (GMT)
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
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [PATCH v4 03/16] ima: Namespace audit status flags
Date:   Tue,  7 Dec 2021 15:21:14 -0500
Message-Id: <20211207202127.1508689-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211207202127.1508689-1-stefanb@linux.ibm.com>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZdmmT68MzeK4NYgJkcvCgY95s7NA0Ssb
X-Proofpoint-ORIG-GUID: Mf1N6vTy2unb4ms2AlTPa5WDtekcO0Fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_08,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

The iint cache stores whether the file is measured, appraised, audited
etc. This patch moves the IMA_AUDITED flag into the per-namespace
ns_status, enabling IMA audit mechanism to audit the same file each time
it is accessed in a new namespace.

The ns_status is not looked up if the CONFIG_IMA_NS is disabled or if
any of the IMA_NS_STATUS_ACTIONS (currently only IMA_AUDIT) is not
enabled.

Read and write operations on the iint flags is replaced with function
calls. For reading, iint_flags() returns the bitwise AND of iint->flags
and ns_status->flags. The ns_status flags are masked with
IMA_NS_STATUS_FLAGS (currently only IMA_AUDITED). Similarly
set_iint_flags() only writes the masked portion to the ns_status flags,
while the iint flags is set as before. The ns_status parameter added to
ima_audit_measurement() is used with the above functions to query and
set the ns_status flags.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

Changelog:
v2:
 * fixed flag calculation in iint_flags()
---
 init/Kconfig                      |  3 +++
 security/integrity/ima/ima.h      | 23 ++++++++++++++++++++++-
 security/integrity/ima/ima_api.c  |  8 +++++---
 security/integrity/ima/ima_main.c | 24 +++++++++++++++++-------
 security/integrity/ima/ima_ns.c   | 20 ++++++++++++++++++++
 5 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 27890607e8cb..1e1c49f1d129 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1251,6 +1251,9 @@ config IMA_NS
 	  Allow the creation of IMA namespaces for each user namespace.
 	  Namespaced IMA enables having IMA features work separately
 	  in each IMA namespace.
+	  Currently, only the audit status flags are stored in the namespace,
+	  which allows the same file to be audited each time it is accessed
+	  in a new namespace.
 
 endif # NAMESPACES
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 28896d256e36..dd06e16c4e1c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -282,7 +282,8 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 			       int pcr, const char *func_data,
 			       bool buf_hash, u8 *digest, size_t digest_len);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename);
+			   const unsigned char *filename,
+			   struct ns_status *status);
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry,
 			    struct ima_template_desc *template_desc);
@@ -426,6 +427,9 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
+#define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
+#define IMA_NS_STATUS_FLAGS     IMA_AUDITED
+
 int ima_ns_init(void);
 struct ima_namespace;
 int ima_init_namespace(struct ima_namespace *ns);
@@ -436,6 +440,10 @@ struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 
 void free_ns_status_cache(struct ima_namespace *ns);
 
+unsigned long iint_flags(struct integrity_iint_cache *iint,
+			 struct ns_status *status);
+unsigned long set_iint_flags(struct integrity_iint_cache *iint,
+			     struct ns_status *status, unsigned long flags);
 #else
 
 static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
@@ -444,6 +452,19 @@ static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 	return NULL;
 }
 
+static inline unsigned long iint_flags(struct integrity_iint_cache *iint,
+				       struct ns_status *status)
+{
+	return iint->flags;
+}
+
+static inline unsigned long set_iint_flags(struct integrity_iint_cache *iint,
+					   struct ns_status *status,
+					   unsigned long flags)
+{
+	iint->flags = flags;
+	return flags;
+}
 #endif /* CONFIG_IMA_NS */
 
 /* LSM based policy rules require audit */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a64fb0130b01..8f7bab17b784 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -342,14 +342,16 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 }
 
 void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename)
+			   const unsigned char *filename,
+			   struct ns_status *status)
 {
 	struct audit_buffer *ab;
 	char *hash;
 	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
 	int i;
+	unsigned long flags = iint_flags(iint, status);
 
-	if (iint->flags & IMA_AUDITED)
+	if (flags & IMA_AUDITED)
 		return;
 
 	hash = kzalloc((iint->ima_hash->length * 2) + 1, GFP_KERNEL);
@@ -372,7 +374,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 	audit_log_task_info(ab);
 	audit_log_end(ab);
 
-	iint->flags |= IMA_AUDITED;
+	set_iint_flags(iint, status, flags | IMA_AUDITED);
 out:
 	kfree(hash);
 	return;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 465865412100..4df60dbb56f7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -204,6 +204,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
+	struct ns_status *status = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
@@ -216,6 +217,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	unsigned long flags;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -244,6 +246,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint = integrity_inode_get(inode);
 		if (!iint)
 			rc = -ENOMEM;
+
+		if (!rc && (action & IMA_NS_STATUS_ACTIONS)) {
+			status = ima_get_ns_status(get_current_ns(), inode);
+			if (IS_ERR(status))
+				rc = PTR_ERR(status);
+		}
 	}
 
 	if (!rc && violation_check)
@@ -259,11 +267,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	mutex_lock(&iint->mutex);
 
+	flags = iint_flags(iint, status);
+
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
 		/* reset appraisal flags if ima_inode_post_setattr was called */
-		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
-				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
-				 IMA_ACTION_FLAGS);
+		flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
+			   IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
+			   IMA_ACTION_FLAGS);
 
 	/*
 	 * Re-evaulate the file if either the xattr has changed or the
@@ -274,7 +284,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
 	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
 	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
-		iint->flags &= ~IMA_DONE_MASK;
+		flags &= ~IMA_DONE_MASK;
 		iint->measured_pcrs = 0;
 	}
 
@@ -282,9 +292,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
 	 */
-	iint->flags |= action;
+	flags = set_iint_flags(iint, status, flags | action);
 	action &= IMA_DO_MASK;
-	action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
+	action &= ~((flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
 
 	/* If target pcr is already measured, unset IMA_MEASURE action */
 	if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
@@ -359,7 +369,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 						  &pathname, filename);
 	}
 	if (action & IMA_AUDIT)
-		ima_audit_measurement(iint, pathname);
+		ima_audit_measurement(iint, pathname, status);
 
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc = 0;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 566e59524958..1fe1d910996b 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -75,6 +75,26 @@ void free_ima_ns(struct kref *kref)
 	destroy_ima_ns(ns);
 }
 
+unsigned long iint_flags(struct integrity_iint_cache *iint,
+			 struct ns_status *status)
+{
+	if (!status)
+		return iint->flags;
+
+	return (iint->flags & ~IMA_NS_STATUS_FLAGS) |
+	       (status->flags & IMA_NS_STATUS_FLAGS);
+}
+
+unsigned long set_iint_flags(struct integrity_iint_cache *iint,
+			     struct ns_status *status, unsigned long flags)
+{
+	iint->flags = flags;
+	if (status)
+		status->flags = flags & IMA_NS_STATUS_FLAGS;
+
+	return flags;
+}
+
 static int __init imans_cache_init(void)
 {
 	imans_cachep = KMEM_CACHE(ima_namespace, SLAB_PANIC);
-- 
2.31.1

