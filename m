Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B54E36C7
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503269AbfJXPgZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 11:36:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43571 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503252AbfJXPgZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 11:36:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so38467050qtr.10
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PO7ANvqkotQ+g2bEe1Hw5w8nqdc9eXAxdBwSeKbXh9w=;
        b=FId3UXasjX6Go4JKCdP9+7lxwA49XZBN71M4vkDWmLldPXBkrsuqTO2rO7bgkx3O6t
         LgQkEtHBKo1SxGszCEqiQoQeClXADtm2nJBTrrpjFqT1cIk3juNv2mW2/whMq36OkZ+B
         tTEUF80A8yDyZURrNU6/LEggk00JMBoW48WuMDoJh7+KQfQ8v9NoEa7ohwZWfEjQpE7T
         BHR9nfWruZWnGJaLhVzlFWwqqVH7iLWz64UdtjvMuuq206vU8/Lihh/yCKV/elWqRqbf
         fflz6yKsmNNmp3+gdXLZFfDYH1zS5MRES24kZjpxYE+aEbJRW6nm76rZ858kq7rUksqC
         9aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PO7ANvqkotQ+g2bEe1Hw5w8nqdc9eXAxdBwSeKbXh9w=;
        b=sBAKB0JCiL7DcrpmC080EBWtGGPGdDHJCFDp0KhDLuX7g0wvAduehBdUb/xHBABXIW
         Q4eBSyuJcyrxyrX6c+R9McR/zeP0Gcv15ZLRSuU72n+wSP6cv2EAOuBWcD7gvRQ92qUK
         HUnQXD2odEfwi1tQrG/Uz8FMMd/LloE2Upy9HlioE6XFrRsyClTp0vp4TxEa1j36dzf2
         OBClMzLdM6IKQLvhpS6+yu5elLFMRLH4A4n2/K7eiS3+5Mw1wYzpzS2bA7AQdADqssdt
         UGgzZuudfygUq9a0oav53DB6LwP+H8+H/jt+mwXH/4HX42B3mitDssBj4dg1XD22YEni
         f0hA==
X-Gm-Message-State: APjAAAXSqIQmTw80C57h+JI0jki/cyoYcJZeQ6XugHBARmszuFZGaK48
        7PKWfh/tSM4Pcq5OUTlhJ+BDtA==
X-Google-Smtp-Source: APXvYqwCZloe629xxoBYgjtTP/gXJ5ZCbyJJpXE/9FDAkwrQZD9eu8FjjhnLm6HCLqlPMhdSZu1wNQ==
X-Received: by 2002:a0c:e64e:: with SMTP id c14mr2422699qvn.13.1571931384065;
        Thu, 24 Oct 2019 08:36:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k187sm3427463qkb.20.2019.10.24.08.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 08:36:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNf9y-0007SF-Sp; Thu, 24 Oct 2019 12:36:22 -0300
Date:   Thu, 24 Oct 2019 12:36:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tpm: Switch to platform_get_irq_optional()
Message-ID: <20191024153622.GU23952@ziepe.ca>
References: <20191019094528.27850-1-hdegoede@redhat.com>
 <20191021140502.GA25178@ziepe.ca>
 <20191023113248.GA21973@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023113248.GA21973@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 23, 2019 at 02:32:48PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 21, 2019 at 11:05:02AM -0300, Jason Gunthorpe wrote:
> > On Sat, Oct 19, 2019 at 11:45:28AM +0200, Hans de Goede wrote:
> > > Since commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> > > platform_get_irq*()"), platform_get_irq() will call dev_err() on an error,
> > > as the IRQ usage in the tpm_tis driver is optional, this is undesirable.
> > 
> > This should have a fixes line for the above, or maybe the commit that
> > addtion the _optional version..
> 
> Is this fixing something?

Yes, an earlier commit caused new bogus warnings to appear, this is
fixing that regression

Jason
