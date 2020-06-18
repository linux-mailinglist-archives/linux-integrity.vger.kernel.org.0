Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526231FED18
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 10:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgFRIAQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 04:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgFRIAP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 04:00:15 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEADC061755
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 01:00:14 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t74so2924674lff.2
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qptjWv5QaH7ssYbTbkU4Sp0zpzNaH0jRkKGIEYFhpI8=;
        b=vmqJCWbgVxlm1ZqXwH/tMdG9YikGGCD1qScFR1RwK0tjtXxlQusjDZSZrDZMmlmgOV
         fK4DQjB58+941HABE98dRmPBfBWz23WXDH8N+uvmstjx3eUnv8u0yobx9CENdWX2I0go
         C2VUE+VNp2BNUZzJsH1lvnSUJW6ERL0+BxcZa7Rfu7ZiyLhLOfB+s5CIzDi8QAr2jfV1
         RRNMYwvHL91rMzxpJgtHY1dpdEqnCnXcR8Edz5UMeYUy0cMj5RzEFX5OOJij3Al1tBZZ
         gYhf+6wtf5VP/6B60/j0k7upSNWezHr0yefBWbXXR0hUeuj+L6jb4JPdzoczJpu5GYEY
         JPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qptjWv5QaH7ssYbTbkU4Sp0zpzNaH0jRkKGIEYFhpI8=;
        b=hwFkEmM5/M8kLuzPz62mDclB1vAg9cFShn9ms4U6oYGODox7wzCznPg7RSSm702FJ5
         q6w+TYlGefvE9ut0v4bIlEAfR24b2d3rWZbrxST4FT7IhOf/ENKgDYC5W6OL2FVm1Ivw
         H6KatRLlKOOOHb5hQ4WZ1JJ7C8gw7jS3Tv/MaVa/kCUO9M+yql3bGF2nPeKjFH3IL2lP
         VV9eNHlUw+JnNSE0wzfPLkcCnxh8tiTaAEm+JRP+Jbtl3KPzbX8b8EmRzjCL3PwAwQlI
         M4VuwZxh0M3kRZMCd8rdeLmt3r+DRAPiAFQ18cfFYU17xbiqlmI5vVn6Oa70h8ze7goH
         kIgg==
X-Gm-Message-State: AOAM5316nXszcszvNZkySRos7KfRIkdXtTg8ESgjZXSI+X3taLFY2oDm
        hM6NH3e+hQdSJjQqp2hgKUzsFg==
X-Google-Smtp-Source: ABdhPJy+ckAArcLwd+8dcpNkBx8F8ZwigIAiiXDYWxdSoPmZjxDhrmskcqwPdgvXXiBxDfhQgNz8JQ==
X-Received: by 2002:a19:6c5:: with SMTP id 188mr1659649lfg.15.1592467212657;
        Thu, 18 Jun 2020 01:00:12 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id a18sm467941ljm.65.2020.06.18.01.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:00:12 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:00:09 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200618080009.GB97184@jade>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
 <20200616082907.GA2305431@jade>
 <CAD8XO3bY7tsEF29AoXtREQ=tYyAL34s2uHke5LiRaKPBx8Xm2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8XO3bY7tsEF29AoXtREQ=tYyAL34s2uHke5LiRaKPBx8Xm2A@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 17, 2020 at 05:26:42PM +0300, Maxim Uvarov wrote:
> On Tue, 16 Jun 2020 at 11:29, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi Maxim and Jarkko,
> >
> > On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> > > ping.
> > > Patchset was reviewed and all comments are codeverd. Optee-os patches
> > > were merged. These kernel patches look like they are hanging
> > > somewhere...
> >
> > I'm almost OK with this patchset, except that
> > Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
> > for the new kernel version and TEE mailing list which we're changing right
> > now.
> >
> 
> What is the new mailing list address? I did git pull the latest
> master and get_maintainer.pl still points to
> tee-dev@lists.linaro.org.

I'm sorry, I should have mentioned that. I just sent a pull request
to update it so it will have changed by the time these patches gets
merged. The new address is op-tee@lists.trustedfirmware.org

Cheers,
Jens

> 
> Maxim.
> 
> > The last patch touches files I'm not maintainer of. That patch depends
> > on the previous patches so it makes sense to keep them together.  If a
> > TPM device driver maintainer would ack that patch I can take it via my
> > tree. Or we can do it the other way around (with a v9 patchset),
> > whichever is preferred.
> >
> > Cheers,
> > Jens
> >
> > >
> > > Thanks,
> > > Maxim.
> > >
> > > On Thu, 4 Jun 2020 at 20:58, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> > > >
> > > > v8: - fix v7 check.
> > > > v7: - check return value of dev_set_name() (Jarkko Sakkinen)
> > > > v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
> > > > v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
> > > >     - added missed kfree in optee_open()
> > > > v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
> > > >     - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
> > > > v3: - support tee-suppicant restart (Jens Wiklander)
> > > >     - description and comments (Jarkko Sakkinen)
> > > >     - do not name optee drivers by index in sysfs (Sumit Garg)
> > > > v2: - write TEE with capital letters.
> > > >     - declare __optee_enumerate_device() as static.
> > > >
> > > > Maxim Uvarov (3):
> > > >   optee: use uuid for sysfs driver entry
> > > >   optee: enable support for multi-stage bus enumeration
> > > >   tpm_ftpm_tee: register driver on TEE bus
> > > >
> > > >  .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
> > > >  MAINTAINERS                                   |  1 +
> > > >  drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
> > > >  drivers/tee/optee/core.c                      | 27 ++++++-
> > > >  drivers/tee/optee/device.c                    | 38 +++++-----
> > > >  drivers/tee/optee/optee_private.h             | 10 ++-
> > > >  6 files changed, 119 insertions(+), 35 deletions(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> > > >
> > > > --
> > > > 2.17.1
> > > >
