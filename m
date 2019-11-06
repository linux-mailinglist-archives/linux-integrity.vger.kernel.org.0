Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A24F1E1B
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfKFTCD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:02:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36152 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbfKFTB1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:27 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id CD31A20B4903;
        Wed,  6 Nov 2019 11:01:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD31A20B4903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573066886;
        bh=Vn1DTnsnkYEUMpWj4b4LGG4HQThqx8QQ+UbmMlGwIIw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VCTitycIB4TCqBKhWLu/29FZdPJmBxbGsPTap00A9B0z97mghgb/tO6CpyZU7cduM
         1aC7+h1Tdf4m5u+b/VzMaB2HRCbSO6s/9pkODDDePGl3r2FWfdNhXxAiSXYk5yg4xm
         gnEmHgbCbuPzACgblxaK/qy8Ao4apr9LSKezeJCs=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] IMA: Added keyrings= option in IMA policy to only measure keys added to the specified keyrings.
Date:   Wed,  6 Nov 2019 11:01:09 -0800
Message-Id: <20191106190116.2578-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
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
index 4344b7354fc5..4d68ad8ed91c 100644
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

