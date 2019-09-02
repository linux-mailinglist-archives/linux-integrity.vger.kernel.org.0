Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8002A5CAE
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfIBT0g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 15:26:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37955 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfIBT0g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 15:26:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so6192718wrx.5
        for <linux-integrity@vger.kernel.org>; Mon, 02 Sep 2019 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Er08pVuN6tZK0oCZUqxbGdt0awjifuB2WIo0IKZWo6I=;
        b=SSx95Ru5R5Ra3x8lm24CfwezV7TrLvrsxRir+XP6k/wUegA+mCjKTPEuGt5uJaFhUM
         QXrmnCsmK8V9xXDIh5h9+3MnHyzJlFlZnXeJl6otrqY4oDGGayRleANZ3lUV2/LV3sT4
         7aYdfbHIq5RYD84hn0le0+l9ap0vchg90xxz+xI9rtxL7o2cexpctR9F3fjcyyqBdKwi
         irxw6cre3aQmwmXhdMvL767AMUob5qT2u8NBO1ygphSGyRyU7WP4SNH1CSGJUO0QE6eI
         GAnrvCQmGi78y2E7Xtdgvdu0xz5m2nvLCPQ6NiH5wnmvytPTR0JnIL4+4b/jgG/P/OTI
         lgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Er08pVuN6tZK0oCZUqxbGdt0awjifuB2WIo0IKZWo6I=;
        b=a6g6CDa89e54zW1fRzIIl95LOiqxp1RpCwWaoK8fb1IaBh4pX/JIHLXGpGhiy7HU48
         u/jsEhjE/qsGZLcdeu46RY3OInAP8EGeGgR/qMqCaOea2nnx3TgLI7XoRpxIunBRfxhV
         +7HT4s+nx9aka/8LT8pCi2Y0L6HshaRjdIcgbA+OIb+F/1Dy/XCaa+ktexVEsm+MDGHh
         unYmBZ35KLa+0kXV5fthVO54XJ0eKUWnzDsxcQerCk0Sv4p+/73v2veLcGCnmyYGRn3E
         aEkdF6pTegwnKvPgRdgKbMD64gSO2S3p9uo4P63kgYDCW/ykTIbXvdAjkPKr5/deH+Zk
         866Q==
X-Gm-Message-State: APjAAAXiss9mAsse/nPCfy4pwEH4lXwrZYl2JmSyv7w6YgIm4NaucDcx
        yeEq2teAb3KbQFYtdVG6up1u7g==
X-Google-Smtp-Source: APXvYqxl5rHjidGm3aLZ1GymLZb+r9loQ7tdpzLQlC6GJ2uVX2lQGUjixp2VAe6nxSjEFkkFHRPMTQ==
X-Received: by 2002:adf:f404:: with SMTP id g4mr37104539wro.290.1567452394017;
        Mon, 02 Sep 2019 12:26:34 -0700 (PDT)
Received: from ziepe.ca (bzq-164-168-31-202.red.bezeqint.net. [31.168.164.202])
        by smtp.gmail.com with ESMTPSA id o22sm9217486wra.96.2019.09.02.12.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 12:26:33 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i4ryC-0001QP-Fy; Mon, 02 Sep 2019 16:26:32 -0300
Date:   Mon, 2 Sep 2019 16:26:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190902192632.GB5393@ziepe.ca>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <20190827010559.GA31752@ziepe.ca>
 <1567007592.6115.58.camel@linux.ibm.com>
 <20190828161502.GC933@ziepe.ca>
 <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
> On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
> >>> So exposing PCRs and things through sysfs is not going to happen.
> >>>
> >>> If you had some very narrowly defined things like version, then
> >>> *maybe* but I think a well defined use case is needed for why this
> >>> needs to be sysfs and can't be done in C as Jarkko explained.
> >> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> >> TPM 2.0 is a reasonable request and probably could be implemented on
> >> TPM registration.
> >>
> >> If exposing the PCRs through sysfs is not acceptable, then perhaps
> >> suggest an alternative.
> > Use the char dev, this is exactly what is is for.
> 
> What about a new /proc entry?
> Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
> What about adding a new /proc/tpminfo that would print info like
> version, number of enabled PCR banks, physical interface [tis|crb],
> vendor, etc.

I thought we were not really doing new proc entries?

Why this focus on making some textual output?

Jason
