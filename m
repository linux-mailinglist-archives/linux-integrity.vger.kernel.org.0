Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18EB1FC602
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 08:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQGHc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 02:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQGHb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 02:07:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02AC061573
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 23:07:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so1365553ljh.7
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2ZEmHhrPs/ulmpdqloJHox+N+2D34dGnYoIhwM09Oc=;
        b=uPykhRwTSAish44ZDPcrnTHTYCxTAoPDQs0s4pqD9Gz+ToeIJigh/T49FDZ4AhuDkX
         ZFti8QWz6Uspvl1RbUitrc4JdzWcICXShXq9TFZKvcMSclCNwY/iHqtBXrDk4tBAazFI
         uzfQqSxSYL7XNi/zx0qIUgOGebOCQ7N2AuzBr3yWfXTTxy3Q/Cegh2vVDSZV4dM3+onD
         KnZocUo2gfKgj2zcrY/20wezao3Gn/JjFkIG9XieO3vzKrjsy3BR2h0UoWhafeGP6dbV
         CzJ5DImXZwKUKFLzbM7oo8fP0qvdLZQHpNFDTZbcD0cNDOwiAUtY3AQAhkx8zFdlZ7Kn
         eu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2ZEmHhrPs/ulmpdqloJHox+N+2D34dGnYoIhwM09Oc=;
        b=JvmneUn+pbd4t9auyC1jlY4xNzF1R5O1ZKlcSwNWJPEPIryUa3OxZcL2Jrz/GK/ubl
         +cg2OTCtw/jtNr7KqEGLjBvVAsRTAWOJ7HSGZBHV6avi1eEb9AVykgA090vywPigo1Ji
         vQHzS0jRBbYiYE8a26QHa02t26V3pTWyHFrkc4lbKhXzuZgeNGWMiXkBNFRz12BlYK4D
         kHw+4ZPZW9iUQIPMPpN+vXJqhUlZFQbUWdLxqQNdbXTPw7/uafXkGAyu1V2zaedsezRX
         qgknrfn2bCHrF3pa0QmhPfYRhw/A3it94XUyfmKSiUWsC21P4TxVowYg7gOKGcVQJBvi
         U7EQ==
X-Gm-Message-State: AOAM533lyg1ESFTKa1ZE59a4j1plh6ae8EyYWPsLCAHFzpHfnx+eO25T
        jsb/cEci1bmihXjncqxpA8+xPBla3vI1RcSy8Caoew==
X-Google-Smtp-Source: ABdhPJwVGClABjAHoGqIadqLzIigFwQpGKlcnffd1cvXC97YTGleZl7YASG+am+g3y0+dLrdmn9YK7ztFIvmDc5Os+w=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr3402768ljb.30.1592374049915;
 Tue, 16 Jun 2020 23:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <20200616205017.GC20943@linux.intel.com>
In-Reply-To: <20200616205017.GC20943@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 Jun 2020 11:37:17 +0530
Message-ID: <CAFA6WYO1X3zdOMgVnHvKm7MAWWyE=dhbLpCcU5zJG7R2fCuycg@mail.gmail.com>
Subject: Re: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 17 Jun 2020 at 02:20, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 04, 2020 at 08:58:49PM +0300, Maxim Uvarov wrote:
> > With the evolving use-cases for TEE bus, now it's required to support
> > multi-stage enumeration process. But using a simple index doesn't
> > suffice this requirement and instead leads to duplicate sysfs entries.
> > So instead switch to use more informative device UUID for sysfs entry
> > like:
> > /sys/bus/tee/devices/optee-ta-<uuid>
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Sumit, are you able to test these easily?

Yes, I could give them a try.

Maxim,

Could you share fTPM TA tree which I should use for testing?

-Sumit

>
> /Jarkko
