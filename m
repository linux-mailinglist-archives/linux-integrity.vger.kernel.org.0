Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8931521FC3
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 23:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfEQVjc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 17:39:32 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51254 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfEQVj3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 17:39:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id k22so5324756pfg.18
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=27XlZCkUSOvunq8Y7K1xpByb07sERoUPEIdUjg1Yu24=;
        b=Nmj5WsGpY6eH5l1CIzj3XtT6AYXnaMsyBZtfyh/nKuUM187l2YkpGAA/m01INmJdCj
         xTEWTeS4ckCQpsaBY4MHAahrSjUgJBXHhMd0P/lhlpALNnqGNP+miZJWEG1F85Yjw0qg
         kIGf97H9mKa5d0NdiOVUgDC7Jbji9+oM22lsZX5Jl8d7ifoKK4BzTH6oJ3hNpAxuN1xU
         LWPbBhFDhE2cJc8xROiesWla2sxdmnTNBAFXUZ/5fI3RvpwuJXYE0nTLgCrta5A+z/vQ
         AvgXW9HGXOWpYCfC14ILu/IA0ft1qk+WTSMNFA1zjj2oXn6Ni3ohT12QbV13T1ZOasxB
         hNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=27XlZCkUSOvunq8Y7K1xpByb07sERoUPEIdUjg1Yu24=;
        b=n0+9JfN/69rK3n7yzRD6cYNCC5NjSyOPb9++qAcM+8yy7KPdQJGm6bpQR9Ah1sserQ
         pwJLuNWF9nDBee85+4ifhuWpNpxqdQTTvp4T71pSz2n4A1ISvhrakde+azu5QdJ5j7xv
         PToA2Zvjj4vtOtvdZX7TII/4hEYHV6SFeZlEMO8a0IX/r2eElFFn2ZwocQ9+bqNlZPLJ
         KhS8ttTb6az4g2SRq1C05bWGx4zP0Wuywzj4JA2n9Hnb+Pg8kpmMFGNjRTh7TaKcRcCp
         tbvINla58jbqpG1hEWXfaQKIS1NEDFOAYJVzNipxKmUMGBpv6eNCT2UQwizo9SuvKusS
         OUOw==
X-Gm-Message-State: APjAAAWHU7ZYGr4nLL+d+Hcx276HTSkd+QVMkV8cVurBIBUNxWheQwnW
        hcGATpZ+w86QJ5PcpBTlBWQ5Mt2Gke8emzmpb3QvtJDzBG6aiIyczySBeCkOoQWagJhad0Tn2ku
        LuYQrVWMeRWL49rBNfiCLSi+GVr1u8Lim340k7YHFpUsTJNaKgjQzEraCbCyxkCAbzfiXFRnkUi
        E1LTSlMw+lH3k43aJI/ZE=
X-Google-Smtp-Source: APXvYqzj+8o+K2xMYgSAvphch1vtsMyLLxJF5a4rIwccSOhZTEy5/Xlo/Z1bRm0oeq8WzJcoO7z9o611UCPt5wFN/4oenA==
X-Received: by 2002:a63:5b5c:: with SMTP id l28mr15268814pgm.158.1558129169103;
 Fri, 17 May 2019 14:39:29 -0700 (PDT)
Date:   Fri, 17 May 2019 14:39:17 -0700
In-Reply-To: <20190517213918.26045-1-matthewgarrett@google.com>
Message-Id: <20190517213918.26045-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517213918.26045-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V6 3/4] tpm: Append the final event log to the TPM event log
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

Any events that are logged after GetEventsLog() is called are logged to
the EFI Final Events table. These events are defined as being in the
crypto agile log format, so we can just append them directly to the
existing log if it's in the same format. In theory we can also construct
old-style SHA1 log entries for devices that only return logs in that
format, but EDK2 doesn't generate the final event log in that case so
it doesn't seem worth it at the moment.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/eventlog/efi.c | 50 ++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 3e673ab22cb4..9179cf6bdee9 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -21,10 +21,13 @@
 int tpm_read_log_efi(struct tpm_chip *chip)
 {
 
+	struct efi_tcg2_final_events_table *final_tbl = NULL;
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct tpm_bios_log *log;
 	u32 log_size;
 	u8 tpm_log_version;
+	void *tmp;
+	int ret;
 
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
@@ -52,15 +55,48 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 
 	/* malloc EventLog space */
 	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
-	if (!log->bios_event_log)
-		goto err_memunmap;
-	log->bios_event_log_end = log->bios_event_log + log_size;
+	if (!log->bios_event_log) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
+	log->bios_event_log_end = log->bios_event_log + log_size;
 	tpm_log_version = log_tbl->version;
-	memunmap(log_tbl);
-	return tpm_log_version;
 
-err_memunmap:
+	ret = tpm_log_version;
+
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
+	    efi_tpm_final_log_size == 0 ||
+	    tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+		goto out;
+
+	final_tbl = memremap(efi.tpm_final_log,
+			     sizeof(*final_tbl) + efi_tpm_final_log_size,
+			     MEMREMAP_WB);
+	if (!final_tbl) {
+		pr_err("Could not map UEFI TPM final log\n");
+		kfree(log->bios_event_log);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tmp = krealloc(log->bios_event_log,
+		       log_size + efi_tpm_final_log_size,
+		       GFP_KERNEL);
+	if (!tmp) {
+		kfree(log->bios_event_log);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	log->bios_event_log = tmp;
+	memcpy((void *)log->bios_event_log + log_size,
+	       final_tbl->events, efi_tpm_final_log_size);
+	log->bios_event_log_end = log->bios_event_log +
+		log_size + efi_tpm_final_log_size;
+
+out:
+	memunmap(final_tbl);
 	memunmap(log_tbl);
-	return -ENOMEM;
+	return ret;
 }
-- 
2.21.0.1020.gf2820cf01a-goog

