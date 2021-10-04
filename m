Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFDC4216A6
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Oct 2021 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhJDSji (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Oct 2021 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhJDSji (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Oct 2021 14:39:38 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A231AC061749
        for <linux-integrity@vger.kernel.org>; Mon,  4 Oct 2021 11:37:48 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id o13so4816036qvm.4
        for <linux-integrity@vger.kernel.org>; Mon, 04 Oct 2021 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opQXkszJB/xI/CFEweHtwFwzXpmjuocqMiJ4mS50dYE=;
        b=b7Sh25BKHqelVTUcxTNbaN7jMfAOYIXUxdy8ORjjPICT01gZjKGqrFxfeU8Td2HxAU
         deli6t51BPPmLSPTseE4YGU7NCy9xdl1WR4WqYEun72GUtgyDDAQ/8/NfcXgxc+B2t+G
         GhMb++XgNidvQo/CzOOKZoSqmEQ4Nek6Bb00LwhlGiwqq1obtL2Gs/L/cFjlZRek9St8
         CwyCua8bpBHQF+qeD+dKv7uECPhddXcOXfPY1u7mFKmj6Xxzl/lTMbEong4sBDyEpAeJ
         +8qOMh9UMezoWD83TfRgtW+oW16N9FpXpoKRgVhTp6FAXdoDZrGpeZUSkcKfxr42Paly
         bZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opQXkszJB/xI/CFEweHtwFwzXpmjuocqMiJ4mS50dYE=;
        b=a+lD8GY1x/+Gks6L0mtJwqKQ6R8tJNTa6viuoZjCA8nTWwiZkUTFFyDDlDfZ8iT1rG
         qslNjXLfBEIrMsrX7LYO9TZzwASW2WEvNdd2jNfpqjp4zooU2eEBbSPIngrXwIEHOd5J
         ZJiNQYol44UG9gbW2BiAZ3hhYpcIptbx9aT0nxWIJTXeDUrjlccJbCj8OxVVY4NwqH5p
         O3WdWQ30LyPi0ZeBfI3b94rHLmorwi5/YmFT9/39T7DX05BPbEOlbFh/UFze7pvY9Q5M
         Lok9+pJJa/PDqJjc5LggCuOCbc35og6o2F7BfUaJtFGJNEvm77dTBb4+XJU8Xbnb/H6U
         DSiw==
X-Gm-Message-State: AOAM531JRB6RVrqn7jQzgagea3ssAolWrqkvSK0KflbrHTsNAimDaeJ6
        2wlk6fJFUUg0uZ1R2dGlHSEB4g==
X-Google-Smtp-Source: ABdhPJxvpKiddo40Ttp/UXy5PfhHTvizcb3Vya8u5FCSvClWPUbTrUxGC7x7DyatGadHStH7piuIWA==
X-Received: by 2002:a05:6214:1269:: with SMTP id r9mr23630686qvv.35.1633372667814;
        Mon, 04 Oct 2021 11:37:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w23sm22967qts.89.2021.10.04.11.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:37:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXSqQ-00AZUO-JW; Mon, 04 Oct 2021 15:37:46 -0300
Date:   Mon, 4 Oct 2021 15:37:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Mark Brown <broonie@kernel.org>, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: do not unregister controller in shutdown
 handler
Message-ID: <20211004183746.GC3544071@ziepe.ca>
References: <20210928195657.5573-1-LinoSanfilippo@gmx.de>
 <20211001175422.GA53652@sirena.org.uk>
 <2c4d7115-7a02-f79e-c91b-3c2dd54051b2@gmx.de>
 <YVr4USeiIoQJ0Pqh@sirena.org.uk>
 <20211004131756.GW3544071@ziepe.ca>
 <YVsLxHMCdXf4vS+i@sirena.org.uk>
 <20211004154436.GY3544071@ziepe.ca>
 <af8df53c-93e9-f157-9308-b0b69908e112@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8df53c-93e9-f157-9308-b0b69908e112@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 04, 2021 at 08:30:52PM +0200, Lino Sanfilippo wrote:
> On 04.10.21 at 17:44, Jason Gunthorpe wrote:
> 
> >
> > Well, that is up to the driver implementing this. It looks like device
> > shutdown is called before the userspace is all nuked so yes,
> > concurrency with userspace is a possible concern here.
> >
> 
> So the TPM driver has to handle remove() after shutdown() anyway, right?
> Because even if not caused by the BCM2835 drivers controller unregistration
> something else could unload the module and the problem (NULL pointer access)
> would be the same.

Technically yes, remove shouldn't crash in this ordering - but it
should be difficult for remove to be called after shutdown in any
normal system.

Jason
