Return-Path: <linux-integrity+bounces-3462-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C3296DE12
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF6CB280ED
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362419E7F6;
	Thu,  5 Sep 2024 15:26:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C09443;
	Thu,  5 Sep 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549987; cv=none; b=vB5O2DvBeYqD9xA0+tafCqdIOxh0NWHmt58Ef7WC2CJd0Xg/dRPV5hS9JtZFJkXFu/IAc7mteyFoLbpEt0uy0lthj7Go4HRrlgG2FklZlygH7IddrUTcteXYwfVv0+/uNpPDawzGf2yu1FHvhFog4r3EkKAsosabEVJDrShBUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549987; c=relaxed/simple;
	bh=LdCYF37BUqoENlXSyScrdWvWkwoTxd9Rody92M1ZmjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6OvIbpge3ybKVaGTuU9g7eBAlC5mdEDk/BINLuqafx4kbFftDPgQzMq7ZBN0MceiGFxBlFE6NHR2jZXVcPvd4cryp3yKTT1FJDSgX/IZB+TidIeAKJkXIXYSkXz3x8n2xeA32Eg+aPsH6XK2IcDCbtwYJbyJhJs5lgrxON5N6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X02cc0ZQ0z9v7Jg;
	Thu,  5 Sep 2024 23:01:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 54FF91402C8;
	Thu,  5 Sep 2024 23:26:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S5;
	Thu, 05 Sep 2024 16:26:20 +0100 (CET)
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
Subject: [RFC][PATCH v3 03/10] ima: Add digest_cache policy keyword
Date: Thu,  5 Sep 2024 17:25:05 +0200
Message-Id: <20240905152512.3781098-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S5
X-Coremail-Antispam: 1UD129KBjvAXoW3Aw1xtFyxKr15XF48GFW3KFg_yoW8Gry8Ao
	ZakwsrJF48Gry3CayUCFnIyay8W3yrGw1xJFnYgr98Z3Z2qryUGasrWr4UZFW3XF48XFZ0
	kw1xX3y8tFW8Jas3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU
	V6pBDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MLPwAIs3

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
index 9d41d6b1cce2..736fe014afbc 100644
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
index 06ee99bd7886..ebf233664194 100644
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
2.34.1


