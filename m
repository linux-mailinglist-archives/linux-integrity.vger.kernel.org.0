Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B520BCBB
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFZWji (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:39:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37846 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgFZWjh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:37 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1D50520B4904;
        Fri, 26 Jun 2020 15:39:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D50520B4904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211176;
        bh=ApKomaGhnLAJ+OBGkdDeyGNla8lfgVB55xcAmYbvTbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngVDXR1WRd7wt1Lg2eFBJfzMAmeh+Czo60DKde1x8U37UyGZpI8JyNPviRH7Bfdox
         zZE9qDEoY46XPowwOpeZ6J0Liy5pHVGihCde8SKL8MHE9dWObvau3DfXiQ8+1Fpx5c
         her5dFTtckEb6ivuBT58W2pFKq7QzHM8bQWdxV7Y=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 04/11] ima: Fail rule parsing when buffer hook functions have an invalid action
Date:   Fri, 26 Jun 2020 17:38:53 -0500
Message-Id: <20200626223900.253615-5-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
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

* v2
  - No change

 security/integrity/ima/ima_policy.c | 36 +++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e458cd47c099..166124d67774 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -973,6 +973,39 @@ static void check_template_modsig(const struct ima_template_desc *template)
 #undef MSG
 }
 
+static bool ima_validate_rule(struct ima_rule_entry *entry)
+{
+	if (entry->action == UNKNOWN)
+		return false;
+
+	if (entry->flags & IMA_FUNC) {
+		switch (entry->func) {
+		case NONE:
+		case FILE_CHECK:
+		case MMAP_CHECK:
+		case BPRM_CHECK:
+		case CREDS_CHECK:
+		case POST_SETATTR:
+		case MODULE_CHECK:
+		case FIRMWARE_CHECK:
+		case KEXEC_KERNEL_CHECK:
+		case KEXEC_INITRAMFS_CHECK:
+		case POLICY_CHECK:
+			break;
+		case KEXEC_CMDLINE:
+		case KEY_CHECK:
+			if (entry->action & ~(MEASURE | DONT_MEASURE))
+				return false;
+
+			break;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
@@ -1150,7 +1183,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			keyrings_len = strlen(args[0].from) + 1;
 
 			if ((entry->keyrings) ||
-			    (entry->action != MEASURE) ||
 			    (entry->func != KEY_CHECK) ||
 			    (keyrings_len < 2)) {
 				result = -EINVAL;
@@ -1356,7 +1388,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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

