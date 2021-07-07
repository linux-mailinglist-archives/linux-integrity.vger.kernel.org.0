Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70B43BE222
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 06:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhGGEhk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 00:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGGEhj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 00:37:39 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856FFC061574
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jul 2021 21:34:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d12so949657pgd.9
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jul 2021 21:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HBOivzC+dDG7XrxWkoaJXZSyZfGrNurrkHZjdwW1Kk0=;
        b=JQ7isiftCoDQ4q8843vQSwWmxln3Nhw5nffn3+C+cWajhyqUSx+JtC6Dci/R69FlIs
         K9kWbE2wdhxQSaZb+Nt78dNCuy7HyL9JJwFuUvDuzr6bOPr1Wt1GX1gkE0KPkYujA9y6
         qzv4mLZtyo/7Da7JE1rkEw2sk50OXGYEjckQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HBOivzC+dDG7XrxWkoaJXZSyZfGrNurrkHZjdwW1Kk0=;
        b=O93zjnyTdga/jjsvAZ15NLQApibHeWrvJ/0dzP/LI/mMtwzC+TDILMkBSq3BHPDS9A
         OG7KRUpWZMqnCfOI2daxzOCLuGZ28obvBsKBF652StiFddpSofX5CaZRCH7jZadOm0/0
         5T6D2DlE6V+ylZG5pxSvgPjXBDqBQ9yHNMBPjVkhGD9Dr0v/cxbqWBuqw2idZk2Ja2jj
         lb43ZhrNWLOoKmdEMFoU2qvRVEJP+JPco1L6hcrYYT15qeAmSWXFOaj9dB/uBVo3j7sU
         IDWFVM8+2sqbCcpcJ46Z5Cum/aOXjsW81L9hDL0OqZ9zo4+G4ttnXT1fMLSE53VnKi2G
         WSdg==
X-Gm-Message-State: AOAM531LhsJ2jiCa4sKWlTt+NvQP+PA73pQqcgikvbUDKZLW5S0q+cq0
        TUgAOIYkbROSBDkf4ZN9Osj2eA==
X-Google-Smtp-Source: ABdhPJyFX6ItmqDPyrBbTGxqD4r1N7uyWVTtOE5wMl+TiFwEMjgqSQ+tw+DF4UhB9C8hME9dU++Xng==
X-Received: by 2002:a62:1514:0:b029:31d:c27f:1daf with SMTP id 20-20020a6215140000b029031dc27f1dafmr16223430pfv.4.1625632497910;
        Tue, 06 Jul 2021 21:34:57 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id n23sm16074712pjq.2.2021.07.06.21.34.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 21:34:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <4A5C6503-134E-40D1-9EE1-03F720C8691E@rubrik.com>
Date:   Tue, 6 Jul 2021 21:34:48 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD80F3D0-E285-4AC2-A976-E2EB2EA7983C@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210704000754.1384-1-hao.wu@rubrik.com>
 <20210705071531.axxzyvecf52foik2@kernel.org>
 <CE168D94-C8F1-4DDB-B0F5-66E5F1D58097@rubrik.com>
 <b90af62dbe71413d76ee297942eadd387dc1ba48.camel@linux.ibm.com>
 <4A5C6503-134E-40D1-9EE1-03F720C8691E@rubrik.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 6, 2021, at 9:18 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
>> On Jul 6, 2021, at 5:34 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>=20
>> On Mon, 2021-07-05 at 16:09 -0700, Hao Wu wrote:
>>>> On Jul 5, 2021, at 12:15 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>>=20
>>>=20
>>>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>>>>> ---
>>>>> Test Plan:
>>>>> - Run fixed kernel with ATMEL TPM chips and see crash
>>>>> has been fixed.
>>>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>>>> the timeout has not been changed.
>>>>=20
>>>> The changelog is missing.
>>> Sorry, I don=E2=80=99t get your point here. Could you help clarify =
it a bit.
>>> I did follow the section 14, but I didn=E2=80=99t see anything =
specifically needed after `---`
>>> Could you be specific ? Thanks for your time.=20
>>=20
>> The changes from one version of a patch, or patch set, to the next =
has
>> moved around a bit.  Some people put it in the cover letter, others =
put
>> it on the individual patches.   It's also moved from within the patch
>> description to after the dashes.  Documentation/process/submitting-
>> patches.rst provides an example, but leaves out the word "Changelog". =
=20
>> For an explanation of what goes into the patch description versus the
>> Changelog, search for "Other comments relevant only to the moment or
>> the maintainer".
> I see. That makes sense to me now. The term =E2=80=9Cchangelog=E2=80=9D =
appears multiple times
> In the doc for different purpose, thus it was confusing to me. Here we =
are
> referring to "patch changelog=E2=80=9D. Will add it after `=E2=80=94`. =
Thanks for the clarification!
>=20
>>=20
>> For example, this version of the patch limits increasing the delay =
just
>> for Atmel TPM 1.2 chips.  At minimum it would be included in the
>> Changelog, but more likely included in the patch description itself =
and
>> perhaps even in the Subject line.
>>=20
>> thanks,
>>=20
>> Mimi
>>=20
>>>=20
>>>> Please read section 14 of
>>>>=20
>>>> =
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
>>>>=20
>>>> /Jarkko
>>> Hao
>>=20
>>=20
> Hao

Updated in =
https://patchwork.kernel.org/project/linux-integrity/patch/20210707043135.=
33434-1-hao.wu@rubrik.com/
Hopefully this time it is qualified.

Hao=
