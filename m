Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F44B3C1E90
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 06:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhGIEp4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 00:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIEp4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 00:45:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D811C061574
        for <linux-integrity@vger.kernel.org>; Thu,  8 Jul 2021 21:43:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x3so4003288pfc.11
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 21:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GDiY53Q0H0pCsRwAiw1Ko/wmj/CAwiUjHahUoPOBYf8=;
        b=S0HqcHYRIIaZHqhQeuDUoIsLD9DXIxzrgzhLCVpLN+tgV2OqzuGzFmZO5qP4V0UuOg
         V+4/5wLKx2+r1OAdYZpRgPu8Fxyc+JaPrxY6BwXZp+TwmDcz2kbpp11NBEXv1xizYxWz
         rONcWE5TIgG+/TFDswT0me+duFgPtcapcqzwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GDiY53Q0H0pCsRwAiw1Ko/wmj/CAwiUjHahUoPOBYf8=;
        b=qfq96bwA7o4vN1D53Xg87j4b7MQ3DD9RCl3HpdcEcYRqG3sCPai8d9cXEQ1a129abl
         +3EC5WS4d1nf3H8U1tF7Imnwj7yE9ZHojWFQMC1g0q9/ASmxrfcZj3rRiqvIGmYeKQsS
         yVLNNpCOTX5bbXsQgwU/E/4JBKNwXP6MI/kt6IXiB4MuoANXvVTZ9iPJfQYHJ5cUDeR7
         aixcVcKCb2EUk9RJAm/UtuMsdcNmCryiRiLm1ab9uzh0ngYjlB/3NzOJYtTGedUbXo60
         neeRhLnZClpf2MY7Q5GIwOkZC+qWbRKnHC7kEKE85DI8Hri+qdCkian03tfbg6/cus+J
         fQpA==
X-Gm-Message-State: AOAM532tupI415yO0R/WgGEVXsmfbWioMTU+rkWSI9vjLcMsvaU6jDfq
        0nSt5NsFzysuUfVHUZ8D7JvzRg==
X-Google-Smtp-Source: ABdhPJyNyGQPpRi5TA2SAVvr69fHDXGeU0xnwwW8ukbeiWYh544lAQn6suTtshoJZRSacON8ZR1mTQ==
X-Received: by 2002:a63:4302:: with SMTP id q2mr35593198pga.428.1625805791564;
        Thu, 08 Jul 2021 21:43:11 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id d1sm4335239pfu.6.2021.07.08.21.43.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jul 2021 21:43:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] tpm: fix ATMEL TPM crash caused by too frequent
 queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210707211053.obfqcfq42cqlamns@kernel.org>
Date:   Thu, 8 Jul 2021 21:43:01 -0700
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
Message-Id: <3019504F-E18A-42C8-BB4E-54F3FB4636D2@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210707043135.33434-1-hao.wu@rubrik.com>
 <20210707092411.onk6ewfmhxj5kf3v@kernel.org>
 <712FD1C1-941C-4ABA-866D-6EA6AFA0FE9F@rubrik.com>
 <20210707211053.obfqcfq42cqlamns@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 7, 2021, at 2:10 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed, Jul 07, 2021 at 11:28:35AM -0700, Hao Wu wrote:
>>> On Jul 7, 2021, at 2:24 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>=20
>>> On Tue, Jul 06, 2021 at 09:31:35PM -0700, Hao Wu wrote:
>>>> Since kernel 4.14, there was a commit (9f3fc7bcddcb)
>=20
> BTW, please remove this. You have a fixes tag.
>=20
>>>> fixed the TPM sleep logic from msleep to usleep_range,
>>>> so that the TPM sleeps exactly with TPM_TIMEOUT (=3D5ms) afterward.
>>>> Before that fix, msleep(5) actually sleeps for around 15ms.
>>>=20
>>> What is TPM sleep logic?
>> It is about the commit metnioned in the description
>> `tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic =
drivers`
>> =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
>=20
> What you should do is to explain in simple terms the unwanted =
behaviour
> that you are observing, and also, *when* you observe it. E.g. does =
this
> happen when you use /dev/tpm0, or is it visible already in klog at =
boot
> time. And also: does it occur for anything you put to /dev/tpm0, or is
> the bug triggering for some particular TPM commands.
>=20
> You also need to have information what kind of Atmel chip triggers the
> bug. I'd presume that you have access to a machine with such chip?
>=20
> When you get all that figured out, you should explain how you change
> the existing behaviour, and why it makes sense. E.g. if you fixup
> timeouts, please just tell how'd you end up choosing the values that
> you picked.
>=20
> E.g. the rationale for that could come from testing and finding the =
"sweet
> spot", or perhaps the reason could be that old values worked, new ones
> don't.
>=20
> Especially in bug fixes the reasoning is *at least* as important as =
the
> the code change itself because I need to know what is going on.
>=20
> /Jarkko

Thanks Jarkko for pointing the direction! I have updated the description
and sent a new revision.

Hao

