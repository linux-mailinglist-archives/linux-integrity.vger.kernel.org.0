Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3F222A0F
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 19:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgGPRiN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 13:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPRiN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 13:38:13 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B25C061755
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jul 2020 10:38:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a8so5394589edy.1
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jul 2020 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVT0J9Mnoh6KQFZ+Is1z4W+ElwDxGQDJlUT/PfjxoTs=;
        b=AkFSpU6dl4IWPv94BJbTRzhClWvrcotA8ft9jlYZBWyqGWGpijHqy3bFvogJ6NBmxp
         +RrPka0inm9ERTMBaoGlH/pu1QgWwQuEAIOWKVTpxIq5P6FK9n5ipj65Dz3s48V6Shou
         zXr553DUydsZpqrGw2gItSaEmo2RP0eZ9q0oJtsmHcQkQ8pIOizvzo381PBt4LOMUaDL
         A2V5F/X82783qDM+zPTBVaR8i1AGNyL19KnjcnJZSD4CuqybOciimS8MtpoPG3N7yXqA
         +9VVVxU/yRBNqtmbXQ0z+0jgJqH9rOhXgeduogxc0zqPI3sMJ22Vn+I6w/LD7tifHkK4
         G9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVT0J9Mnoh6KQFZ+Is1z4W+ElwDxGQDJlUT/PfjxoTs=;
        b=eAb6OY5sRKGXqGVejbGLIGQLdS9iN5LtpjFtlfm2J7mLzBZE1S5jtXHGnOvkUeQYLG
         AAywxKW4WoQKbHNqpDEx7+wOwZ3pkW/of35QfpSh+IYOqHypTW0mg6aiP5AQKhRLI97P
         +w1UoGpatG7jtTNCFiw7s3PceywVDjZ8Yw2BpojFBEbpOSPMxO+/NN43k8weFEN9Co1L
         r7hRfig4fS0RKpDfXUvV2JdVpKqR+twcJx0plyPrcw2hGumG6vaeK128N5LVv7O0O9gl
         H4L1QbuD44ZHw1230X83uYwP/2JjLxznODASKf72Ab6momo6wlPh900oOEnn03yUIVVc
         qlyQ==
X-Gm-Message-State: AOAM530SpCvJFhUHfjUvjSwg7BJ90dJ8kHTg44+ZIPHIsfRLR65Ie2XS
        mn9yhW3yFgrjxUVMHK1Zf95s6nwGQBWQJIo89shj6w==
X-Google-Smtp-Source: ABdhPJwj1a0ZBWmjixk6X/sNKVRUUadtEYpVwfYwK0ttL1AyGhEOnWi9jW3CgiHzo3CiylWi4K7r2yTb37BMSsAEXNg=
X-Received: by 2002:a50:ed15:: with SMTP id j21mr5697574eds.246.1594921091453;
 Thu, 16 Jul 2020 10:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <20200710114000.GD2614@linux.intel.com>
 <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
 <20200714113205.GA1461506@linux.intel.com> <CABXOdTcAZjG8aQvs+M72CFe9rAdBKZH+6x=C1Ha2aX_w0gXiHw@mail.gmail.com>
 <20200716172811.GB14135@linux.intel.com>
In-Reply-To: <20200716172811.GB14135@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 16 Jul 2020 10:38:00 -0700
Message-ID: <CABXOdTd4oY8TpuE1qZP--dYTJ-czdovsjmhLVbd_tTw=sApHYw@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 16, 2020 at 10:28 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Jul 14, 2020 at 08:48:38AM -0700, Guenter Roeck wrote:
> > On Tue, Jul 14, 2020 at 4:32 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 11:25:44AM -0700, Andrey Pronin wrote:
> > > > > Why does not tpm_del_char_device need this?
> > > >
> > > > "Not" is a typo in the sentence above, right? tpm_del_char_device *does*
> > > > need the fix. When tpm_class_shutdown is called it sets chip->ops to
> > > > NULL. If tpm_del_char_device is called after that, it doesn't check if
> > > > chip->ops is NULL (normal kernel API and char device API calls go
> > > > through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
> > > > call tpm2_shutdown(), which tries sending the command and dereferences
> > > > chip->ops.
> > >
> > > It's a typo, yes. Sorry about that.
> > >
> > > tpm_class_shutdown() is essentially tail of tpm_del_char_device().
> > >
> > > To clean things up, I'd suggest dropping tpm_del_char_device() and
> > > call tpm_class_shutdown() in tpm_chip_unregisters() along, and open
> > > coding things that prepend it in tpm_del_char_device().
> > >
> >
> > Personally I would have preferred two separate patches, one to fix the
> > immediate problem (with Cc: stable) and one for the cleanup, but I
> > guess merging both into one is ok as long as it is marked for stable.
> >
> > Thanks,
> > Guenter
>
> Not sure about stable as this issue does not afaik concern earlier
> kernel versions?
>

I just had a quick look into linux-5.4.y, and it seemed to me that it
is affected. Maybe I am wrong. Either case, we already applied this
patch to all affected ChromeOS kernel branches, so from our
perspective it doesn't really matter.

Thanks,
Guenter
