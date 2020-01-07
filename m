Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDAE132FB8
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 20:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAGTn7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 14:43:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34234 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgAGTnz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 14:43:55 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id D28F320B479C;
        Tue,  7 Jan 2020 11:43:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D28F320B479C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578426234;
        bh=s+Zmgddx5AD2JWjCVm06VmtkMsj4CxUiQH6gDbhgmxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SL6AW4CDhIAUptYWQwcTD7CFARyO6jxQXB1soIX08LDi+zEsj9a7lW52YaoYZLIsS
         dx28qbMroZLHVTQfX7Kr8EIzwxHujqe6keEoAEo8TB78uvlfoYmsgmQFZed+bscUO/
         UoXc6uWiXMXHlY34M2EKClFXQK+tblCfu4fV5Wsk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH 3/4] IMA: Add support to limit measuring keys
Date:   Tue,  7 Jan 2020 11:43:49 -0800
Message-Id: <20200107194350.3782-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107194350.3782-1-nramas@linux.microsoft.com>
References: <20200107194350.3782-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Limit measuring keys to those keys being loaded onto a given set of
keyrings only and when the user id (uid) matches if uid is specified
in the policy.

This patch defines a new IMA policy option namely "keyrings=" that
can be used to specify a set of keyrings. If this option is specified
in the policy for "measure func=KEY_CHECK" then only the keys
loaded onto a keyring given in the "keyrings=" option are measured.

If uid is specified in the policy then the key is measured only if
the current user id matches the one specified in the policy.

Added a new parameter namely "keyring" (name of the keyring) to
process_buffer_measurement(). The keyring name is passed to
ima_get_action() to determine the required action.
ima_match_rules() is updated to check keyring in the policy, if
specified, for KEY_CHECK function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Fixes: e9085e0ad38a ("IMA: Add support to limit measuring keys")
---
 Documentation/ABI/testing/ima_policy         | 10 +++-
 security/integrity/ima/ima.h                 |  8 ++-
 security/integrity/ima/ima_api.c             |  8 ++-
 security/integrity/ima/ima_appraise.c        |  4 +-
 security/integrity/ima/ima_asymmetric_keys.c |  8 ++-
 security/integrity/ima/ima_main.c            |  9 +--
 security/integrity/ima/ima_policy.c          | 62 ++++++++++++++++++--
 7 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 066d32797500..cd572912c593 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,7 +25,7 @@ Description:
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
-				[appraise_flag=]
+				[appraise_flag=] [keyrings=]
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
@@ -42,6 +42,9 @@ Description:
 			appraise_flag:= [check_blacklist]
 			Currently, blacklist check is only for files signed with appended
 			signature.
+			keyrings:= list of keyrings
+			(eg, .builtin_trusted_keys|.ima). Only valid
+			when action is "measure" and func is KEY_CHECK.
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
@@ -117,3 +120,8 @@ Description:
 		Example of measure rule using KEY_CHECK to measure all keys:
 
 			measure func=KEY_CHECK
+
+		Example of measure rule using KEY_CHECK to only measure
+		keys added to .builtin_trusted_keys or .ima keyring:
+
+			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fe6c698617bd..f06238e41a7c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -208,7 +208,8 @@ struct modsig;
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc);
+		   struct ima_template_desc **template_desc,
+		   const char *keyring);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -220,7 +221,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr);
+				int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
@@ -235,7 +236,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc);
+		     struct ima_template_desc **template_desc,
+		     const char *keyring);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 610759fe63b8..f6bc00914aa5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -169,12 +169,13 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
  * @template_desc: pointer filled in if matched measure policy sets template=
+ * @keyring: keyring name used to determine the action
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE
+ *	| KEXEC_CMDLINE | KEY_CHECK
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
@@ -183,14 +184,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
-		   struct ima_template_desc **template_desc)
+		   struct ima_template_desc **template_desc,
+		   const char *keyring)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc);
+				template_desc, keyring);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 300c8d2943c5..a9649b04b9f1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -55,7 +55,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL);
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
@@ -330,7 +330,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr);
+						   pcr, NULL);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 994d89d58af9..fea2e7dd3b09 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -46,7 +46,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 * parameter to process_buffer_measurement() and is set
 	 * in the "eventname" field in ima_event_data for
 	 * the key measurement IMA event.
+	 *
+	 * The name of the keyring is also passed in the "keyring"
+	 * parameter to process_buffer_measurement() to check
+	 * if the IMA policy is configured to measure a key linked
+	 * to the given keyring.
 	 */
 	process_buffer_measurement(payload, payload_len,
-				   keyring->description, KEY_CHECK, 0);
+				   keyring->description, KEY_CHECK, 0,
+				   keyring->description);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b35db2fc777..2272c3255c7d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -215,7 +215,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
-				&template_desc);
+				&template_desc, NULL);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -632,12 +632,13 @@ int ima_load_data(enum kernel_load_data_id id)
  * @eventname: event name to be used for the buffer entry.
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
+ * @keyring: keyring name to determine the action to be performed
  *
  * Based on policy, the buffer is measured into the ima log.
  */
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr)
+				int pcr, const char *keyring)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -668,7 +669,7 @@ void process_buffer_measurement(const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(NULL, current_cred(), secid, 0, func,
-					&pcr, &template);
+					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
@@ -721,7 +722,7 @@ void ima_kexec_cmdline(const void *buf, int size)
 {
 	if (buf && size != 0)
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   KEXEC_CMDLINE, 0);
+					   KEXEC_CMDLINE, 0, NULL);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3f3928b3db99..7667ca546ce9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -79,6 +79,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *keyrings; /* Measure keys added to these keyrings */
 	struct ima_template_desc *template;
 };
 
@@ -356,6 +357,50 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_OK;
 }
 
+/**
+ * ima_match_keyring - determine whether the keyring matches the measure rule
+ * @rule: a pointer to a rule
+ * @keyring: name of the keyring to match against the measure rule
+ * @cred: a pointer to a credentials structure for user validation
+ *
+ * Returns true if keyring matches one in the rule, false otherwise.
+ */
+static bool ima_match_keyring(struct ima_rule_entry *rule,
+			      const char *keyring, const struct cred *cred)
+{
+	char *keyrings, *next_keyring, *keyrings_ptr;
+	bool matched = false;
+
+	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
+		return false;
+
+	if (!rule->keyrings)
+		return true;
+
+	if (!keyring)
+		return false;
+
+	keyrings = kstrdup(rule->keyrings, GFP_KERNEL);
+	if (!keyrings)
+		return false;
+
+	/*
+	 * "keyrings=" is specified in the policy in the format below:
+	 * keyrings=.builtin_trusted_keys|.ima|.evm
+	 */
+	keyrings_ptr = keyrings;
+	while ((next_keyring = strsep(&keyrings_ptr, "|")) != NULL) {
+		if (!strcmp(next_keyring, keyring)) {
+			matched = true;
+			break;
+		}
+	}
+
+	kfree(keyrings);
+
+	return matched;
+}
+
 /**
  * ima_match_rules - determine whether an inode matches the measure rule.
  * @rule: a pointer to a rule
@@ -364,18 +409,23 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  * @secid: the secid of the task to be validated
  * @func: LIM hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
+ * @keyring: keyring name to check in policy for KEY_CHECK func
  *
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    const struct cred *cred, u32 secid,
-			    enum ima_hooks func, int mask)
+			    enum ima_hooks func, int mask,
+			    const char *keyring)
 {
 	int i;
 
 	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
-		if ((rule->flags & IMA_FUNC) && (rule->func == func))
+		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
+			if (func == KEY_CHECK)
+				return ima_match_keyring(rule, keyring, cred);
 			return true;
+		}
 		return false;
 	}
 	if ((rule->flags & IMA_FUNC) &&
@@ -479,6 +529,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
  * @template_desc: the template that should be used for this rule
+ * @keyring: the keyring name, if given, to be used to check in the policy.
+ *           keyring can be NULL if func is anything other than KEY_CHECK.
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -489,7 +541,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  */
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
-		     struct ima_template_desc **template_desc)
+		     struct ima_template_desc **template_desc,
+		     const char *keyring)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -503,7 +556,8 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
+		if (!ima_match_rules(entry, inode, cred, secid, func, mask,
+				     keyring))
 			continue;
 
 		action |= entry->flags & IMA_ACTION_FLAGS;
-- 
2.17.1

