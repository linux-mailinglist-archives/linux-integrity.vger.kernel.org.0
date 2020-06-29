Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4343C20E211
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2020 00:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390161AbgF2VCK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 17:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731177AbgF2TMv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CEBC08ED07
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jun 2020 23:55:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q7so3520386ljm.1
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jun 2020 23:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJRa3lLZIGNEa0u0bubwwSGZfoJedNAcGkyPYqNgizc=;
        b=A7bBagnvz+CsMEc9lE6It2pGWXk9fRL3Zintjy5iI8PEvE/kGQ//XRKdnwtTJ/BX3G
         O4aAviDJhqgfwsn54Rxa0bWfsz1MsLfhkjcSyWywRQr/6jbaU4l+wWcEBxdbhtAx8oqT
         QslK/7YhyguhlNukH/0XSYiQmd7tPvOWT81/g6vsCZERYc/oNp1DnRhhA6kbR2TKnDXD
         BbojcHXCNvUeAHPXhtOad77ctyHVVJ+pGyhyZ7aqblW3z2I9fx/PzJqodEqwfBawklGy
         hxAx1Mx0Ufmye2g8oX2sp+qThavwH+xNDKrp+eTzn9Q+zDmhyBT9M1eMjXnb48twOHZK
         yE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJRa3lLZIGNEa0u0bubwwSGZfoJedNAcGkyPYqNgizc=;
        b=q6uH+FfIcrj0nYeUzbT0/cmFLnr0PFzhRFPvZtXcXA8xxfczRpS13l0CyNbADD0cNB
         NkfVTfV7YhlbFBoAoCU54ZiBlmKyBV9Zs6ju/nY5iektnwihDSX0CjMArnNIVkOb6UDt
         qa1redTZN6+a8WjSZcJverSI9juErrMmjrAiyrzmvoWWBRGe/l32zpRVWNl4s0v+KP6K
         Evuu3N8qK4Mfr+301E9mGvAjeX3zpO+2JiPDh8duZig0KZctJMReOj8W4rq6UU/pSkTi
         KWjfT+6w5b58+fd5jgyaaG+2mMiZhcczVawtugH6GBsZzvkYh6gYRcY3B/6T41QYB51z
         9Lrg==
X-Gm-Message-State: AOAM531Fm67M2vE/AhGs/lUhoa7oaff5yb/QGNtMB/eX1iBCjAFaoEPB
        Qq4dt/hcd/0rw42jbUZnRx2Cf1FzaDePCT8b2QpzvQ==
X-Google-Smtp-Source: ABdhPJxBGJZuEQ8BqbOfIhB8sjR3+C/M0w9SaWT9vxyNM9d4n775uSZF4RCCLgXRgJMiuLvaM8Fk0wqmaZ4lwwYr9YE=
X-Received: by 2002:a2e:850b:: with SMTP id j11mr7174734lji.30.1593413730053;
 Sun, 28 Jun 2020 23:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com> <CAFA6WYMF+JjrB9Cx9TdgDzMeQSvPZfMNapzD-MH4ALVoUoo1sQ@mail.gmail.com>
 <1593127902.13253.11.camel@HansenPartnership.com> <CAFA6WYMPtLtv=cWppU=-LZp6FD_3KYymrLgVP+-KQd_N_GcT_Q@mail.gmail.com>
 <20200626112927.vfffwdhzdjf6ndmb@holly.lan> <1593184281.7381.16.camel@HansenPartnership.com>
In-Reply-To: <1593184281.7381.16.camel@HansenPartnership.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 29 Jun 2020 12:25:18 +0530
Message-ID: <CAFA6WYMKbm7HxGf_041JPD+wkjXprB9h+2HgTh4z_Ty97udFSw@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
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

On Fri, 26 Jun 2020 at 20:41, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
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
> trip the static checkers.

This is exactly which is fixed in v9 patch-set to use %Ub on a uuid_t.

>  That shows me there's a confusion in the
> code between little and big endian UUID types, but I haven't looked
> further than that.

From kernel TEE subsystem perspective, it's all big endian UUID type
which forms the ABI into and out of the kernel.

-Sumit

>
> James
>
