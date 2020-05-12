Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A361CEBBC
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 06:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgELEB5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 00:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELEB4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 00:01:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0DCC061A0C
        for <linux-integrity@vger.kernel.org>; Mon, 11 May 2020 21:01:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so6765341wmd.0
        for <linux-integrity@vger.kernel.org>; Mon, 11 May 2020 21:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHu/I0/jx2sW1DokJ+Kufd/ty31VLzykSRHqsd1EPLQ=;
        b=fmiCg8FmMYn5QMPDM671yjeWBu0/9xuST9stMkpNILUmgIsbrHlpqgXtHlsKkDaDXS
         eHK1MEVqnuhveaiQyFr/3BNJwkFhPnru8bcRoBSF1YyOd39LXoqxlV3dWvQ8aJpFbIlr
         0YBUt88IwPloXQri/eC2aCqmVDZE6+ry9THSgEncfinmo1T8sdFLk3F5Z1bgLROlNNhu
         99WIgiumaZ7PV2xIRLPr8NebF/wERowEG0BypHqgrY4t+XFXhjPL0IYnwSdzjmA6g8HL
         lygjFehfkyTzF8WpHbbf4ueSxzLMqArxUMPO+6LTMU1yrpLupUYobGkkvcIoZ4EuQRS2
         viZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHu/I0/jx2sW1DokJ+Kufd/ty31VLzykSRHqsd1EPLQ=;
        b=rhlbiZCfAH3XAuCL8QPy+/N/MHEHSNRGYSXvEc7jnpKw7XZ1ToPRGV8mDn0YWNbK9O
         UJNiZkKvoVOYGyfTNglbiKia1G07EQ4qBPGerp7yEHkuacpUY42x1zd0A9tA7ULaANat
         +HpnWG1uJfW5niOPZzCQrA6iKYoH/uhxCNJrzd+HkqsvA0DDR5WngTQWUXkccROyoYFz
         uUYXF5L46+wkBb//djWG09MA3QdgWPgSBCoVIneCWdAx/tb66xaZQ4xNmq2pUzCimO+G
         dVoo7Ydi3uw19UKOEUEgr+6+j8VyoGM0RNZ9JKjIue65jC6xNatjIw3O51CND65c5lIV
         dlWA==
X-Gm-Message-State: AGi0PuY4lLKwsh05602Y6JOeDv/86wYGAJ+jMyeG3piFA3bxNrAIId01
        9DmrrYRsbj+k92Wl4E6q2RJIdJMNKXY=
X-Google-Smtp-Source: APiQypIj7iE6OIfRD0Yb+X8K95Ajj+Ic3eSSrCyYp0kbUkY4ueRID8RiDxm4/vPn1J8tWPAoaJD/kg==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr8016876wmh.157.1589256115082;
        Mon, 11 May 2020 21:01:55 -0700 (PDT)
Received: from localhost.localdomain (174.39.207.77.rev.sfr.net. [77.207.39.174])
        by smtp.gmail.com with ESMTPSA id g135sm12274450wme.22.2020.05.11.21.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 21:01:53 -0700 (PDT)
From:   =?UTF-8?q?Lo=C3=AFc=20Yhuel?= <loic.yhuel@gmail.com>
To:     linux-integrity@vger.kernel.org
Cc:     matthewgarrett@google.com, ardb@kernel.org,
        jarkko.sakkinen@linux.intel.com, javierm@redhat.com,
        =?UTF-8?q?Lo=C3=AFc=20Yhuel?= <loic.yhuel@gmail.com>
Subject: [PATCH] tpm: check event log version before reading final events
Date:   Tue, 12 May 2020 06:01:13 +0200
Message-Id: <20200512040113.277768-1-loic.yhuel@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This fixes the boot issues since 5.3 on several Dell models when the TPM
is enabled. Depending on the exact grub binary, booting the kernel would
freeze early, or just report an error parsing the final events log.

We get an event log in the SHA-1 format, which doesn't have a
tcg_efi_specid_event_head in the first event, and there is a final events
table which doesn't match the crypto agile format.
__calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
either fails, or loops long enough for the machine to be appear frozen.

So we now only parse the final events table, which is per the spec always
supposed to be in the crypto agile format, when we got a event log in this
format.

Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
Fixes: 166a2809d65b2 ("tpm: Don't duplicate events from the final event log in the TCG2 log")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1779611
Signed-off-by: Loïc Yhuel <loic.yhuel@gmail.com>
---
 drivers/firmware/efi/libstub/tpm.c | 5 +++--
 drivers/firmware/efi/tpm.c         | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 1d59e103a2e3..e9a684637b70 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -54,7 +54,7 @@ void efi_retrieve_tpm2_eventlog(void)
 	efi_status_t status;
 	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
-	struct efi_tcg2_final_events_table *final_events_table;
+	struct efi_tcg2_final_events_table *final_events_table = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
@@ -127,7 +127,8 @@ void efi_retrieve_tpm2_eventlog(void)
 	 * Figure out whether any events have already been logged to the
 	 * final events structure, and if so how much space they take up
 	 */
-	final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
+	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 55b031d2c989..77e101a395e7 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -62,7 +62,8 @@ int __init efi_tpm_eventlog_init(void)
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
+	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
 		goto out;
 
 	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
-- 
2.26.2

