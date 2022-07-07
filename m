Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45156A60E
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiGGOtO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiGGOsh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293FC31DEB;
        Thu,  7 Jul 2022 07:48:36 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMfFR006437;
        Thu, 7 Jul 2022 14:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=40feqhaBpdbLg8DyX1lE795k57r1AtKfKEdCt3hVgww=;
 b=mIz888Jw1vPnYATmAsTOBx49zNRDCkZZe4QQAmP4iDnXfqeyNq2kB0Y7hSHGoet81Jan
 eYWGk7KZwo424N65vB+Re0YHgTsqKNxw9o61L+YXdazHqfalEVVtrp0GDPNWFrS6uVHO
 nDmSE3VoK9Sbj05FEH/y/mcLgWUY5vFd7HOf5Wecx+AuMttlD8bt6jVlv92PqAjZKa3W
 wUJN8vYl44uXeJHaQTw7im1VNYZ8pybGsWGgnef+unIFYUAyDSPzM+37kxZa7fHemirh
 Nvk5CBZpuyJH/7t9JR4STGxGQax+S2c91JAKzQKyc0XyF7BKrKNQhvo3JjZYAupJzOXo 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h605j3c6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:09 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EOAWc017180;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h605j3c4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EaWvS028106;
        Thu, 7 Jul 2022 14:48:06 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 3h4v503q0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:06 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em6Oj9896570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EB93112061;
        Thu,  7 Jul 2022 14:48:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F4227112062;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
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
Subject: [PATCH v13 14/26] ima: Implement hierarchical processing of file accesses
Date:   Thu,  7 Jul 2022 10:47:48 -0400
Message-Id: <20220707144800.828288-15-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1MPJFLpt-eNGUFeT2luXt3JtP3f-p3XK
X-Proofpoint-GUID: q9dxmKVLZ1qNEgkevYr77fl5LQvKgxAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>

---

v10:
  - Fixed compilation issue

v9:
  - Switch callers to pass user_namespace rather than ima_namespace with
    potential NULL pointer
  - Add default case to switch statement and warn if this happens
  - Implement ima_ns_from_user_ns() in this patch now
---
 security/integrity/ima/ima.h      |  8 ++++
 security/integrity/ima/ima_main.c | 76 +++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 28a9842c566f..e662641772fd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -497,4 +497,12 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
 	return file_sb_user_ns(filp);
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
index 789415f65204..d2157c26d151 100644
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
+	}
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
 		security_current_getsecid_subj(&secid);
-		return process_measurement(ns, file, current_cred(), secid,
-					   NULL, 0, MAY_EXEC, MMAP_CHECK);
+		return process_measurement(user_ns, file, current_cred(),
+					   secid, NULL, 0, MAY_EXEC,
+					   MMAP_CHECK);
 	}
 
 	return 0;
@@ -486,19 +522,19 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
  */
 int ima_bprm_check(struct linux_binprm *bprm)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	int ret;
 	u32 secid;
 
 	security_current_getsecid_subj(&secid);
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
@@ -513,11 +549,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	u32 secid;
 
 	security_current_getsecid_subj(&secid);
-	return process_measurement(ns, file, current_cred(), secid, NULL, 0,
+	return process_measurement(user_ns, file, current_cred(), secid,
+				   NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -718,7 +755,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -741,7 +778,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getsecid_subj(&secid);
-	return process_measurement(ns, file, current_cred(), secid, NULL,
+	return process_measurement(user_ns, file, current_cred(), secid, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -769,7 +806,8 @@ const int read_idmap[READING_MAX_ID] = {
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	enum ima_hooks func;
 	u32 secid;
 
@@ -786,8 +824,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getsecid_subj(&secid);
-	return process_measurement(ns, file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+	return process_measurement(user_ns, file, current_cred(), secid,
+				   buf, size, MAY_READ, func);
 }
 
 /**
-- 
2.36.1

