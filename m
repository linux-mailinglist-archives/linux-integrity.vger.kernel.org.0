Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED4C8F48
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 19:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJBRD5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 13:03:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33960 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfJBRD4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so20561353wrx.1
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4a/CPg2xqZ+b/NZpx616PMtohSxll231qGMOuYzcxWE=;
        b=tdnoIcnmIker0lvF0KY3CO60+cNs1URBTEXXNXeUHW2fshCRDEH9xmYdis8pb1fbyb
         vNRpKz04Fu+yWrCMZl4FUbI/pJEuRCInVKToqfVtof3VoXvgmrFZtNwmeBWMGXrl00xF
         FqVum7Wmu5DH4DDvKIL3nYWX00HsxNPaIzDN5jDm0hi91BB0lXTB58XpG5EYQ6fIvWns
         3YVbuJarZaqE5M9XLA0CmxLCQ7htEsQld6/RrO2fbgf84bF3w1DL/ozhBDdgqWWWOwyz
         NsAL2C7i/UyXnd35g6XPDzPh2xyrhVXOtrhyCG/WpIOwdMbI5nzYR9ztd3wtLNA46vQj
         HAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4a/CPg2xqZ+b/NZpx616PMtohSxll231qGMOuYzcxWE=;
        b=r4+wgKFOMXeImjt0fVAjZRUwls78ePSnwC/o2+KfKkwsb3O7k5CbFZ7Sb2ggm6dlEI
         0NDNzYjdlPm8j0ZiogeFnmulK2R3+IvMpbEnBWRbV4mjbSahBTZbm0yVDnAJrS7vRy0Q
         DrmdCpvgG+LNuaWN+I+d0RjITVMRy0fuQYgWzJsN5XXL6p8v7ZcH24myeoSJIayAKD7f
         /5BPIyqqBgJu6xdNIrkr5msBM7BNzc5o+T7zRK3U+ijFVsjk1LkoufGJoBvSiuV7oc4y
         sIUCSt3hogjYzFGylE3Pw5JDazoO4/NalCccTHlcIi9XMIXBfMxoExQz93+77SFeQNjv
         GznA==
X-Gm-Message-State: APjAAAVEgPcBBM+3x75ezb2qW45/dktBy1cvav09UlFXUhvCd6/YYQv/
        TWeEoCwifUNiAGNHrFwA9EYWtQ==
X-Google-Smtp-Source: APXvYqzYraTwzohAp1cOr3JZijdPGRhdWNVm7YqHKQHJV7nNyafLy7wTF+k2v7yiQ67qhfcMavJB8Q==
X-Received: by 2002:adf:e849:: with SMTP id d9mr3616348wrn.358.1570035834376;
        Wed, 02 Oct 2019 10:03:54 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:53 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 4/7] efi/tpm: don't traverse an event log with no events
Date:   Wed,  2 Oct 2019 18:59:01 +0200
Message-Id: <20191002165904.8819-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Peter Jones <pjones@redhat.com>

When there are no entries to put into the final event log, some machines
will return the template they would have populated anyway.  In this case
the nr_events field is 0, but the rest of the log is just garbage.

This patch stops us from trying to iterate the table with
__calc_tpm2_event_size() when the number of events in the table is 0.

Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Peter Jones <pjones@redhat.com>
Tested-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/tpm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 1d3f5ca3eaaf..b9ae5c6f9b9c 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -75,11 +75,16 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
-					    + sizeof(final_tbl->version)
-					    + sizeof(final_tbl->nr_events),
-					    final_tbl->nr_events,
-					    log_tbl->log);
+	tbl_size = 0;
+	if (final_tbl->nr_events != 0) {
+		void *events = (void *)efi.tpm_final_log
+				+ sizeof(final_tbl->version)
+				+ sizeof(final_tbl->nr_events);
+
+		tbl_size = tpm2_calc_event_log_size(events,
+						    final_tbl->nr_events,
+						    log_tbl->log);
+	}
 	memblock_reserve((unsigned long)final_tbl,
 			 tbl_size + sizeof(*final_tbl));
 	early_memunmap(final_tbl, sizeof(*final_tbl));
-- 
2.20.1

