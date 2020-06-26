Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0120B436
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFZPLZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 11:11:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51862 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgFZPLZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 11:11:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B04DA8EE25D;
        Fri, 26 Jun 2020 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593184284;
        bh=9gRlHJuWfxaDuLlI6MepXpQCwc5rECThM9BQ89P4ZfU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=czwfGzo5CVll8EH44IbhLTHxG+ZQG9KZvCxLefUkJu3szWaXT1LIk14lyoLCDg4cQ
         UQXcJmwq7gkQpF9Tw8kvq2LSpPVaARAvXfAZVZWlfiTdQkyNkDZ1txsQt8u0PEode0
         4vsf+F9R+KcOSfNLiYNyRP3oEObDvkD9vJhvaQms=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8tu5VS6kzL4H; Fri, 26 Jun 2020 08:11:24 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8572D8EE051;
        Fri, 26 Jun 2020 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593184284;
        bh=9gRlHJuWfxaDuLlI6MepXpQCwc5rECThM9BQ89P4ZfU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=czwfGzo5CVll8EH44IbhLTHxG+ZQG9KZvCxLefUkJu3szWaXT1LIk14lyoLCDg4cQ
         UQXcJmwq7gkQpF9Tw8kvq2LSpPVaARAvXfAZVZWlfiTdQkyNkDZ1txsQt8u0PEode0
         4vsf+F9R+KcOSfNLiYNyRP3oEObDvkD9vJhvaQms=
Message-ID: <1593184281.7381.16.camel@HansenPartnership.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Date:   Fri, 26 Jun 2020 08:11:21 -0700
In-Reply-To: <20200626112927.vfffwdhzdjf6ndmb@holly.lan>
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
         <20200626112927.vfffwdhzdjf6ndmb@holly.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-26 at 12:29 +0100, Daniel Thompson wrote:
> On Fri, Jun 26, 2020 at 10:40:41AM +0530, Sumit Garg wrote:
> > On Fri, 26 Jun 2020 at 05:01, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > 
> > > On Thu, 2020-06-25 at 19:54 +0530, Sumit Garg wrote:
> > > > On Wed, 24 Jun 2020 at 20:51, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > 
> > > > > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > > > > > Apologies for delay in my reply as I was busy with some
> > > > > > other stuff.
> > > > > > 
> > > > > > On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > 
> > > > > [...]
> > > > > > > it's about consistency with what the kernel types
> > > > > > > mean.  When some checker detects your using little endian
> > > > > > > operations on a big endian structure (like in the prink
> > > > > > > for instance) they're going to keep emailing you about
> > > > > > > it.
> > > > > > 
> > > > > > As mentioned above, using different terminology is meant to
> > > > > > cause more confusion than just difference in endianness
> > > > > > which is manageable inside TEE.
> > > > > > 
> > > > > > And I think it's safe to say that the kernel implements
> > > > > > UUID in big endian format and thus uses %pUb whereas OP-TEE
> > > > > > implements UUID in little endian format and thus uses %pUl.
> > > > > 
> > > > > So what I think you're saying is that if we still had uuid_be
> > > > > and uuid_le you'd use uuid_le, because that's exactly the
> > > > > structure described in the docs.  But because we renamed
> > > > > 
> > > > > uuid_be -> uuid_t
> > > > > uuid_le -> guid_t
> > > > > 
> > > > > You can't use guid_t as a kernel type because it has the
> > > > > wrong name?
> > > > 
> > > > Isn't the rename commit description [1] pretty clear about
> > > > which is the true UUID type from Linux point of view?
> > > 
> > > I don't think the kernel code takes a position on eternal verity,
> > > just on logical or arithmetic truth.  We just have to deal with
> > > both LE and BE UUIDs so we have appropriate types for them and
> > > the LE type is now named guid_t.  They're both equally correct to
> > > use provided the use case matches the designed one. So does the
> > > name really matter?
> > 
> > Yes it does. I guess I have provided enough reasoning for that.
> > Also, the rename commit itself illustrates its importance and
> > clarifies the use case for which they are meant to be used.
> > 
> > > If we did
> > > 
> > > #define uuid_le_t guid_t
> > > 
> > > would you be happy? (not that the kernel cares about karmic
> > > emotional states either ...)
> > 
> > It's not about me being happy but more about confusion and
> > inconsistency it will bring.
> > 
> > IMO, either kernel should be opinionated about UUID endianness like
> > currently it is:
> > 
> > uuid_t and its corresponding helpers (eg. UUID_INIT) follows BE
> > format.
> > 
> > or support both endianness for UUID (no common type: uuid_t) like
> > we had earlier prior to rename commit:
> > 
> > uuid_be_t and its corresponding helpers (eg. UUID_BE_INIT) follow
> > BE format. uuid_le_t and its corresponding helpers (eg.
> > UUID_LE_INIT) follow LE format.
> > 
> > But even if we consider later case as well, I am still not sure if
> > we can switch to uuid_le_t as it's been part of TEE core ABI
> > (open_session) where UUID is passed in BE format (see LE to BE
> > conversion in TEE client [1] and vice-versa in OP-TEE OS [2]) and
> > won't be a backwards compatible change.
> > 
> > [1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/
> > tee_client_api.c#L595
> > [2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/ke
> > rnel/ree_fs_ta.c#L92
> 
> I'm struck that all references here are to code that does not run in
> kernel space. Frankly on LKML I don't know if we should even *care*
> what format UUIDs are stored in other address spaces.
> 
> We care about is the endianness of the UUID on the interface
> boundaries into and out of the kernel[1] and we care that we use the
> correct kernel type to describe it.
> 
> I understood from Jerome's post that the UUID that the kernel
> manipulates are, in fact, big endian and that they should be called
> uuid_t.
> 
> Is there more going on here or is that it?

As you say, a UUID to the kernel is a binary blob except for input,
which to the kernel is INIT_UUID or INIT_GUID and output, which is
either printk %Ub for uuid_t or %Ul for guid_t.

The bit I objected to was doing a %Ul on a uuid_t because it's going to
trip the static checkers.  That shows me there's a confusion in the
code between little and big endian UUID types, but I haven't looked
further than that.

James

