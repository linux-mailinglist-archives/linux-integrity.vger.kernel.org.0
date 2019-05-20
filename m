Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47024259
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2019 22:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfETUzK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 16:55:10 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:37550 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfETUzJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 16:55:09 -0400
Received: by mail-qt1-f201.google.com with SMTP id q23so579458qtb.4
        for <linux-integrity@vger.kernel.org>; Mon, 20 May 2019 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=akrm/3bgh71I70hR0K09l3Kfzzk0aIwNcfCkA5T1H8s=;
        b=YBpxht9kl8QYDiQ4NThsO65nDKncBg5XXpPzCNuHbT4kR7k7m0qx2/e6WdDmMsY2LY
         2iLbS1wFLp6/bGp5FJa/Eo9+dJu1YFPAi9sl9XwAPRy5XI699M8FGgE45AOooLuweR6O
         gha7bK5+MQaJxFFeJAk3iPUZltWJVWxqBNLcjgfb3Cu7FLGAHh+Mgx61RYJGcEls3wcv
         ioK5P59ZLO4RWWuJe8gEgYB0SLYIr0S0drSe5DfqZ8oE9wDAy6Hq5siXjpUcd4nlvldz
         jmEdqpWaXcU0TJhsFdE6Jlqwynd771VjOkcgUnAoBRH14294GeufY8URUrFX2A7JYt4O
         sBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=akrm/3bgh71I70hR0K09l3Kfzzk0aIwNcfCkA5T1H8s=;
        b=pwTE4GKjMSVRFM5IaVdKCl8gBMoBEHktqgAALA3XiE/pKhRQyuvdv+AzcwUe88zI28
         5jpRCM00Fv1hbeU9niV2i0LAahODv5lDRg7N32y92VeaimlvH7cvwUQNBgHR8wTjV7kU
         UbUTxMN6Muiu0uZU4qhzHUGeyaOWveqmIiuRyQRiBcWKabdaekfEISh8clwvm873Vbnm
         2Rb591QUpKmcJE5VpMv5+eUR+ZqTuZQ2KmbyI16xdB0c1aNSsOwzjpr88IMuv7xfACF/
         u7vLmwUhZ02GT6gmAByMf6SRPkKYQ57vQKkZtVEBNvY/CgEg5nlNU/ebQk7CLcqiR2G+
         4XKQ==
X-Gm-Message-State: APjAAAXq5CLuZluqF/ei6LDpvGPXYk3idLhmxG2dEGgohC2EV0aM36io
        +LmLOYfnp7Fe1SquebuT00kinQQG2ICOiw4kgnplEiuZiL0OqF/vCRtldhgIfBQJesNreLySs/P
        8gpJPXGA+Hj4NR92A/nbZWzfy8Oz4dFjgcqHu+Gx+K5MPM0yMMrlKQGPgpb0YOmAAIgt3uWlxht
        FiK3Me450/uPzeH4FPB8w=
X-Google-Smtp-Source: APXvYqzKTMYg8rW5jVfSQPhysQn7BFeOUlYvYPTcDiKFgnvWNRdEhRqy390LZ8ffPMPH9cPbWXbojWbOAP680fBQu19y3w==
X-Received: by 2002:aed:21ca:: with SMTP id m10mr60246543qtc.97.1558385708444;
 Mon, 20 May 2019 13:55:08 -0700 (PDT)
Date:   Mon, 20 May 2019 13:54:58 -0700
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
Message-Id: <20190520205501.177637-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 1/4] tpm: Abstract crypto agile event size calculations
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

We need to calculate the size of crypto agile events in multiple
locations, including in the EFI boot stub. The easiest way to do this is
to put it in a header file as an inline and leave a wrapper to ensure we
don't end up with multiple copies of it embedded in the existing code.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 47 +---------------------
 include/linux/tpm_eventlog.h     | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 46 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index f824563fc28d..1a977bdd3bd2 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -40,52 +40,7 @@
 static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				   struct tcg_pcr_event *event_header)
 {
-	struct tcg_efi_specid_event_head *efispecid;
-	struct tcg_event_field *event_field;
-	void *marker;
-	void *marker_start;
-	u32 halg_size;
-	size_t size;
-	u16 halg;
-	int i;
-	int j;
-
-	marker = event;
-	marker_start = marker;
-	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
-		+ sizeof(event->count);
-
-	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
-
-	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs)
-		return 0;
-
-	for (i = 0; i < event->count; i++) {
-		halg_size = sizeof(event->digests[i].alg_id);
-		memcpy(&halg, marker, halg_size);
-		marker = marker + halg_size;
-		for (j = 0; j < efispecid->num_algs; j++) {
-			if (halg == efispecid->digest_sizes[j].alg_id) {
-				marker +=
-					efispecid->digest_sizes[j].digest_size;
-				break;
-			}
-		}
-		/* Algorithm without known length. Such event is unparseable. */
-		if (j == efispecid->num_algs)
-			return 0;
-	}
-
-	event_field = (struct tcg_event_field *)marker;
-	marker = marker + sizeof(event_field->event_size)
-		+ event_field->event_size;
-	size = marker - marker_start;
-
-	if ((event->event_type == 0) && (event_field->event_size == 0))
-		return 0;
-
-	return size;
+	return __calc_tpm2_event_size(event, event_header);
 }
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 81519f163211..6a86144e13f1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -112,4 +112,72 @@ struct tcg_pcr_event2_head {
 	struct tpm_digest digests[];
 } __packed;
 
+/**
+ * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
+ * @event:        Pointer to the event whose size should be calculated
+ * @event_header: Pointer to the initial event containing the digest lengths
+ *
+ * The TPM2 event log format can contain multiple digests corresponding to
+ * separate PCR banks, and also contains a variable length of the data that
+ * was measured. This requires knowledge of how long each digest type is,
+ * and this information is contained within the first event in the log.
+ *
+ * We calculate the length by examining the number of events, and then looking
+ * at each event in turn to determine how much space is used for events in
+ * total. Once we've done this we know the offset of the data length field,
+ * and can calculate the total size of the event.
+ *
+ * Return: size of the event on success, <0 on failure
+ */
+
+static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+					 struct tcg_pcr_event *event_header)
+{
+	struct tcg_efi_specid_event_head *efispecid;
+	struct tcg_event_field *event_field;
+	void *marker;
+	void *marker_start;
+	u32 halg_size;
+	size_t size;
+	u16 halg;
+	int i;
+	int j;
+
+	marker = event;
+	marker_start = marker;
+	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
+		+ sizeof(event->count);
+
+	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
+
+	/* Check if event is malformed. */
+	if (event->count > efispecid->num_algs)
+		return 0;
+
+	for (i = 0; i < event->count; i++) {
+		halg_size = sizeof(event->digests[i].alg_id);
+		memcpy(&halg, marker, halg_size);
+		marker = marker + halg_size;
+		for (j = 0; j < efispecid->num_algs; j++) {
+			if (halg == efispecid->digest_sizes[j].alg_id) {
+				marker +=
+					efispecid->digest_sizes[j].digest_size;
+				break;
+			}
+		}
+		/* Algorithm without known length. Such event is unparseable. */
+		if (j == efispecid->num_algs)
+			return 0;
+	}
+
+	event_field = (struct tcg_event_field *)marker;
+	marker = marker + sizeof(event_field->event_size)
+		+ event_field->event_size;
+	size = marker - marker_start;
+
+	if ((event->event_type == 0) && (event_field->event_size == 0))
+		return 0;
+
+	return size;
+}
 #endif
-- 
2.21.0.1020.gf2820cf01a-goog

