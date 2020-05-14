Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53E81D2E60
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENLdd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:33:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbgENLdc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589456010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2g8xrqpnBtZg1yEipPkcil9Ez0ybDcEwF2eaj66C9Vc=;
        b=G0GbdAP9GnbhQn/lwsP+oNMDl7UtctAAyNMw2iPgg/UQqlTWBq76VpDgoPSHAh5geQbu/4
        YWlqQ44vkyd+b15r4H9tILQ9sN1KKrms9X0simjXTNz8VSEnM2gcl41TYAxOWHW4d8BLjI
        eLMFGolCPOxVh9wFolxOJczV6/zmXKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-gETNiqYlPUudHB4cqL0sbg-1; Thu, 14 May 2020 07:33:28 -0400
X-MC-Unique: gETNiqYlPUudHB4cqL0sbg-1
Received: by mail-wm1-f71.google.com with SMTP id n124so357944wma.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 04:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2g8xrqpnBtZg1yEipPkcil9Ez0ybDcEwF2eaj66C9Vc=;
        b=NpvUpePMP+GfKPwVaYwSG1i1uo3Ulyo5l++p5bT9F3SPt9bgXroDh+Qk8nC31g4nck
         41+yWPcc/RGGHKp4NwdV7o/gn7vc3T/B24p68JG+x9dpYZT+rt9XiSFs7O3oMnh8v+PV
         Bjng+U+AdmHe6Ft+Ibt8p7bkKVzbR/GFyElxwglDa2f0xoDfjxiv0iHG2H3FAn31Uxoy
         9uXSEn7z89AP+3Q/FUtnA7dez3Dy/qtwcXHbZhA+516mY31OuIBjRC9gr05UZBIRP+zE
         Bm87YmAkCzrBOAuLfpPLhJGoVvn1bHi6eWVCOLz6gWJJ2g7KTVTzXFIKcm78LrpIZx0H
         TWfg==
X-Gm-Message-State: AGi0PuYn7Een9gdw4YSao925xYEh6bhLbpw0CCGre5o5Uh+DhBijkd1o
        eu/F9sclfkdoZVF3V46PMLtLZrpZhHmQnF+xI8mPGZcH+/gTfyhC792Xij5zNDjKsW2WZiSm1oF
        V6MZUv1C6Fj8OpAZctXKmw8EFOA/t
X-Received: by 2002:a7b:c413:: with SMTP id k19mr22196327wmi.124.1589456007211;
        Thu, 14 May 2020 04:33:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypKSA61mh33hpVAOC1brJkMUy8uokt2zP/EYoEz71EIbFd3gKs9Rp40tA03od660Vs6zwVFrOA==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr22196313wmi.124.1589456006930;
        Thu, 14 May 2020 04:33:26 -0700 (PDT)
Received: from ?IPv6:2a01:c50f:ab80:6700:527f:85b3:5615:ff0b? ([2a01:c50f:ab80:6700:527f:85b3:5615:ff0b])
        by smtp.gmail.com with ESMTPSA id v126sm11268861wmb.4.2020.05.14.04.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 04:33:26 -0700 (PDT)
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     =?UTF-8?Q?Lo=c3=afc_Yhuel?= <loic.yhuel@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
 <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
 <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <29fb28c4-9642-0265-a926-455377066b75@redhat.com>
Date:   Thu, 14 May 2020 13:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Loïc,

On 5/14/20 1:28 PM, Loïc Yhuel wrote:
> Le jeu. 14 mai 2020 à 12:54, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> a écrit :
>> So it is clear that "pr_warn(FW_BUG ..." would be a sane to have there.
> So only to tell the UEFI might have logged events the kernel can't read ?
> There is no warning if the table is missing, which would have the same result.
> 
> I can try to dump it, perhaps it is using the SHA-1 log format.
> If so, would a patch to support this non-standard behavior be accepted ?
>

I was thinking the same and wrote the following (untested) patch that should
expose the logs from this Final Events Table that is not following the spec.

From a08ec2b99b62b3ce97c0906527d5d11f41c255a6 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 14 May 2020 13:29:42 +0200
Subject: [RFC PATCH] tpm: Append logs from the Final Events table also for SHA1
 format

The Final Events Table contains the logs for any events that are triggered
by ExitBootServices(). According to the TCG EFI Protocol Specification the
table will only contains log entries using the crypto agile log format.

But some EFI firmwares seems to expose a Final Events Table even when the
SHA-1 log format is used. This is not supported according to the TCG spec,
but there is also no other way to get a complete TPM event log for SHA-1
if ExitBootServices() extends PCR5.

Currently the kernel only queries for the Final Events Log when using the
crypto agile log format, which is the correct behaviour to be compliant
with the spec. But since there are firmwares that provide the table even
for the SHA-1 log format, attempt to get it and append the final logs to
the TPM event log that is exposed to user-space.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/char/tpm/eventlog/efi.c    |  3 +--
 drivers/firmware/efi/libstub/tpm.c | 18 ++++++++++++------
 drivers/firmware/efi/tpm.c         | 21 +++++++++++++++------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 6bb023de17f..4a8200c9445 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -61,8 +61,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	ret = tpm_log_version;
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
-	    efi_tpm_final_log_size == 0 ||
-	    tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+	    efi_tpm_final_log_size == 0)
 		goto out;
 
 	final_tbl = memremap(efi.tpm_final_log,
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index e9a684637b7..ba9d3ac2e19 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -127,10 +127,9 @@ void efi_retrieve_tpm2_eventlog(void)
 	 * Figure out whether any events have already been logged to the
 	 * final events structure, and if so how much space they take up
 	 */
-	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
-		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
+	final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
-		struct tcg_pcr_event2_head *header;
+		void *header;
 		int offset;
 		void *data;
 		int event_size;
@@ -142,9 +141,16 @@ void efi_retrieve_tpm2_eventlog(void)
 
 		while (i > 0) {
 			header = data + offset + final_events_size;
-			event_size = __calc_tpm2_event_size(header,
-						   (void *)(long)log_location,
-						   false);
+			if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+				event_size = __calc_tpm2_event_size(header,
+						(void *)(long)log_location,
+								    false);
+			} else {
+				struct tcpa_event *event =
+					(struct tcpa_event *)header;
+				event_size = sizeof(*event) + event->event_size;
+			}
+
 			final_events_size += event_size;
 			i--;
 		}
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 77e101a395e..0962d566481 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -16,14 +16,24 @@
 int efi_tpm_final_log_size;
 EXPORT_SYMBOL(efi_tpm_final_log_size);
 
-static int __init tpm2_calc_event_log_size(void *data, int count, void *size_info)
+static int __init tpm2_calc_event_log_size(void *data, int count,
+					   struct linux_efi_tpm_eventlog *log)
 {
-	struct tcg_pcr_event2_head *header;
+	void *header;
 	int event_size, size = 0;
+	struct tcpa_event *event;
 
 	while (count > 0) {
 		header = data + size;
-		event_size = __calc_tpm2_event_size(header, size_info, true);
+		if (log->version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+			event_size = __calc_tpm2_event_size(header,
+							    (void *)log->log,
+							    true);
+		} else {
+			event = (struct tcpa_event *)header;
+			event_size = sizeof(*event) + event->event_size;
+		}
+
 		if (event_size == 0)
 			return -1;
 		size += event_size;
@@ -62,8 +72,7 @@ int __init efi_tpm_eventlog_init(void)
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
-	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
 		goto out;
 
 	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
@@ -84,7 +93,7 @@ int __init efi_tpm_eventlog_init(void)
 
 		tbl_size = tpm2_calc_event_log_size(events,
 						    final_tbl->nr_events,
-						    log_tbl->log);
+						    log_tbl);
 	}
 
 	if (tbl_size < 0) {
-- 
2.26.2

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

