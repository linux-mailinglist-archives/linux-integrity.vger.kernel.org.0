Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C697B20155A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgFSQVZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 12:21:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53378 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390663AbgFSPAw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 11:00:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A11F68EE181;
        Fri, 19 Jun 2020 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592578846;
        bh=zaOfjMLUicfvkFqmOv15FzKipwPwAhku6LgsJnkaFCQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p8LdRkUmPri2dS1AzivVmaFMMNqMakT3EjlWS2ud4bHoPUae0D1rxgD3z1IuUPLeQ
         jGBdWsfgGCHgTRRkzl/rp6uCndRHHKDQ4Wnw3jBbXfgHDaj+UpNH9vJKs8l3XEUejs
         p5yJs5WAnMhSK3Ga2lYWHsIYcy+D6tQxshS0U4Xs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vTJBUrhddUy4; Fri, 19 Jun 2020 08:00:46 -0700 (PDT)
Received: from jarvis (unknown [216.116.10.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9CE508EE149;
        Fri, 19 Jun 2020 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1592578846;
        bh=zaOfjMLUicfvkFqmOv15FzKipwPwAhku6LgsJnkaFCQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p8LdRkUmPri2dS1AzivVmaFMMNqMakT3EjlWS2ud4bHoPUae0D1rxgD3z1IuUPLeQ
         jGBdWsfgGCHgTRRkzl/rp6uCndRHHKDQ4Wnw3jBbXfgHDaj+UpNH9vJKs8l3XEUejs
         p5yJs5WAnMhSK3Ga2lYWHsIYcy+D6tQxshS0U4Xs=
Message-ID: <1592578844.4369.5.camel@HansenPartnership.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Date:   Fri, 19 Jun 2020 08:00:44 -0700
In-Reply-To: <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
         <20200604175851.758-2-maxim.uvarov@linaro.org>
         <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
         <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
         <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
         <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
         <1592507935.15159.5.camel@HansenPartnership.com>
         <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-19 at 13:42 +0530, Sumit Garg wrote:
> On Fri, 19 Jun 2020 at 00:49, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Thu, 2020-06-18 at 10:42 +0530, Sumit Garg wrote:
> > > On Thu, 18 Jun 2020 at 10:29, Sumit Garg <sumit.garg@linaro.org>
> > > wrote:
> > 
> > [...]
> > > > > typedef struct
> > > > > {
> > > > >         uint32_t timeLow;
> > > > >         uint16_t timeMid;
> > > > >         uint16_t timeHiAndVersion;
> > > > >         uint8_t clockSeqAndNode[8];
> > > > > } TEE_UUID;
> > > > > 
> > > > > (GlobalPlatform TEE Internal Core API spec v1.2.1 section
> > > > > 3.2.4)
> > > > > 
> > > > > - The spec does not mandate any particular endianness and
> > > > > simply
> > > > > warnsabout possible issues if secure and non-secure worlds
> > > > > differ
> > > > > in endianness.
> > > > > - OP-TEE uses %pUl assuming that host order is little endian
> > > > > (that is true for the Arm platforms that run OP-TEE
> > > > > currently).
> > > > > By the same logic %pUl should be fine in the kernel.
> > > 
> > > I think Linux adheres to this RFC [1] for UUID byte order. See
> > > below
> > > snippet from section: "Layout and Byte Order":
> > > 
> > >    The fields are encoded as 16 octets, with the sizes and order
> > > of
> > > the
> > >    fields defined above, and with each field encoded with the
> > > Most
> > >    Significant Byte first (known as network byte order).  Note
> > > that
> > > the
> > >    field names, particularly for multiplexed fields, follow
> > > historical
> > >    practice.
> > 
> > Actually, that's not quite true.  We used to support both little
> > and
> > big endian uuids until we realised it was basically microsoft vs
> > everyone else (as codified by RFC 4122).  Now we support UUIDs
> > which
> > are big endian and GUIDs which are little endian.  This was the
> > commit
> > that sorted out the confusion:
> > 
> > commit f9727a17db9bab71ddae91f74f11a8a2f9a0ece6
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Wed May 17 10:02:48 2017 +0200
> > 
> >     uuid: rename uuid types
> > 
> 
> Thanks for providing the background here.
> 
> > so if you're using a little endian uuid, you should probably be
> > using GUID for TEE_UUID.
> 
> IMO, using GUID in kernel for TEE_UUID in OP-TEE OS will lead to
> deviation from GlobalPlatform TEE client spec [1] as the spec only
> references it as UUID and we would like to keep kernel TEE client
> interface to be compatible with GP specs.
> 
> [1] https://globalplatform.org/specs-library/tee-client-api-specifica
> tion/

So having read the above, you know uuid_t is for big endian and guid_t
for little endian.  However in your patch:

> -static int optee_register_device(const uuid_t *device_uuid, u32
> device_id)
> +static int optee_register_device(const uuid_t *device_uuid)
> 

You're using uuid_t for little endian, you should be using guid_t. 
It's not about consistency with the OP-TEE docs (although I'm pretty
sure they don't mandate what kernel type to use), it's about
consistency with what the kernel types mean.  When some checker detects
your using little endian operations on a big endian structure (like in
the prink for instance) they're going to keep emailing you about it.

James

