Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EADC207068
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbgFXJvB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388998AbgFXJvA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 05:51:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF2C061573
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 02:51:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so1877494ljn.4
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sKHLRgcWO4ZhRPOySi24dajzcXSZuIk6rlKEh3o2c5s=;
        b=lq95J/zOza3A1BI0ec2TDCKrKTaY4uuyHmRpIROZdo7HZYgLTKAzTkIb08UCcIqkFe
         r/dBWyKTxg9fFHkJmPwcjpS833uSJ14HfTMzX1zySvIdOxNYUfNXMUN73yGG7j+L1g2f
         UOuxlCeX+hGTKylfTu1wv6peBwrCMn9ed+hODcYl972iYmctbQkSlGgthesAKD7qFIHF
         LoLbimNsThmJqdvqrGNDaW9mjvabTzPwdVVgV7C1r/VjKObEUszItkAOgwo1I2pDYwQJ
         d+0We32IEL4jfCnjyADTM6VDGGTCXOtp9wSYvAnsRpCW+f/YX4YMwuumfvPcKNH422+g
         Zh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sKHLRgcWO4ZhRPOySi24dajzcXSZuIk6rlKEh3o2c5s=;
        b=O71oDRmg63UjVpLIkRjIwR+8Da6PjmbvbGAdqW2hDmCou61CzPg3povyXdSXo4SxDx
         +85cqNgatQ3ebUxaktQi03PB+mmyU+gwtwYFobnsKus7cA0OIBM65jJy9/lbrNI6ehPl
         WYH5R3/X1DYZJgmskh9JnovqjSK84pRT5QsSuj6iOnUJK7sHzDrxRvh/i5CIxps7NuOa
         bj7VyfeaEU29cs59oselleZlDfG9YC0lQrLHBzgYvGfJI3o6jBtVUeLd8WguzAsQyNT4
         j+5khuk+ziBawZZEV5z3kIYPNZITb8ifSDBCiEf6ujZPUG2KDNjqg+a4bIx9ln6TY4DA
         DY4A==
X-Gm-Message-State: AOAM531ZBoeOsId9JCXFVZaJ7SfWjfJNfSEPJjjXu5mjxIZ64xD4AGIU
        2p2hgtD0Iho2b4uTV4w3ImEpNQ==
X-Google-Smtp-Source: ABdhPJzXLgbSM50f569GDg1HhFmAIfSM1kMC3rlge1j32RJLNo36lV3zXGJGe5zv2k01lf7vQNaIqQ==
X-Received: by 2002:a2e:9041:: with SMTP id n1mr7856442ljg.67.1592992258776;
        Wed, 24 Jun 2020 02:50:58 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id e80sm4990734lfd.64.2020.06.24.02.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 02:50:58 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:50:55 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerome Forissier <jerome@forissier.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
Message-ID: <20200624095055.GA1336604@jade>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
 <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com>
 <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1592578844.4369.5.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 19, 2020 at 08:00:44AM -0700, James Bottomley wrote:
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
> It's not about consistency with the OP-TEE docs (although I'm pretty
> sure they don't mandate what kernel type to use), it's about
> consistency with what the kernel types mean.  When some checker detects
> your using little endian operations on a big endian structure (like in
> the prink for instance) they're going to keep emailing you about it.

Thanks for the clarification. Sumit, Maxim, please take care of this.

Cheers,
Jens

> 
> James
> 
