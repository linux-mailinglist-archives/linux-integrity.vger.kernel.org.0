Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA39229A76
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 16:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgGVOpO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 10:45:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:33828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgGVOpN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 10:45:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40FD6AE44;
        Wed, 22 Jul 2020 14:45:20 +0000 (UTC)
Date:   Wed, 22 Jul 2020 16:45:11 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
Message-ID: <20200722144511.GA18945@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200722114729.4210-1-pvorel@suse.cz>
 <1595428021.5311.93.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595428021.5311.93.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Wed, 2020-07-22 at 13:47 +0200, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  NEWS | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  delete mode 100644 NEWS

> > diff --git a/NEWS b/NEWS
> > deleted file mode 100644
> > index e69de29..0000000

> Really annoying having to include an empty file, but without it,
> autoconf fails with:

> Makefile.am: error: required file './NEWS' not found
> src/Makefile.am: installing './depcomp'
> autoreconf: automake failed with exit status: 1

OK, it does not work with the new way.
It'd be better to touch the file in autogen.sh and add it into .gitignore, but
let's ignore it.
I found that when looking at rpmlint errors, I just don't package this file and
hope you never start to use it.

Kind regards,
Petr
