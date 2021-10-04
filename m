Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F454210AB
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Oct 2021 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhJDNuQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Oct 2021 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbhJDNuD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Oct 2021 09:50:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD925C04E2F1
        for <linux-integrity@vger.kernel.org>; Mon,  4 Oct 2021 06:17:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a13so15769309qtw.10
        for <linux-integrity@vger.kernel.org>; Mon, 04 Oct 2021 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPvcFTOHIGx9xgqu5ddNdve5jNdRddJHTQcQMlxuUb4=;
        b=UMIFsC4ZdZIj3RkBCIxhu+WL1QM8xiwS679e8/Y8EifC/4Pc/Vov5qlsZsgb9rWOaZ
         KI+kC8rRZF7jDiNSIQrlK9BMn+6z26u2rf67nRVgdcuer9tVqIApteymS6Zbo6/roHCC
         9FSGMGZlujafa/5QodHnnoqTIS6zB88kv0egPGAHfCpUvDOa3rZEt2QOVx9NtkubRJtU
         bfbymcUaq/18N5vh5iFrPxGaquVTUMwDGL/CAXrWYzYtrjyV04YSWH40toiZP/1QaKui
         hk2ZubrkTADUaeaeR4xji8rQcH7PUR3GsDeerelpgIS8DnSzbkuUqbL3r4OZKfMBxIlR
         Hzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPvcFTOHIGx9xgqu5ddNdve5jNdRddJHTQcQMlxuUb4=;
        b=x3KtzB6OoU1YjMo9kAU7DAAsBdi6s0YGjaTLoi2BpSAKbpemEoBmO9pVDBhphC8M8S
         /o4DfHtmpj3fTxYybJtyr01u1XCMgEqun2bDRdYYJDEtLqoPSPRFTCPMOy3ByyBYV3Bv
         /DVIlGkgLZ8XPbxfuajXkBViaz+3D860lK81qAxt0Uwi8UMKVKm07g56ahXpV+jNTNKv
         2NivLx8Fb61uindwBDr9jgokJfTeMoc8ylODxdbX4hHb+XEeivapQ6wrbdbpVYY6/IdR
         mXDsXYasARi5gUUxTuGmo9GZer2tyNdxTYLfe24a4QUkgHYlPzE0MxOseWDI9Vkxw40l
         5XiA==
X-Gm-Message-State: AOAM531BrRuZa+L0VX5V6UddhxWDuVBFlyKIw0SWTXvwtX5/FsHPCW1L
        rb+pz9jQWUaPQ6utJu0khu4N0g==
X-Google-Smtp-Source: ABdhPJwdFLgMD3BnQcwrih7T2hB2I/DIr+gMNW6QdD7a1s9w2k10tDtk2GbyLGc/JQ96h26jkMNd0w==
X-Received: by 2002:ac8:4084:: with SMTP id p4mr13618411qtl.255.1633353478081;
        Mon, 04 Oct 2021 06:17:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v17sm8247440qkp.75.2021.10.04.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:17:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXNqv-00ATdu-02; Mon, 04 Oct 2021 10:17:57 -0300
Date:   Mon, 4 Oct 2021 10:17:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: do not unregister controller in shutdown
 handler
Message-ID: <20211004131756.GW3544071@ziepe.ca>
References: <20210928195657.5573-1-LinoSanfilippo@gmx.de>
 <20211001175422.GA53652@sirena.org.uk>
 <2c4d7115-7a02-f79e-c91b-3c2dd54051b2@gmx.de>
 <YVr4USeiIoQJ0Pqh@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVr4USeiIoQJ0Pqh@sirena.org.uk>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 04, 2021 at 01:49:21PM +0100, Mark Brown wrote:

> This still leaves a potential race where something (eg, an interrupt
> handler) could come in and try to schedule more SPI transfers on the
> shut down hardware.  I'm really not sure we can do something that's
> totally robust here without also ensuring that all the client drivers
> also have effective shutdown implementations (which seems ambitious) or
> doing what we have now and unregistering the clients.  I am, however,
> wondering if we really need the shutdown callback at all - the commit
> adding it just describes what it's doing, it doesn't explain why it's
> particularly needed.  I guess there might be an issue on reboot with
> reset not completely resetting the hardware?

Shutdown is supposed to quiet the HW so it is not doing DMAs any
more. This is basically an 'emergency' kind of path, the HW should be
violently stopped if available - ie clearing the bus master bits on
PCI, for instance.

When something like kexec happens we need the machine to be in a state
where random DMA's are not corrupting memory.

Due to the emergency sort of nature it is not appropriate to do
locking complicated sorts of things like struct device unregistrations
here.

Jason

