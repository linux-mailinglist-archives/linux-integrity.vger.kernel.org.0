Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF020A0C4
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405200AbgFYOYd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbgFYOYc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 10:24:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35E1C08C5C1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 07:24:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so6737023ljv.5
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+ZtbKOKX10FRQ/X2SmiDT2iPwxMyGZIFzesaKUw/OU=;
        b=AIE1va1pK6qjTUIYzsqfq69DSL60n3yRxhhJAUQ4ljo9HbnzGYGmzB06jqCpGnRGvm
         FLQJbddriT4bUI6Np72Zg2oIRPtdfckb/kWyIydY9842xrPMEFX0UQnMbHtTXcvAdrtM
         BlhZXKdWCMlaI1hz2Xlpk++uAshiCgzl8eiaDOaKYMb+CRQcclI4/RiD3Xf6oLapJ+eA
         bKrek8UrYI9Aj0CRgK6umLa2T+wz2NW/4RQw391bTv7Dk2zhamMCVrdOJu3nCCNCkljO
         ZPpytb0dgLNaupmZGVIt+yFK9OgrMw1vmMrIAtC6KGQEA54sC3qDbX52crKQAWEg0ahU
         +raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+ZtbKOKX10FRQ/X2SmiDT2iPwxMyGZIFzesaKUw/OU=;
        b=RCwUnqQY2I8R04jLnUeGXo2LFum/csSjla2GC6uOTDXXUTU+Vg9uDJS0GnJhSM06jC
         vQf1vPlrh6Pd1G1GXLlTbCX5AHy2zUiQlMNA6LDjeYJ4ex41IqXTlywVZky6lcKFTyAD
         jJnKMCaMV5P1sdFI1OGH6OZVQlIk3IukQMibr4Mu+SfW4NVZ5dz1JoVJHMP2KhvVHyMS
         rbPaDWCBtGNbbVxeoWhFbx635eDQu79epHm0UH5GljXyAvvS+2wrjmed92x+XfvTd+jS
         q0knEXr7unYU+Kr4s89IU1zPixKgezB61kKdvNosJ+zB60Z4673B0M4x/e2+jWiD7mCx
         oFxw==
X-Gm-Message-State: AOAM530lNx1KJEE2KQsUeE9fW1d3Ru4xxsDLb64LDRV/7bDOBi+dZC+A
        i/c4hyoO9ADjrXmBCm5/ZzBUhzVLM/q6iFGhdIpSUg==
X-Google-Smtp-Source: ABdhPJxPgkRDIQn+rur+DUyyMOCmeL6Rcf7WSslIvGFOV9fp5nQeRVyy4GySaOMLVD53kxrl5RJ1QkbyRQOUst/GZvI=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr18010266ljb.30.1593095070064;
 Thu, 25 Jun 2020 07:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com>
In-Reply-To: <1593012069.28403.11.camel@HansenPartnership.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 25 Jun 2020 19:54:18 +0530
Message-ID: <CAFA6WYMF+JjrB9Cx9TdgDzMeQSvPZfMNapzD-MH4ALVoUoo1sQ@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 24 Jun 2020 at 20:51, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > Apologies for delay in my reply as I was busy with some other stuff.
> >
> > On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > it's about consistency with what the kernel types mean.  When some
> > > checker detects your using little endian operations on a big endian
> > > structure (like in the prink for instance) they're going to keep
> > > emailing you about it.
> >
> > As mentioned above, using different terminology is meant to cause
> > more confusion than just difference in endianness which is manageable
> > inside TEE.
> >
> > And I think it's safe to say that the kernel implements UUID in big
> > endian format and thus uses %pUb whereas OP-TEE implements UUID in
> > little endian format and thus uses %pUl.
>
> So what I think you're saying is that if we still had uuid_be and
> uuid_le you'd use uuid_le, because that's exactly the structure
> described in the docs.  But because we renamed
>
> uuid_be -> uuid_t
> uuid_le -> guid_t
>
> You can't use guid_t as a kernel type because it has the wrong name?

Isn't the rename commit description [1] pretty clear about which is
the true UUID type from Linux point of view?

[1]
commit f9727a17db9bab71ddae91f74f11a8a2f9a0ece6
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 17 10:02:48 2017 +0200

    uuid: rename uuid types

    Our "little endian" UUID really is a Wintel GUID, so rename it and its
    helpers such (guid_t).  The big endian UUID is the **only true** one, so
    give it the name uuid_t.  The uuid_le and uuid_be names are retained for
    now, but will hopefully go away soon.  The exception to that are the _cmp
    helpers that will be replaced by better primitives ASAP and thus don't
    get the new names.

    Also the _to_bin helpers are named to match the better named uuid_parse
    routine in userspace.

    Also remove the existing typedef in XFS that's now been superceeded by
    the generic type name.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    [andy: also update the UUID_LE/UUID_BE macros including fallout]
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Amir Goldstein <amir73il@gmail.com>
    Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

    Signed-off-by: Christoph Hellwig <hch@lst.de>

-Sumit

>
> James
>
