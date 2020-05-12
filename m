Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8431CED2B
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgELGpJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 02:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgELGpJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 02:45:09 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283E620752
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589265909;
        bh=Ibbq3rhPEuZHzZttWYIdBD2cMJ4dRooE/97LgSRNa4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0KuZvZnpEp4zOnRhNzOoqTJg/MMAhzuHH0OCYFCm15mW3skQtYNKQ6LKMo4HNPC8s
         5ls+cDunTcgchOFRw1vfoP8UZjH4Bi/4ReLlzVHmwpg/CkRTZfkWHeZ28WlsL/cpO9
         036qAGSBZsprHVOaZfL9E3efYedZGU/gZ3JEA3VU=
Received: by mail-il1-f170.google.com with SMTP id i16so11138744ils.12
        for <linux-integrity@vger.kernel.org>; Mon, 11 May 2020 23:45:09 -0700 (PDT)
X-Gm-Message-State: AGi0Pubj0bJNk2GLcvH9dJgr0tvmmTWuM6Ges3OxYxZBL7YDZAW8vK5N
        OYuwEEYfFB2KCOLqnlaILgQ22xrzlbtvSS62Vuc=
X-Google-Smtp-Source: APiQypIjxvIGB0jbUMC3BgygJ9D5Rw03n6oLcV5uHWE3muITAmAbD5zkrk2pjKJ6h+aAoQlf/9hetfLVTf2Y/+QKdvQ=
X-Received: by 2002:a92:c948:: with SMTP id i8mr14019965ilq.258.1589265908506;
 Mon, 11 May 2020 23:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
In-Reply-To: <20200512040113.277768-1-loic.yhuel@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 May 2020 08:44:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
Message-ID: <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Cc:     linux-integrity@vger.kernel.org, matthewgarrett@google.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        javierm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lo=C3=AFc,

Thanks for the fix.

On Tue, 12 May 2020 at 06:01, Lo=C3=AFc Yhuel <loic.yhuel@gmail.com> wrote:
>
> This fixes the boot issues since 5.3 on several Dell models when the TPM
> is enabled. Depending on the exact grub binary, booting the kernel would
> freeze early, or just report an error parsing the final events log.
>
> We get an event log in the SHA-1 format, which doesn't have a
> tcg_efi_specid_event_head in the first event, and there is a final events
> table which doesn't match the crypto agile format.
> __calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
> either fails, or loops long enough for the machine to be appear frozen.
>
> So we now only parse the final events table, which is per the spec always
> supposed to be in the crypto agile format, when we got a event log in thi=
s
> format.
>

So what functionality do we lose here? Can we still make meaningful
use of the event log without the final log? I thought one was
incomplete without the other?

> Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
> Fixes: 166a2809d65b2 ("tpm: Don't duplicate events from the final event l=
og in the TCG2 log")
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779611
> Signed-off-by: Lo=C3=AFc Yhuel <loic.yhuel@gmail.com>

I can take this as a fix, but I need an ack from Matt as well.

> ---
>  drivers/firmware/efi/libstub/tpm.c | 5 +++--
>  drivers/firmware/efi/tpm.c         | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/li=
bstub/tpm.c
> index 1d59e103a2e3..e9a684637b70 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -54,7 +54,7 @@ void efi_retrieve_tpm2_eventlog(void)
>         efi_status_t status;
>         efi_physical_addr_t log_location =3D 0, log_last_entry =3D 0;
>         struct linux_efi_tpm_eventlog *log_tbl =3D NULL;
> -       struct efi_tcg2_final_events_table *final_events_table;
> +       struct efi_tcg2_final_events_table *final_events_table =3D NULL;
>         unsigned long first_entry_addr, last_entry_addr;
>         size_t log_size, last_entry_size;
>         efi_bool_t truncated;
> @@ -127,7 +127,8 @@ void efi_retrieve_tpm2_eventlog(void)
>          * Figure out whether any events have already been logged to the
>          * final events structure, and if so how much space they take up
>          */
> -       final_events_table =3D get_efi_config_table(LINUX_EFI_TPM_FINAL_L=
OG_GUID);
> +       if (version =3D=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> +               final_events_table =3D get_efi_config_table(LINUX_EFI_TPM=
_FINAL_LOG_GUID);
>         if (final_events_table && final_events_table->nr_events) {
>                 struct tcg_pcr_event2_head *header;
>                 int offset;
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 55b031d2c989..77e101a395e7 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -62,7 +62,8 @@ int __init efi_tpm_eventlog_init(void)
>         tbl_size =3D sizeof(*log_tbl) + log_tbl->size;
>         memblock_reserve(efi.tpm_log, tbl_size);
>
> -       if (efi.tpm_final_log =3D=3D EFI_INVALID_TABLE_ADDR)
> +       if (efi.tpm_final_log =3D=3D EFI_INVALID_TABLE_ADDR ||
> +           log_tbl->version !=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
>                 goto out;
>
>         final_tbl =3D early_memremap(efi.tpm_final_log, sizeof(*final_tbl=
));
> --
> 2.26.2
>
