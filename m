Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9297227DF10
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 05:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgI3Dlb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 23:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3Dla (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 23:41:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCD3C061755
        for <linux-integrity@vger.kernel.org>; Tue, 29 Sep 2020 20:41:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so229204pfd.5
        for <linux-integrity@vger.kernel.org>; Tue, 29 Sep 2020 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aedxfdaC64tTdshnyPF5puUHl4greaCvjjtAm9R6n3A=;
        b=W02bXXUYAIVCtBTj+neuMGGTc9/WvDhEF+6z52UJ8S9YeIBY8rM1M46IyZh4VA0/Zu
         vWF9IiCvGVJQt8M6qgWQU5Rs345dixjXJ25db/zHSnW5ZXqk7h8YjckHIgRza7grEj1W
         uA/kkYUOQLxUR7V7bB19ByfBGi9zns27cw9v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aedxfdaC64tTdshnyPF5puUHl4greaCvjjtAm9R6n3A=;
        b=IpiXHGS096qA9zUARWhbb32hikck3Hc0coaVz7/84oNvdMU/2aSS/U/4uEr472ZX2d
         uRj6XGtbJ1aJ9VUcNa9rlzJ/jgAPA4M82KofYxS/N/NgGX4VNELUcHvBrA5zzPxWlIUl
         rIfImIcOcwWno/ns/Kst2Pc1T39q2MyEbzbiZ0Z0t6wpvrsN9aFCzjMnS/WLi0YrOa/K
         wFVyQmKi0ifqhHypuLN4rmfyvTqZzJnZhIdOqTfIxbChr1I0K7Olf7JhhWSBIJPFCHX/
         g8vjQyMcuT5yEfp9FVtwkmhd0KgPHpPTuatQ92Zs8vtMqz0F/WISpMGCyYTHqwRccAYf
         hRAg==
X-Gm-Message-State: AOAM532v2hTOiJ/1AFJ6+lnvpKejqaC+hIzhgmGL77qjt0Yhd56cHmb3
        4GA3+R090LjTXRLTRAuTv60fpA==
X-Google-Smtp-Source: ABdhPJz0i3afj5FAXHoYpHjfXtthb6JOkgO2ghvF17y2qp0GVtxz2BUn6y/1jpJu6AN9GTXxj9k/nw==
X-Received: by 2002:a63:c74f:: with SMTP id v15mr580615pgg.143.1601437289951;
        Tue, 29 Sep 2020 20:41:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:703d:807f:b172:a799? ([2601:647:4200:3be0:703d:807f:b172:a799])
        by smtp.gmail.com with ESMTPSA id b4sm353727pjz.22.2020.09.29.20.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 20:41:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20200930021136.GD808399@linux.intel.com>
Date:   Tue, 29 Sep 2020 20:41:27 -0700
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B6A7DBB-C06B-467E-9BA4-C0F9E241F5A6@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <20200928010835.GD6704@linux.intel.com>
 <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
 <20200928141613.GB70098@linux.intel.com>
 <E0629B0C-E49F-4FA1-8DBA-E8CB1EDEFD1A@rubrik.com>
 <20200928194745.GB125819@linux.intel.com>
 <18048BE4-2700-4BF9-8959-D024ECF0B704@rubrik.com>
 <20200930021136.GD808399@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 29, 2020, at 7:11 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Mon, Sep 28, 2020 at 01:27:14PM -0700, Hao Wu wrote:
>>=20
>>=20
>>> On Sep 28, 2020, at 12:47 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>=20
>>> On Mon, Sep 28, 2020 at 10:49:56AM -0700, Hao Wu wrote:
>>>> Hi Jarkko,
>>>>=20
>>>> =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3=20
>>>> Is the one introducing the issue since 4.14. Then the other three =
commits
>>>> changed the relevant code a bit. Probably you can check the =
timestamp / release version
>>>> on each commit to understand the relationship.
>>>>=20
>>>> I think the original patch commit message can help you understand =
the root cause.
>>>> Attaching the commit here for your convenience.
>>>>=20
>>>> Thanks
>>>> Hao
>>>=20
>>> Please, again, when you respond quote properly instead of putting =
your
>>> response on top. Thank you.
>>>=20
>>> Yes, I know the issue and it is already documented also in the =
James'
>>> earlier patch that did a similar change. I.e. for some reason some =
TPM's
>>> (or the bus itself) do not like poking it too often.
>> Yes, probably. Although the issue James=E2=80=99s patch fixes has the =
same error code,
>> it is about a different issue which is similar.
>=20
> OK, great.
>=20
>>> So: what if you revert on using msleep(TPM_TIMEOUT) in
>>> wait_for_tpm_stat(), i.e. revert to the behaviour before the
>>> aformentioned commit?
>> I believe that should resolve the issue as well
>=20
> I'd return to the old code that works instead of doing something new
> along the lines. James?
>=20
I would not use msleep back which is actually wrong way to do.=20
We don=E2=80=99t know the actual time it sleeps on different system in =
the future.
Currently, my measurement over msleep(TPM_TIMEOUT) , i.e. msleep(5)=20
sleeps 15ms. Maybe we should use tpm_msleep to precisely do the sleep.

I will test out James=E2=80=99 patch and your proposal this week and get =
you back anyway.=20

> Anyway, thanks a lot for coming with this. I think we are making at
> least some progress sorting this out.
>=20
> Also want to underline that my comments about quoting emails did not
> have anything to do that I would not appreciate this feedback. It is
> just a "protocol thing".
No worries. I am not familiar with the rules here. Thank you for =
corrections.

>=20
>> Thanks
>> Hao
>=20
> /Jarkko

Hao

