Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7385E27285
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfEVWqU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 18:46:20 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42241 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfEVWqT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 18:46:19 -0400
Received: by mail-yb1-f202.google.com with SMTP id v22so3538853ybb.9
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4HxaNYh8j2kBMooDaUOvbyYsJiBd0zv5O4lj+D7Hnm8=;
        b=OEp+RJT5b7UlXyyYEqMfyfqj1eTWzJXJUSRUgxlYizKVDClwFfI/ifZ0fpRvirNM0Q
         896TUHXp1eFWgtpKaFslun3IxqJQWgaGifVtrhkFOgwfHC/L8fuugesuK4+CGVCVT+MX
         zzC0nC4iYzbf8310P9YO0KPsaUi3QHbnX5kqeaF+7Shov8sYzNOVgL802/aiKRZnJOSc
         xQNxJL+mIZhnOu0wwFlR9WVc9PFbk8LBkNCVetW4w3cC0aY1b5eOGvHaECPauT2E5Lcs
         FJrjZfcLtSUmSPJHxA9jyeHDgDT7ZqHK5YXLmchmvkbud7yI9lJveVwscUv4SlXfu3Fr
         DKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4HxaNYh8j2kBMooDaUOvbyYsJiBd0zv5O4lj+D7Hnm8=;
        b=sE6U3aIXgrL/+eFEoX++ki+6ireDPR8TY6aG7Oeu8iu0XxaAyPb2QvYCzl0LPBGTPu
         G6Fve1GSc3UjJvcktS0xDqjHP6yrxhkX/It1Dw7QB6KQzM3XGNRBRynV1IIfF/x5Yzmz
         JCojoHQdZkviUr4KzYj8/9k4XwqCYO04cz81Db5CC/dbU3ixX02atyZKIA7HGBawsru2
         iT0XAwEWsD7XxzshluTd1QOeuQTgbhioKdQY1YYbQRZlxM77W85OUkEYjswQbwHs9CqL
         imRVwGi4CyCJUb4Euc6QQwoFVfm6PbPirUiQfkn5yfbgqYGllUKvcu0QcvtW2sih0NAM
         s21g==
X-Gm-Message-State: APjAAAWkYg6DFRNKREVU5q6WWKhLiM2dbMjVynbiQrVPpf7zg872yBs5
        vwLMKy2tPuYFM6n/2ZV8xiHL4h8a+llMvcz0hOEGLnhluyEf7XJ7z5VRzlts4Tc1BhREkgrUkoH
        Uo9MIk0Tof22Nl1hzn1o0b2HlPIsAE8g+auVAVxQ3GovoTpkt02clCaNghipanMgZvrHyujhd1E
        Iq40pQhr9nOchX5OCZAHo=
X-Google-Smtp-Source: APXvYqwUAWN7dFLEx54mTtlh6/Pbs3sQkge+VvSOBqpr8LshfEUAiYWQ9Ea1gfKh+9VhN24IKFOPHZZM//XfRCBzWtfO5w==
X-Received: by 2002:a25:3803:: with SMTP id f3mr15896384yba.158.1558565178273;
 Wed, 22 May 2019 15:46:18 -0700 (PDT)
Date:   Wed, 22 May 2019 15:46:14 -0700
Message-Id: <20190522224614.151764-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] IMA: Allow profiles to define the desired IMA template
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

Sending separately as requested by Mimi. Roberto, I know your approach
here was more ambitious in terms of allowing definition of custom
policies - let me know what the best way of integrating with your work
here is.

 Documentation/ABI/testing/ima_policy  |  3 ++-
 security/integrity/ima/ima.h          |  7 +++++--
 security/integrity/ima/ima_api.c      |  7 +++++--
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     |  9 ++++++---
 security/integrity/ima/ima_policy.c   | 24 ++++++++++++++++++++++--
 security/integrity/ima/ima_template.c | 15 +++++++++++----
 security/integrity/integrity.h        |  1 +
 8 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 6a517282068d..f707ef7eda88 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -24,7 +24,7 @@ Description:
 				[euid=] [fowner=] [fsname=] [subtype=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
-			option:	[[appraise_type=] [permit_directio]
+			option:	[[appraise_type=] [template=] [permit_directio]
 			         [trust_vfs]]
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
@@ -41,6 +41,7 @@ Description:
 			fowner:= decimal value
 		lsm:  	are LSM specific
 		option:	appraise_type:= [imasig]
+			template:= name of an IMA template type (eg, d-ng)
 			pcr:= decimal value
 			permit_directio:= allow directio accesses
 			trust_vfs:= trust VFS-provided hash values
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d99b867bdc53..29a71c2e6cfa 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -148,6 +148,7 @@ int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
+struct ima_template_desc *lookup_template_desc(const char *name);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
@@ -194,7 +195,8 @@ enum ima_hooks {
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
-		   int mask, enum ima_hooks func, int *pcr);
+		   int mask, enum ima_hooks func, int *pcr,
+		   struct ima_template_desc **template_desc);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -215,7 +217,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr);
+		     enum ima_hooks func, int mask, int flags, int *pcr,
+		     struct ima_template_desc **template_desc);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 55bafce3d9c0..457b071669ff 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -164,6 +164,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *        MAY_APPEND)
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
+ * @template_desc: pointer filled in if matched measure policy sets template=
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -176,13 +177,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..f23069d9e43d 100644
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
@@ -275,7 +276,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		goto out_locked;
 	}
 
-	template_desc = ima_template_desc_current();
+	if (!template_desc)
+		template_desc = ima_template_desc_current();
+
 	if ((action & IMA_APPRAISE_SUBMASK) ||
 		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
 		/* read 'security.ima' */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c293cbc6c578..33c52466bc8a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -82,6 +82,7 @@ struct ima_rule_entry {
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	char *subtype;
+	struct ima_template_desc *template;
 };
 
 /*
@@ -403,6 +404,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
+ * @template_desc: the template that should be used for this rule
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -412,7 +414,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
-		     enum ima_hooks func, int mask, int flags, int *pcr)
+		     enum ima_hooks func, int mask, int flags, int *pcr,
+		     struct ima_template_desc **template_desc)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -444,6 +447,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if ((pcr) && (entry->flags & IMA_PCR))
 			*pcr = entry->pcr;
 
+		if (template_desc && entry->flags & IMA_TEMPLATE)
+			*template_desc = entry->template;
+
 		if (!actmask)
 			break;
 	}
@@ -681,7 +687,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr, Opt_trust_vfs, Opt_err
+	Opt_pcr, Opt_trust_vfs, Opt_template, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -717,6 +723,7 @@ static const match_table_t policy_tokens = {
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_trust_vfs, "trust_vfs"},
+	{Opt_template, "template=%s"},
 	{Opt_err, NULL}
 };
 
@@ -770,6 +777,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	char *from;
 	char *p;
 	bool uid_token;
+	struct ima_template_desc *template_desc;
 	int result = 0;
 
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
@@ -1079,6 +1087,16 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else
 				entry->flags |= IMA_PCR;
 
+			break;
+		case Opt_template:
+			ima_log_string(ab, "template", args[0].from);
+			template_desc = lookup_template_desc(args[0].from);
+			if (!template_desc) {
+				result = -EINVAL;
+			} else {
+				entry->template = template_desc;
+				entry->flags |= IMA_TEMPLATE;
+			}
 			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
@@ -1358,6 +1376,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 			}
 		}
 	}
+	if (entry->flags & IMA_TEMPLATE)
+		seq_printf(m, "template=%s ", entry->template->name);
 	if (entry->flags & IMA_DIGSIG_REQUIRED)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 78bd8fea8b35..f1e3300a0a04 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -50,7 +50,6 @@ static const struct ima_template_field supported_fields[] = {
 #define MAX_TEMPLATE_NAME_LEN 15
 
 static struct ima_template_desc *ima_template;
-static struct ima_template_desc *lookup_template_desc(const char *name);
 static int template_desc_init_fields(const char *template_fmt,
 				     const struct ima_template_field ***fields,
 				     int *num_fields);
@@ -111,16 +110,24 @@ static int __init ima_template_fmt_setup(char *str)
 }
 __setup("ima_template_fmt=", ima_template_fmt_setup);
 
-static struct ima_template_desc *lookup_template_desc(const char *name)
+struct ima_template_desc *lookup_template_desc(const char *name)
 {
 	struct ima_template_desc *template_desc;
-	int found = 0;
+	int result, found = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(template_desc, &defined_templates, list) {
 		if ((strcmp(template_desc->name, name) == 0) ||
 		    (strcmp(template_desc->fmt, name) == 0)) {
-			found = 1;
+			/*
+			 * template_desc_init_fields() will return immediately
+			 * if the template is already initialised
+			 */
+			result = template_desc_init_fields(template_desc->fmt,
+						 &(template_desc->fields),
+						 &(template_desc->num_fields));
+			if (!result)
+				found = 1;
 			break;
 		}
 	}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9d74119bcdfd..9f647b04fc23 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -37,6 +37,7 @@
 #define EVM_IMMUTABLE_DIGSIG	0x08000000
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
 #define IMA_TRUST_VFS		0x20000000
+#define IMA_TEMPLATE		0x40000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-- 
2.21.0.1020.gf2820cf01a-goog

