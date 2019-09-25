Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC6BE3B9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2019 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfIYRsx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Sep 2019 13:48:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54944 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfIYRsw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Sep 2019 13:48:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so6707067wmp.4
        for <linux-integrity@vger.kernel.org>; Wed, 25 Sep 2019 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebxFzT8nIL71E7fF2H7syY8mxEeNW0UnVZfk5obr57o=;
        b=JVxVCrFTteo7kL3Q/6uyAeAdJ5jibVhsw2TEqNk0TzTj7auWG4Uf/aH7smqWnJomfc
         CDUNJeF3M/kpeGdQ6+fXkLc+U4vMPNnvbqkqmh6LnYrNv6lWFWKmiLVVYNXuEuf2+uXl
         a6zz/NmbMAVwYmW3jzHqode7PLKNYs5XKkRETfTpDOo2O80oX2FOG33GuM6dbmFiT5rv
         GyaQeDrwN2ZF8uIWv7BmSlh4T/Hf75s6pWNAGiSZ6JpQMrhdGLN/VrNb2wyYQxKmmXib
         tDH3xMzpJrJ4PL9uKf4CaYu3aPY6khfDev+4zGDMqpkfFJWuN+Wvw6qZk1rmB8TcfyNT
         lsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebxFzT8nIL71E7fF2H7syY8mxEeNW0UnVZfk5obr57o=;
        b=WOM5TSjTk2JuWcD+I2dEBs4jNm3W5ssxXmN+ulpvnkp4ioR84SKQpaOhIm9BEjDnlH
         8LiRTnEIIk4oFQJm1qyw5xRW6D367jC/d6drge6XPymk95Qi2AAwx7hvkgCkRnZkj6NV
         j8VUyAvDfG9ZMprlDz3BlxAJnjYm2n5IgE7D6erUo7fV+Gr8B9X9JoEXBjq5EOKOJM9D
         OGrAY38GHQNtt6WDVM4yMY97ekz+kUGhmWRPeBlk6GQpayh10ybo7YxWxUN31RFQY3pt
         hET5kT4QNHIrx5nh0wXzEUNI4tqiMJqzpWvszv0ONhDASRjieSBJ2sUvedEyjFRlc+3j
         4ZMQ==
X-Gm-Message-State: APjAAAWnccumye104s2d5HhHdZpQCC/ppN+aXnM7sXE170Hq8W9q6gm1
        ZXV3vEQCNukL3uO1ijYCq01OvvMbhNWce1I6Q+wmrg==
X-Google-Smtp-Source: APXvYqyYALcK3m8CRmcocOzbXY3zrK/sT/SQ3+NBoFRSexJRHY7hSdwcSYHlmvCBBRp0Pb5Org/v//mZkMMDTp+qqFk=
X-Received: by 2002:a1c:2546:: with SMTP id l67mr9183119wml.10.1569433731493;
 Wed, 25 Sep 2019 10:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190925172705.17358-1-jsnitsel@redhat.com>
In-Reply-To: <20190925172705.17358-1-jsnitsel@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 19:48:39 +0200
Message-ID: <CAKv+Gu_yq_9ZZCy5d3yfV5onyoc_qc-rvdVJ2_iyYvdFS5iCOw@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: only set efi_tpm_final_log_size after successful
 event log parsing
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 25 Sep 2019 at 19:27, Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> If __calc_tpm2_event_size fails to parse an event it will return 0,
> resulting tpm2_calc_event_log_size returning -1. Currently there is
> no check of this return value, and efi_tpm_final_log_size can end up
> being set to this negative value resulting in a panic like the
> the one given below.
>
> Also __calc_tpm2_event_size returns a size of 0 when it fails
> to parse an event, so update function documentation to reflect this.
>
...
>
> The root cause of the issue that caused the failure of event parsing
> in this case is resolved by Peter Jone's patchset dealing with large
> event logs where crossing over a page boundary causes the page with
> the event count to be unmapped.
>
> Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
> Cc: linux-efi@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks Jerry, I have queued this in the efi/urgent branch.


> ---
> v3: rebase on top of Peter Jone's patchset
> v2: added FW_BUG to pr_err, and renamed label to out_calc.
>     Updated doc comment for __calc_tpm2_event_size.
>
>  drivers/firmware/efi/tpm.c   | 9 ++++++++-
>  include/linux/tpm_eventlog.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index b9ae5c6f9b9c..703469c1ab8e 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -85,11 +85,18 @@ int __init efi_tpm_eventlog_init(void)
>                                                     final_tbl->nr_events,
>                                                     log_tbl->log);
>         }
> +
> +       if (tbl_size < 0) {
> +               pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
> +               goto out_calc;
> +       }
> +
>         memblock_reserve((unsigned long)final_tbl,
>                          tbl_size + sizeof(*final_tbl));
> -       early_memunmap(final_tbl, sizeof(*final_tbl));
>         efi_tpm_final_log_size = tbl_size;
>
> +out_calc:
> +       early_memunmap(final_tbl, sizeof(*final_tbl));
>  out:
>         early_memunmap(log_tbl, sizeof(*log_tbl));
>         return ret;
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 12584b69a3f3..2dfdd63ac034 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -152,7 +152,7 @@ struct tcg_algorithm_info {
>   * total. Once we've done this we know the offset of the data length field,
>   * and can calculate the total size of the event.
>   *
> - * Return: size of the event on success, <0 on failure
> + * Return: size of the event on success, 0 on failure
>   */
>
>  static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> --
> 2.23.0
>
