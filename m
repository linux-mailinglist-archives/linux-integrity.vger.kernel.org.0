Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BAE4BA3
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfJYM5Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 08:57:16 -0400
Received: from mail.hallyn.com ([178.63.66.53]:39036 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438960AbfJYM5Q (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 08:57:16 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 08:57:15 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 6836A85B; Fri, 25 Oct 2019 07:52:02 -0500 (CDT)
Date:   Fri, 25 Oct 2019 07:52:02 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191025125202.GA1966@mail.hallyn.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
 <1571964420.5173.12.camel@linux.ibm.com>
 <20191025021159.dt7ifgnebnke6ca7@cantor>
 <20191025085617.GA13329@x230>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025085617.GA13329@x230>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 25, 2019 at 10:56:17AM +0200, Petr Vorel wrote:
> Hi,
> 
> > /sys/kernel/security/tpmX/major_version (on fedora and rhel at least, is it elsewhere on other distros?)
> 
> > versus
> 
> > /sys/class/tpm/tpmX/major_version
> 
> Is it more HW related (/sys/class/tpm/tpmX) or LSM related
> (/sys/kernel/security/tpmX)?
> I guess /sys/kernel/security/tpmX might be better.

This is purely about whether the phsyical TPM chip is 1.2 or 2.,
right?  /sys/class/tpm/tpmX is where I would expect to find that.

> Thanks for implementing this, I'll try to test it soon.

Yes, it's been a pain point, and someone (..., I) should have done this years
ago - thanks!
