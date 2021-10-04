Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863D2421533
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Oct 2021 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhJDRhX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Oct 2021 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhJDRhW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Oct 2021 13:37:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90764C061749
        for <linux-integrity@vger.kernel.org>; Mon,  4 Oct 2021 10:35:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t2so330185qtx.8
        for <linux-integrity@vger.kernel.org>; Mon, 04 Oct 2021 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s9zoLF/MgNaPjaZR+JeLQsj/a9Rsc/IJzh+CjAnpcGg=;
        b=OgrydoSelRcLx1oyHyBgH+lLYPFnfnXn8MsSCu4nOKH9ZW3eD1gM/dTR+zwgcEJRou
         MIvdZcSStbZZxwA144uM1NkUCe4/ji8Ht29uI0DOV1o66aHANeUixv5p+H3NwBM12mLM
         JDxweIvKdobh3UdofT+4yhL2PpnU5T6agvFmsfu86gFCHlxwwM8ARqd6+8oXAegWLTRE
         zU/vRetl4pMkjQ/wFlMAEXtgUwvu2PgQWI64WDybo7WtZ20QKnqiFpKU17LDlX+fmaHZ
         XP05XOs3gzZwnk1pgfkos2ybbmKo/KqbQhpajWJbHX1Sn/g35oubA39bWPoPbLzs3A+i
         hivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s9zoLF/MgNaPjaZR+JeLQsj/a9Rsc/IJzh+CjAnpcGg=;
        b=01VrA5B6LXTWyjAcAuMiS4ZoxBeNm8kNyCKLNvXBqpMhQX4uUoBdLUtV+6s5+5KOX+
         NsxVYqSvt6kwGFUXNHL7YUvC//u6nmQLZdNuvrkbm6cSucmUcNt5Pva70iu2tSvSLhWU
         TDCL1q6sR4SnXBZ8QkHkXbZjJovm3wYefSHsT3iwoqMPubPsQBp0vu0DINB1/HnhS/R/
         lZjaqTniEDP3+bbWJBOuHfft+jgzpOL7e+AQkExsimf4n4jBJh2Ew4oln0fcoThh9qBX
         MGCPTMOZ/bL2IleJCXq27Llrj4uvbUaowWEGxiWwis4X/7hq716LmT/y3p8vOVEGdxMq
         Pkew==
X-Gm-Message-State: AOAM532m4UM9OstFfitrgfGV6nNZ/Y7Kp0KqGK6RH7pFlnwzA/80SmYW
        /i3fLZrDBB1QHHLmj0omIFcMvA==
X-Google-Smtp-Source: ABdhPJyuK8QutD+64SmMVldzYIkBdTmala+1kw3pePr14EIL7iYRjW6JUEvfZbsfZjUzTlzz8eJHOg==
X-Received: by 2002:a05:622a:164b:: with SMTP id y11mr14777104qtj.310.1633368932754;
        Mon, 04 Oct 2021 10:35:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j184sm8223325qkd.74.2021.10.04.10.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:35:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXRsB-00AXrn-LQ; Mon, 04 Oct 2021 14:35:31 -0300
Date:   Mon, 4 Oct 2021 14:35:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        nsaenz@kernel.org, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: do not unregister controller in shutdown
 handler
Message-ID: <20211004173531.GB3544071@ziepe.ca>
References: <YVr4USeiIoQJ0Pqh@sirena.org.uk>
 <20211004131756.GW3544071@ziepe.ca>
 <YVsLxHMCdXf4vS+i@sirena.org.uk>
 <20211004154436.GY3544071@ziepe.ca>
 <YVssWYaxuQDi8jI5@sirena.org.uk>
 <e68b04ab-831b-0ed5-074a-0879194569f9@gmail.com>
 <20211004165127.GZ3544071@ziepe.ca>
 <f481f7cc-6734-59b3-6432-5c2049cd87ea@gmail.com>
 <20211004171301.GA3544071@ziepe.ca>
 <YVs5gT1rj9HiAW5p@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVs5gT1rj9HiAW5p@sirena.org.uk>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 04, 2021 at 06:27:29PM +0100, Mark Brown wrote:
> On Mon, Oct 04, 2021 at 02:13:01PM -0300, Jason Gunthorpe wrote:
> 
> > I'm kind of surprised a scheme like this didn't involve a FW call
> > after Linux is done with the CPUs to quiet all the HW and let it
> > sleep, I've built things that way before at least.
> 
> That's a *lot* of code to put in firmware if you can't physically power
> most of the system down.

Maybe? The chip I worked on we just made a list of register/value
pairs that covered all the functional blocks and the FW ran down the
list.

Mind you the chip was designed that poking ABC to reg 123 turned the
unit off no matter what. It didn't have a complex interactive shutdown
sequence.

Jason


