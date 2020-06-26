Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A620B078
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 13:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgFZL3c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgFZL3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 07:29:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FAFC08C5DB
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jun 2020 04:29:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so9054187wmh.2
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jun 2020 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhe/uDr1Hk5CjlOdQmxKxf2Wv1kV6ipt5MgKjBIph/M=;
        b=GNOietCVMKeCVo/Qdy1JQJRM0YoqGv+rwYJBEke6bUxjkyGghV5CMz/nKi/iV2MqmR
         hPsVqEy9rcCrMjSDKq7UQP5ii96XCsZDbSJ0sVkXK8YsBhLJFT7VLOGLCg3g2+B68NK7
         OfVQuO0cQCoW8MVJ1Iy+Bb6O+xmeArfv7rcpSKznrWvq8iP2HdQuFiDf03ZnwPXqdtMh
         lCHfgoHEDiZW+E0l0N4QmawdVk/FCTkz8Rl+DtSU53DAWd1U4QFoXjAzZWsvDF7Gdtna
         Y7cTSOJ+vuqdBkoi7L52Iwg0IIgDtqcqqvlV/C6yBZiUBDNo5/ceXotxD3rhpfeI94ii
         TOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhe/uDr1Hk5CjlOdQmxKxf2Wv1kV6ipt5MgKjBIph/M=;
        b=mow+mcCb0Ok548p2vCwIa2a4IUpw/xaEVWRdziG4TWhyPTeMelNeBiyE5xYFKhMMG3
         rrcBtGe5otyUlH02MGACFc0eNFWWOjyDSF93WaFzDVpiIqqPQWYr/2WmSbTwR89Cy5DL
         ISQzGinaEeB6ZpQZ2BvHokAOzx0zrIAwjAt+9OXQ6wGIqqV6C2ZSj9ZkNEd+2bUULjYp
         TgG0MSrR5v1ry9NQmcC0FPpCicTn3YaqlQEn6AcpAt4oGs39Kq4jceG3aUd4gqbxX0pW
         UoqCJ1h8doSwHFA7HGW2JZ2vQT6Zndwmg50W6FUB3P17gnYinCr1a/3uKbQu4R+QVCU6
         CzSg==
X-Gm-Message-State: AOAM530rC26uM1JxpxJ4Zrb0nJX5fn6ImYlKTE64ao+PuDWLTneDhVL7
        Y4RcmqIdXrTNfGSrzAq14WN8h5Gwx8A=
X-Google-Smtp-Source: ABdhPJxg7zKMcEEthem7yjq1WKE+1gImsA/C/MvGn15YCPYMW3Pbia+IEy2X0GWhjmFqLgScPL33/A==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr2828166wmi.148.1593170969745;
        Fri, 26 Jun 2020 04:29:29 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a4sm28930843wrg.80.2020.06.26.04.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 04:29:28 -0700 (PDT)
Date:   Fri, 26 Jun 2020 12:29:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerome Forissier <jerome@forissier.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
Message-ID: <20200626112927.vfffwdhzdjf6ndmb@holly.lan>
References: <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com>
 <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com>
 <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com>
 <CAFA6WYMF+JjrB9Cx9TdgDzMeQSvPZfMNapzD-MH4ALVoUoo1sQ@mail.gmail.com>
 <1593127902.13253.11.camel@HansenPartnership.com>
 <CAFA6WYMPtLtv=cWppU=-LZp6FD_3KYymrLgVP+-KQd_N_GcT_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMPtLtv=cWppU=-LZp6FD_3KYymrLgVP+-KQd_N_GcT_Q@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 26, 2020 at 10:40:41AM +0530, Sumit Garg wrote:
> On Fri, 26 Jun 2020 at 05:01, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Thu, 2020-06-25 at 19:54 +0530, Sumit Garg wrote:
> > > On Wed, 24 Jun 2020 at 20:51, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > > > > Apologies for delay in my reply as I was busy with some other
> > > > > stuff.
> > > > >
> > > > > On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > [...]
> > > > > > it's about consistency with what the kernel types mean.  When
> > > > > > some checker detects your using little endian operations on a
> > > > > > big endian structure (like in the prink for instance) they're
> > > > > > going to keep emailing you about it.
> > > > >
> > > > > As mentioned above, using different terminology is meant to cause
> > > > > more confusion than just difference in endianness which is
> > > > > manageable inside TEE.
> > > > >
> > > > > And I think it's safe to say that the kernel implements UUID in
> > > > > big endian format and thus uses %pUb whereas OP-TEE implements
> > > > > UUID in little endian format and thus uses %pUl.
> > > >
> > > > So what I think you're saying is that if we still had uuid_be and
> > > > uuid_le you'd use uuid_le, because that's exactly the structure
> > > > described in the docs.  But because we renamed
> > > >
> > > > uuid_be -> uuid_t
> > > > uuid_le -> guid_t
> > > >
> > > > You can't use guid_t as a kernel type because it has the wrong
> > > > name?
> > >
> > > Isn't the rename commit description [1] pretty clear about which is
> > > the true UUID type from Linux point of view?
> >
> > I don't think the kernel code takes a position on eternal verity, just
> > on logical or arithmetic truth.  We just have to deal with both LE and
> > BE UUIDs so we have appropriate types for them and the LE type is now
> > named guid_t.  They're both equally correct to use provided the use
> > case matches the designed one. So does the name really matter?
> 
> Yes it does. I guess I have provided enough reasoning for that. Also,
> the rename commit itself illustrates its importance and clarifies the
> use case for which they are meant to be used.
> 
> > If we
> > did
> >
> > #define uuid_le_t guid_t
> >
> > would you be happy? (not that the kernel cares about karmic emotional
> > states either ...)
> 
> It's not about me being happy but more about confusion and
> inconsistency it will bring.
> 
> IMO, either kernel should be opinionated about UUID endianness like
> currently it is:
> 
> uuid_t and its corresponding helpers (eg. UUID_INIT) follows BE format.
> 
> or support both endianness for UUID (no common type: uuid_t) like we
> had earlier prior to rename commit:
> 
> uuid_be_t and its corresponding helpers (eg. UUID_BE_INIT) follow BE format.
> uuid_le_t and its corresponding helpers (eg. UUID_LE_INIT) follow LE format.
> 
> But even if we consider later case as well, I am still not sure if we
> can switch to uuid_le_t as it's been part of TEE core ABI
> (open_session) where UUID is passed in BE format (see LE to BE
> conversion in TEE client [1] and vice-versa in OP-TEE OS [2]) and
> won't be a backwards compatible change.
> 
> [1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/tee_client_api.c#L595
> [2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/ree_fs_ta.c#L92

I'm struck that all references here are to code that does not run in
kernel space. Frankly on LKML I don't know if we should even *care* what
format UUIDs are stored in other address spaces.

We care about is the endianness of the UUID on the interface boundaries
into and out of the kernel[1] and we care that we use the correct kernel
type to describe it.

I understood from Jerome's post that the UUID that the kernel
manipulates are, in fact, big endian and that they should be called
uuid_t.

Is there more going on here or is that it?


Daniel.


[1] I guess we'd also like those interface boundaries to be reasonably
    sane but if they already exist and are the interface is consistent
    about endianness then I find it hard to see no reason for a
    gratuitous endianness change.
