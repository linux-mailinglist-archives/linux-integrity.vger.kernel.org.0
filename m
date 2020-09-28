Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6E27A4B3
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 02:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgI1ALb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 20:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgI1ALa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 20:11:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AEEC0613CE
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 17:11:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn7so2546682pjb.5
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A6mR5ROEJzh58GXS2N8RGbR/C2ISKi+pYWvUdSGwxxY=;
        b=H3axNa4g5JIy3ZVQDeo/tcGNFK70cpYrux2tkAUhsQ8WVrBEWk711IyOvj266rpspC
         Tn0RXIJWEwGMhd+7IH0Ree1SKUDdVvVagxY4OH5c4D0372WV35EfobADh8bDnlS80iU0
         72+E/AJizMjVDqED39ASYEPmK1CG82POlLank=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A6mR5ROEJzh58GXS2N8RGbR/C2ISKi+pYWvUdSGwxxY=;
        b=C0aQXMbvGRz5MboJhQueZx2z+rpx9ijJIfIJc3mnCm0eir9Ujg3XZZAQVbNvq4N8sA
         i+10WTXGoELlSJrIiKZgK0pQ+EIoXG8q3WNTPUJM3Jo2DafZ2w+4lz8TRVzYcSdTK1y9
         xGTYpP5EMiSrICiZJXenJVqMugwkPnq5kZPBa63xvhfgcCRjlxCZVqUq6gC+RdogPrmn
         LE5DqMdPYTauwPbSCJ+fkNcEoDLh7E8ekx4FmRq7CJGwZY8v+E7rM1LCqysJBXaCKhtN
         SAed2jVSoZ7ewvUYzramNGT4ydTWwfjbQYYeprUJohsYa8MurEoK9QCbomkCfFPvdWXP
         zENQ==
X-Gm-Message-State: AOAM532iUdfkLomBfxr/BP6jN8zUiwMWzN7Bq0AfM6dKy42ZomRtImRl
        H4lz+39eddf5hJmC97InnpVplw==
X-Google-Smtp-Source: ABdhPJy5GHn3Mi+C/fGaukQPAq4Viu45PT/y1E6IBc9tGuXBLTAs8Rqko9rY1C103E942Dzt/jP8sw==
X-Received: by 2002:a17:90a:67c7:: with SMTP id g7mr6790414pjm.42.1601251889899;
        Sun, 27 Sep 2020 17:11:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:5808:e111:eba3:c439? ([2601:647:4200:3be0:5808:e111:eba3:c439])
        by smtp.gmail.com with ESMTPSA id t12sm1065662pgk.32.2020.09.27.17.11.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 17:11:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
Date:   Sun, 27 Sep 2020 17:11:27 -0700
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

Maybe there is a misunderstanding. Here I am using tpm_msleep, not =
msleep.
tpm_msleep is using usleep underlaying. See
=
https://github.com/torvalds/linux/blob/master/drivers/char/tpm/tpm.h#L188

The reasons I choose 15ms, is because before=20
=
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
(Where msleep is changed to tpm_msleep (which is essentially usleep)),
The actual sleep time is 15ms, thus here we change this back to 15ms to =
fix
regression.

Thanks
Hao=20

> On Sep 27, 2020, at 11:25 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Sat, 2020-09-26 at 16:10 -0700, Hao Wu wrote:
>> Resending following email in plaintext.
>>=20
>> ----
>>=20
>> Hi James,
>>=20
>> Thanks for following up.
>>=20
>> We have actually tried change=20
>> TPM_TIMEOUT_USECS_MIN / TPM_TIMEOUT_USECS_MAX=20
>> according to https://patchwork.kernel.org/patch/10520247/
>> It does not solve the problem for ATMEL chip. The chips facing crash
>> is=20
>> not experimental, but happens commonly in=20
>> the production systems we and our customers are using.
>> It is widely found in Cisco 220 / 240 systems which are using
>> Ateml chips.
>=20
> Well, I came up with the values in that patch by trial and error ....
> all I know is they work for my nuvoton. If they're not right for you,
> see if you can find what values actually do work for your TPM.  The
> difference between msleep and usleep_range is that the former can have
> an indefinitely long timeout and the latter has a range bounded one.=20=

> If you think msleep works for you, the chances are it doesn't and
> you're relying on the large upper bound to make the bug infrequent
> enough for you not to see it.  Playing with the values in usleep range
> will help you find what the actual timeout is and eliminate the =
problem
> for good.
>=20
> James

