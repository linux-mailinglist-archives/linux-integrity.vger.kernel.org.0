Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E933B7CBD
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhF3E3g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 00:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhF3E3f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 00:29:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D8DC061760
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 21:27:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso501121pjb.4
        for <linux-integrity@vger.kernel.org>; Tue, 29 Jun 2021 21:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZzuZXcgbYB+New9vBMz1XPaNHdijGir3ZmiP+vC9OA8=;
        b=UpDYyOQVNQhq9pAhaHjwz0VV3AxnFx1nb71S06nXLPhr3NrKXuRu38PHyCcVVe5htR
         XxtXKNEb/HY8XYGVP/awSQvyJeADevI5G5sDlTweIuH802P9m9g+yOiCgWKoGx3vBQcS
         6WFlowHeYSrEPKuVgdHgGw2gGbjY1fF5Y0EwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZzuZXcgbYB+New9vBMz1XPaNHdijGir3ZmiP+vC9OA8=;
        b=X8JgP1uiniRRcKcBsIOPHWuXllGywfceis4htHTxPXUHrnLUpgecrGdVbD8imPgg8M
         c/yO44gp5ZgVKpw/Fyep1Lb3mptiriNq6Ma84clXjc1y1U1WMSt2Flcs1Izm3ZrncjkD
         f2UJ276K0vT8h/ERj3KNpJDs7ijjrIL08RdxNhTaFt26A5LEtc5dZJ/s91iQq/z18cBs
         lBgSHLgbcsePHMTGBXcbCIHydBAewKVN3+H4GLpndH65EaeHFGhOuvQT8WJvUlkL4RBN
         z5yPpoWBtIqtQux4cn2DTfSkTVNl7ZjuR3ox3i5R95jF5VLzZhDUZ8wVLWWbEuwmlQVN
         K4hQ==
X-Gm-Message-State: AOAM533W1pFWXz7q6Jvsk7ACwaC9tdh8284atMv2b/CBh4lgy93NGT37
        8yzVRBrSCZFWQKH1SJbFwKusEQ==
X-Google-Smtp-Source: ABdhPJxQfsgpF8rq0AYNATBGzJORkNuljP8DumIGEu9dQpFKoEJpXEQDKHvXZOnjWAHEoE4uXpFwjA==
X-Received: by 2002:a17:90a:10c8:: with SMTP id b8mr2392076pje.147.1625027225572;
        Tue, 29 Jun 2021 21:27:05 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id y6sm19702931pjr.48.2021.06.29.21.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 21:27:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210629200628.slv7fnjxsmnvv2cf@kernel.org>
Date:   Tue, 29 Jun 2021 21:27:03 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James.Bottomley@hansenpartnership.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <20A0208C-FC96-4788-B59C-6019A5A32EF9@rubrik.com>
References: <20210620231809.21101-1-hao.wu@rubrik.com>
 <20210623133518.5vykitqsdwtfqzd6@kernel.org>
 <51DCB704-8E9D-40DD-9E81-F1D16EB28BD5@rubrik.com>
 <20210629200628.slv7fnjxsmnvv2cf@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jun 29, 2021, at 1:06 PM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>=20
> On Wed, Jun 23, 2021 at 10:49:27PM -0700, Hao Wu wrote:
>>> On Jun 23, 2021, at 6:35 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>=20
>>> On Sun, Jun 20, 2021 at 04:18:09PM -0700, Hao Wu wrote:
>>>> This is a fix for the ATMEL TPM crash bug reported in
>>>> =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>>>=20
>>>> According to the discussions in the original thread,
>>>> we don't want to revert the timeout of wait_for_tpm_stat
>>>> for non-ATMEL chips, which brings back the performance cost.
>>>> For investigation and analysis of why wait_for_tpm_stat
>>>> caused the issue, and how the regression was introduced,
>>>> please read the original thread above.
>>>>=20
>>>> Thus the proposed fix here is to only revert the timeout
>>>> for ATMEL chips by checking the vendor ID.
>>>>=20
>>>> Test Plan:
>>>> - Run fixed kernel with ATMEL TPM chips and see crash
>>>> has been fixed.
>>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>>> the timeout has not been changed.
>>>=20
>>> Please move test plan right before diffstat if you wan to include =
such,
>>> so that it does not go into the commit log.
>> Hi Jarkko, not sure I understood your suggestion or not. I removed
>> the test plan from the commit message in a updated commit
>> =
https://patchwork.kernel.org/project/linux-integrity/patch/20210624053321.=
861-1-hao.wu@rubrik.com/
>>=20
>> Let me know if I misunderstood this. I am fine to not include test =
plan,
>> If this is not something expected by linux community.
>> I personally think it is helpful to understand the confidence of the =
commit.
>>=20
>>>=20
>>>> ---
>=20
> You can add it right here. Then it won't be included to the actual
> commit log but is still available in the patch.
>=20
I see, thanks Jarkko. Updated the patch
=
https://patchwork.kernel.org/project/linux-integrity/patch/20210630042205.=
30051-1-hao.wu@rubrik.com/
Hopefull it makes more sense now.

> /Jarkko=20

Hao=
