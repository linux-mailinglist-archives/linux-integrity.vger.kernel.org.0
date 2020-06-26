Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6867120ABBE
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 07:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgFZFN3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 01:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZFN3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 01:13:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD74BC08C5C1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 22:13:28 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c11so4444832lfh.8
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 22:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlzbbRoUsiNgCT+vaniYsWp4jyroliVG1Gc8oOdbYFc=;
        b=ovzR0esJWDDdDFb0jyp9YafS2plBJiJOi/tQHePW6RnDCVpGvwaXPT2LuDIrUgc3q2
         19hx1drG3bg59u5lR7vRrAY6Nc3AUcx+SA/aJCuaCCFTu6aQdtWyThAj08WHnhyRw9Wh
         djgKIGc1yRDJDXqra3ydGeqbRZMcEZFebg+jyQ4oWw0einDd3cg+CJMMY2689VPNftDy
         KY4yrmpnhxAj1bfFechr6cP9x/fFBTtyBayKVePsUXqf/2OZ4PJ67B1KUbE2mAg7BxfK
         mB/Qg0/3cqSxnvejiVmmjeA9fcct413ZTfYjwUWRtxtT6icZvCUAo4HVFq7TgeRGMsn9
         7Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlzbbRoUsiNgCT+vaniYsWp4jyroliVG1Gc8oOdbYFc=;
        b=EbqVnDO1rTTbSc3E/5hUgyft9p0aywOAzH8X1iR1laYfi3HyhKdyA37iBdmQesLVSx
         2/nrUlaqze5L1i58+0ZQyBVC6uo4Eyr8FnZIcZ+cQBAAY86lsrzBQfdxjcwIxSTIV7MW
         Yw/218H9/dQtji/YRnmXfEJK5XXKlHEzbBsR7Rm46Esfr+oq+yLgtJhqTjEvUD/TyzaD
         Xut2jsOLdbkIydNhim0Vcg2ogvg20vtQ2i/Afn/Y25FqcSQyyxx5nkGWDl9WvIN1ySoX
         m2e1pL17tS2Y+FPZ3PPN5bjV78hWcjQG7yxYBNi9SngqZe+ml1pNREVid1AXxff7mTNe
         qbJg==
X-Gm-Message-State: AOAM533fo5AV8sAJQJwRlkN+x76rgJDeov5Aot8F4JDIOBe6BxelWSg5
        bLUYXZWQOpaZ2ecpVIiOHCNAb9pEGkPT5atlsdS5oA==
X-Google-Smtp-Source: ABdhPJzS7QYS1nugoTAgxtiZp65oSa+zQBCVvgk1F0KpTPkRj4nd5Gfi/Kfsl7MWSE54t3cG5t/3WfNBT0GZqy1mLws=
X-Received: by 2002:a19:435b:: with SMTP id m27mr825249lfj.40.1593148407135;
 Thu, 25 Jun 2020 22:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com> <3aa8705a-0342-25ea-00c4-d5370d91ddb4@forissier.org>
 <CAD8XO3ZDv-RZ-VPv-AFMRkMD_3uW9XYLeZQf0btGVK8m7GX2Dg@mail.gmail.com>
In-Reply-To: <CAD8XO3ZDv-RZ-VPv-AFMRkMD_3uW9XYLeZQf0btGVK8m7GX2Dg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Jun 2020 10:43:15 +0530
Message-ID: <CAFA6WYOiBNQt0ZRyRxfsqW57z+O=aLqi3DTEAfZ7fGjf8UPB3Q@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
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

On Thu, 25 Jun 2020 at 18:22, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Wed, 24 Jun 2020 at 18:44, Jerome Forissier <jerome@forissier.org> wrote:
> >
> >
> >
> > On 6/24/20 5:21 PM, James Bottomley wrote:
> > > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > >> Apologies for delay in my reply as I was busy with some other stuff.
> > >>
> > >> On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > >> <James.Bottomley@hansenpartnership.com> wrote:
> > > [...]
> > >>> it's about consistency with what the kernel types mean.  When some
> > >>> checker detects your using little endian operations on a big endian
> > >>> structure (like in the prink for instance) they're going to keep
> > >>> emailing you about it.
> > >>
> > >> As mentioned above, using different terminology is meant to cause
> > >> more confusion than just difference in endianness which is manageable
> > >> inside TEE.
> > >>
> > >> And I think it's safe to say that the kernel implements UUID in big
> > >> endian format and thus uses %pUb whereas OP-TEE implements UUID in
> > >> little endian format and thus uses %pUl.
> > >
> > > So what I think you're saying is that if we still had uuid_be and
> > > uuid_le you'd use uuid_le, because that's exactly the structure
> > > described in the docs.  But because we renamed
> > >
> > > uuid_be -> uuid_t
> > > uuid_le -> guid_t
> > >
> > > You can't use guid_t as a kernel type because it has the wrong name?
> >
> > Let me try to clear the confusion that I introduce myself I believe :-/
> > IMO:
> >
> > - optee_register_device(const uuid_t *device_uuid) *is* the correct
> > prototype.
> > - device_uuid is *guaranteed* to be BE because OP-TEE makes this
> > guarantee (it converts from its internal LE representation to BE when
> > enumerating the devices, but it doesn't matter to the kernel).
> > - Therefore %pUb is the correct format.
> >
> > I'm sorry for doubting the BE order initially. I am so used to OP-TEE
> > using LE internally, that I missed the fact that we have an explicit
> > conversion...
> >
> > Does this sound good?
> >
> > Thanks,
> > --
> > Jerome
>
> I think your description is correct. But I think this problem  would
> be solved outside of the current patchset.
> All places should use one single format (LE):

I guess you missed the point that uuid_t is implemented in BE format
in the kernel which is compliant as per RFC 4122.

> -  internal optee representation;
> -  device enumeration pta;
> -  this kernel driver which creates sysfs entry and sets
> uid_copy(&optee_device->id.uuid, device_uuid);
> -  matching function;
> -  drivers use UUID_INIT();

See carefully the implementation of UUID_INIT() which is in BE format.

-Sumit

>
> In that way everything will be consistent. But it will require
> changing other pieces, not just the kernel. While
> these patches add functionality to support current device enumeration
> in optee os.
> So I think this version is ok to be applied.
>
> Regards,
> Maxim.
