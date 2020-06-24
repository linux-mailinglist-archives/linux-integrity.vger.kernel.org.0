Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0A207177
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 12:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgFXKrb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 06:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388421AbgFXKr3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 06:47:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865FC061573
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 03:47:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a9so2012098ljn.6
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyTXXlvMUy40CYC5v7Z+Q/X5JA59REcubb6BNXoR+UQ=;
        b=huUJ3BiU3tuUASS9pTZvMRr7NtR7fyU6ufd6mFmDhk+We49iclpDaz+6XuZIaaS61g
         3PbhOg5c8MDBdjNgXIhKM1Wst9e3rNYqGZ4cGa54y4ag8GHZHvFKwdaM6z/aHBNal5TR
         63HpNxhw1Mp0e+6mgLvlia0cko1mMH4bTMe+zLk3DyK8CuoL+WmMCbSEZuCPFlfjgyt4
         LXyxEBsrLXnQJStwdA0WbyMVIcwXWuI4H/NDvKsd2FPGIO0/D4sPP+qOTttIQSJ++yuq
         LJ5XqLAhq2r3spv9uwr4NzwaLsbLIFeGiJppIJNNf4LixUOihowmmFqXVHEqleBGFzxf
         ONwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyTXXlvMUy40CYC5v7Z+Q/X5JA59REcubb6BNXoR+UQ=;
        b=qHd/z5PW48c+Y3VbPEx6SGGx1YS4FCFzzu0iDiz/7kg/HAM8dkomhZRnhqZ/sPIAHD
         l0YUA3vd7XqTVtPH8MKLb1JJaS8RN7rH43TRCCmFNzY84RUarz4oqKD6W8ZgSd56nmrk
         P5hsSaXXe+oJPn71kSchazwRDle7mCpFW5GENrs3OfbaNDrVOPj0Ssi1wmR7fpHXAVtd
         2FrqUBz2fo3hZIQZhEIlJ0zjc0Nee9CTHaVKpH9vfZAK7UUgK/hHtXi7KNYkadEOmOXf
         tD8RizuptosDzfQY4TCfH9kdshPUR2cGRwUy4Uu8UoSrZWurH8CiF8Bs2mJxoYdHuVnj
         c02Q==
X-Gm-Message-State: AOAM532BPRi54Y600PfSKlyKu63FeVUu7Q4wa+uV4SnYzVpRUCxLbg1j
        hiCdws8j6DtUKaW4kOoJBwjhGWlrBdra5dsa+S+aug==
X-Google-Smtp-Source: ABdhPJxf9FrzVIQOZki7R3VE9LFaHkJdw0tt03trhX3GDRu1Be7sq7Pd7Qb75Wtg2pEP40e2JhI0FKqkQYX/9OfIXZY=
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr14252516ljo.110.1592995646769;
 Wed, 24 Jun 2020 03:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com>
In-Reply-To: <1592578844.4369.5.camel@HansenPartnership.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 24 Jun 2020 16:17:15 +0530
Message-ID: <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
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

Apologies for delay in my reply as I was busy with some other stuff.

On Fri, 19 Jun 2020 at 20:30, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2020-06-19 at 13:42 +0530, Sumit Garg wrote:
> > On Fri, 19 Jun 2020 at 00:49, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Thu, 2020-06-18 at 10:42 +0530, Sumit Garg wrote:
> > > > On Thu, 18 Jun 2020 at 10:29, Sumit Garg <sumit.garg@linaro.org>
> > > > wrote:
> > >
> > > [...]
> > > > > > typedef struct
> > > > > > {
> > > > > >         uint32_t timeLow;
> > > > > >         uint16_t timeMid;
> > > > > >         uint16_t timeHiAndVersion;
> > > > > >         uint8_t clockSeqAndNode[8];
> > > > > > } TEE_UUID;
> > > > > >
> > > > > > (GlobalPlatform TEE Internal Core API spec v1.2.1 section
> > > > > > 3.2.4)
> > > > > >
> > > > > > - The spec does not mandate any particular endianness and
> > > > > > simply
> > > > > > warnsabout possible issues if secure and non-secure worlds
> > > > > > differ
> > > > > > in endianness.
> > > > > > - OP-TEE uses %pUl assuming that host order is little endian
> > > > > > (that is true for the Arm platforms that run OP-TEE
> > > > > > currently).
> > > > > > By the same logic %pUl should be fine in the kernel.
> > > >
> > > > I think Linux adheres to this RFC [1] for UUID byte order. See
> > > > below
> > > > snippet from section: "Layout and Byte Order":
> > > >
> > > >    The fields are encoded as 16 octets, with the sizes and order
> > > > of
> > > > the
> > > >    fields defined above, and with each field encoded with the
> > > > Most
> > > >    Significant Byte first (known as network byte order).  Note
> > > > that
> > > > the
> > > >    field names, particularly for multiplexed fields, follow
> > > > historical
> > > >    practice.
> > >
> > > Actually, that's not quite true.  We used to support both little
> > > and
> > > big endian uuids until we realised it was basically microsoft vs
> > > everyone else (as codified by RFC 4122).  Now we support UUIDs
> > > which
> > > are big endian and GUIDs which are little endian.  This was the
> > > commit
> > > that sorted out the confusion:
> > >
> > > commit f9727a17db9bab71ddae91f74f11a8a2f9a0ece6
> > > Author: Christoph Hellwig <hch@lst.de>
> > > Date:   Wed May 17 10:02:48 2017 +0200
> > >
> > >     uuid: rename uuid types
> > >
> >
> > Thanks for providing the background here.
> >
> > > so if you're using a little endian uuid, you should probably be
> > > using GUID for TEE_UUID.
> >
> > IMO, using GUID in kernel for TEE_UUID in OP-TEE OS will lead to
> > deviation from GlobalPlatform TEE client spec [1] as the spec only
> > references it as UUID and we would like to keep kernel TEE client
> > interface to be compatible with GP specs.
> >
> > [1] https://globalplatform.org/specs-library/tee-client-api-specifica
> > tion/
>
> So having read the above, you know uuid_t is for big endian and guid_t
> for little endian.  However in your patch:
>
> > -static int optee_register_device(const uuid_t *device_uuid, u32
> > device_id)
> > +static int optee_register_device(const uuid_t *device_uuid)
> >
>
> You're using uuid_t for little endian, you should be using guid_t.

It's not just about implementation differences but about terminology
as well. AFAIK about GUID, it's been typically used in Microsoft
centric softwares as compared to UUID which is generically defined by
RFC 4122.

AFAIU about the differences [1] among UUID and GUID, it seems like
UUID is a subset of GUID. IOW, we can't say that every GUID can be
represented as UUID as per RFC 4122.

So by using different terminology in the kernel with respect to a TEE
implementation is meant to cause more confusion among users than
difference in implementation details (like endianness).

[1] https://stackoverflow.com/questions/246930/is-there-any-difference-between-a-guid-and-a-uuid

> It's not about consistency with the OP-TEE docs (although I'm pretty
> sure they don't mandate what kernel type to use),

The document which I shared wasn't OP-TEE specific but a generic TEE
specification defined by GlobalPlatform. And that spec doesn't put any
restrictions on UUID endianness. So it is very much possible that
another TEE implementation could implement UUID in big endian format
as the kernel does.

> it's about
> consistency with what the kernel types mean.  When some checker detects
> your using little endian operations on a big endian structure (like in
> the prink for instance) they're going to keep emailing you about it.

As mentioned above, using different terminology is meant to cause more
confusion than just difference in endianness which is manageable
inside TEE.

And I think it's safe to say that the kernel implements UUID in big
endian format and thus uses %pUb whereas OP-TEE implements UUID in
little endian format and thus uses %pUl.

-Sumit

>
> James
>
