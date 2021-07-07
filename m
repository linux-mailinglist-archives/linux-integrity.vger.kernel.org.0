Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44D3BE1E0
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 06:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhGGEVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 00:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGGEVs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 00:21:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098A1C061574
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jul 2021 21:19:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f17so980960pfj.8
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jul 2021 21:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GyCsuRQHuqmkaiMImJwhxWoBet0GkgSA8CRWrgti2i8=;
        b=lYwGXbdFBzw1fM5HzuPDoKBcP7JoBqyHiSrZ2pg57Br/oHu3nBftR5IGIwHGuMQtD1
         HCdcXilVPEyfABABmAcFxBkiKqpcIdKuIv9T3//OmJMxJO5h4u8xnRy2vBkXccQrppJJ
         AuRx1OuDeUO0DID+gFJjgopXygq1XFcQNbJds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GyCsuRQHuqmkaiMImJwhxWoBet0GkgSA8CRWrgti2i8=;
        b=s53tv9SWJkeCebNRPvKNMowDTzhZvS19rMUqwa9qGMTVVXS2iG7209xEWqb7JtTFPY
         muLmHWtsKByIPnJ0cTr8Rv12NFvDnuK/faVAuL3NKCnQRQvrKovz8aa9Ysl+rzlvHTwX
         Hn9LjW5AGWNMzph7lEXQ8W4IqDFqKvBIGpWZdQoAb15m1OYgAuFGj0CoiTVxLYT9k0o/
         cP+hrd/OJGLAXf6p3taMrpuIa4dwi7lkLm3lXHi//kQ2zZiKGqW4Rjrg+tcjDIUBw8tT
         MVySMkBjxw+9CuUczQ9sXSDFVJS7AWnZz4M3skZ/S3TeBzvZ1td8YIcz0BU8dLipD1gv
         krAA==
X-Gm-Message-State: AOAM532hxlfSWzQ2XNIQrFUFn+KvRpbE+fkwG6ax6/NzzySe6ZvvOOTs
        UiOjM1IoZqspmfwZk4/HAb1pjw==
X-Google-Smtp-Source: ABdhPJxjebzxdXebXiNTFUFTdVPujiATD5V2XIy/pHxqYLGEUUkAJugipPB3InVrFHLHOmi9bP1C2Q==
X-Received: by 2002:a05:6a00:2293:b029:309:e87c:1f4a with SMTP id f19-20020a056a002293b0290309e87c1f4amr22887233pfe.36.1625631547180;
        Tue, 06 Jul 2021 21:19:07 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id w14sm22649998pgo.75.2021.07.06.21.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 21:19:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <b90af62dbe71413d76ee297942eadd387dc1ba48.camel@linux.ibm.com>
Date:   Tue, 6 Jul 2021 21:18:56 -0700
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
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
Message-Id: <4A5C6503-134E-40D1-9EE1-03F720C8691E@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210704000754.1384-1-hao.wu@rubrik.com>
 <20210705071531.axxzyvecf52foik2@kernel.org>
 <CE168D94-C8F1-4DDB-B0F5-66E5F1D58097@rubrik.com>
 <b90af62dbe71413d76ee297942eadd387dc1ba48.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 6, 2021, at 5:34 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Mon, 2021-07-05 at 16:09 -0700, Hao Wu wrote:
>>> On Jul 5, 2021, at 12:15 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>=20
>>=20
>>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>>>> ---
>>>> Test Plan:
>>>> - Run fixed kernel with ATMEL TPM chips and see crash
>>>> has been fixed.
>>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>>> the timeout has not been changed.
>>>=20
>>> The changelog is missing.
>> Sorry, I don=E2=80=99t get your point here. Could you help clarify it =
a bit.
>> I did follow the section 14, but I didn=E2=80=99t see anything =
specifically needed after `---`
>> Could you be specific ? Thanks for your time.=20
>=20
> The changes from one version of a patch, or patch set, to the next has
> moved around a bit.  Some people put it in the cover letter, others =
put
> it on the individual patches.   It's also moved from within the patch
> description to after the dashes.  Documentation/process/submitting-
> patches.rst provides an example, but leaves out the word "Changelog". =20=

> For an explanation of what goes into the patch description versus the
> Changelog, search for "Other comments relevant only to the moment or
> the maintainer".
I see. That makes sense to me now. The term =E2=80=9Cchangelog=E2=80=9D =
appears multiple times
In the doc for different purpose, thus it was confusing to me. Here we =
are
referring to "patch changelog=E2=80=9D. Will add it after `=E2=80=94`. =
Thanks for the clarification!

>=20
> For example, this version of the patch limits increasing the delay =
just
> for Atmel TPM 1.2 chips.  At minimum it would be included in the
> Changelog, but more likely included in the patch description itself =
and
> perhaps even in the Subject line.
>=20
> thanks,
>=20
> Mimi
>=20
>>=20
>>> Please read section 14 of
>>>=20
>>> =
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
>>>=20
>>> /Jarkko
>> Hao
>=20
>=20
Hao=
