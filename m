Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D74219879
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGIGUS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 02:20:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38134 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGIGUQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 02:20:16 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C792520B4909;
        Wed,  8 Jul 2020 23:20:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C792520B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275614;
        bh=rN9s22YZtVw6MnRwRHBu0f8F/NRhD2zbr74Gq7VM/zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njDV7IVWMrem4WjDgsC7a5Bj4upgmla+ZcHWV3CDpcdAfFGgEU5IrXD2XUiFgNTOR
         W4zSXxKxWU3bjpL7xXslltRm6zVSEVT1pPOxscu22Bh/ymvO7DygcFhNmhvCw0usVQ
         S1JHWW150rgb2V5/sFbiJnMf/nV2/tXclfqWde3o=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 10/12] ima: Move comprehensive rule validation checks out of the token parser
Date:   Thu,  9 Jul 2020 01:19:09 -0500
Message-Id: <20200709061911.954326-11-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use ima_validate_rule(), at the end of the token parsing stage, to
verify combinations of actions, hooks, and flags. This is useful to
increase readability by consolidating such checks into a single function
and also because rule conditionals can be specified in arbitrary order
making it difficult to do comprehensive rule validation until the entire
rule has been parsed.

This allows for the check that ties together the "keyrings" conditional
with the KEY_CHECK function hook to be moved into the final rule
validation.

The modsig check no longer needs to compiled conditionally because the
token parser will ensure that modsig support is enabled before accepting
"imasig|modsig" appraise type values. The final rule validation will
ensure that appraise_type and appraise_flag options are only present in
appraise rules.

Finally, this allows for the check that ties together the "pcr"
conditional with the measure action to be moved into the final rule
validation.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v3
  - Significant broadening of the patch's scope along with renaming and
    re-describing the patch. ima_validate_rule() is now the consolidated
    location for checking combinations of
    actions/functions/conditionals and the existing checks are now
    removed from the token parsing code.
    + Ensure that the IMA_FUNC flag is only set when a function hook is
      specified, and vice versa, which allows us to use the NONE case in
      the switch statement to enforce that "keyrings=",
      "appraise_type=imasig|modsig", and "appraise_flag=blacklist"
      cannot be specified on a rule without an appropriate hook function
  - Adjust for the indentation change introduced in patch #4
  - Adjust for new fixes introduced in patch #7
* v2
  - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
    IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
    present in the rule entry flags for non-buffer hook functions.

 security/integrity/ima/ima.h        |  6 ---
 security/integrity/ima/ima_modsig.c | 20 ----------
 security/integrity/ima/ima_policy.c | 57 +++++++++++++++++++----------
 3 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 59ec28f5c117..ea7e77536f3c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -372,7 +372,6 @@ static inline int ima_read_xattr(struct dentry *dentry,
 #endif /* CONFIG_IMA_APPRAISE */
 
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
-bool ima_hook_supports_modsig(enum ima_hooks func);
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
 void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
@@ -382,11 +381,6 @@ int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
 		       u32 *data_len);
 void ima_free_modsig(struct modsig *modsig);
 #else
-static inline bool ima_hook_supports_modsig(enum ima_hooks func)
-{
-	return false;
-}
-
 static inline int ima_read_modsig(enum ima_hooks func, const void *buf,
 				  loff_t buf_len, struct modsig **modsig)
 {
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index d106885cc495..fb25723c65bc 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -32,26 +32,6 @@ struct modsig {
 	u8 raw_pkcs7[];
 };
 
-/**
- * ima_hook_supports_modsig - can the policy allow modsig for this hook?
- *
- * modsig is only supported by hooks using ima_post_read_file(), because only
- * they preload the contents of the file in a buffer. FILE_CHECK does that in
- * some cases, but not when reached from vfs_open(). POLICY_CHECK can support
- * it, but it's not useful in practice because it's a text file so deny.
- */
-bool ima_hook_supports_modsig(enum ima_hooks func)
-{
-	switch (func) {
-	case KEXEC_KERNEL_CHECK:
-	case KEXEC_INITRAMFS_CHECK:
-	case MODULE_CHECK:
-		return true;
-	default:
-		return false;
-	}
-}
-
 /*
  * ima_read_modsig - Read modsig from buf.
  *
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 13a178c70b44..c4d0a0c1f896 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -984,10 +984,27 @@ static void check_template_modsig(const struct ima_template_desc *template)
 
 static bool ima_validate_rule(struct ima_rule_entry *entry)
 {
-	/* Ensure that the action is set */
+	/* Ensure that the action is set and is compatible with the flags */
 	if (entry->action == UNKNOWN)
 		return false;
 
+	if (entry->action != MEASURE && entry->flags & IMA_PCR)
+		return false;
+
+	if (entry->action != APPRAISE &&
+	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST))
+		return false;
+
+	/*
+	 * The IMA_FUNC bit must be set if and only if there's a valid hook
+	 * function specified, and vice versa. Enforcing this property allows
+	 * for the NONE case below to validate a rule without an explicit hook
+	 * function.
+	 */
+	if (((entry->flags & IMA_FUNC) && entry->func == NONE) ||
+	    (!(entry->flags & IMA_FUNC) && entry->func != NONE))
+		return false;
+
 	/*
 	 * Ensure that the hook function is compatible with the other
 	 * components of the rule
@@ -999,12 +1016,27 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	case BPRM_CHECK:
 	case CREDS_CHECK:
 	case POST_SETATTR:
-	case MODULE_CHECK:
 	case FIRMWARE_CHECK:
+	case POLICY_CHECK:
+		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
+				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
+				     IMA_INMASK | IMA_EUID | IMA_PCR |
+				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_PERMIT_DIRECTIO))
+			return false;
+
+		break;
+	case MODULE_CHECK:
 	case KEXEC_KERNEL_CHECK:
 	case KEXEC_INITRAMFS_CHECK:
-	case POLICY_CHECK:
-		/* Validation of these hook functions is in ima_parse_rule() */
+		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
+				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
+				     IMA_INMASK | IMA_EUID | IMA_PCR |
+				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
+				     IMA_CHECK_BLACKLIST))
+			return false;
+
 		break;
 	case KEXEC_CMDLINE:
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
@@ -1218,7 +1250,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			keyrings_len = strlen(args[0].from) + 1;
 
 			if ((entry->keyrings) ||
-			    (entry->func != KEY_CHECK) ||
 			    (keyrings_len < 2)) {
 				result = -EINVAL;
 				break;
@@ -1358,15 +1389,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 						   AUDIT_SUBJ_TYPE);
 			break;
 		case Opt_appraise_type:
-			if (entry->action != APPRAISE) {
-				result = -EINVAL;
-				break;
-			}
-
 			ima_log_string(ab, "appraise_type", args[0].from);
 			if ((strcmp(args[0].from, "imasig")) == 0)
 				entry->flags |= IMA_DIGSIG_REQUIRED;
-			else if (ima_hook_supports_modsig(entry->func) &&
+			else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
 				 strcmp(args[0].from, "imasig|modsig") == 0)
 				entry->flags |= IMA_DIGSIG_REQUIRED |
 						IMA_MODSIG_ALLOWED;
@@ -1374,11 +1400,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				result = -EINVAL;
 			break;
 		case Opt_appraise_flag:
-			if (entry->action != APPRAISE) {
-				result = -EINVAL;
-				break;
-			}
-
 			ima_log_string(ab, "appraise_flag", args[0].from);
 			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
 			    strstr(args[0].from, "blacklist"))
@@ -1388,10 +1409,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			entry->flags |= IMA_PERMIT_DIRECTIO;
 			break;
 		case Opt_pcr:
-			if (entry->action != MEASURE) {
-				result = -EINVAL;
-				break;
-			}
 			ima_log_string(ab, "pcr", args[0].from);
 
 			result = kstrtoint(args[0].from, 10, &entry->pcr);
-- 
2.25.1

