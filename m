Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E054AE4C08
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394578AbfJYNZb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 09:25:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394577AbfJYNZb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 09:25:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68388AD3A;
        Fri, 25 Oct 2019 13:25:29 +0000 (UTC)
Date:   Fri, 25 Oct 2019 15:25:27 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?iso-8859-2?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191025132527.GB13329@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
 <1571964420.5173.12.camel@linux.ibm.com>
 <20191025021159.dt7ifgnebnke6ca7@cantor>
 <20191025085617.GA13329@x230>
 <20191025125202.GA1966@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025125202.GA1966@mail.hallyn.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> > > /sys/kernel/security/tpmX/major_version (on fedora and rhel at least, is it elsewhere on other distros?)

> > > versus

> > > /sys/class/tpm/tpmX/major_version

> > Is it more HW related (/sys/class/tpm/tpmX) or LSM related
> > (/sys/kernel/security/tpmX)?
> > I guess /sys/kernel/security/tpmX might be better.

> This is purely about whether the phsyical TPM chip is 1.2 or 2.,
> right?  /sys/class/tpm/tpmX is where I would expect to find that.
+1

> > Thanks for implementing this, I'll try to test it soon.

> Yes, it's been a pain point, and someone (..., I) should have done this years
> ago - thanks!

Kind regards,
Petr
