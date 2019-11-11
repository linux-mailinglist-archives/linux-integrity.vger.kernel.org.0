Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511E6F802C
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 20:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKKTdK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 14:33:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44814 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKKTdK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 14:33:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0ED6020B4902;
        Mon, 11 Nov 2019 11:33:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0ED6020B4902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573500789;
        bh=czD3YKVQUEwiJ2IIPaqqvbq8+xrjcmi3FNWW61OJEmg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=C/SFRAxBZ4xNSXwCswB1POx3GjRJbq26Yc9qI8Qqdoj/64fipWal/n/cvAyGB6Pe5
         yie976FdsLC8PTalcdHW+D3W1qecoIpoHmblKCG8q/Cf4ayNjGLINn/FcyNysCa4dP
         k9zS1j1SNq5ywcOh87MRu0EIlW7yc619VppJRERk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/10] IMA: Added keyrings= option in IMA policy to only measure keys added to the specified keyrings.
Date:   Mon, 11 Nov 2019 11:32:55 -0800
Message-Id: <20191111193303.12781-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA policy needs to support measuring only those keys linked to
a specific set of keyrings.

This patch defines a new IMA policy option namely "keyrings=" that
can be used to specify a set of keyrings. If this option is specified
in the policy for func=KEYRING_CHECK then only the keys linked to
the keyrings given in "keyrings=" option are measured.

If "keyrings=" option is not specified for func=KEYRING_CHECK then
all keys are measured.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy | 10 +++++++++-
 security/integrity/ima/ima_policy.c  |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 341df49b5ad1..be2874fa3928 100644
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
@@ -43,6 +43,9 @@ Description:
 			appraise_flag:= [check_blacklist]
 			Currently, blacklist check is only for files signed with appended
 			signature.
+			keyrings:= list of keyrings
+			(eg, .builtin_trusted_keys|.ima). Only valid
+			when action is "measure" and func is KEYRING_CHECK.
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
@@ -119,3 +122,8 @@ Description:
 		all keys:
 
 			measure func=KEYRING_CHECK
+
+		Example of measure rule using KEYRING_CHECK to only measure
+		keys added to .builtin_trusted_keys or .ima keyring:
+
+			measure func=KEYRING_CHECK keyrings=.builtin_trusted_keys|.ima
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9ca32ffaaa9d..a0f7ffa80736 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_KEYRINGS	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -79,6 +80,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *keyrings; /* Measure keys added to these keyrings */
 	struct ima_template_desc *template;
 };
 
-- 
2.17.1

