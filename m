Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07CB1D30A1
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 15:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgENNEi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 09:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgENNEh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 09:04:37 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F7320748
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589461477;
        bh=Rbpqw4q9YQgTkPxJMMGrLnrCBwb928GEfYREah7lFfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tOP3kNgJAP1oHgsdpqFxABr4mVFhQNXVOr8Uj0f4IG3PuQsX1Zf/xc0tP3fFjilDi
         iojeijRsqTLJVOw6Jtjq9zONgYef5DbObZA4fM62j/uU69AXM5zpB3EzzTmgnD++Nw
         fOZJMQBH8R07BycJG6uMararVXndbfr0G5SK5POo=
Received: by mail-il1-f170.google.com with SMTP id j2so638099ilr.5
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 06:04:37 -0700 (PDT)
X-Gm-Message-State: AOAM5319bz+VVRn8ym0tDPr7CXDjmmZWVK1MGeOqv0ZqJQAYxz2fKOWz
        b0h5TWCH2t3i4M9M7CwsuQUSGDNeE2Rj3CcHBSU=
X-Google-Smtp-Source: ABdhPJwFjYeeA5K6j1xF/B2ekQ+AX0cI3irLgGBLARh87YjDQFTaHoFlks/W88U+ou4Rkh08jog8XWdGSXu2k4r8RWI=
X-Received: by 2002:a92:8555:: with SMTP id f82mr4317839ilh.279.1589461476743;
 Thu, 14 May 2020 06:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
 <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
 <29fb28c4-9642-0265-a926-455377066b75@redhat.com> <CAMj1kXHFKajuvd5KkrQTozebKzaO1LaMQdd37unLs_dGR0UwVg@mail.gmail.com>
 <789b40ad-3017-b2cc-df15-d2739787d05e@redhat.com>
In-Reply-To: <789b40ad-3017-b2cc-df15-d2739787d05e@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 May 2020 15:04:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFs6Z8VwqRMHf_OOZct4xNnNqiVOGBO0TtLfirg7WX8Eg@mail.gmail.com>
Message-ID: <CAMj1kXFs6Z8VwqRMHf_OOZct4xNnNqiVOGBO0TtLfirg7WX8Eg@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 14 May 2020 at 14:56, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Ard,
>
> On 5/14/20 2:28 PM, Ard Biesheuvel wrote:
> > On Thu, 14 May 2020 at 13:33, Javier Martinez Canillas
>
> [snip]
>
> >>
> >> The Final Events Table contains the logs for any events that are triggered
> >> by ExitBootServices().
> >
> > This is inaccurate afaik. The final events table contains all events
> > that were logged since the first call to Tcg2::GetEventLog()
> >
>
> Yes, you are correct. After the first call to GetEventLog(), all events
> are logged in both the event log and the Final Events Table IIUC.
>
> But what I tried to say is that only the Final Events Table can be used to
> obtain the logs for the events triggered by ExitBootServices(). I'll try
> to make it more clear if I post this as a proper patch.
>
> I still don't know if something like that would be acceptable or if we
> should just consider a bug if a firmware doesn't conform with the spec.
>

I'd like Matt's and Jarkko's take on this - for me, considering it a
bug is just fine. I just want to understand what exactly to warn
about, since we currently silently ignore the lack of a final events
table, while it apparently defeats the purpose of having a log in the
first.

So given that the ordinary event log will contain everything *except*
the events that were logged during EBS(), I agree that the log may
still be useful if those final events only affected PCRs that you
don't care about.

Something like the below perhaps? Should we suppress the warning for
tables of size 0x0?

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 6bb023de17f1..65bfee8e636d 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -62,8 +62,10 @@ int tpm_read_log_efi(struct tpm_chip *chip)

        if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
            efi_tpm_final_log_size == 0 ||
-           tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+           tpm_log_version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+               pr_warn(FW_BUG "TPM Final Event table not found - some
events may be missing\n");
                goto out;
+       }

        final_tbl = memremap(efi.tpm_final_log,
                             sizeof(*final_tbl) + efi_tpm_final_log_size,
