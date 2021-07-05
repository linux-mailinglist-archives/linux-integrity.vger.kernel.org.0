Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810303BC400
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhGEXLw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhGEXLw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 19:11:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17AC061574
        for <linux-integrity@vger.kernel.org>; Mon,  5 Jul 2021 16:09:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id in17-20020a17090b4391b0290170ba0ec7fcso408125pjb.4
        for <linux-integrity@vger.kernel.org>; Mon, 05 Jul 2021 16:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cfzVhVTNiBmHBkzSNzyhTvUbGCuid0rOTKYTc6m9+IU=;
        b=hPQwntoYAyZuHjUFe+HB/6o7aWyJh+XKFmPW8PJbIZFJ1jAg3j4voKldxRjEWiY+rY
         DAARt0IpbWs0BymRJnBjr1jINBKc7uz7nY92jxpWjgm9qqChU//M0DkebIavIcPWIRUZ
         cV3owdvsI/7/4aUd0PHyQ9oK4f4FElL0mEclk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cfzVhVTNiBmHBkzSNzyhTvUbGCuid0rOTKYTc6m9+IU=;
        b=pAvMPGAEvwOyBRCu71uCJuzRXqwE8AJXTHonKs3jv6Qlr7V4JJ1mqnR5IYILBDIgDP
         gchrYjErIJMCFAkVlmcxZ4GcFrfjhPUlj/xcnGhloJOt6OyJcmry6CpzmoOkKlxDx58X
         wBj7Akk1yDQZZlzm/2UMso/pQ8Bn1XElqwDJHcE0/S6cfLeZF7B+EJHNpONhHIU2rBrm
         PafZf/hGGYV1RxvtH+HxEcSDwkETw08zK0Ue2Qgk2h6q6wCa7gdE2u27rogtBMbKl8t9
         ZansmLmL9oELywsHyez+diehaW4zX/YzOQe4v3IUGt62wIwugSmajIN97DotKIhTRI+t
         o4gw==
X-Gm-Message-State: AOAM532NeQpHcNqSLmc7/S/hUZBZKqXWUtc58qK3riz5huMGaJFlRl8W
        Skjy6aL7lFH92ZTBB+IRX5sONg==
X-Google-Smtp-Source: ABdhPJynfM1JNhUvqjn9Vlf1Lcj9otRGBXJGl5ZEtx48qUZ/u+XgqwBVSB5EzeIWSylk3KRvvGi8yg==
X-Received: by 2002:a17:902:8698:b029:128:ce62:82b5 with SMTP id g24-20020a1709028698b0290128ce6282b5mr11865893plo.40.1625526552884;
        Mon, 05 Jul 2021 16:09:12 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id i27sm15992555pgl.78.2021.07.05.16.09.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 16:09:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210705071531.axxzyvecf52foik2@kernel.org>
Date:   Mon, 5 Jul 2021 16:09:10 -0700
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
Message-Id: <CE168D94-C8F1-4DDB-B0F5-66E5F1D58097@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210704000754.1384-1-hao.wu@rubrik.com>
 <20210705071531.axxzyvecf52foik2@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 5, 2021, at 12:15 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>=20
> Is this really the first version? Please, use git-format-patch -vX.
Got it, will re-send the patch with `[PATCH v2]`.=20
Thanks for bearing my mistakes, I am not quite familiar with the =
workflow yet.

> On Sat, Jul 03, 2021 at 05:07:54PM -0700, Hao Wu wrote:
>> This is a fix for the ATMEL TPM crash bug reported in
>> =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>=20
>> According to the discussions in the original thread,
>> we don't want to revert the timeout of wait_for_tpm_stat
>> for non-ATMEL chips, which brings back the performance cost.
>> For investigation and analysis of why wait_for_tpm_stat
>> caused the issue, and how the regression was introduced,
>> please read the original thread above.
>=20
> Please, no xrefs. Instead, describe what you are doing.
Ok, will rewrite the commit message
>=20
>> Thus the proposed fix here is to only revert the timeout
>> for ATMEL chips by checking the vendor ID.
>=20
> What do you mean by reverting?
>=20
> The long description needs a full rewrite.
>=20
> You can add
>=20
> Link: =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>=20
> But do not expect anyone to read the thread in order to
> understand what the commit is doing.
>=20
>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in =
TPM 1.2/2.0 generic drivers")
>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>> ---
>> Test Plan:
>> - Run fixed kernel with ATMEL TPM chips and see crash
>> has been fixed.
>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>> the timeout has not been changed.
>=20
> The changelog is missing.
Sorry, I don=E2=80=99t get your point here. Could you help clarify it a =
bit.
I did follow the section 14, but I didn=E2=80=99t see anything =
specifically needed after `---`
Could you be specific ? Thanks for your time.=20

> Please read section 14 of
>=20
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
>=20
> /Jarkko
Hao=
