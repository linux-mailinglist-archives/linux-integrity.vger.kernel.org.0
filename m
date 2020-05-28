Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6E1E5CBE
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgE1KL7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgE1KL5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 06:11:57 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B188C08C5C5
        for <linux-integrity@vger.kernel.org>; Thu, 28 May 2020 03:11:56 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so16243272lfc.10
        for <linux-integrity@vger.kernel.org>; Thu, 28 May 2020 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GvfntBARHGj9tyZqdVS0AkSrdT6KC+PYhROqxRjCMSI=;
        b=dciROLJOVOVwViZNuh26Z/D+bUVPDpn5YJh8ZZttPxszTWryj9rOVEeufhdM5e1xGy
         YfDBZ2KvD8mWzVKTPn0h3ANgfslgu9bpKn18ygjJqto1jKZsOENRKNzj6CrLLZITeSFj
         trh4CDPfzYRDnG0qguZAHiADbM8kCqoVHKX4ZjtCOsBqVJtc+YNUYhVbMa93BMeGbkZ0
         6D3AOy7TVkze0Pud/A/q8VCuE9+HD05/39pszecnFngXZx3Lg97kpBJ9VEFu/+yathLE
         3+LeS904+pW0/zHStBygu1Wx/d6DKguY0APiH7LGNsmguPhm6uRoY5aHq/A432qDSH7n
         P/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GvfntBARHGj9tyZqdVS0AkSrdT6KC+PYhROqxRjCMSI=;
        b=WC5PKXiPxzP/RcJswNMyAfUBvZiewsTVcQNn5Rlf4L3bmoB3rkNmqWgWnnykDhd7nD
         bK1llpmR1kPjmSqDNDaRwXncAKtoy+oQYsgOmIcFuEsSvLmyVcres0mR5HkU6jEgzlQN
         6hb8k8KP9hZp17YKPlaFsyTS39FN+MyDzRoLz11twU7XRHgrsLtywKO7iJ1uha9yA4F6
         hdk+djhzhQ+rp8z6ONoo88hM+Vzt7zQbA0b1qKGoSIslynuD5y2pRCaL6CuGd1wQZIj6
         xXxP1UedpAP/GyMHu6BeD45qX5Eo7VhJHHTXz9NUQMjuB/tx53oLpCEwnT2YFxDmJgYZ
         kLkg==
X-Gm-Message-State: AOAM530t9GcdoMJK6qwrbYnTFil8kb+C+4HdAITR5LLpa1dX/Nip2Y2a
        Gejyykgxw8wKB/+ESRx84fVpxQ==
X-Google-Smtp-Source: ABdhPJwJPxDKqS8mBjb4QtN2KNtIstmDRs+NseXg6dzSjdWdbXvIn1CwDgUyIkAE0AkSO7B3dm5mgA==
X-Received: by 2002:a05:6512:3082:: with SMTP id z2mr1350303lfd.32.1590660713685;
        Thu, 28 May 2020 03:11:53 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id m11sm567347lji.51.2020.05.28.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 03:11:53 -0700 (PDT)
Date:   Thu, 28 May 2020 12:11:50 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
Message-ID: <20200528101150.GA156014@jade>
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org>
 <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
 <20200522200346.GB150221@linux.intel.com>
 <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
 <81c59da1dc2a255c58e7e338f30285e68b4664d6.camel@linux.intel.com>
 <CAD8XO3a5Xqw3oDAn=VH25Fb0j-_GSripEgQjwurhqGQRW_mq5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD8XO3a5Xqw3oDAn=VH25Fb0j-_GSripEgQjwurhqGQRW_mq5g@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 28, 2020 at 11:08:18AM +0300, Maxim Uvarov wrote:
> On Wed, 27 May 2020 at 22:42, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, 2020-05-25 at 09:50 +0300, Maxim Uvarov wrote:
> > > Jakko,
> > > tee-supplicant application provides state machine over callbacks with
> > > RPC messages.
> > > https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
> > > It also allocates shm. Without running tee-supplicant
> > > tee_client_open_session() will fail.
> > > optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
> > > Optee team wanted to remove some dependencies from tee-supplicant with
> > > moving code
> > > to the kernel. But for now I think that should be out of the scope of
> > > current patches due to
> > > they fix driver initialization on tee bus without breaking current
> > > functionality.
> >
> > So what is the role in high-level for tee-supplicant? Why does it
> > exist? No time to dive into code unfortunately.
> >
> 
> Original implementation for tee-supplicant does several things:
> 1. allocate shm
> 2. load ta from user space (fs file)
> 3. emulate rpmb
> 4. also there are some ftrace and socket functions which I did not use.
> 
> As I I understand, current implementation uses tee-supplicant and it's
> library as
> API from user land to Trusted OS.
> 
> Some docs can be found here:
> https://optee.readthedocs.io/en/latest/architecture/index.html
> 
> 
> 
> > These kernel commits do not explain in simple terms enough how all
> > of these entities connect with each other, if you don't have that
> > understanding beforehand.
> >
> 
> Yes, that is true. But I think it's something new and good docs will
> be some time later.

There's already some in Documentation/tee.txt, but it will get outdated
if we don't update it when we architectural changes like this. It's a
pity we missed updating it with the introduction of the bus. It seems a
good time to do it now so it easier to follow what's done.

Cheers,
Jens

> 
> > /Jarkko
> >
> 
> Regards,
> Maxim.
