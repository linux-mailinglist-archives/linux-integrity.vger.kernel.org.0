Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAC219883
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGIGUF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 02:20:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37996 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGIGUD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 02:20:03 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1AF3320B4909;
        Wed,  8 Jul 2020 23:20:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1AF3320B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275602;
        bh=yI0/g2aB0s9h4ACzf3IyT+lQGzmQDlqQ6wtp8tod5FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4RNW+DrHFkTk1qvxZmSQHwG7aRBQp4vhDsW1yFMPo79ZpRJ8OOVgj4kYg6+mERq+
         tuRJfg5xOoluwdQYo5LFqbRK/juKp98ioIe5aT2QKHwT3atagUB2EelWMZ2ELjos63
         ph6+ujmrG9pZwEhRoL4DOgdpq6xRHWPTAGk3cbSc=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 04/12] ima: Fail rule parsing when buffer hook functions have an invalid action
Date:   Thu,  9 Jul 2020 01:19:03 -0500
Message-Id: <20200709061911.954326-5-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Buffer based hook functions, such as KEXEC_CMDLINE and KEY_CHECK, can
only measure. The process_buffer_measurement() function quietly ignores
all actions except measure so make this behavior clear at the time of
policy load.

The parsing of the keyrings conditional had a check to ensure that it
was only specified with measure actions but the check should be on the
hook function and not the keyrings conditional since
"appraise func=KEY_CHECK" is not a valid rule.

Fixes: b0935123a183 ("IMA: Define a new hook to measure the kexec boot command line arguments")
Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v3
  - Add comments to ima_validate_rule() to separate/explain the types of
    validation checks (section for action checks, section for hook
    function checks, soon to be a section for combination of options
    checks, etc.)
  - Removed the "if (entry->flags & IMA_FUNC)" conditional around the
    switch statement in ima_validate_rule() which reduced the overall indention
    by a tab. This could be removed because entry->func is NONE when the
    IMA_FUNC flag is not set. We'll explicitly enforce and then leverage
    that property in a later patch when we start validating all hook
    functions in ima_validate_rule().
  - Add comment explicitly stating that all hook functions except
    KEXEC_CMDLINE and KEY_CHECK are still being validated in
    ima_parse_rule().
* v2
  - No change

 security/integrity/ima/ima_policy.c | 40 +++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e458cd47c099..40c28f1a6a5a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -973,6 +973,43 @@ static void check_template_modsig(const struct ima_template_desc *template)
 #undef MSG
 }
 
+static bool ima_validate_rule(struct ima_rule_entry *entry)
+{
+	/* Ensure that the action is set */
+	if (entry->action == UNKNOWN)
+		return false;
+
+	/*
+	 * Ensure that the hook function is compatible with the other
+	 * components of the rule
+	 */
+	switch (entry->func) {
+	case NONE:
+	case FILE_CHECK:
+	case MMAP_CHECK:
+	case BPRM_CHECK:
+	case CREDS_CHECK:
+	case POST_SETATTR:
+	case MODULE_CHECK:
+	case FIRMWARE_CHECK:
+	case KEXEC_KERNEL_CHECK:
+	case KEXEC_INITRAMFS_CHECK:
+	case POLICY_CHECK:
+		/* Validation of these hook functions is in ima_parse_rule() */
+		break;
+	case KEXEC_CMDLINE:
+	case KEY_CHECK:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
@@ -1150,7 +1187,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			keyrings_len = strlen(args[0].from) + 1;
 
 			if ((entry->keyrings) ||
-			    (entry->action != MEASURE) ||
 			    (entry->func != KEY_CHECK) ||
 			    (keyrings_len < 2)) {
 				result = -EINVAL;
@@ -1356,7 +1392,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		}
 	}
-	if (!result && (entry->action == UNKNOWN))
+	if (!result && !ima_validate_rule(entry))
 		result = -EINVAL;
 	else if (entry->action == APPRAISE)
 		temp_ima_appraise |= ima_appraise_flag(entry->func);
-- 
2.25.1

