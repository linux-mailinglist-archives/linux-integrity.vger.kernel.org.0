Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC351D31CE
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENNvv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 09:51:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56326 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgENNvu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 09:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589464308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efjaVrgMBOavtCD7eQNlqVJMXGEwbv20kGqzKX/uDEI=;
        b=SvKpDCu+NxCsrxauhm/mu+PmIjpOPVIZ0dQxgl1qc384i7y1xaF0ZXq3clMk79/1MA55bw
        r+pLhjyl88XvYSMG1owC9jw8TCvnPltVNIjmKQX9JTBRqnBD9drIY+PNjrTs4Ozkp5LAYQ
        KyJJyt2mmFS2qIg4fND89RFOzxdBZzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-4nOMim8INH61yc1wEOcL4g-1; Thu, 14 May 2020 09:51:47 -0400
X-MC-Unique: 4nOMim8INH61yc1wEOcL4g-1
Received: by mail-wm1-f70.google.com with SMTP id k17so4174984wmi.4
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 06:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efjaVrgMBOavtCD7eQNlqVJMXGEwbv20kGqzKX/uDEI=;
        b=kETbK4sZLL3MjOoCXr0A9Ii5iyaanTuLN3IKGEIODWhkv3OVEAdGsGbgdIR33IQ26n
         u449KmPo9dtSVwgDNxIy3OZqtLCVOXM/2BCtzQ1IZFjxPk7BnNiYjUyfrTio/UF+hOvP
         tZpgRAGhGvgdbehFgC/Z+OOqcXqXYf+syd9cJfCcECLJxFMIMaJaRn+EkWhlbvCrMoX5
         MkjRCQkkDpms575AsLnGQpN7zPEtEZIkwp5nqOoKwuAokWXMgFPve2A3jzCqlZHHqsv+
         VuIGXmHzvvzljEg0j6NVyhwdsd7YTjH694Rn4qWtrzgaA96WxSndBpZbjdbv7DV1Jsw/
         2gKg==
X-Gm-Message-State: AOAM5317Zc29hZJZKwgwOq0cNmUOxrX9pvM/aaZYK47moLTgVUo8rEVf
        TkyH8ty2y8Ay9vOf8HVoMIMvE+nlkAyN+dDcBV0Lc68LOM/Psfmy2LAc87NSmqtazlPvTeYt/L4
        PCcyUiaYED+uE5JxewOAvAVQ696tZ
X-Received: by 2002:adf:c508:: with SMTP id q8mr5360650wrf.4.1589464305020;
        Thu, 14 May 2020 06:51:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye1Qfo71M6H8Dj93MK9d23hfv1t0aHOb9vA4ScEg1DRVfmR8/wA/U+EkSlNRglkF1evbhAkQ==
X-Received: by 2002:adf:c508:: with SMTP id q8mr5360633wrf.4.1589464304811;
        Thu, 14 May 2020 06:51:44 -0700 (PDT)
Received: from ?IPv6:2a01:c50f:ab80:6700:527f:85b3:5615:ff0b? ([2a01:c50f:ab80:6700:527f:85b3:5615:ff0b])
        by smtp.gmail.com with ESMTPSA id a15sm3984912wrw.56.2020.05.14.06.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 06:51:43 -0700 (PDT)
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?UTF-8?Q?Lo=c3=afc_Yhuel?= <loic.yhuel@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
 <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
 <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
 <29fb28c4-9642-0265-a926-455377066b75@redhat.com>
 <CAMj1kXHFKajuvd5KkrQTozebKzaO1LaMQdd37unLs_dGR0UwVg@mail.gmail.com>
 <789b40ad-3017-b2cc-df15-d2739787d05e@redhat.com>
 <CAMj1kXFs6Z8VwqRMHf_OOZct4xNnNqiVOGBO0TtLfirg7WX8Eg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <9ebd9e60-12dd-a6df-923c-dc9c6dbd709b@redhat.com>
Date:   Thu, 14 May 2020 15:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFs6Z8VwqRMHf_OOZct4xNnNqiVOGBO0TtLfirg7WX8Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/14/20 3:04 PM, Ard Biesheuvel wrote:
> On Thu, 14 May 2020 at 14:56, Javier Martinez Canillas

[snip]

>>
>> I still don't know if something like that would be acceptable or if we
>> should just consider a bug if a firmware doesn't conform with the spec.
>>
> 
> I'd like Matt's and Jarkko's take on this - for me, considering it a
> bug is just fine. I just want to understand what exactly to warn
> about, since we currently silently ignore the lack of a final events
> table, while it apparently defeats the purpose of having a log in the
> first.
>
> So given that the ordinary event log will contain everything *except*
> the events that were logged during EBS(), I agree that the log may
> still be useful if those final events only affected PCRs that you
> don't care about.
>

Agreed.

> Something like the below perhaps? Should we suppress the warning for
> tables of size 0x0?
>

That's what is not clear to me. For example, if a firmware follows the
spec what happens during EBS() when a TPM2 only supports the SHA-1 format?

Does the firmware always log events during EBS() even when it won't provide
a Final Events Table? If so, are the SHA-1 logs always incomplete?

What I wonder is if the firmware bug error should always be printed if the
crypto agile log format isn't used or only if isn't used and the firmware
provides a Final Events Table, which is a behavior that's out of the spec.

> diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
> index 6bb023de17f1..65bfee8e636d 100644
> --- a/drivers/char/tpm/eventlog/efi.c
> +++ b/drivers/char/tpm/eventlog/efi.c
> @@ -62,8 +62,10 @@ int tpm_read_log_efi(struct tpm_chip *chip)
> 
>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
>             efi_tpm_final_log_size == 0 ||
> -           tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> +           tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> +               pr_warn(FW_BUG "TPM Final Event table not found - some
> events may be missing\n");

Maybe mentioning that the missing logs are for events that happen during EBS()?

>                 goto out;
> +       }
> 
>         final_tbl = memremap(efi.tpm_final_log,
>                              sizeof(*final_tbl) + efi_tpm_final_log_size,
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

