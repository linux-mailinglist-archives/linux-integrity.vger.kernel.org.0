Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D0D27EB7F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgI3OzG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 10:55:06 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:32924 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgI3OzG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 10:55:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A70218EE17F;
        Wed, 30 Sep 2020 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601477703;
        bh=VaMZ7Emd85vZRu6q2i/ihCPCmX85kAYVPIe5UZvG3UI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lcWp9cXX3WS3et7gQHVegAkrGKXU49pVg5wxp45DfkKRB+o/ov/qxsKYg3071lVdo
         ypU/gNcbDJxOEN2BnwREy6BVn1FP2v02O7Ms9OHtAdenIv4gMpfjQxv9wxgdEjXIVA
         4IHmclMHegZPmytmHWqOF2OJzEidLeCoKNcN8Y2E=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VIkf6vXtLI_B; Wed, 30 Sep 2020 07:55:02 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 260E88EE0E2;
        Wed, 30 Sep 2020 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601477701;
        bh=VaMZ7Emd85vZRu6q2i/ihCPCmX85kAYVPIe5UZvG3UI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Sgt+87M30J2hB58vHFA5qoJTX5bJMfJ0meVSg5E6bBpaFfS9sEwheJTtmdnU/oaJD
         qMtcODv4eEXlfb0k4cYKZPdZ5nNX7g5MdxFnsGRuL/ZuZE2qCxwcrvlQ0OKnXZsWM9
         JIJBvM0bZkC1TWWPXLzMrHsnm9MvdJ5vqHrvVUOQ=
Message-ID: <a97706be196e2e02ca815b3011d3731684905737.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Hao Wu <hao.wu@rubrik.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Date:   Wed, 30 Sep 2020 07:54:58 -0700
In-Reply-To: <20200930021637.GF808399@linux.intel.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
         <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
         <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
         <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
         <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
         <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
         <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
         <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
         <20200930021637.GF808399@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-30 at 05:16 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 28, 2020 at 03:11:39PM -0700, James Bottomley wrote:
> > On Sun, 2020-09-27 at 22:59 -0700, Hao Wu wrote:
> > [...]
> > > > However, there is another possibility: it's something to do
> > > > with the byte read; I notice you don't require the same
> > > > slowdown for the burst count read, which actually reads the
> > > > status register and burst count as a read32.  If that really is
> > > > the case, for the atmel would substituting a read32 and just
> > > > throwing the upper bytes away in tpm_tis_status() allow us to
> > > > keep the current timings?  I can actually try doing this and
> > > > see if it fixes my nuvoton.
> > > 
> > > If would be helpful if you can find the solution without reducing
> > > performance. I think it is a separate problem to address though.
> > > Maybe not worth to mix them in the same fix.
> > 
> > Well, if it works, no other fix is needed.
> > 
> > This is what I'm currently trying out on my nuvoton with the
> > timings reverted to being those in the vanilla kernel.  So far it
> > hasn't crashed, but I haven't run it for long enough to be sure
> > yet.
> > 
> > James
> 
> OK, so the bus does not like one byte reads but prefers full (32-bit)
> word reads? I.e. what's the context?

It's not supported by anything in the spec just empirical observation. 
However, the spec says the status register is 24 bits: the upper 16
being the burst count.  When we read the whole status register,
including the burst count, we do a read32. I observed that the
elongated timing was only added for the read8 code not the read32 which
supports the theory that the former causes the Atmel to crash but the
latter doesn't.  Of course it's always possible that probabilistically
the Atmel is going to crash on the burst count read, but that's
exercised far less than the status only read.

James
 

