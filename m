Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D878122B0F1
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGWOEX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 10:04:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39318 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGWOEW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 10:04:22 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 52B5C72CCDC;
        Thu, 23 Jul 2020 17:04:21 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 1BE174A4AEF;
        Thu, 23 Jul 2020 17:04:21 +0300 (MSK)
Date:   Thu, 23 Jul 2020 17:04:20 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
Message-ID: <20200723140420.jwz6rjwq5j2ouzzt@altlinux.org>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20200722114729.4210-1-pvorel@suse.cz>
 <1595428021.5311.93.camel@linux.ibm.com>
 <20200722144510.l5qwn62dlanbuul4@altlinux.org>
 <20200722145047.GB18945@dell5510>
 <1595431869.5311.102.camel@linux.ibm.com>
 <1595503098.5211.85.camel@linux.ibm.com>
 <20200723115457.GA26679@dell5510>
 <1595506070.5211.103.camel@linux.ibm.com>
 <20200723122934.GA30011@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723122934.GA30011@dell5510>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Jul 23, 2020 at 02:29:34PM +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> ...
> > > Thanks for fixing it. foreign flavor fits our needs better than gnu.
> > > Autotools "features" like this (having strange gnu flavor as the default)
> > > explain why people keep introducing new build systems like Meson (which brings
> > > other problems).
> 
> > Changing the autotools flavor solved the problem, but I wasn't sure
> > that it was the correct solution. šThank you for validating the flavor
> > change.
> yw :).
> 
> BTW could you also merge your .travis.yml from next-testing-travis to next (and
> preferably also to master)? Even if you have no way to setup automatic mirror to
> some travis account, it help to run it sometimes or at least before release.

Also, it's useful to packagers to see that there is tests and how to run
them.

Thanks,

> 
> Also, having docker based travis setup helps to test build against other distros
> (we have it in LTP).
> 
> Kind regards,
> Petr
