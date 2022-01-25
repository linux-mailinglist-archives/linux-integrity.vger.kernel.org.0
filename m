Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEAB49BED8
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 23:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiAYWrc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 17:47:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234203AbiAYWr0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMfiYg010964;
        Tue, 25 Jan 2022 22:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SFcFD/EvTQUoNcYyKVdfg6JmVIDdzQPCJOH1FaaGd5g=;
 b=p4Yf+StFEY8xsu172qvPCKqPPx3DTnpJYE410WsrLrNOVCqzJke/19Xp+WFWobP6IhBV
 ab1xr1+60gqMY49IGFRCY1K/RY/6THPyhPUuK/TVT3oAzEu7Tr/9uABXauvNlnforeky
 K4AwI5C/nRTdb+HN38ECoaZbMSFreAy5RybIOWqEZ99Ko9LzVCnyd2gnGX7L/hXN39bM
 1gR4SmwT28q4FvW2jawswMv+j8KABou0hWsu5f7qz6okDr2AMipR405qLUCPvrU7NByn
 ln3QCR6kJZAew8HybXlBq8Xt4HDM3JaZlZ/kTJBNNcduvb2Z+lazzUuQg2nWkVqcLHbb 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtt7ng2g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMgSiM012126;
        Tue, 25 Jan 2022 22:47:03 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtt7ng2ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMhnL7006726;
        Tue, 25 Jan 2022 22:47:02 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3dr9jb6e5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkwv732768428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:58 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96778AC062;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7927DAC05E;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
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
Subject: [PATCH v9 15/23] ima: Implement hierarchical processing of file accesses
Date:   Tue, 25 Jan 2022 17:46:37 -0500
Message-Id: <20220125224645.79319-16-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HCdg-vNidBEYyHILyHmR7rwAN1zlubVr
X-Proofpoint-ORIG-GUID: 9ga8XOLzV59JZDzjNC1xxYo1NmfJBHx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement hierarchical processing of file accesses in IMA namespaces by
walking the list of user namespaces towards the root. This way file
accesses can be audited in an IMA namespace and also be evaluated against
the IMA policies of parent IMA namespaces.

Pass the user_namespace into process_measurement since we will be walking
the hierarchy of user_namespaces towards the init_user_ns and we can easily
derive the ima_namespace from the user_namespace.

__process_measurement() returns either 0 or -EACCES. For hierarchical
processing remember the -EACCES returned by this function but continue
to the parent user namespace. At the end either return 0 or -EACCES
if an error occurred in one of the IMA namespaces.

Currently the ima_ns pointer of the user_namespace is always NULL except
at the init_user_ns, so test ima_ns for NULL pointer and skip the call to
__process_measurement() if it is NULL. Once IMA namespacing is fully
enabled, the pointer may still be NULL due to late initialization of the
IMA namespace.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---

v9:
  - Switch callers to pass user_namespace rather than ima_namespace with
    potential NULL pointer
  - Add default case to switch statement and warn if this happens
  - Implement ima_ns_from_user_ns() in this patch now
---
 security/integrity/ima/ima.h      |  8 ++++
 security/integrity/ima/ima_main.c | 75 +++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0057b1fd6c18..aea8fb8d2854 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -493,4 +493,12 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
 	return file_inode(filp)->i_sb->s_user_ns;
 }
 
+static inline struct ima_namespace
+*ima_ns_from_user_ns(struct user_namespace *user_ns)
+{
+	if (user_ns == &init_user_ns)
+		return &init_ima_ns;
+	return NULL;
+}
+
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ae0e9b14554a..3385221ca1d5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -196,10 +196,10 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct ima_namespace *ns,
-			       struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+static int __process_measurement(struct ima_namespace *ns,
+				 struct file *file, const struct cred *cred,
+				 u32 secid, char *buf, loff_t size, int mask,
+				 enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -391,6 +391,41 @@ static int process_measurement(struct ima_namespace *ns,
 	return 0;
 }
 
+static int process_measurement(struct user_namespace *user_ns,
+			       struct file *file, const struct cred *cred,
+			       u32 secid, char *buf, loff_t size, int mask,
+			       enum ima_hooks func)
+{
+	struct ima_namespace *ns;
+	int ret = 0;
+
+	while (user_ns) {
+		ns = ima_ns_from_user_ns(user_ns);
+		if (ns) {
+			int rc;
+
+			rc = __process_measurement(ns, file, cred, secid, buf,
+						   size, mask, func);
+			switch (rc) {
+			case 0:
+				break;
+			case -EACCES:
+				/* return this error at the end but continue */
+				ret = -EACCES;
+				break;
+			default:
+				/* should not happen */
+				ret = -EACCES;
+				WARN_ON_ONCE(true);
+			}
+		}
+
+		user_ns = user_ns->parent;
+	};
+
+	return ret;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
@@ -404,13 +439,14 @@ static int process_measurement(struct ima_namespace *ns,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	u32 secid;
 
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid_subj(current, &secid);
-		return process_measurement(ns, file, current_cred(), secid,
-					   NULL, 0, MAY_EXEC, MMAP_CHECK);
+		return process_measurement(user_ns, file, current_cred(),
+					   secid, NULL, 0, MAY_EXEC,
+					   MMAP_CHECK);
 	}
 
 	return 0;
@@ -485,19 +521,19 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
  */
 int ima_bprm_check(struct linux_binprm *bprm)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	int ret;
 	u32 secid;
 
 	security_task_getsecid_subj(current, &secid);
-	ret = process_measurement(ns, bprm->file, current_cred(), secid, NULL,
-				  0, MAY_EXEC, BPRM_CHECK);
+	ret = process_measurement(user_ns, bprm->file, current_cred(), secid,
+				  NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
-	return process_measurement(ns, bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+	return process_measurement(user_ns, bprm->file, bprm->cred, secid,
+				   NULL, 0, MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -512,11 +548,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	u32 secid;
 
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(ns, file, current_cred(), secid, NULL, 0,
+	return process_measurement(user_ns, file, current_cred(), secid,
+				   NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -698,7 +735,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -721,7 +758,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(ns, file, current_cred(), secid, NULL,
+	return process_measurement(user_ns, file, current_cred(), secid, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -749,7 +786,7 @@ const int read_idmap[READING_MAX_ID] = {
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -766,8 +803,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid_subj(current, &secid);
-	return process_measurement(ns, file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+	return process_measurement(user_ns, file, current_cred(), secid,
+				   buf, size, MAY_READ, func);
 }
 
 /**
-- 
2.31.1

