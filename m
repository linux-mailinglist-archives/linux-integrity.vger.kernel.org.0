Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7E27ED4F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgI3PhV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 11:37:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:15767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730057AbgI3PhV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 11:37:21 -0400
IronPort-SDR: 0JiDVTRV6QtysMkFlzNjsmHZkYDYsjoLMNY22pyhEPCRR0vX+d9VBwubnOstSeLBpZ9vkaGby1
 F/lGOY1jPLfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="226619065"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="226619065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 08:37:20 -0700
IronPort-SDR: cEmP9Y42u5Nk7YenxDKoyjgCTWVJuKu+SRfR4MJFeVbcD4n05C9FVMD8/gjI/LZQVrppU/jt09
 GpSQA84McvKA==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="498051057"
Received: from geigerri-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 08:37:16 -0700
Date:   Wed, 30 Sep 2020 18:37:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
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
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20200930153715.GC52739@linux.intel.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
 <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
 <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
 <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
 <20200930021637.GF808399@linux.intel.com>
 <a97706be196e2e02ca815b3011d3731684905737.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97706be196e2e02ca815b3011d3731684905737.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 30, 2020 at 07:54:58AM -0700, James Bottomley wrote:
> On Wed, 2020-09-30 at 05:16 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 28, 2020 at 03:11:39PM -0700, James Bottomley wrote:
> > > On Sun, 2020-09-27 at 22:59 -0700, Hao Wu wrote:
> > > [...]
> > > > > However, there is another possibility: it's something to do
> > > > > with the byte read; I notice you don't require the same
> > > > > slowdown for the burst count read, which actually reads the
> > > > > status register and burst count as a read32.  If that really is
> > > > > the case, for the atmel would substituting a read32 and just
> > > > > throwing the upper bytes away in tpm_tis_status() allow us to
> > > > > keep the current timings?  I can actually try doing this and
> > > > > see if it fixes my nuvoton.
> > > > 
> > > > If would be helpful if you can find the solution without reducing
> > > > performance. I think it is a separate problem to address though.
> > > > Maybe not worth to mix them in the same fix.
> > > 
> > > Well, if it works, no other fix is needed.
> > > 
> > > This is what I'm currently trying out on my nuvoton with the
> > > timings reverted to being those in the vanilla kernel.  So far it
> > > hasn't crashed, but I haven't run it for long enough to be sure
> > > yet.
> > > 
> > > James
> > 
> > OK, so the bus does not like one byte reads but prefers full (32-bit)
> > word reads? I.e. what's the context?
> 
> It's not supported by anything in the spec just empirical observation. 
> However, the spec says the status register is 24 bits: the upper 16
> being the burst count.  When we read the whole status register,
> including the burst count, we do a read32. I observed that the
> elongated timing was only added for the read8 code not the read32 which
> supports the theory that the former causes the Atmel to crash but the
> latter doesn't.  Of course it's always possible that probabilistically
> the Atmel is going to crash on the burst count read, but that's
> exercised far less than the status only read.

This paragraph is good enough explanation for me. Can you include it
to the final commit as soon as we hear how your fix works for Hao?

/Jarkko
