Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA1720AE81
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFZIrx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFZIrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 04:47:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275ACC08C5C1;
        Fri, 26 Jun 2020 01:47:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so4363509pfu.8;
        Fri, 26 Jun 2020 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JI/FNcwdyAdin6Ur1Q7aBKHSJFRVIajQTwQ7ldYrmC8=;
        b=VHQ0XxB8CemNyEW0YECC8FE3K9egsL2tOTVGWMGaeuV0MgtUDhU8VIFX/eHRvAVJqk
         Cnw8D+eieVeLnHM8yH+bSsmAd/sMX684rTaFJ5kSycvbLZAa6JPhGO4xflp7E506KY14
         2bG0xv4Vqlm9Y4T0fQz5L9I4Kr7LQh2GCJhbNmTk7Jj8M1mpv6Vtiz1gyZx8ZwxpVl/8
         gm9g/mRMU2Ol0Ks7bn8UZxnDUj2JpEmFAER7fPJ38AR/v6fXCyJ3Y4ZwgluwTa1gS7ew
         1bdztItqfrWThqsVpntoxvDDH54RzgXcCQV+pBg39qkBckMY4agtwgezElS9iGvUoGLH
         w+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JI/FNcwdyAdin6Ur1Q7aBKHSJFRVIajQTwQ7ldYrmC8=;
        b=FoxFwvvTq08ef+olJRqa2YEd1fs8WCSMDoEMJd0zUp5/W6NNvzuOI4S67hx+Ia4oIw
         VhJUgOgNdDSH5uiIZppJinG+MrvUqbQnHVNCOHuN3Q7WUpAQWHl+KO4CdF++h8mWoIlx
         Fh0VP+UmrnJzoInZzr/RPZUnEvN/nVChNicj0LHgceMDo4oUuPhfDLssq8IAbe0k2UMd
         pcVu3aBlcp/fX/QsLQr/cIwVUgCnc8WTFlq9qjsNYuvwwlvNNBJDCUuwarvL3FjFbHoQ
         Ev3v9p39ZKI3Fn4m4eNkQuVM3dJcGX4Acf182BbVx37h02ECnxZPZzDrHzY0YE4dPor+
         hLlQ==
X-Gm-Message-State: AOAM5305vZ97xH2/AOjeZvZGD57MBs+99Bi4CBQ4LvW+qzQNIY8DQNFJ
        PLubJ6E0qHvy2VSVA78r+wU/ZHHYd8cDAHJP+BU=
X-Google-Smtp-Source: ABdhPJyzcy/EnnkJVkh4VCmUDv0EuqOkP7T5Q9t74koNfxidVlOE5ZRRJE1H+NyHSzDnj/A8bDCDmE4h7sIlVdqv3ZE=
X-Received: by 2002:a63:924b:: with SMTP id s11mr1766606pgn.74.1593161272465;
 Fri, 26 Jun 2020 01:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com> <3aa8705a-0342-25ea-00c4-d5370d91ddb4@forissier.org>
 <CAD8XO3ZDv-RZ-VPv-AFMRkMD_3uW9XYLeZQf0btGVK8m7GX2Dg@mail.gmail.com> <CAFA6WYOiBNQt0ZRyRxfsqW57z+O=aLqi3DTEAfZ7fGjf8UPB3Q@mail.gmail.com>
In-Reply-To: <CAFA6WYOiBNQt0ZRyRxfsqW57z+O=aLqi3DTEAfZ7fGjf8UPB3Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Jun 2020 11:47:36 +0300
Message-ID: <CAHp75VcO=pEOhuvwwVxDmkXYmgq+4KR-j0___sbQ4LQ4p=5MDg@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 26, 2020 at 8:18 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> On Thu, 25 Jun 2020 at 18:22, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:

...

> I guess you missed the point that uuid_t is implemented in BE format
> in the kernel which is compliant as per RFC 4122.

I guess you missed the point. Kernel doesn't have anything special
about these types and does NOT compliant as per RFC.
The only things the kernel distinguishes are a) byte order (always),
and b) version bits when you get a random UUID (whatever you call it).

I guess this discussion takes too much time. The idea is that kernel
types are just for kernel use with as little intrusion as possible.
The main principle, we get something, we carry it w/o modifications
inside the kernel.

So, you may use whatever you want and LE/BE is purely based on a) and b) above.

-- 
With Best Regards,
Andy Shevchenko
