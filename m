Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB12EA89F
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 02:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfJaBT3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Oct 2019 21:19:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34450 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfJaBTT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:19 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 86D6820B4906;
        Wed, 30 Oct 2019 18:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86D6820B4906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572484757;
        bh=VSY0Vw8UdX9CVrIZ/u88NW9hTh80xgwP33AQrmg1Ing=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ml5mkmNn5GOlufTSuXQMdln2F9es/3GxfYr9Tz1rGMVzMEucBUaY98Goa1TNOPTWt
         gMeDzzSmx6ZW3MTAFb5Qenw9xFr0qGBqrkEK0cQ/2TOCA3bL9QPFcu4az0Oghf2Po+
         OT+DJ7PUpVzxdlUhKq9liUEWzYGaE/FIh2ANA2kk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
Subject: [PATCH v3 6/9] KEYS: Measure key if the IMA policy allows measurement for the given keyring
Date:   Wed, 30 Oct 2019 18:19:07 -0700
Message-Id: <20191031011910.2574-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031011910.2574-1-nramas@linux.microsoft.com>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() does not know which keyring the given key
is being linked to. It needs the keyring name to determine whether 
or not the given key needs to be measured.

This patch adds a new parameter "keyring" to process_buffer_measurement()
to convey which keyring the given key is linked to.

If KEYRING_CHECK alone is set in the policy, all keys are measured.
If a list of keyrings is also specified in the policy then only keys
linked to those keyrings will be measured.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 +-
 security/integrity/ima/ima_main.c  | 24 +++++++++++++++++++-----
 security/integrity/ima/ima_queue.c |  3 ++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ded78af94e69..f8bf5c24e0d0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -225,7 +225,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr);
+				int pcr, const char *keyring);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cbc7de87106f..bd835ec89ead 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -612,12 +612,22 @@ int ima_load_data(enum kernel_load_data_id id)
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
@@ -647,8 +657,10 @@ void process_buffer_measurement(const void *buf, int size,
 			return;
 	}
 
-	if (keyrings != NULL)
-		keyrings = NULL;
+	if ((keyring != NULL) && (keyrings != NULL)
+	    && (strstr(keyrings, keyring) == NULL)) {
+		return;
+	}
 
 	if (!pcr)
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
@@ -698,7 +710,8 @@ void ima_kexec_cmdline(const void *buf, int size)
 {
 	if (buf && size != 0) {
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   KEXEC_CMDLINE, 0);
+					   KEXEC_CMDLINE, 0,
+					   NULL);
 	}
 }
 
@@ -722,7 +735,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	pk = key->payload.data[asym_crypto];
 	process_buffer_measurement(pk->key, pk->keylen,
 				   keyring->description,
-				   KEYRING_CHECK, 0);
+				   KEYRING_CHECK, 0,
+				   keyring->description);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 5625381c5a97..805dcacb48e6 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -317,7 +317,8 @@ void ima_measure_queued_keys(void)
 		process_buffer_measurement(entry->public_key,
 					   entry->public_key_len,
 					   entry->keyring_name,
-					   KEYRING_CHECK, 0);
+					   KEYRING_CHECK, 0,
+					   entry->keyring_name);
 		list_del(&entry->list);
 		ima_free_measure_key_entry(entry);
 	}
-- 
2.17.1

