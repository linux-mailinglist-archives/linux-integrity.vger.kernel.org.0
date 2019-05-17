Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 149E921FC4
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 23:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfEQVje (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 17:39:34 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42819 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbfEQVjd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 17:39:33 -0400
Received: by mail-qk1-f201.google.com with SMTP id f82so6962404qkb.9
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/ITrQNIi0NTjerZ5MiR7r+4SVrslKsoTGUVP7IEv6kU=;
        b=EQVVmRZXphR6AKeVQ4JSoeX5ztR2+S1HUTR1XM5/6QvgP1eBiAXVWL3Ro0ebl1UuQU
         U7IMllkNfVgGtOvqZhrKhuiM/Pmm/bQ0WaDVwgWs4bIR9+VOFHmCUxcyJVwGGaRJ8HPC
         LEfCOxuK2SlCVJ3xuvJVjzewGoWYg6RJlVtdlfeVYegnHznxZWo7LOsiEOmPaTY5Kyg2
         r2bCvjNjnIlbxAXrZrlySsa+IRF2Y3qRZkqjjuUS1gPsphxbbWbwUNh2TkkaILJBEkCf
         L99WWMZx63g9f3xLjPfZqME23QkJo6o/Sc3EIg8HsbGNBiseDxLcQyc5zjang4tRyEur
         XUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/ITrQNIi0NTjerZ5MiR7r+4SVrslKsoTGUVP7IEv6kU=;
        b=iuTDCwXSdXIrke3Dtjrsuae454yQFZC+Qz2fsQ0CMhpTJpmcBZEZSUK5OsbISw5GXt
         9PWSIDJ9sRrtaRNLsp7Nyovkf/NOtFeW33laRseHtvpqHhpg9efZIqym98Ubg9Mc89+D
         sSNV4LpAudpkSj4VeTfSeTT902LPQ+LvGACND4lJiNJgvNqWsLfYzwSHjt2wrsZX9s2n
         rlOOabde4mKSlwzg9Oox/WfO9U5zdJGqcKb8/1qb8NyB8MLRRb01ZqSX9WhrptxHCCGA
         dH4CkNbYskD2/pngVxGI1cFkZ+BG44G33M+Xjsqq2BQ7dTMRAi4wGaxPMiNKdsDV/ok7
         SY9Q==
X-Gm-Message-State: APjAAAX+9PI3tZ5RSTcFpPy9KcJyA8/7HTpDlY2SYZIjBvH5t+qmMdBw
        qxp2+fYai0uDv417ZASOB78XP3IqXfmYaF68zzDo8xO1Y/LiTn5024nQQP4i/1YFZoZREy9S5o5
        ku8wAR6QcCODubmwc85Aanar6U4yBvbnDGZJzmZ1caUYQX+C+qGoDgIyyKjN6g2ebrdDG8fD9BX
        mW/yR78zY7kHqnneUJ4+w=
X-Google-Smtp-Source: APXvYqxuE90XrZHB/VO7+Xrb4zeWDdpZr9ZkE2jFp92Gxnl0nXadyAYNdgO+zMIR06dwvERZz59AduFXGXMHenfcK2FqyA==
X-Received: by 2002:a37:34b:: with SMTP id 72mr46524708qkd.42.1558129172544;
 Fri, 17 May 2019 14:39:32 -0700 (PDT)
Date:   Fri, 17 May 2019 14:39:18 -0700
In-Reply-To: <20190517213918.26045-1-matthewgarrett@google.com>
Message-Id: <20190517213918.26045-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517213918.26045-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V6 4/4] efi: Attempt to get the TCG2 event log in the boot stub
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

Right now we only attempt to obtain the SHA1-only event log. The
protocol also supports a crypto agile log format, which contains digests
for all algorithms in use. Attempt to obtain this first, and fall back
to obtaining the older format if the system doesn't support it. This is
lightly complicated by the event sizes being variable (as we don't know
in advance which algorithms are in use), and the interface giving us
back a pointer to the start of the final entry rather than a pointer to
the end of the log - as a result, we need to parse the final entry to
figure out its length in order to know how much data to copy up to the
OS.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/firmware/efi/libstub/tpm.c | 57 ++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 5bd04f75d8d6..b3f30448e454 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -8,8 +8,13 @@
  *     Thiebaud Weksteen <tweek@google.com>
  */
 #include <linux/efi.h>
-#include <linux/tpm_eventlog.h>
 #include <asm/efi.h>
+/*
+ * KASAN redefines memcpy() in a way that isn't available in the EFI stub.
+ * We need to include asm/efi.h before linux/tpm_eventlog.h in order to avoid
+ * the wrong memcpy() being referenced.
+ */
+#include <linux/tpm_eventlog.h>
 
 #include "efistub.h"
 
@@ -57,7 +62,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
 
 #endif
 
-static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
+void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 {
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
@@ -67,6 +72,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
+	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	void *tcg2_protocol = NULL;
 
 	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
@@ -74,14 +80,20 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		return;
 
-	status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
-				EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
-				&log_location, &log_last_entry, &truncated);
-	if (status != EFI_SUCCESS)
-		return;
+	status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+				tcg2_protocol, version, &log_location,
+				&log_last_entry, &truncated);
+
+	if (status != EFI_SUCCESS || !log_location) {
+		version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+		status = efi_call_proto(efi_tcg2_protocol, get_event_log,
+					tcg2_protocol, version, &log_location,
+					&log_last_entry, &truncated);
+		if (status != EFI_SUCCESS || !log_location)
+			return;
+
+	}
 
-	if (!log_location)
-		return;
 	first_entry_addr = (unsigned long) log_location;
 
 	/*
@@ -96,8 +108,23 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 		 * We need to calculate its size to deduce the full size of
 		 * the logs.
 		 */
-		last_entry_size = sizeof(struct tcpa_event) +
-			((struct tcpa_event *) last_entry_addr)->event_size;
+		if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+			/*
+			 * The TCG2 log format has variable length entries,
+			 * and the information to decode the hash algorithms
+			 * back into a size is contained in the first entry -
+			 * pass a pointer to the final entry (to calculate its
+			 * size) and the first entry (so we know how long each
+			 * digest is)
+			 */
+			last_entry_size =
+				__calc_tpm2_event_size((void *)last_entry_addr,
+						    (void *)(long)log_location,
+						    false);
+		} else {
+			last_entry_size = sizeof(struct tcpa_event) +
+			   ((struct tcpa_event *) last_entry_addr)->event_size;
+		}
 		log_size = log_last_entry - log_location + last_entry_size;
 	}
 
@@ -114,7 +141,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 
 	memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
 	log_tbl->size = log_size;
-	log_tbl->version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	log_tbl->version = version;
 	memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
 
 	status = efi_call_early(install_configuration_table,
@@ -126,9 +153,3 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 err_free:
 	efi_call_early(free_pool, log_tbl);
 }
-
-void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
-{
-	/* Only try to retrieve the logs in 1.2 format. */
-	efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
-}
-- 
2.21.0.1020.gf2820cf01a-goog

