Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC231D2FB1
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgENM26 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 08:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENM26 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 08:28:58 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F3020734
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589459336;
        bh=LublLW5V70u4VL/HwQ23bC7aUgA/qOoEt8EUhKO0uUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CsMRbKHDoM8Ax6JkTXQ1o+M00AkzzLB7x8CKpcRyD0t93wSwhu43709F2f1YyGXls
         2icjuFKtrKQBFIOFhEufrJt2T04O/74EvTMdlFpCenntL4cgsecoMpxAUaU7cWyjKJ
         d2YyhVhiwUxDj2I9yHOiNXyDqM/L3jODTbMr2vYE=
Received: by mail-io1-f48.google.com with SMTP id x5so192517ioh.6
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 05:28:56 -0700 (PDT)
X-Gm-Message-State: AOAM530bRdjgz4Z1nL92HK6jZs7g/4D2n+edSYN+5/kA4ukN16l4SaxC
        yoVTiA0KHdJMBw7E7LZygOAFiCghBvK/1xWAKgA=
X-Google-Smtp-Source: ABdhPJzMIYY2trcECno64MDB46AnYaqNYqF3Y/FuOmK+oAIfbr008KPGJVyg87Sv7mMe6Jt5zxYeKu6wc3OIJtq1vOY=
X-Received: by 2002:a6b:5008:: with SMTP id e8mr3829472iob.161.1589459336166;
 Thu, 14 May 2020 05:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
 <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com> <29fb28c4-9642-0265-a926-455377066b75@redhat.com>
In-Reply-To: <29fb28c4-9642-0265-a926-455377066b75@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 May 2020 14:28:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHFKajuvd5KkrQTozebKzaO1LaMQdd37unLs_dGR0UwVg@mail.gmail.com>
Message-ID: <CAMj1kXHFKajuvd5KkrQTozebKzaO1LaMQdd37unLs_dGR0UwVg@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 14 May 2020 at 13:33, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Lo=C3=AFc,
>
> On 5/14/20 1:28 PM, Lo=C3=AFc Yhuel wrote:
> > Le jeu. 14 mai 2020 =C3=A0 12:54, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> a =C3=A9crit :
> >> So it is clear that "pr_warn(FW_BUG ..." would be a sane to have there=
.
> > So only to tell the UEFI might have logged events the kernel can't read=
 ?
> > There is no warning if the table is missing, which would have the same =
result.
> >
> > I can try to dump it, perhaps it is using the SHA-1 log format.
> > If so, would a patch to support this non-standard behavior be accepted =
?
> >
>
> I was thinking the same and wrote the following (untested) patch that sho=
uld
> expose the logs from this Final Events Table that is not following the sp=
ec.
>
> From a08ec2b99b62b3ce97c0906527d5d11f41c255a6 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javierm@redhat.com>
> Date: Thu, 14 May 2020 13:29:42 +0200
> Subject: [RFC PATCH] tpm: Append logs from the Final Events table also fo=
r SHA1
>  format
>
> The Final Events Table contains the logs for any events that are triggere=
d
> by ExitBootServices().

This is inaccurate afaik. The final events table contains all events
that were logged since the first call to Tcg2::GetEventLog()

> According to the TCG EFI Protocol Specification the
> table will only contains log entries using the crypto agile log format.
>
> But some EFI firmwares seems to expose a Final Events Table even when the
> SHA-1 log format is used. This is not supported according to the TCG spec=
,
> but there is also no other way to get a complete TPM event log for SHA-1
> if ExitBootServices() extends PCR5.
>
> Currently the kernel only queries for the Final Events Log when using the
> crypto agile log format, which is the correct behaviour to be compliant
> with the spec. But since there are firmwares that provide the table even
> for the SHA-1 log format, attempt to get it and append the final logs to
> the TPM event log that is exposed to user-space.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/char/tpm/eventlog/efi.c    |  3 +--
>  drivers/firmware/efi/libstub/tpm.c | 18 ++++++++++++------
>  drivers/firmware/efi/tpm.c         | 21 +++++++++++++++------
>  3 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/=
efi.c
> index 6bb023de17f..4a8200c9445 100644
> --- a/drivers/char/tpm/eventlog/efi.c
> +++ b/drivers/char/tpm/eventlog/efi.c
> @@ -61,8 +61,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>         ret =3D tpm_log_version;
>
>         if (efi.tpm_final_log =3D=3D EFI_INVALID_TABLE_ADDR ||
> -           efi_tpm_final_log_size =3D=3D 0 ||
> -           tpm_log_version !=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> +           efi_tpm_final_log_size =3D=3D 0)
>                 goto out;
>
>         final_tbl =3D memremap(efi.tpm_final_log,
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/li=
bstub/tpm.c
> index e9a684637b7..ba9d3ac2e19 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -127,10 +127,9 @@ void efi_retrieve_tpm2_eventlog(void)
>          * Figure out whether any events have already been logged to the
>          * final events structure, and if so how much space they take up
>          */
> -       if (version =3D=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> -               final_events_table =3D get_efi_config_table(LINUX_EFI_TPM=
_FINAL_LOG_GUID);
> +       final_events_table =3D get_efi_config_table(LINUX_EFI_TPM_FINAL_L=
OG_GUID);
>         if (final_events_table && final_events_table->nr_events) {
> -               struct tcg_pcr_event2_head *header;
> +               void *header;
>                 int offset;
>                 void *data;
>                 int event_size;
> @@ -142,9 +141,16 @@ void efi_retrieve_tpm2_eventlog(void)
>
>                 while (i > 0) {
>                         header =3D data + offset + final_events_size;
> -                       event_size =3D __calc_tpm2_event_size(header,
> -                                                  (void *)(long)log_loca=
tion,
> -                                                  false);
> +                       if (version =3D=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_=
2) {
> +                               event_size =3D __calc_tpm2_event_size(hea=
der,
> +                                               (void *)(long)log_locatio=
n,
> +                                                                   false=
);
> +                       } else {
> +                               struct tcpa_event *event =3D
> +                                       (struct tcpa_event *)header;
> +                               event_size =3D sizeof(*event) + event->ev=
ent_size;
> +                       }
> +
>                         final_events_size +=3D event_size;
>                         i--;
>                 }
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 77e101a395e..0962d566481 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -16,14 +16,24 @@
>  int efi_tpm_final_log_size;
>  EXPORT_SYMBOL(efi_tpm_final_log_size);
>
> -static int __init tpm2_calc_event_log_size(void *data, int count, void *=
size_info)
> +static int __init tpm2_calc_event_log_size(void *data, int count,
> +                                          struct linux_efi_tpm_eventlog =
*log)
>  {
> -       struct tcg_pcr_event2_head *header;
> +       void *header;
>         int event_size, size =3D 0;
> +       struct tcpa_event *event;
>
>         while (count > 0) {
>                 header =3D data + size;
> -               event_size =3D __calc_tpm2_event_size(header, size_info, =
true);
> +               if (log->version =3D=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) =
{
> +                       event_size =3D __calc_tpm2_event_size(header,
> +                                                           (void *)log->=
log,
> +                                                           true);
> +               } else {
> +                       event =3D (struct tcpa_event *)header;
> +                       event_size =3D sizeof(*event) + event->event_size=
;
> +               }
> +
>                 if (event_size =3D=3D 0)
>                         return -1;
>                 size +=3D event_size;
> @@ -62,8 +72,7 @@ int __init efi_tpm_eventlog_init(void)
>         tbl_size =3D sizeof(*log_tbl) + log_tbl->size;
>         memblock_reserve(efi.tpm_log, tbl_size);
>
> -       if (efi.tpm_final_log =3D=3D EFI_INVALID_TABLE_ADDR ||
> -           log_tbl->version !=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> +       if (efi.tpm_final_log =3D=3D EFI_INVALID_TABLE_ADDR)
>                 goto out;
>
>         final_tbl =3D early_memremap(efi.tpm_final_log, sizeof(*final_tbl=
));
> @@ -84,7 +93,7 @@ int __init efi_tpm_eventlog_init(void)
>
>                 tbl_size =3D tpm2_calc_event_log_size(events,
>                                                     final_tbl->nr_events,
> -                                                   log_tbl->log);
> +                                                   log_tbl);
>         }
>
>         if (tbl_size < 0) {
> --
> 2.26.2
>
> Best regards,
> --
> Javier Martinez Canillas
> Software Engineer - Desktop Hardware Enablement
> Red Hat
>
