Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD548C030
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jan 2022 09:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351741AbiALIrK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jan 2022 03:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351737AbiALIrH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jan 2022 03:47:07 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E71C06173F;
        Wed, 12 Jan 2022 00:47:07 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so1740035oti.11;
        Wed, 12 Jan 2022 00:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s9uju5lktsl2BkeSmx7+Ucw5N0WQwmtf63EDu0Y/kqo=;
        b=njpeRzdd707CcSA9IsThlEC7roEZp7FrGsogWyW2y9Ok8bMD2iuN733qt7/QDI0DMr
         r+hVn9iTuE/eRvtVzYVR7x6xYj3YCxHVZI/oEw5feGVKCH8xTwsReVC2VzvTTRlVhW8+
         F1Q8BuWvTPpOo5IiRf3O2yfNPUmHBkiFnqWGgPwaGojpVVyCgNvu/X+eCYjFE5z3WQDo
         HfaUW8f+PzhQFzopdUyp5MjNWsPWP0FnByeJ8KQTcZhprfdJcGwqeoHgMCu0rA3kD9Ag
         VKkOw6XKUbQ8jayOC47toLh2MfiInEHOa7jTMN6vXmgPcchHcsQwtGgWzUk1sMtGeNhN
         hzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s9uju5lktsl2BkeSmx7+Ucw5N0WQwmtf63EDu0Y/kqo=;
        b=iUQi89sLGbRaBesBVNB4vlvoxP9PYpfppi88tabh/sPE/bN+lQMMu4+VrNEqApOy+4
         M/9ys/JRH7c1UjsRgBt70AcX44G9E0mYWsiV95W9ximhXstoBahvBBgY0lbH8C/vd9cx
         krPhHM7Huoc9uQ/MvdSPreh+IYfomAypYwKFcpJ28FhY8Z95daVR8nyXQCRiXXMvnUjt
         AKQ5ZoGIu3jBUCG4Egc+BQS1BAI1rSHWF6lbitfcz1RNQUKrKj+Vsccec3ydbMxZyGpw
         djuMoSFxrTl6VokFX9IbL30T8tID2FZ/sVdCvNzlQS6ONDMsj1Wm8EouixpJINaSpjes
         z1Lg==
X-Gm-Message-State: AOAM533BmDjBIdDLLW+ugIH1Sts/ktMSydNKBXSrIeGjfrUHI6KOQ2LP
        rPMrdXsOA1yh271HrDZVJ9GQUuICahJXWtN/bvHqbEB6
X-Google-Smtp-Source: ABdhPJynnDNRHIEDntsC5XjuiwZCFNN+RWK5Wp/x6GpTKDHklJAXFCGgujYR1FRxcQADeQd2BjHO7RIxf/V6x4KlXPE=
X-Received: by 2002:a9d:37a2:: with SMTP id x31mr1420675otb.51.1641977226796;
 Wed, 12 Jan 2022 00:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20211124214418.GA1094@raspberrypi>
In-Reply-To: <20211124214418.GA1094@raspberrypi>
From:   Austin Kim <austinkernel.kim@gmail.com>
Date:   Wed, 12 Jan 2022 17:46:56 +0900
Message-ID: <CAOoBcBWHi+UJENsfNzG2NMAjBj0RjsKSWNDaQ+++F-uL0ubAYQ@mail.gmail.com>
Subject: Re: [PATCH] ima: Fix trivial typos in the comments
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Would you take a look at this patch?
It won't take long.

BR,
Austin Kim

2021=EB=85=84 11=EC=9B=94 26=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:34,=
 Austin Kim <austindh.kim@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> There are a few minor typos in the comments. Fix these.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  security/integrity/ima/ima_api.c          | 2 +-
>  security/integrity/ima/ima_main.c         | 2 +-
>  security/integrity/ima/ima_policy.c       | 2 +-
>  security/integrity/ima/ima_template_lib.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index a64fb0130b01..5b220a2fe573 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -238,7 +238,7 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>                 goto out;
>
>         /*
> -        * Dectecting file change is based on i_version. On filesystems
> +        * Detecting file change is based on i_version. On filesystems
>          * which do not support i_version, support is limited to an initi=
al
>          * measurement/appraisal/audit.
>          */
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 8c6e4514d494..8ed6da428328 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -764,7 +764,7 @@ int ima_post_read_file(struct file *file, void *buf, =
loff_t size,
>   *           call to ima_post_load_data().
>   *
>   * Callers of this LSM hook can not measure, appraise, or audit the
> - * data provided by userspace.  Enforce policy rules requring a file
> + * data provided by userspace.  Enforce policy rules requiring a file
>   * signature (eg. kexec'ed kernel image).
>   *
>   * For permission return 0, otherwise return -EACCES.
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 320ca80aacab..ad7e19208a69 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -429,7 +429,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry =
*entry)
>         /*
>          * ima_lsm_copy_rule() shallow copied all references, except for =
the
>          * LSM references, from entry to nentry so we only want to free t=
he LSM
> -        * references and the entry itself. All other memory refrences wi=
ll now
> +        * references and the entry itself. All other memory references w=
ill now
>          * be owned by nentry.
>          */
>         ima_lsm_free_rule(entry);
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integri=
ty/ima/ima_template_lib.c
> index ca017cae73eb..5a5d462ab36d 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -272,7 +272,7 @@ static int ima_eventdigest_init_common(const u8 *dige=
st, u32 digestsize,
>          * digest formats:
>          *  - DATA_FMT_DIGEST: digest
>          *  - DATA_FMT_DIGEST_WITH_ALGO: [<hash algo>] + ':' + '\0' + dig=
est,
> -        *    where <hash algo> is provided if the hash algoritm is not
> +        *    where <hash algo> is provided if the hash algorithm is not
>          *    SHA1 or MD5
>          */
>         u8 buffer[CRYPTO_MAX_ALG_NAME + 2 + IMA_MAX_DIGEST_SIZE] =3D { 0 =
};
> --
> 2.20.1
>
