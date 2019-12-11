Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33AE11B923
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 17:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfLKQr3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 11:47:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38792 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbfLKQrQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 11:47:16 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA0D620B71BB;
        Wed, 11 Dec 2019 08:47:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA0D620B71BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576082835;
        bh=XL88Vyq69uD2pl0nExPMLilfhDE8tdQEbj9zo0Wa5NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFtXTBJIxJwwevkTyVqEt4tRKzRUKw7bRODCTXMiY9o2hHbzrbeg3HQgxGM4RiMlV
         6dAsgUAQ36YcU/QkmwMzJTJ6m+NdoUpUgDUJ3GRHGf63lMAOsh+pOWBRJ7eVjpmAg/
         mhNE/94ZWL5HN6jqVUrDqdvnqNxodyMvs3yWF6YI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v11 6/6] IMA: Read keyrings= option from the IMA policy
Date:   Wed, 11 Dec 2019 08:47:07 -0800
Message-Id: <20191211164707.4698-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211164707.4698-1-nramas@linux.microsoft.com>
References: <20191211164707.4698-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Read "keyrings=" option, if specified in the IMA policy, and store in
the list of IMA rules when the configured IMA policy is read.

This patch defines a new policy token enum namely Opt_keyrings
and an option flag IMA_KEYRINGS for reading "keyrings=" option
from the IMA policy.

Updated ima_parse_rule() to parse "keyrings=" option in the policy.
Updated ima_policy_show() to display "keyrings=" option.

The following example illustrates how key measurement can be verified.

Sample "key" measurement rule in the IMA policy:

measure func=KEY_CHECK uid=0 keyrings=.ima|.evm template=ima-buf

Display "key" measurement in the IMA measurement list:

cat /sys/kernel/security/ima/ascii_runtime_measurements

10 faf3...e702 ima-buf sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b .ima 308202863082...4aee

Verify "key" measurement data for a key added to ".ima" keyring:

cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | grep -m 1 "\.ima" | cut -d' ' -f 6 | xxd -r -p |tee ima-cert.der | sha256sum | cut -d' ' -f 1

The output of the above command should match the template hash
of the first "key" measurement entry in the IMA measurement list for
the key added to ".ima" keyring.

The file namely "ima-cert.der" generated by the above command
should be a valid x509 certificate (in DER format) and should match
the one that was used to import the key to the ".ima" keyring.
The certificate file can be verified using openssl tool.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cca87c499c4f..a4dde9d575b2 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_KEYRINGS	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -820,7 +821,8 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
-	Opt_permit_directio, Opt_pcr, Opt_template, Opt_err
+	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
+	Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -856,6 +858,7 @@ static const match_table_t policy_tokens = {
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
+	{Opt_keyrings, "keyrings=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1105,6 +1108,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_keyrings:
+			ima_log_string(ab, "keyrings", args[0].from);
+
+			if ((entry->keyrings) ||
+			    (entry->action != MEASURE) ||
+			    (entry->func != KEY_CHECK)) {
+				result = -EINVAL;
+				break;
+			}
+			entry->keyrings = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->keyrings) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_KEYRINGS;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1480,6 +1500,13 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_KEYRINGS) {
+		if (entry->keyrings != NULL)
+			snprintf(tbuf, sizeof(tbuf), "%s", entry->keyrings);
+		seq_printf(m, pt(Opt_keyrings), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.17.1

