Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3AF1E0D
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 20:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfKFTB5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 14:01:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36170 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbfKFTB2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 14:01:28 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4EDA020B4906;
        Wed,  6 Nov 2019 11:01:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EDA020B4906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573066887;
        bh=n1NP0EUOPt57DXoMwVasH/v3zddNJcqY0C3hlBcerBA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HsFPoEXQcPIUDqX9bZ6aRXalWlW33QNp6m4uPNRI8qfX2Nk2pc4RFV/riaoCL0OV+
         t54Kgxzd/ZVPMYvy6ZOMrr3IbfpiY/7+JpDIUqo17y9UFDPQ7awv8BeAUvA5ENngxX
         2ZgXtkqAT2MPOIcw5xSl6tWlZfFFcRlYHweAiOmE=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/10] IMA: Measure key if the IMA policy allows measurement for the keyring to which the key is linked to
Date:   Wed,  6 Nov 2019 11:01:12 -0800
Message-Id: <20191106190116.2578-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() needs to check if the keyring to which
the given key is linked to is listed in the keyrings option in
the IMA policy.

This patch adds a new parameter "keyring" to process_buffer_measurement().

If process_buffer_measurement() is called with func KEYRING_CHECK and
the name of the keyring to which the key is linked to, then the given
key is measured if:
  1, IMA policy did not specify "keyrings=" option.
  2, Or, the given keyring name is listed in the "keyrings=" option.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     | 26 ++++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 387829afb9a2..f15199f7ff2a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -221,7 +221,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr);
+				int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 47ad4f56c0a8..a9649b04b9f1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -330,7 +330,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr);
+						   pcr, NULL);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b6d17f37ba61..56540357c854 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -632,12 +632,22 @@ int ima_load_data(enum kernel_load_data_id id)
  * @eventname: event name to be used for the buffer entry.
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
+ * @keyring: keyring for the measurement
+ *
+ *	The following scenarios are possible with respect to
+ *	the parameter "keyring":
+ *	1, keyring is NULL. In this case buffer is measured.
+ *	2, keyring is not NULL, but ima_get_action returned
+ *	   a NULL keyrings. In this case also the buffer is measured.
+ *	3, keyring is not NULL and ima_get_action returned
+ *	   a non-NULL keyrings. In this case measure the buffer
+ *	   only if the given keyring is present in the keyrings.
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
@@ -656,6 +666,13 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	/*
+	 * If IMA is not yet initialized or IMA policy is empty
+	 * then there is no need to measure.
+	 */
+	if (!ima_policy_flag)
+		return;
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
@@ -671,6 +688,11 @@ void process_buffer_measurement(const void *buf, int size,
 			return;
 	}
 
+	if ((keyring != NULL) && (keyrings != NULL)
+	    && (strstr(keyrings, keyring) == NULL)) {
+		return;
+	}
+
 	if (!pcr)
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 
@@ -719,7 +741,7 @@ void ima_kexec_cmdline(const void *buf, int size)
 {
 	if (buf && size != 0)
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   KEXEC_CMDLINE, 0);
+					   KEXEC_CMDLINE, 0, NULL);
 }
 
 /**
-- 
2.17.1

