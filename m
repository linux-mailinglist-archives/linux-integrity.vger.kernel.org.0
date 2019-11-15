Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA1FE4FE
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2019 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKOSgY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Nov 2019 13:36:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32844 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfKOSgY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Nov 2019 13:36:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id y39so11861930qty.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 Nov 2019 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmhmT2/lpw5E3a3t/TqBOzoCn7nixan0CEkVXorZZoM=;
        b=joAezW7gib3gJoviK/Y6NKyx+9IWZH+xyHyWf3myiIVDpMlilJ0CwDnlYBR4o0RjPo
         NSQnJw886okNTsJdX0C/Lcp9H3V+x5hBVzkfoqVChaPOFFtJM5JfKSkpkttB7yMZRxH4
         U7TtYu0skLt5GrBe8zee9Nka6um/nQKYVV9ZreH0QXBn/SwmUreqIx4JjfhnUqisWmuq
         N4EqgfM516CcLVvzEsPi78q36GIaz68LYPkTiqM5AqXxYIb2bk63Og3gxH6WWGSnaFGu
         wnPuk7sIo8Oq7dAKqwr66KTNEjp1JA3e4HK9odU/4FG8v6m6bStTF3XIJeQlIu21faZ3
         3cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmhmT2/lpw5E3a3t/TqBOzoCn7nixan0CEkVXorZZoM=;
        b=ivXVSQ9hdiyWRhw2emf7LLGhVJ7oXHzDXpFFgptz15bq70tiiWRs6YKeUQN8ssS7Xu
         KggmqKLMEOmzTvFHrOXQmO+rCoPMSqwG56vteR0xK+G3UDVrVarUt4nYvV0NpmjsrEpW
         M45JCtLgunaBHLqGSliq6UB+49TwRbw0UKHiKO2NnlabODzHjVrMiCGqsPeYSfYzUKek
         swP//dIx3TZENTm3bZuyIBj/IKcgEjjIyDhLKlQmmPV+rT5mYnMkDhbhUt/nK8DH6u7A
         QP0oGlvgD2Hef7ZejLbCnlUXALTuRrXt2CWYwMIv9aL1B23fXiHKY8H2nMnxdfjgjrU/
         5vOw==
X-Gm-Message-State: APjAAAWIIvC/4yubYvxc8j/G065Du5xjr5ObdbB1e6xvLTl/gwMod74f
        ljiu7oAqMIlKN7kycDRJuwzCag==
X-Google-Smtp-Source: APXvYqyi+aLYl2/RaifcV84mbm+JUduRv4SFJqWUvJMPacuk66dvh5/epouBxno226ZJ6iYf3mWXnA==
X-Received: by 2002:ac8:382e:: with SMTP id q43mr15186871qtb.326.1573842983013;
        Fri, 15 Nov 2019 10:36:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id b54sm5808220qta.38.2019.11.15.10.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 10:36:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVgSD-0007Hb-64; Fri, 15 Nov 2019 14:36:21 -0400
Date:   Fri, 15 Nov 2019 14:36:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191115183621.GD4055@ziepe.ca>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
 <20191114165357.GA11107@linux.intel.com>
 <20191114165629.GC26068@ziepe.ca>
 <20191115174329.GA22029@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115174329.GA22029@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 15, 2019 at 07:43:29PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 14, 2019 at 12:56:29PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 14, 2019 at 06:55:06PM +0200, Jarkko Sakkinen wrote:
> > > > Would it function with the timeout values set at the beginning of
> > > > tpm_tis_core_init (max values)?
> > > 
> > > tpm_get_timeouts() should be replaced with:
> > > 
> > > if (tpm_chip_start()) {
> > > 	dev_err(dev, "Could not get TPM timeouts and durations\n");
> > > 	rc = -ENODEV;
> > > 	goto out_err;
> > > }
> > > 
> > > tpm_stop_chip(chip);
> > > 
> > > tpm_get_timeouts() is called by tpm_auto_startup(). Also the function
> > > should be moved to tpm_chip.c and converted to a static function so
> > > that it won't be called from random cal sites like above.
> > 
> > Careful, the design here was to allow a driver to do only
> > get_timeouts, then additional setup work, then do auto_startup()
> > 
> > Forcing a driver to do auto_startup too early may not be good.
> 
> All drivers always do it anyway because all drivers always call
> tpm_chip_register().

But chip_register is after the driver has done it's setup and after it
may have called get_timeouts

auto_setup should not be moved to before chip_register()

Jason
