Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215C61C08F7
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgD3VPY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 17:15:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47725 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbgD3VPX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 17:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588281321;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Gpgo8QhStYUhDPmOT7znh0qOxQgcHTQeTAkj6k74Xck=;
        b=PnIOo7UDLGhEyKckUeVzoFRUYhig4DHPOdd4KhUWTKAKkyqhS6/pBKCCC6H40eXYQkf/rA
        2VK9YkHSLR65D4XTkVygk6HtwnJg4utbKb2Nk5hbg98WesPxw15rdVXYBfhrAPy4v9jFsa
        DlzVik4NazzP+0SPupDvzfLJD/6Cv3k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-bl7zWQo7OKiOoS11DJ_lMw-1; Thu, 30 Apr 2020 17:15:20 -0400
X-MC-Unique: bl7zWQo7OKiOoS11DJ_lMw-1
Received: by mail-qk1-f198.google.com with SMTP id y64so7843253qkb.12
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 14:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Gpgo8QhStYUhDPmOT7znh0qOxQgcHTQeTAkj6k74Xck=;
        b=UedevOnHc/c5ogKWdtomlFj9bk0pKbw6/QfbdjZBUu4SEezhSX74L2L6DXtZoVgLlF
         dgOY4SHmQ8zr4SMUIYF6W+UDn9Tj3c3ERUxo5neXq3HfiNRdxYqAtczAzF5ugnw6gevC
         FV6NkWdJqMPqTEzcViRC3gBKlvSu6qBhIRdZp2Jb+WwU2Im7xGVs7aClB7r4ML+LsGcr
         RMk2rL+VEmlg3BS78C5jjuM2KEM+6vkoclfsPiSYaRQTkv5rY6zFa0M2809Ist5P/LaH
         F6UqDKZmDDx0yEYG6UjON/sS2NDi9AnVCLAZTKT2Phw7sJXGE+w76ly1Z7ezspJyhNpo
         JlcQ==
X-Gm-Message-State: AGi0PualbAliKznrp5t6vJEVUMpBJotFvFEoP+p+d/gWFK+mzRnjgJ70
        TWxnwJsxmKmV/GkMCKSUH/xOoVojUj1srP1tktphapYAqZBY1IfJWtSEa6walcDN9oWf9Lnx+zg
        nJVeL5h25S6CA5K9/P8LcjyG5Fekg
X-Received: by 2002:a37:9b0f:: with SMTP id d15mr557179qke.62.1588281319660;
        Thu, 30 Apr 2020 14:15:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypK47/YxDMcJQ0hvZtrevVhbt6vQJ5blpDkAeoLIO/G7QMniCYPHE7M/pzWYGebnwVKPPApSsA==
X-Received: by 2002:a37:9b0f:: with SMTP id d15mr557149qke.62.1588281319422;
        Thu, 30 Apr 2020 14:15:19 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h6sm766622qtd.79.2020.04.30.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:15:18 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:15:16 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/tpm: fix section mismatch warning
Message-ID: <20200430211516.gkwaefjrzj2dypmr@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200429190119.43595-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200429190119.43595-1-arnd@arndb.de>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Apr 29 20, Arnd Bergmann wrote:
>Building with gcc-10 causes a harmless warning about a section mismatch:
>
>WARNING: modpost: vmlinux.o(.text.unlikely+0x5e191): Section mismatch in reference from the function tpm2_calc_event_log_size() to the function .init.text:early_memunmap()
>The function tpm2_calc_event_log_size() references
>the function __init early_memunmap().
>This is often because tpm2_calc_event_log_size lacks a __init
>annotation or the annotation of early_memunmap is wrong.
>
>Add the missing annotation.
>
>Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Minor thing, but should the Fixes be c46f3405692d ("tpm: Reserve the TPM final events table")? Or what am I missing
about e658c82be556 that causes this? Just trying to understand what I did. :)

Regards,
Jerry

>---
> drivers/firmware/efi/tpm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>index 31f9f0e369b9..55b031d2c989 100644
>--- a/drivers/firmware/efi/tpm.c
>+++ b/drivers/firmware/efi/tpm.c
>@@ -16,7 +16,7 @@
> int efi_tpm_final_log_size;
> EXPORT_SYMBOL(efi_tpm_final_log_size);
>
>-static int tpm2_calc_event_log_size(void *data, int count, void *size_info)
>+static int __init tpm2_calc_event_log_size(void *data, int count, void *size_info)
> {
> 	struct tcg_pcr_event2_head *header;
> 	int event_size, size = 0;
>-- 
>2.26.0
>

