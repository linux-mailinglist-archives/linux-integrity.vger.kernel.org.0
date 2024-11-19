Return-Path: <linux-integrity+bounces-4151-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B201E9D2466
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F790B20FF6
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AFF1C4A16;
	Tue, 19 Nov 2024 11:02:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93C1465A1;
	Tue, 19 Nov 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014133; cv=none; b=dgt43aoIsghGYAFX9sTB8laLVvjDBTvkoZF8AVQd/ZaaBBO6X6ZGfWOuzyDXkjrJG2TsIJapyiwvjwjKqQFc2SCnZNLJsd7MWjQtlqj8CFXc04SiU2AbW2ActoyUAKmzA3mN2XGHTyLEwZURmefH+To5ZSCarzOS9gar3Hcm/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014133; c=relaxed/simple;
	bh=Jdw+Y+AjJQtKleSeZKDc1VxrS9OvhOw1w2BNe4QWTp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DILNgnCHKaJydQHxrjQY2o5iLiRHOAxpaIsXy0mSZp6pAf+nxyXDsZ47LkYdKPGgoOFV9/N246siue9htxA1aeVuXNoeJID/brwrH/9f6HgmcXpKp0Gi+YlRZ6BwJ4yPe+3l3b3bR5I7QkohXrQ/vDemO9K9T+DHcUQibqOuOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xt1Hw2kQbz9v7NL;
	Tue, 19 Nov 2024 18:41:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 09F3E140ABD;
	Tue, 19 Nov 2024 19:01:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S4;
	Tue, 19 Nov 2024 12:01:57 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v4 2/9] ima: Add digest_cache policy keyword
Date: Tue, 19 Nov 2024 12:00:56 +0100
Message-ID: <20241119110103.2780453-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241119110103.2780453-1-roberto.sassu@huaweicloud.com>
References: <20241119110103.2780453-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S4
X-Coremail-Antispam: 1UD129KBjvAXoW3Aw1xtFyxKr15XF48GFW3KFg_yoW8GryrJo
	ZakwsrJF48Gry3CayUCFnIyay8W3yrGw1xJFnYgr98Z3Z2qryUG3ZrWr4UZFW3XF48Xa90
	k3WxX3y8tFW8Jas3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07jx
	DGOUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QEkwABsA

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the 'digest_cache=' policy keyword, to enable the usage of digest
caches for specific IMA actions and purpose.

At the moment, it accepts only 'data' as value, as digest caches can be
used only for measurement and appraisal of file data. In the future, it
might be possible to use them for file metadata too.

The 'digest_cache=' keyword can be specified for the subset of IMA hooks
listed in ima_digest_cache_func_allowed(). In case the function is not
specified in the policy, the filtering is done when the policy is
evaluated.

POLICY_CHECK has been excluded for measurement, because policy changes must
be visible in the IMA measurement list. For appraisal, instead, it might be
useful to load custom policies in the initial ram disk (no security.ima
xattr).

Add the digest_cache_usage member to the ima_rule_entry structure, and set
the flag IMA_DIGEST_CACHE_MEASURE_DATA if 'digest_cache=data' was specified
for a measure rule, IMA_DIGEST_CACHE_APPRAISE_DATA for an appraise rule.

Propagate the usage down to ima_match_policy() and ima_get_action(), so
that process_measurement() can make the final decision on whether or not
digest caches should be used to measure/appraise the file being evaluated.

Since using digest caches changes the meaning of the IMA measurement list,
which will include only digest lists and unknown files, enforce specifying
'pcr=' with a non-standard value, when 'digest_cache=data' is specified in
a measure rule.

This removes the ambiguity on the meaning of the IMA measurement list.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy  |  5 +-
 security/integrity/ima/ima.h          | 10 +++-
 security/integrity/ima/ima_api.c      |  6 +-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     |  8 +--
 security/integrity/ima/ima_policy.c   | 81 ++++++++++++++++++++++++++-
 6 files changed, 100 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 22237fec5532..887ac79f66eb 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[digest_type=] [template=] [permit_directio]
 				[appraise_type=] [appraise_flag=]
-				[appraise_algos=] [keyrings=]
+				[appraise_algos=] [keyrings=] [digest_cache=]
 		  base:
 			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
@@ -77,6 +77,9 @@ Description:
 			For example, "sha256,sha512" to only accept to appraise
 			files where the security.ima xattr was hashed with one
 			of these two algorithms.
+			digest_cache:= [data]
+			"data" means that the digest cache is used only
+			for file data measurement and/or appraisal.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 301f4ddfa487..64667f16a30f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -44,6 +44,10 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
+/* Digest cache usage flags. */
+#define IMA_DIGEST_CACHE_MEASURE_DATA	0x0000000000000001
+#define IMA_DIGEST_CACHE_APPRAISE_DATA	0x0000000000000002
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
@@ -374,7 +378,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos);
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_usage);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
@@ -405,7 +410,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos);
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_usage);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flags(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 984e861f6e33..b44cf7d9fbcb 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -173,6 +173,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @template_desc: pointer filled in if matched measure policy sets template=
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_usage: Actions and purpose for which digest cache is allowed
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -190,7 +191,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos)
+		   const char *func_data, unsigned int *allowed_algos,
+		   u64 *digest_cache_usage)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
@@ -198,7 +200,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	return ima_match_policy(idmap, inode, cred, secid, func, mask,
 				flags, pcr, template_desc, func_data,
-				allowed_algos);
+				allowed_algos, digest_cache_usage);
 }
 
 static bool ima_get_verity_digest(struct ima_iint_cache *iint,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..d479cf58d859 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -81,7 +81,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 	security_current_getsecid_subj(&secid);
 	return ima_match_policy(idmap, inode, current_cred(), secid,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry, struct ima_iint_cache *iint)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8f732d3bd024..bcbf64bb03c2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -234,7 +234,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos);
+				&allowed_algos, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -502,11 +502,11 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL, NULL);
+				&pcr, &template, NULL, NULL, NULL);
 	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				 current_cred(), secid, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
-				 NULL);
+				 NULL, NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -994,7 +994,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 		security_current_getsecid_subj(&secid);
 		action = ima_get_action(idmap, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
-					func_data, NULL);
+					func_data, NULL, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 047d50c2eb57..eb3bfe01782d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -122,6 +122,7 @@ struct ima_rule_entry {
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
+	u64 digest_cache_usage;	/* Actions and purpose for which digest cache is allowed */
 };
 
 /*
@@ -714,6 +715,27 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 	}
 }
 
+/* Filter IMA hooks that can use digest caches. */
+static bool ima_digest_cache_func_allowed(enum ima_hooks func)
+{
+	switch (func) {
+	case NONE:
+	case FILE_CHECK:
+	case MMAP_CHECK:
+	case MMAP_CHECK_REQPROT:
+	case BPRM_CHECK:
+	case CREDS_CHECK:
+	case FIRMWARE_CHECK:
+	case POLICY_CHECK:
+	case MODULE_CHECK:
+	case KEXEC_KERNEL_CHECK:
+	case KEXEC_INITRAMFS_CHECK:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * ima_match_policy - decision based on LSM and other conditions
  * @idmap: idmap of the mount the inode was found from
@@ -728,6 +750,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @digest_cache_usage: Actions and purpose for which digest cache is allowed
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -740,7 +763,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos)
+		     const char *func_data, unsigned int *allowed_algos,
+		     u64 *digest_cache_usage)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -785,6 +809,22 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		if (template_desc && entry->template)
 			*template_desc = entry->template;
 
+		/*
+		 * Since we allow IMA policy rules without func=, check if the
+		 * current IMA hook is allowed and, if not, disregard the digest
+		 * cache usage from the policy.
+		 *
+		 * In addition, don't allow digest caches to be used for IMA
+		 * policy measurements, so that policies always appear in the
+		 * measurement list.
+		 */
+		if (digest_cache_usage && ima_digest_cache_func_allowed(func)) {
+			*digest_cache_usage |= entry->digest_cache_usage;
+
+			if (func == POLICY_CHECK)
+				*digest_cache_usage &= ~IMA_DIGEST_CACHE_MEASURE_DATA;
+		}
+
 		if (!actmask)
 			break;
 	}
@@ -1075,7 +1115,7 @@ enum policy_opt {
 	Opt_digest_type,
 	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
 	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
-	Opt_label, Opt_err
+	Opt_label, Opt_digest_cache, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -1124,6 +1164,7 @@ static const match_table_t policy_tokens = {
 	{Opt_template, "template=%s"},
 	{Opt_keyrings, "keyrings=%s"},
 	{Opt_label, "label=%s"},
+	{Opt_digest_cache, "digest_cache=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1248,6 +1289,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	if (entry->action != MEASURE && entry->flags & IMA_PCR)
 		return false;
 
+	/* New-style measurements with digest cache cannot be on default PCR. */
+	if (entry->action == MEASURE &&
+	    (entry->digest_cache_usage & IMA_DIGEST_CACHE_MEASURE_DATA)) {
+		if (!(entry->flags & IMA_PCR) ||
+		    entry->pcr == CONFIG_IMA_MEASURE_PCR_IDX)
+			return false;
+	}
+
+	/* Digest caches can be used only for a subset of the IMA hooks. */
+	if (entry->digest_cache_usage &&
+	    !ima_digest_cache_func_allowed(entry->func))
+		return false;
+
 	if (entry->action != APPRAISE &&
 	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
 			    IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
@@ -1884,6 +1938,26 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						 &(template_desc->num_fields));
 			entry->template = template_desc;
 			break;
+		case Opt_digest_cache:
+			ima_log_string(ab, "digest_cache", args[0].from);
+
+			result = -EINVAL;
+
+			if (!strcmp(args[0].from, "data")) {
+				switch (entry->action) {
+				case MEASURE:
+					entry->digest_cache_usage |= IMA_DIGEST_CACHE_MEASURE_DATA;
+					result = 0;
+					break;
+				case APPRAISE:
+					entry->digest_cache_usage |= IMA_DIGEST_CACHE_APPRAISE_DATA;
+					result = 0;
+					break;
+				default:
+					break;
+				}
+			}
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -2274,6 +2348,9 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "digest_type=verity ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if ((entry->digest_cache_usage & IMA_DIGEST_CACHE_MEASURE_DATA) ||
+	    (entry->digest_cache_usage & IMA_DIGEST_CACHE_APPRAISE_DATA))
+		seq_puts(m, "digest_cache=data ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
-- 
2.47.0.118.gfd3785337b


