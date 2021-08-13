Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4EE3EB235
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbhHMIG1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbhHMIGS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 04:06:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460F7C0617AD;
        Fri, 13 Aug 2021 01:05:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h11so14482963ljo.12;
        Fri, 13 Aug 2021 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2LYg1yU9oJXc34vTl4ZsDQidrbUH8kwt1gvllnHU3c=;
        b=ervkKIo5zGiVW0JJbCNPMpCkKm4cHcoUFYGrOWL23uyI1ypDwLV9PtMI32eBre6/HE
         CtDV5pAUGovYhwOhMTWrLmN4/nSTQypCd7qxiTdWGFAvX34tJxxDUalWNrB+3Rzdbd+p
         wWAiwLq80rsCas4A+YkhqpWOyMDEy/08yDXXr6wuT47+VVE3Tkb8GWLcWJvdFq1X3oyn
         IgE4XvTS1Y5oC3NiNPnY/5dE0x216z/wrFQl0xn10xPKvwV8gE07MthgG5xLLWNLq8Lx
         KhWbNdhqkTF7rMzZRgV6srk/RdSRr7Pbb514DRfpldlBaM4T1tSJhMG9zhuV0ltywj5l
         24uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2LYg1yU9oJXc34vTl4ZsDQidrbUH8kwt1gvllnHU3c=;
        b=fdcIOQQ8EaziYJT6YPJ3EC1Okgb92rlOVCtQCy8iW6yWrCzEJ6/M+nA0UnaXuNJGxh
         ksygogLgcGRBqif9Ye+TWyr+ZqSg3v8xBWFxSBC7B+9DyysOkAm7jO/WV0wGqx0SFUjW
         g65Yg1FtE7uC35BEDZeszNZewfAZ3oiwowOaZwXRfufvuCQmho/q0ZJjsxAG6WzEyPBf
         zYviEuuMkvN9naVmKoMXeQLvOu8kUnnjMoruOyzQv2QonEMEIp1KxB33K11MLtFLu9Dz
         4odVXc2ZpUTq+mwUYqGQ4XE35rRWKyJ/w1t8qneQyGZsGgoltbKrAdxIwRMltz09DarT
         obWw==
X-Gm-Message-State: AOAM530FtHnOwiwaWg+Lk5EebIWJ5dI0WNxeetjA4Oy3yrga5Cxdgod6
        Tz1ojHdvG0JiGupEXLADrVDf7pB1/WdiJk/uC/A=
X-Google-Smtp-Source: ABdhPJyELgF06GLVF/1Wx21RO5Js6IyFg79WrEbUybL3dh4VDK7y9GSgIsPSomyZRdPmzfIpvsitx4rBpGuagIRJ4NM=
X-Received: by 2002:a2e:a40a:: with SMTP id p10mr951513ljn.264.1628841907555;
 Fri, 13 Aug 2021 01:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru> <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <CAEUiM9PRv+WhALQb-1im2_oZzAOvWzrMFrgn5xX9sU1K6DJ6+w@mail.gmail.com> <7642c670-55d9-9c30-40a9-15aba27503da@viveris.fr>
In-Reply-To: <7642c670-55d9-9c30-40a9-15aba27503da@viveris.fr>
From:   Igor Zhbanov <izh1979@gmail.com>
Date:   Fri, 13 Aug 2021 11:05:01 +0300
Message-ID: <CAEUiM9MCWyRTZyuV1KGDamib34Z0r_vJUWasVGb8wLFH04ynqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
To:     THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

> Yes, what I meant was that maybe you could just declare it at the beginning of the function,
> and not use it at all in the sysctl table. Because as I see it, you only use allowed_caps_hex in the sysctl
> table to copy the string to that temporary (variable), and its use is limited to that one function.
>
> Instead of:
>
> +               if ((error = proc_dostring(table, write, buffer, lenp, ppos)))
> +                       return error;
...
> You could probably get away with something like:
...
>+       strncpy(allowed_caps_hex, buffer, ALLOWED_CAPS_HEX_LEN + 1);

proc_dostring() is more than simple strncpy(). It is handling offsets too.
I.e. if a user will try to write not from the starting position. But
I've seen that some
functions simply create an instance of struct ctl_table, fill it and
call needed function.

Thanks.
