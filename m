Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D568510A833
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 02:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfK0B5I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 20:57:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54514 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfK0B5F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 20:57:05 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id B0BC720BBF94;
        Tue, 26 Nov 2019 17:57:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0BC720BBF94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574819824;
        bh=6VkDuQtMfZ0JxsdKb2br0Z+5f0VVuOr0R9vAUsy6phY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJIr1VWrpzeGxEYUAjoPwcjdHhhhKbfYADGJ+Q9l9QrroY3jjrsILcsAouv1qO040
         ZZ4osXAsCw/sxUr9gpgfvig0AED4uCIW2gQmBa2xR0t8Pn5qM3QmOtKtMwgKs649J9
         hTJ22NpZw5lGHIlwnx5NbgaxDLTqpgba0wK2ejKw=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v9 6/6] IMA: Read keyrings= option from the IMA policy
Date:   Tue, 26 Nov 2019 17:56:54 -0800
Message-Id: <20191127015654.3744-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127015654.3744-1-nramas@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
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

Sample IMA Policy entry to measure keys
(Added in the file /etc/ima/ima-policy):
measure func=KEY_CHECK keyrings=.ima|.evm template=ima-buf

Build the kernel with this patch set applied and reboot to that kernel.

Ensure the IMA policy is applied:

root@nramas:/home/nramas# cat /sys/kernel/security/ima/policy
measure func=KEY_CHECK keyrings=.ima|.evm template=ima-buf

View the initial IMA measurement log:

root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements
10 67ec... ima-ng sha1:b5466c508583f0e633df83aa58fc7c5b67ccf667 boot_aggregate

Now, add a certificate (for example, x509_ima.der) to the .ima keyring
using evmctl (IMA-EVM Utility)

root@nramas:/home/nramas# keyctl show %:.ima
Keyring
 547515640 ---lswrv      0     0  keyring: .ima

root@nramas:/home/nramas# evmctl import x509_ima.der 547515640

root@nramas:/home/nramas# keyctl show %:.ima
Keyring
 547515640 ---lswrv      0     0  keyring: .ima
 809678766 --als--v      0     0   \_ asymmetric: hostname: whoami signing key: 052dd247dc3c36...

View the updated IMA measurement log:

root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements
10 67ec... ima-ng sha1:b5466c508583f0e633df83aa58fc7c5b67ccf667 boot_aggregate
10 3adf... ima-buf sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b .ima 308202863082...4aee
root@nramas:/home/nramas#

For this sample, SHA256 should be selected as the hash algorithm
used by IMA.

The following command verifies if the SHA256 hash generated from
the payload in the IMA log entry (listed above) for the .ima key
matches the SHA256 hash in the IMA log entry. The output of this
command should match the SHA256 hash given in the IMA log entry
(In this case, it should be 27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b)

root@nramas:/home/nramas# cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | grep 27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b | cut -d' ' -f 6 | xxd -r -p |tee ima-cert.der | sha256sum | cut -d' ' -f 1

The above command also creates a binary file namely ima-cert.der
using the payload in the IMA log entry. This file should be a valid
x509 certificate which can be verified using openssl as given below:

root@nramas:/home/nramas# openssl x509 -in ima-cert.der -inform DER -text

The above command should display the contents of the file ima-cert.der
as an x509 certificate.

The IMA policy used here allows measurement of keys added to
".ima" and ".evm" keyrings only. Add a key to any other keyring and
verify that the key is not measured.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d9400585fcda..78b25f083fe1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_KEYRINGS	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -825,7 +826,8 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_appraise_flag,
-	Opt_permit_directio, Opt_pcr, Opt_template, Opt_err
+	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
+	Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -861,6 +863,7 @@ static const match_table_t policy_tokens = {
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
+	{Opt_keyrings, "keyrings=%s"},
 	{Opt_err, NULL}
 };
 
@@ -1110,6 +1113,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
 
@@ -1485,6 +1505,13 @@ int ima_policy_show(struct seq_file *m, void *v)
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

