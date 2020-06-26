Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6320ABB9
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 07:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgFZFKz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 01:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgFZFKz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 01:10:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC28C08C5DB
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 22:10:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y18so4430535lfh.11
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 22:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zv05Jk142CPLMrkpPf7EfVAdMyUtN+Y1uEp+zMCdvAY=;
        b=th+Or/Uzk9iYCaVGl9gUQnM5lTHUq7sv+kIcrWMJxR20Dd/BZs5j5OhR8tv6ySfslY
         44NHACjL211z1qThQ7GPQ59v9EoaneBoN5UHkLR63zuF99a6OCjEDf6X+GLx7CTmabsS
         skhSJW++JJiSj22mhb/CO05lGvow8iZG9kcXpTDAvozqh2/GU6WlXDTJpPxCrJLKPXPx
         46jVyTMeFpM+pX45ECzj84F/5ub9XljxJVGeanERd/w7XMrjfamenn/e7MntnELmgjSn
         F1nlKvMKqCafSVLlzGeMbHcfwSShL2iJr7MSoAnqRukMtvuiyOTFH05mMjBg1IksGNp5
         xlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zv05Jk142CPLMrkpPf7EfVAdMyUtN+Y1uEp+zMCdvAY=;
        b=Cl9vfVre2CtAhlJWT4srUYiIv9cuMsBqZD+W20AEk9lJJCMMIQJyoAfQvv3NfGx/Kv
         2cR0pGfb/cElGdmpkXpmLM0wviEvDK5tXUs16+DBKJdHbfXSPrNFR7lD+tVimzWMpLZi
         A5b4nbJXJlimsYs6es3GEXfSA51rInnJ8nat2BDtmTil6s5EivYCy3jNskXKA2vqGOgI
         TiDmZPpQjlj18jnhbbgs9t/Mxxa8CPWiN+D0xMycjfEu75+Juhn8CixUE8uVjnHSw0vZ
         VaOR+0CZljxs2Sa128QiJqtEWv+elmeAXgmp6JY8an0Icw6K2X9aDcR4o/ght/1K1+/a
         /sNQ==
X-Gm-Message-State: AOAM533umolQWneTx+hKXUINBO32XMfAjmI/QPPy/T7Tkd7BukztvOIE
        ZAYBg/ak+PI/eyFEPfs2z+OYhiWagvnkKNw1bdpwcA==
X-Google-Smtp-Source: ABdhPJx+f5S6Xcaq1kk/Z+zAVDkurQDmKD6fsbTP0JTmGvswCUHtNRkS3v8xD0WmqMuM9hXohMi0qissWgBT0OLX8/0=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr791520lfi.204.1593148252979;
 Thu, 25 Jun 2020 22:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com> <CAFA6WYMF+JjrB9Cx9TdgDzMeQSvPZfMNapzD-MH4ALVoUoo1sQ@mail.gmail.com>
 <1593127902.13253.11.camel@HansenPartnership.com>
In-Reply-To: <1593127902.13253.11.camel@HansenPartnership.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Jun 2020 10:40:41 +0530
Message-ID: <CAFA6WYMPtLtv=cWppU=-LZp6FD_3KYymrLgVP+-KQd_N_GcT_Q@mail.gmail.com>
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

On Fri, 26 Jun 2020 at 05:01, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2020-06-25 at 19:54 +0530, Sumit Garg wrote:
> > On Wed, 24 Jun 2020 at 20:51, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > > > Apologies for delay in my reply as I was busy with some other
> > > > stuff.
> > > >
> > > > On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > [...]
> > > > > it's about consistency with what the kernel types mean.  When
> > > > > some checker detects your using little endian operations on a
> > > > > big endian structure (like in the prink for instance) they're
> > > > > going to keep emailing you about it.
> > > >
> > > > As mentioned above, using different terminology is meant to cause
> > > > more confusion than just difference in endianness which is
> > > > manageable inside TEE.
> > > >
> > > > And I think it's safe to say that the kernel implements UUID in
> > > > big endian format and thus uses %pUb whereas OP-TEE implements
> > > > UUID in little endian format and thus uses %pUl.
> > >
> > > So what I think you're saying is that if we still had uuid_be and
> > > uuid_le you'd use uuid_le, because that's exactly the structure
> > > described in the docs.  But because we renamed
> > >
> > > uuid_be -> uuid_t
> > > uuid_le -> guid_t
> > >
> > > You can't use guid_t as a kernel type because it has the wrong
> > > name?
> >
> > Isn't the rename commit description [1] pretty clear about which is
> > the true UUID type from Linux point of view?
>
> I don't think the kernel code takes a position on eternal verity, just
> on logical or arithmetic truth.  We just have to deal with both LE and
> BE UUIDs so we have appropriate types for them and the LE type is now
> named guid_t.  They're both equally correct to use provided the use
> case matches the designed one. So does the name really matter?

Yes it does. I guess I have provided enough reasoning for that. Also,
the rename commit itself illustrates its importance and clarifies the
use case for which they are meant to be used.

> If we
> did
>
> #define uuid_le_t guid_t
>
> would you be happy? (not that the kernel cares about karmic emotional
> states either ...)

It's not about me being happy but more about confusion and
inconsistency it will bring.

IMO, either kernel should be opinionated about UUID endianness like
currently it is:

uuid_t and its corresponding helpers (eg. UUID_INIT) follows BE format.

or support both endianness for UUID (no common type: uuid_t) like we
had earlier prior to rename commit:

uuid_be_t and its corresponding helpers (eg. UUID_BE_INIT) follow BE format.
uuid_le_t and its corresponding helpers (eg. UUID_LE_INIT) follow LE format.

But even if we consider later case as well, I am still not sure if we
can switch to uuid_le_t as it's been part of TEE core ABI
(open_session) where UUID is passed in BE format (see LE to BE
conversion in TEE client [1] and vice-versa in OP-TEE OS [2]) and
won't be a backwards compatible change.

[1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/tee_client_api.c#L595
[2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/ree_fs_ta.c#L92

-Sumit

>
> James
>
