Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986C268BF53
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjBFOE1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBFOD6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:03:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1849222DC;
        Mon,  6 Feb 2023 06:03:47 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqePr027262;
        Mon, 6 Feb 2023 14:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MGslkxU9Mul/1x4YlpF4+eydimvd6ApPJ8hCrrGWrA8=;
 b=TYyYn8hvzFPOEpNYsDZM/pjVZ920LA/P1accjLoCXTXTCRul/6KtfF2Byed+bFJvUhga
 UkoFFjdUWkbL9yoEoL3RChg0x70Yqn3Idd8IPBV4ZA27tPkhMCsIICkW7sWEEEGW2bqf
 9uSi9/yym4GcbiA0FloUBPyWXNO2o6xDvSW24GEItaaCyeap/HwoZ5gbV8eRzW9jcnzO
 9maboOmoAwNzx8x+loWiGaEzCaHJCTbaKYw0X7s1MLDEO/haHVjo6n13IdwcgxmiTjVU
 gX+Kvn9cNF02gal2zt9iwj9iIPN+wrkvhEsN2v49JlylUXzHde31y+l9KxW8YxEav6mj Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tbggk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:34 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DqhKo031088;
        Mon, 6 Feb 2023 14:03:34 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tbgggp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:34 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CBKEE003944;
        Mon, 6 Feb 2023 14:03:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf072yxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3Uw98651480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0134658059;
        Mon,  6 Feb 2023 14:03:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5FE95805B;
        Mon,  6 Feb 2023 14:03:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:27 +0000 (GMT)
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
Subject: [PATCH v15 14/26] ima: Implement hierarchical processing of file accesses
Date:   Mon,  6 Feb 2023 09:02:41 -0500
Message-Id: <20230206140253.3755945-15-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sDyhvfPooCeAVA95euKzRqOUG2sycx3s
X-Proofpoint-GUID: -8QMt5ioDWmHGfmO2xP3CvrFOHPcHDeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 69f95ed0b8c6..5d647011429b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -498,4 +498,12 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
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
index c7a5f47b50fc..55ddf2c8506a 100644
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
@@ -393,6 +393,41 @@ static int process_measurement(struct ima_namespace *ns,
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
@@ -406,13 +441,14 @@ static int process_measurement(struct ima_namespace *ns,
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
@@ -488,19 +524,19 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
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
@@ -515,11 +551,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -725,7 +762,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -748,7 +785,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getsecid_subj(&secid);
-	return process_measurement(ns, file, current_cred(), secid, NULL,
+	return process_measurement(user_ns, file, current_cred(), secid, NULL,
 				   0, MAY_READ, func);
 }
 
@@ -776,7 +813,8 @@ const int read_idmap[READING_MAX_ID] = {
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = current_user_ns();
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	enum ima_hooks func;
 	u32 secid;
 
@@ -793,8 +831,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getsecid_subj(&secid);
-	return process_measurement(ns, file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+	return process_measurement(user_ns, file, current_cred(), secid,
+				   buf, size, MAY_READ, func);
 }
 
 /**
-- 
2.37.3

