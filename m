Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1429C7CB
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 19:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829152AbgJ0St4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 14:49:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59762 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829143AbgJ0Stw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 14:49:52 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 71EF520C27C5;
        Tue, 27 Oct 2020 11:49:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71EF520C27C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603824591;
        bh=UCqR8kmyvQ0FXKqJhCb0mbrqDtMWWtwjtNpTAWZi0CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeXXkBqJFZ4o4JS2eSSKWDo91NZioycspBg4MtM0r8Rza0FWgX/KVEATGe2UW07pd
         f87Uyrpd5MDppghwpFM529K5HVWCTGrZ9b71iW9v0DMVn9uN0D5JkMhxj5fOX31X7w
         Y02px0ZOINQ2UxhdrdYRfBkV1gVrr/uEWSA/Yvuw=
Date:   Tue, 27 Oct 2020 13:49:33 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA
 not enabled
Message-ID: <20201027184933.GA5210@sequoia>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
 <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
 <20201020180231.GA14580@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020180231.GA14580@dell5510>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-10-20 20:02:31, Petr Vorel wrote:
> Hi Mimi, Dmitry,
> 
> > [Cc'ing Dmitry Eremin-Solenikov]
> 
> > Hi Petr,
> 
> > On Mon, 2020-10-19 at 22:08 +0200, Petr Vorel wrote:
> > > This is required, because when TPM HW available (i.e. -c /dev/tpm0),
> > > evmctl ima_boot_aggregate returns sha1:xxxx.
> 
> > > skip requires to move cleanup().
> 
> > > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> 
> > Nice.
> > > ---
> > > Hi Mimi,
> 
> > > this Fixes problems on current Debian, which has still disabled CONFIG_IMA
> > > (FYI [1]). I was not able to figure out how to get it working with
> > > sample-* files, but maybe there is a way.
> 
> > > Although it sound strange, people may want to build and check evmctl
> > > even on a system with disabled CONFIG_IMA (both Debian and Ubuntu have
> > > outdated ima-evm-utils (1.1)).
> 
> > Oops, I need to keep Dmitry in the loop better.  I'm hoping to release
> > v1.3 shortly.
> Thanks!
> @Dmitry do you wish to be Cc: before release or any other time?
> 
> > > Kind regards,
> > > Petr
> 
> > > [1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA
> 
> > I wasn't aware that because of lockdown, IMA was disabled.  Thank you
> > for reporting and updating the IMA w/lockdown status.
> Feel free to comment it, please. It'd be nice to have IMA in Debian (not sure
> about Ubuntu status).

I can help with the Ubuntu status. IMA is still enabled there. You can
see CONFIG_IMA set to 'y' in the 20.04 LTS (Focal) and most recent 20.10
release (Groovy):

https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/focal/tree/debian.master/config/annotations#n12861
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/groovy/tree/debian.master/config/annotations#n13173

Tyler

> 
> @Dmitry: do you plan to update Debian package? (you're the listed maintainer,
> although the package was signed by Wartan Hachaturow).
> 
> > Mimi
> 
> Kind regards,
> Petr
