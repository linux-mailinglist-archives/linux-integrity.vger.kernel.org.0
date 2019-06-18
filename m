Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76994ABAE
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfFRUYz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 16:24:55 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:57242 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbfFRUYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 16:24:55 -0400
Received: by mail-oi1-f202.google.com with SMTP id u200so5325142oia.23
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jun 2019 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0ylCPXAQaO/zzJZ5rVvXPXI4HQlQsKnBXawgEGxpaok=;
        b=A3pfgdpHckRpWWNofLcXRu/OayJTLt35NzZgaMP8GNbQTXM2c98bQ1WoZZhvEbd/Qb
         ki1Va1RoMLeojoml7EiaDrD4KYih5F9EDhJpl3LBgIIZi8o4ib3aVNKPSNjX4gfni9Dy
         VmOapVj8Fx81BYY+z1I/NUir/r2IZSELSpUp95NSF2bbkW4TQu88wEtq1yV6oSgTJlu4
         QhDGPN7leOVkOkNA7AXSaUXXpJyqNIq83wQzPaTlP+eU2HVmUW8S9KENyFg7OX8fR6Nz
         gLUCq1nr8/3AFkp/4kSUR9jMjlKD6NrtC6rqLzk7BkQ9iqtIXu0ZU7Ou2b4vXwPfJEqu
         xJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0ylCPXAQaO/zzJZ5rVvXPXI4HQlQsKnBXawgEGxpaok=;
        b=flILZjX6uzFssKrWvRvU8/Cr4wtVKGTwkFIwrtTv04QRSappp2H+iMHH0XGML558Eg
         WSXmk8lvhmUkz/NfGCvNF82oARvhtww+eVGf7E+tYyqu4VsUXRid4b+DtZDL60XJWP/M
         yCtdBWMxgNx3EamS1bX3kDKweyCvb98dXKfh5vudKIAWCcyFcsH/fEoYWYwOD9OGU6Jb
         9EyF3hVedJP22rGuIHUWbBkyd+WREuDcgCu/KVOA/5p8osJj/9R9NJf/CNd9e8/8JGsq
         PBpZ/EkRKzn0g7/wcH/TKJ4vFPp5Bcv3v0k1TXYZ9O8xD38ARNHIe+olAb71kFp09fSt
         wSRg==
X-Gm-Message-State: APjAAAU4PYS03xgXiRjpvBY/7LX/72gFjKwOmle6nuFaIZ6d2RsiebHH
        2HMsoQ4QO/CvSndP1fKq2W+z+r7eams0htJ3HRSBE0NrImU7aIuAxUk9unWH7DQijW5TrP8Dl6C
        9dNiWKEVpgBuE1VmPfSeunOW8Ou1hS4zIwVuh8qfHkoRs6uTfkh6zRNbo0biV5SfMgFr/2r/MfP
        43RXy1NnPnX8f6C9EZr60=
X-Google-Smtp-Source: APXvYqzTG1dxqOZhwHue59DMR4ugu/T34Q2ELmjVDyiqDChEZPA3gPe2/bFwjWVeYdnSuXFh5Tb4UNq4ZY8LXaNwnenLTw==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr30920529otg.125.1560889493902;
 Tue, 18 Jun 2019 13:24:53 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:24:28 -0700
Message-Id: <20190618202428.10320-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V4] IMA: support for per policy rule template formats
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, roberto.sassu@huawei.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Admins may wish to log different measurements using different IMA
templates. Add support for overriding the default template on a per-rule
basis.

Inspired-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---

Updated to initialise the template fields at runtime rather than at init
in order to avoid potentially sleeping allocations while the lock is
held.

 Documentation/ABI/testing/ima_policy  |  5 ++--
 security/integrity/ima/ima.h          | 16 +++++++++---
 security/integrity/ima/ima_api.c      | 24 ++++++++++++-----
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_init.c     |  2 +-
 security/integrity/ima/ima_main.c     |  9 ++++---
 security/integrity/ima/ima_policy.c   | 37 +++++++++++++++++++++++++--
 security/integrity/ima/ima_template.c | 12 +++------
 8 files changed, 78 insertions(+), 29 deletions(-)

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
index 2203451862d4..e7b9ea7732d9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -146,7 +146,11 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
+int template_desc_init_fields(const char *template_fmt,
+			      const struct ima_template_field ***fields,
+			      int *num_fields);
 struct ima_template_desc *ima_template_desc_current(void);
+struct ima_template_desc *lookup_template_desc(const char *name);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
@@ -195,7 +199,8 @@ enum ima_hooks {
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr);
+		   int mask, enum ima_hooks func, int *pcr,
+		   struct ima_template_desc **template_desc);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -203,11 +208,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
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
@@ -216,7 +223,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr);
+		     enum ima_hooks func, int mask, int flags, int *pcr,
+		     struct ima_template_desc **template_desc);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4aec6b035fe9..c0cf4bcfc82f 100644
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
@@ -143,7 +149,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	/* can overflow, only indicator */
 	atomic_long_inc(&ima_htable.violations);
 
-	result = ima_alloc_init_template(&event_data, &entry);
+	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
 		result = -ENOMEM;
 		goto err_out;
@@ -166,6 +172,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *        MAY_APPEND)
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
+ * @template_desc: pointer filled in if matched measure policy sets template=
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -178,13 +185,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
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
@@ -279,7 +288,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 void ima_store_measurement(struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
-			   int xattr_len, int pcr)
+			   int xattr_len, int pcr,
+			   struct ima_template_desc *template_desc)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
@@ -296,7 +306,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
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
index ef6c3a26296e..368ef658a1cd 100644
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
index 9e3ea8a3f2db..a7e7e2d7224c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -199,7 +199,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
-	struct ima_template_desc *template_desc;
+	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
@@ -217,7 +217,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
+	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
+				&template_desc);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -304,7 +305,6 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		goto out_locked;
 	}
 
-	template_desc = ima_template_desc_current();
 	if ((action & IMA_APPRAISE_SUBMASK) ||
 		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
 		/* read 'security.ima' */
@@ -321,7 +321,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, pcr);
+				      xattr_value, xattr_len, pcr,
+				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		inode_lock(inode);
 		rc = ima_appraise_measurement(func, iint, file, pathname,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ec4efa8ea366..88ae36cfa69c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -80,6 +80,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	struct ima_template_desc *template;
 };
 
 /*
@@ -473,6 +474,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
+ * @template_desc: the template that should be used for this rule
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -482,7 +484,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr)
+		     enum ima_hooks func, int mask, int flags, int *pcr,
+		     struct ima_template_desc **template_desc)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -514,6 +517,11 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
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
@@ -752,7 +760,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr, Opt_err
+	Opt_pcr, Opt_template, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -786,6 +794,7 @@ static const match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_template, "template=%s"},
 	{Opt_err, NULL}
 };
 
@@ -839,6 +848,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	char *from;
 	char *p;
 	bool uid_token;
+	struct ima_template_desc *template_desc;
 	int result = 0;
 
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
@@ -1134,6 +1144,27 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else
 				entry->flags |= IMA_PCR;
 
+			break;
+		case Opt_template:
+			ima_log_string(ab, "template", args[0].from);
+			if (entry->action != MEASURE) {
+				result = -EINVAL;
+				break;
+			}
+			template_desc = lookup_template_desc(args[0].from);
+			if (!template_desc || entry->template) {
+				result = -EINVAL;
+			} else {
+				/*
+				 * template_desc_init_fields() does nothing
+				 * if the template is already initialised,
+				 * so it's safe to do this unconditionally
+				 */
+				template_desc_init_fields(template_desc->fmt,
+						 &(template_desc->fields),
+						 &(template_desc->num_fields));
+				entry->template = template_desc;
+			}
 			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
@@ -1410,6 +1441,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 			}
 		}
 	}
+	if (entry->template)
+		seq_printf(m, "template=%s ", entry->template->name);
 	if (entry->flags & IMA_DIGSIG_REQUIRED)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..00dd5a434689 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -47,10 +47,6 @@ static const struct ima_template_field supported_fields[] = {
 #define MAX_TEMPLATE_NAME_LEN 15
 
 static struct ima_template_desc *ima_template;
-static struct ima_template_desc *lookup_template_desc(const char *name);
-static int template_desc_init_fields(const char *template_fmt,
-				     const struct ima_template_field ***fields,
-				     int *num_fields);
 
 static int __init ima_template_setup(char *str)
 {
@@ -108,7 +104,7 @@ static int __init ima_template_fmt_setup(char *str)
 }
 __setup("ima_template_fmt=", ima_template_fmt_setup);
 
-static struct ima_template_desc *lookup_template_desc(const char *name)
+struct ima_template_desc *lookup_template_desc(const char *name)
 {
 	struct ima_template_desc *template_desc;
 	int found = 0;
@@ -153,9 +149,9 @@ static int template_fmt_size(const char *template_fmt)
 	return j + 1;
 }
 
-static int template_desc_init_fields(const char *template_fmt,
-				     const struct ima_template_field ***fields,
-				     int *num_fields)
+int template_desc_init_fields(const char *template_fmt,
+			      const struct ima_template_field ***fields,
+			      int *num_fields)
 {
 	const char *template_fmt_ptr;
 	const struct ima_template_field *found_fields[IMA_TEMPLATE_NUM_FIELDS_MAX];
-- 
2.22.0.410.gd8fdbe21b5-goog

