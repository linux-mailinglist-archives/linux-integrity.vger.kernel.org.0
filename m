Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD3067D1DD
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 17:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjAZQjf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 11:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjAZQjc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 11:39:32 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05166183;
        Thu, 26 Jan 2023 08:39:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P2mRx3hD5z9v7Gl;
        Fri, 27 Jan 2023 00:31:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHXGOnrNJjEzvKAA--.36334S3;
        Thu, 26 Jan 2023 17:39:16 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 2/2] ima: Introduce MMAP_CHECK_REQPROT hook
Date:   Thu, 26 Jan 2023 17:38:11 +0100
Message-Id: <20230126163812.1870942-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHXGOnrNJjEzvKAA--.36334S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy5Kw1rtFy3JF13WF48WFg_yoW3Xr1fpa
        yvgayqkF18JFyIgr97A3Wa9Fs5K3yxKryUGasxu34vk3Z8XF10vry5JF1DuF1rCryrC3Z7
        Jrn09r4UZa1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        V73kDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4gjYQAAs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 98de59bfe4b2f ("take calculation of final prot in
security_mmap_file() into a helper") caused ima_file_mmap() to receive the
protections requested by the application and not those applied by the
kernel.

After restoring the original MMAP_CHECK behavior with a patch, existing
systems might be broken due to not being ready to handle new entries
(previously missing) in the IMA measurement list.

Restore the original correct MMAP_CHECK behavior instead of keeping the
current buggy one and introducing a new hook with the correct behavior. The
second option would have had the risk of IMA users not noticing the problem
at all, as they would actively have to update the IMA policy, to switch to
the correct behavior.

Also, introduce the new MMAP_CHECK_REQPROT hook to keep the current
behavior, so that IMA users could easily fix a broken system, although this
approach is discouraged due to potentially missing measurements.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy  |  2 +-
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_api.c      |  3 ++-
 security/integrity/ima/ima_appraise.c |  3 +++
 security/integrity/ima/ima_main.c     | 27 ++++++++++++++++++++++-----
 security/integrity/ima/ima_policy.c   |  4 ++++
 6 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index db17fc8a0c9f..49db0ff288e5 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -35,7 +35,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
-				[SETXATTR_CHECK]
+				[SETXATTR_CHECK][MMAP_CHECK_REQPROT]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 03b440921e61..7186769d5e13 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -190,6 +190,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(NONE, none)				\
 	hook(FILE_CHECK, file)				\
 	hook(MMAP_CHECK, mmap)				\
+	hook(MMAP_CHECK_REQPROT, mmap_reqprot)		\
 	hook(BPRM_CHECK, bprm)				\
 	hook(CREDS_CHECK, creds)			\
 	hook(POST_SETATTR, post_setattr)		\
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c1e76282b5ee..3e134c900f0c 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -179,7 +179,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE | KEY_CHECK | CRITICAL_DATA
+ *	| KEXEC_CMDLINE | KEY_CHECK | CRITICAL_DATA | SETXATTR_CHECK
+ *	| MMAP_CHECK_REQPROT
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ee6f7e237f2e..97c7d247315c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -111,6 +111,7 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 {
 	switch (func) {
 	case MMAP_CHECK:
+	case MMAP_CHECK_REQPROT:
 		return iint->ima_mmap_status;
 	case BPRM_CHECK:
 		return iint->ima_bprm_status;
@@ -131,6 +132,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 {
 	switch (func) {
 	case MMAP_CHECK:
+	case MMAP_CHECK_REQPROT:
 		iint->ima_mmap_status = status;
 		break;
 	case BPRM_CHECK:
@@ -155,6 +157,7 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
 {
 	switch (func) {
 	case MMAP_CHECK:
+	case MMAP_CHECK_REQPROT:
 		iint->flags |= (IMA_MMAP_APPRAISED | IMA_APPRAISED);
 		break;
 	case BPRM_CHECK:
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f48f4e694921..58c2fd5fe22c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -89,7 +89,8 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
 	struct inode *inode;
 	int rc = 0;
 
-	if ((func == MMAP_CHECK) && mapping_writably_mapped(file->f_mapping)) {
+	if ((func == MMAP_CHECK || func == MMAP_CHECK_REQPROT) &&
+	    mapping_writably_mapped(file->f_mapping)) {
 		rc = -ETXTBSY;
 		inode = file_inode(file);
 
@@ -227,7 +228,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	action = ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
 				&allowed_algos);
-	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
+	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
+			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
 		return 0;
@@ -411,12 +413,23 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
 		  unsigned long prot, unsigned long flags)
 {
 	u32 secid;
+	int ret;
 
-	if (file && (prot & PROT_EXEC)) {
-		security_current_getsecid_subj(&secid);
+	if (!file)
+		return 0;
+
+	security_current_getsecid_subj(&secid);
+
+	if (reqprot & PROT_EXEC) {
+		ret = process_measurement(file, current_cred(), secid, NULL,
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
+		if (ret)
+			return ret;
+	}
+
+	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), secid, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
-	}
 
 	return 0;
 }
@@ -457,6 +470,10 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
 				&pcr, &template, NULL, NULL);
+	action |= ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
+				 current_cred(), secid, MAY_EXEC,
+				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
+				 NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6a68ec270822..419db81c4f67 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -697,6 +697,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 
 	switch (func) {
 	case MMAP_CHECK:
+	case MMAP_CHECK_REQPROT:
 		return IMA_MMAP_APPRAISE;
 	case BPRM_CHECK:
 		return IMA_BPRM_APPRAISE;
@@ -1266,6 +1267,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	case NONE:
 	case FILE_CHECK:
 	case MMAP_CHECK:
+	case MMAP_CHECK_REQPROT:
 	case BPRM_CHECK:
 	case CREDS_CHECK:
 	case POST_SETATTR:
@@ -1504,6 +1506,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if ((strcmp(args[0].from, "FILE_MMAP") == 0)
 				|| (strcmp(args[0].from, "MMAP_CHECK") == 0))
 				entry->func = MMAP_CHECK;
+			else if ((strcmp(args[0].from, "MMAP_CHECK_REQPROT") == 0))
+				entry->func = MMAP_CHECK_REQPROT;
 			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
 				entry->func = BPRM_CHECK;
 			else if (strcmp(args[0].from, "CREDS_CHECK") == 0)
-- 
2.25.1

