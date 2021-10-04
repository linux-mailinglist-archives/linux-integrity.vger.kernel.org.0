Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2701D421469
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Oct 2021 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhJDQxU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Oct 2021 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhJDQxT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Oct 2021 12:53:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429BC061749
        for <linux-integrity@vger.kernel.org>; Mon,  4 Oct 2021 09:51:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l13so16499092qtv.3
        for <linux-integrity@vger.kernel.org>; Mon, 04 Oct 2021 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fm0N+uR1hXDzNubZl52j+8JgNSoL4ihvsWR45BnPk0U=;
        b=fONFgNJfZDZei6PZNVpZuBiLsJj1X5q23bUBDHR6Fuxaodm1hwle2aSXXPZVhQpqj9
         /ElI7DyN32U6z+PhNlz1pYV8PPs8OQn/iFlypBkab16easskT0oRAko11Dw8EcB06gh3
         CT8v9N1IlFy843LfazZZljBlqka49vpAeBfatzveca+w8ZlAxXkZUlYcmf+sEfKG76u1
         TY3Qw27XfzNUrJYbeVCCKzCM9MyLRwvqODBB2+ZIY6INJBFgZ0vzDFcU4588yCEQbWfI
         VrxXG8yZyLHHstArVfuqbBlnxD2yIw4Q9BeabvwIFlg/VlzoHYsVmsWnFXrwI3rskJ6H
         T5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fm0N+uR1hXDzNubZl52j+8JgNSoL4ihvsWR45BnPk0U=;
        b=kmHy/TCdqgQNlTgCQCchQYahE1v5Y+CdODjCZrLa/64pGHmIK4kO5rxSZv6M15cEjP
         i1oIPasC7Df3SUXItmrnTV1DFE6XeSSlY6FGwd/fyj02/p6/6fmyuUxOVvOoakDEdRca
         NsLdocOCW/9iFXaA3ZgehJd9LqAzgCQZ0k1juqCd5e2G+R3ZXATnngMkgr00phA2zX4j
         JRkXEc9foyL48TYfQuJ2a7/+zGwVlNhb0Uepl3228oaCryjs/f3IME9nhxIJu1J9w+ea
         4ckL72IEVd7WsArESbP4FsFUSmT3FQybYS0qz6e8gYrkt93xy6N3Qfjmu64jZSsPq7Ve
         z8ZQ==
X-Gm-Message-State: AOAM532i4VWbKnbPt7J76ZKd8FNogijBQQrKZoNHUrsMSWZdzyjEsj6G
        qaT38oHAUgsqtk/HUwJdzwc+tQ==
X-Google-Smtp-Source: ABdhPJwYxtXAD8Z3ExxCEQ19TzIoVR9HRb32/NI/yIjc3B407LzHe5QYs0z4lz+/49EyQ9oJMCYpoQ==
X-Received: by 2002:ac8:4610:: with SMTP id p16mr6740796qtn.98.1633366289243;
        Mon, 04 Oct 2021 09:51:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l26sm974766qkj.38.2021.10.04.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:51:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXRBX-00AXAU-Qu; Mon, 04 Oct 2021 13:51:27 -0300
Date:   Mon, 4 Oct 2021 13:51:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        nsaenz@kernel.org, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: do not unregister controller in shutdown
 handler
Message-ID: <20211004165127.GZ3544071@ziepe.ca>
References: <20210928195657.5573-1-LinoSanfilippo@gmx.de>
 <20211001175422.GA53652@sirena.org.uk>
 <2c4d7115-7a02-f79e-c91b-3c2dd54051b2@gmx.de>
 <YVr4USeiIoQJ0Pqh@sirena.org.uk>
 <20211004131756.GW3544071@ziepe.ca>
 <YVsLxHMCdXf4vS+i@sirena.org.uk>
 <20211004154436.GY3544071@ziepe.ca>
 <YVssWYaxuQDi8jI5@sirena.org.uk>
 <e68b04ab-831b-0ed5-074a-0879194569f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68b04ab-831b-0ed5-074a-0879194569f9@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 04, 2021 at 09:36:37AM -0700, Florian Fainelli wrote:

> No please don't, I should have arguably justified the reasons why
> better, but the main reason is that one of the platforms on which this
> driver is used has received extensive power management analysis and
> changes, and shutting down every bit of hardware, including something as
> small as a SPI controller, and its clock (and its PLL) helped meet
> stringent power targets.

Huh? for device shutdown? What would this matter if the next step is
reboot or power off?

> TBH, I still wonder why we have .shutdown() and we simply don't use
> .remove() which would reduce the amount of work that people have to do
> validate that the hardware is put in a low power state and would also
> reduce the amount of burden on the various subsystems.

The difference between remove and shutdown really is that 'emergency'
sense that shutdown is something that must complete in bounded time
and thus only has to concern itself with quieting hardware to a safe
state for the next step in the shutdown/reboot/kexec/kdump sequence.

Many remove handlers happily block until, eg all user files are closed
or something to allow a graceful module unload.

Jason
