Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D953AAB2A
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Jun 2021 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhFQFrH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Jun 2021 01:47:07 -0400
Received: from smtp2.axis.com ([195.60.68.18]:37607 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQFrH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Jun 2021 01:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1623908700;
  x=1655444700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0SZp+MtB0FHehHfzfK9jQoLO67WK2V4tsZ4tytRZpo=;
  b=F2h2JIbTOkCZNmNFfvBJR5bgzKJWpoxsTckkmsWVGwaWLO3d/m4VSDna
   EaWkNTUpqIk9M8iEAZ+TwR39uphq+xvQqjbGJ5+MnDe+3U2DpNjw2lKKj
   3kXC6DdnWy49qxY15+4iYRmSwXY5l7q2O7tJo0ez3h6MOVpn/c2yl/oDX
   5Ni6pVZBJuiHVO7sbFMvbAHO+msN8vRF3hexLKazIJav483aR8O9XYlre
   mMscH6S69AnxB6COnUG0LsIYxRdR5OcJUfq3U6/TkkFBk5iehBKMkrQNk
   bI/DIMXYTRVE5qU5y9jfZrYvoXbb5vi7S++V+lGyt+jXp0jB4BwIYEvi1
   Q==;
Date:   Thu, 17 Jun 2021 07:44:58 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <James.Bottomley@HansenPartnership.com>, <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 2/2] tpm: Fix crash on tmprm release
Message-ID: <20210617054458.GB4049@axis.com>
References: <20210615091410.17007-1-vincent.whitchurch@axis.com>
 <20210615091410.17007-2-vincent.whitchurch@axis.com>
 <20210615131848.cynblt5qindtvtiz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210615131848.cynblt5qindtvtiz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 15, 2021 at 03:18:48PM +0200, Jarkko Sakkinen wrote:
> On Tue, Jun 15, 2021 at 11:14:09AM +0200, Vincent Whitchurch wrote:
> > If the tpm_tis module is removed (or a system shutdown is triggered)
> > while the tpmrm device is use, the kernel crashes due to chip->ops being
> > NULL:
> > 
> >  # exec 3<>/dev/tpmrm0
> >  # rmmod tpm_tis
> >  # exit
> >  ==================================================================
> >  BUG: KASAN: null-ptr-deref in tpm_chip_start+0x2d/0x120 [tpm]
> >  Read of size 8 at addr 0000000000000060 by task sh/994
> > 
> >  Call Trace:
> >   kasan_report.cold.13+0x10f/0x111
> >   tpm_chip_start+0x2d/0x120 [tpm]
> >   tpm2_del_space+0x2c/0xa0 [tpm]
> >   tpmrm_release+0x3f/0x50 [tpm]
> >   __fput+0x110/0x3c0
> >   task_work_run+0x94/0xd0
> >   do_exit+0x683/0x13e0
> >   do_group_exit+0x8b/0x140
> >   do_syscall_64+0x3c/0x80
> >  ==================================================================
> > 
> > Fix this by making tpm2_del_space() use tpm_try_get_ops().  The latter
> > already includes the calls to tpm_chip_start() and tpm_chip_stop().
> 
> This lacks explanation why migrating to tpm_try_get_ops() fixes the
> issue. Saying that doing something fixes something is not good enough
> explanation. So, can you extend this paragraph just a bit in the next
> version?

Thank you for the review, but I see now that James already proposed a
more-or-less identical fix earlier, so I'll let that patch run its due
course:

 https://lore.kernel.org/linux-integrity/e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com/
 https://lore.kernel.org/linux-integrity/327f4c87-e652-6cbe-c624-16a6edf0c31d@kunbus.com/
