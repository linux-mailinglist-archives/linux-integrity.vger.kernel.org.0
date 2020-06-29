Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6520DFA1
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2020 23:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgF2Uif (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 16:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbgF2TOT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2E5C08ED88
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2020 00:03:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so16795946ljn.4
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2020 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/yELURPUELr0RANbRRCH86eAdkrYG/jrKJ3LKXC0aDE=;
        b=yXEm3fbqcQwKG7nK61aZx2+tS2B2siGdpA4FyZTHm16lqgr2Bo7W568PHnFym4vvIe
         Bhh4eDSCBfbMHgr7VXw9iGOWRVH2sf7qPL8lP79n1rmAdkEf5nuMzDfshmewhppuwIS1
         cvi6+g6PaH29gy4HE8w/+UeYVupFgBRrXcKclUxY8FNZ9kw1YFjgL/YEwEvZa0zTTicC
         7MXclKLVA9gFU4Mngd2CNr7txYKtPrErDDuaEiR7TaTrtcxy/OBO1L30Q7Qt6kJXmd4v
         LepJuk1zJC7tfvnkcRnJxWbAfCXkr6WWg8MilG8BmNYzBg5UywX8g9UySb+KVjloeLeX
         M/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/yELURPUELr0RANbRRCH86eAdkrYG/jrKJ3LKXC0aDE=;
        b=BQLysTkXuBaxV3pHfnd/HQbECsIrFKUDGaZ1LTHfY/jNsZ65KSQIuKVr3zFf+KH8pG
         rnYS4dV8G/jYYMCRLyVa44pEQFz34AMeBwYq18P+KHdJwT/dbzzqHTD0Dfa5qZ5VsJtd
         ySgNEAc6GPX0Whd8yM1wi0vd0w3hympOigaSUHXfyYF1+tUo/X1Ncg+IbGfgt3wMrAiF
         H+DssB7zjORHuBN1tNbqABDlq287QkXEn6zgD8a4TjS1W/2qP0CTrtF3NpXimoxqlIDQ
         PVVNCOf1gHsx964/2OEcbb4UQGT3LAr1XW94MkwkjWznWeXr8r/ExUu4fgTMj6swZk84
         3hDQ==
X-Gm-Message-State: AOAM532bjmwaqR/hxzW2Z/0xvrmICK7n8uo88EGeE9V4h9FChM4w5gKf
        d3YNc66jevMrpb19ULOsrTmyrA==
X-Google-Smtp-Source: ABdhPJyg3TRcwVaCz2Ovo25g6+LWQDnpAnhfZXFDel+ueVCszVoT1erbwZAMnYSynbMCv0qdmnRLGg==
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr2982371ljj.462.1593414185044;
        Mon, 29 Jun 2020 00:03:05 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id e80sm8969653lfd.64.2020.06.29.00.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 00:03:04 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:03:02 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
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
Message-ID: <20200629070302.GA210870@jade>
References: <1592507935.15159.5.camel@HansenPartnership.com>
 <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com>
 <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com>
 <CAFA6WYMF+JjrB9Cx9TdgDzMeQSvPZfMNapzD-MH4ALVoUoo1sQ@mail.gmail.com>
 <1593127902.13253.11.camel@HansenPartnership.com>
 <CAFA6WYMPtLtv=cWppU=-LZp6FD_3KYymrLgVP+-KQd_N_GcT_Q@mail.gmail.com>
 <20200626112927.vfffwdhzdjf6ndmb@holly.lan>
 <1593184281.7381.16.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593184281.7381.16.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 26, 2020 at 08:11:21AM -0700, James Bottomley wrote:
> On Fri, 2020-06-26 at 12:29 +0100, Daniel Thompson wrote:
> > On Fri, Jun 26, 2020 at 10:40:41AM +0530, Sumit Garg wrote:
> > > On Fri, 26 Jun 2020 at 05:01, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > 
> > > > On Thu, 2020-06-25 at 19:54 +0530, Sumit Garg wrote:
> > > > > On Wed, 24 Jun 2020 at 20:51, James Bottomley
> > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > 
> > > > > > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > > > > > > Apologies for delay in my reply as I was busy with some
> > > > > > > other stuff.
> > > > > > > 
> > > > > > > On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > > > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > 
> > > > > > [...]
> > > > > > > > it's about consistency with what the kernel types
> > > > > > > > mean.  When some checker detects your using little endian
> > > > > > > > operations on a big endian structure (like in the prink
> > > > > > > > for instance) they're going to keep emailing you about
> > > > > > > > it.
> > > > > > > 
> > > > > > > As mentioned above, using different terminology is meant to
> > > > > > > cause more confusion than just difference in endianness
> > > > > > > which is manageable inside TEE.
> > > > > > > 
> > > > > > > And I think it's safe to say that the kernel implements
> > > > > > > UUID in big endian format and thus uses %pUb whereas OP-TEE
> > > > > > > implements UUID in little endian format and thus uses %pUl.
> > > > > > 
> > > > > > So what I think you're saying is that if we still had uuid_be
> > > > > > and uuid_le you'd use uuid_le, because that's exactly the
> > > > > > structure described in the docs.  But because we renamed
> > > > > > 
> > > > > > uuid_be -> uuid_t
> > > > > > uuid_le -> guid_t
> > > > > > 
> > > > > > You can't use guid_t as a kernel type because it has the
> > > > > > wrong name?
> > > > > 
> > > > > Isn't the rename commit description [1] pretty clear about
> > > > > which is the true UUID type from Linux point of view?
> > > > 
> > > > I don't think the kernel code takes a position on eternal verity,
> > > > just on logical or arithmetic truth.  We just have to deal with
> > > > both LE and BE UUIDs so we have appropriate types for them and
> > > > the LE type is now named guid_t.  They're both equally correct to
> > > > use provided the use case matches the designed one. So does the
> > > > name really matter?
> > > 
> > > Yes it does. I guess I have provided enough reasoning for that.
> > > Also, the rename commit itself illustrates its importance and
> > > clarifies the use case for which they are meant to be used.
> > > 
> > > > If we did
> > > > 
> > > > #define uuid_le_t guid_t
> > > > 
> > > > would you be happy? (not that the kernel cares about karmic
> > > > emotional states either ...)
> > > 
> > > It's not about me being happy but more about confusion and
> > > inconsistency it will bring.
> > > 
> > > IMO, either kernel should be opinionated about UUID endianness like
> > > currently it is:
> > > 
> > > uuid_t and its corresponding helpers (eg. UUID_INIT) follows BE
> > > format.
> > > 
> > > or support both endianness for UUID (no common type: uuid_t) like
> > > we had earlier prior to rename commit:
> > > 
> > > uuid_be_t and its corresponding helpers (eg. UUID_BE_INIT) follow
> > > BE format. uuid_le_t and its corresponding helpers (eg.
> > > UUID_LE_INIT) follow LE format.
> > > 
> > > But even if we consider later case as well, I am still not sure if
> > > we can switch to uuid_le_t as it's been part of TEE core ABI
> > > (open_session) where UUID is passed in BE format (see LE to BE
> > > conversion in TEE client [1] and vice-versa in OP-TEE OS [2]) and
> > > won't be a backwards compatible change.
> > > 
> > > [1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/
> > > tee_client_api.c#L595
> > > [2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/ke
> > > rnel/ree_fs_ta.c#L92
> > 
> > I'm struck that all references here are to code that does not run in
> > kernel space. Frankly on LKML I don't know if we should even *care*
> > what format UUIDs are stored in other address spaces.
> > 
> > We care about is the endianness of the UUID on the interface
> > boundaries into and out of the kernel[1] and we care that we use the
> > correct kernel type to describe it.
> > 
> > I understood from Jerome's post that the UUID that the kernel
> > manipulates are, in fact, big endian and that they should be called
> > uuid_t.
> > 
> > Is there more going on here or is that it?
> 
> As you say, a UUID to the kernel is a binary blob except for input,
> which to the kernel is INIT_UUID or INIT_GUID and output, which is
> either printk %Ub for uuid_t or %Ul for guid_t.
> 
> The bit I objected to was doing a %Ul on a uuid_t because it's going to
> trip the static checkers.  That shows me there's a confusion in the
> code between little and big endian UUID types, but I haven't looked
> further than that.

Thanks for bringing our attention to this, it was educating for me at
least. It seems the only problem was just the %Ul that should have been
a %Ub. The OP-TEE driver is only dealing with BE UUIDs internallay and
in the ABIs to user space and secure world.

I agree with Daniel, what happens in user space and in secure world
isn't of interest here as long as the ABIs are OK.

Cheers,
Jens
