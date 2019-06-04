Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9368B35125
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFDUjE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 16:39:04 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:41064 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFDUjE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 16:39:04 -0400
Received: by mail-qt1-f201.google.com with SMTP id e39so6051933qte.8
        for <linux-integrity@vger.kernel.org>; Tue, 04 Jun 2019 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bHG+ef31oUT0Q9coOBGq++DV3GL50gUq5VzoJAWjUl8=;
        b=KGxuidmcp0yTTJifpw55IM4XO33tDsjanOoiGNJgJTufB2mh8kcx8+zCAEgaDknJLP
         HK4nKG87N22wCM/Gl6eJKKmZ/NUfMBFS/jmmF/oWBM8MnLBb1+pFD+vz3KlMVV/U7T9l
         46a5L+X9lZgDoyV/R+zkLvyMK06ypLAfjSsCFCnBxPTveQjI5SQs9trVD8Y9P1DfckEc
         cBPaiRwIu6Uv6KzeExncqf6nHZPGu3QcKEe3zbNet/irgyrk+YGYg2UyViH9kPUdEW7L
         1bHwuBIB5fB9Jb5P55JvL9qpYVm0Z23yB84S7rJVJ6eZebuzeckReUz2LfqI4iItUmjt
         Az/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bHG+ef31oUT0Q9coOBGq++DV3GL50gUq5VzoJAWjUl8=;
        b=SxZkA71LN3YW9e61UB1bPrZqUBG9PVtP+vigO2lij1iXZ77oiSMiJK5oKTrMnZ4CK1
         BPP58+PAFZpd4YufTGgm8nTy0LkN0J17NNiR5Yt2gQZmPsoLgWtD5zKEjdaSpkkz9/XQ
         W+V8rVXL1UM2b/yoT+fzn51QcZkMIfm92fv2Y6AxNwwpxfENsT7issOtKLUtHpiEhS//
         W1JkcHRGMV/TJPZ9PZjCmDQBU9lXiRqXhzLSbpws1c+qfMXQ2T7ybr4yVBYeEKJUlJ13
         0C3kvsopAlx+gx6nFNE+ZD1gHqkca0OXluEtBoGOj6UL0Dera2bFj53DqRjzmjdJteHX
         h2zg==
X-Gm-Message-State: APjAAAXZw+cchmMTN3Ex6RN9ZLDvqv7IupEKt3CZ1S2ntRJ1BR6MoeGU
        VKrLEkB/e4R5Cih+KcrlCKTO16DPGL/gKfSoSOT8qXRdorcyGkCFEDVwOo1qjHShl+0QzKldoTc
        YB2DrQwIZnUiKKrJNFVDh31VHtLwnDxnafINPkNYvsiC7SACtGTDThcZEaBb5t7qmypPsBzX679
        aTRIvdWnc3gxMpPvI2PF8=
X-Google-Smtp-Source: APXvYqxcPR5srWXipE2qgPgSdCSP90L8jEOyCoTCwTUyUSNfA2d7/Qi0OQkI925npgGavdC6LO/OhQWtxYinEevJJjJd+A==
X-Received: by 2002:a0c:d003:: with SMTP id u3mr15737589qvg.112.1559680742656;
 Tue, 04 Jun 2019 13:39:02 -0700 (PDT)
Date:   Tue,  4 Jun 2019 13:38:59 -0700
Message-Id: <20190604203859.181156-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH V4] IMA: Allow profiles to define the desired IMA template
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, roberto.sassu@huawei.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Admins may wish to log different measurements using different IMA
templates. Add support for overriding the default template on a per-rule
basis.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Remove mention of template format from the documentation, and avoid
 attempting to assign to template_desc if we weren't provided a pointer
 in the first place.

 Documentation/ABI/testing/ima_policy  |  5 +++--
 security/integrity/ima/ima.h          | 13 +++++++++----
 security/integrity/ima/ima_api.c      | 24 ++++++++++++++++-------
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_init.c     |  2 +-
 security/integrity/ima/ima_main.c     |  9 +++++----
 security/integrity/ima/ima_policy.c   | 28 +++++++++++++++++++++++++--
 security/integrity/ima/ima_template.c | 10 ++++++++--
 8 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 74c6702de74e..b383c1763610 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -24,8 +24,7 @@ Description:
 				[euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
-			option:	[[appraise_type=]] [permit_directio]
-
+			option:	[[appraise_type=]] [template=] [permit_directio]
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
@@ -38,6 +37,8 @@ Description:
 			fowner:= decimal value
 		lsm:  	are LSM specific
 		option:	appraise_type:= [imasig]
+			template:= name of a defined IMA template type
+			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
 
 		default policy:
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..18b48a6d0b80 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -147,6 +147,7 @@ int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
+struct ima_template_desc *lookup_template_desc(const char *name);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
@@ -193,7 +194,8 @@ enum ima_hooks {
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr);
+		   int mask, enum ima_hooks func, int *pcr,
+		   struct ima_template_desc **template_desc);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -201,11 +203,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
-			   int xattr_len, int pcr);
+			   int xattr_len, int pcr,
+			   struct ima_template_desc *template_desc);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
-			    struct ima_template_entry **entry);
+			    struct ima_template_entry **entry,
+			    struct ima_template_desc *template_desc);
 int ima_store_template(struct ima_template_entry *entry, int violation,
 		       struct inode *inode,
 		       const unsigned char *filename, int pcr);
@@ -214,7 +218,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr);
+		     enum ima_hooks func, int mask, int flags, int *pcr,
+		     struct ima_template_desc **template_desc);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..78eb11c7ac07 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -38,11 +38,17 @@ void ima_free_template_entry(struct ima_template_entry *entry)
  * ima_alloc_init_template - create and initialize a new template entry
  */
 int ima_alloc_init_template(struct ima_event_data *event_data,
-			    struct ima_template_entry **entry)
+			    struct ima_template_entry **entry,
+			    struct ima_template_desc *desc)
 {
-	struct ima_template_desc *template_desc = ima_template_desc_current();
+	struct ima_template_desc *template_desc;
 	int i, result = 0;
 
+	if (desc)
+		template_desc = desc;
+	else
+		template_desc = ima_template_desc_current();
+
 	*entry = kzalloc(sizeof(**entry) + template_desc->num_fields *
 			 sizeof(struct ima_field_data), GFP_NOFS);
 	if (!*entry)
@@ -141,7 +147,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	/* can overflow, only indicator */
 	atomic_long_inc(&ima_htable.violations);
 
-	result = ima_alloc_init_template(&event_data, &entry);
+	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
 		result = -ENOMEM;
 		goto err_out;
@@ -164,6 +170,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *        MAY_APPEND)
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
+ * @template_desc: pointer filled in if matched measure policy sets template=
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -176,13 +183,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *
  */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr)
+		   int mask, enum ima_hooks func, int *pcr,
+		   struct ima_template_desc **template_desc)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr);
+	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
+				template_desc);
 }
 
 /*
@@ -277,7 +286,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 void ima_store_measurement(struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
-			   int xattr_len, int pcr)
+			   int xattr_len, int pcr,
+			   struct ima_template_desc *template_desc)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
@@ -291,7 +301,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	if (iint->measured_pcrs & (0x1 << pcr))
 		return;
 
-	result = ima_alloc_init_template(&event_data, &entry);
+	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
 				    op, audit_cause, result, 0);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5fb7127bbe68..2f6536ab69e8 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -57,7 +57,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL);
+				IMA_APPRAISE | IMA_HASH, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6c9295449751..993d0f1915ff 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -72,7 +72,7 @@ static int __init ima_add_boot_aggregate(void)
 		}
 	}
 
-	result = ima_alloc_init_template(&event_data, &entry);
+	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
 		audit_cause = "alloc_entry";
 		goto err_out;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..83c5dea0d939 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -174,7 +174,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
-	struct ima_template_desc *template_desc;
+	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
@@ -192,7 +192,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
+	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
+				&template_desc);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -275,7 +276,6 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		goto out_locked;
 	}
 
-	template_desc = ima_template_desc_current();
 	if ((action & IMA_APPRAISE_SUBMASK) ||
 		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
 		/* read 'security.ima' */
@@ -292,7 +292,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, pcr);
+				      xattr_value, xattr_len, pcr,
+				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		inode_lock(inode);
 		rc = ima_appraise_measurement(func, iint, file, pathname,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 0f6fe53cef09..db47e02f8dd8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -80,6 +80,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	struct ima_template_desc *template;
 };
 
 /*
@@ -397,6 +398,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
+ * @template_desc: the template that should be used for this rule
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -406,7 +408,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr)
+		     enum ima_hooks func, int mask, int flags, int *pcr,
+		     struct ima_template_desc **template_desc)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -438,6 +441,11 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if ((pcr) && (entry->flags & IMA_PCR))
 			*pcr = entry->pcr;
 
+		if (template_desc && entry->template)
+			*template_desc = entry->template;
+		else if (template_desc)
+			*template_desc = ima_template_desc_current();
+
 		if (!actmask)
 			break;
 	}
@@ -676,7 +684,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr, Opt_err
+	Opt_pcr, Opt_template, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -710,6 +718,7 @@ static const match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_template, "template=%s"},
 	{Opt_err, NULL}
 };
 
@@ -763,6 +772,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	char *from;
 	char *p;
 	bool uid_token;
+	struct ima_template_desc *template_desc;
 	int result = 0;
 
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
@@ -1059,6 +1069,18 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->flags |= IMA_PCR;
 
 			break;
+		case Opt_template:
+			ima_log_string(ab, "template", args[0].from);
+			if (entry->action != MEASURE) {
+				result = -EINVAL;
+				break;
+			}
+			template_desc = lookup_template_desc(args[0].from);
+			if (!template_desc || entry->template)
+				result = -EINVAL;
+			else
+				entry->template = template_desc;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1331,6 +1353,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 			}
 		}
 	}
+	if (entry->template)
+		seq_printf(m, "template=%s ", entry->template->name);
 	if (entry->flags & IMA_DIGSIG_REQUIRED)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..e6e892f31cbd 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -47,7 +47,6 @@ static const struct ima_template_field supported_fields[] = {
 #define MAX_TEMPLATE_NAME_LEN 15
 
 static struct ima_template_desc *ima_template;
-static struct ima_template_desc *lookup_template_desc(const char *name);
 static int template_desc_init_fields(const char *template_fmt,
 				     const struct ima_template_field ***fields,
 				     int *num_fields);
@@ -108,7 +107,7 @@ static int __init ima_template_fmt_setup(char *str)
 }
 __setup("ima_template_fmt=", ima_template_fmt_setup);
 
-static struct ima_template_desc *lookup_template_desc(const char *name)
+struct ima_template_desc *lookup_template_desc(const char *name)
 {
 	struct ima_template_desc *template_desc;
 	int found = 0;
@@ -117,6 +116,13 @@ static struct ima_template_desc *lookup_template_desc(const char *name)
 	list_for_each_entry_rcu(template_desc, &defined_templates, list) {
 		if ((strcmp(template_desc->name, name) == 0) ||
 		    (strcmp(template_desc->fmt, name) == 0)) {
+			/*
+			 * template_desc_init_fields() will return immediately
+			 * if the template is already initialised
+			 */
+			template_desc_init_fields(template_desc->fmt,
+						 &(template_desc->fields),
+						 &(template_desc->num_fields));
 			found = 1;
 			break;
 		}
-- 
2.22.0.rc1.311.g5d7573a151-goog

