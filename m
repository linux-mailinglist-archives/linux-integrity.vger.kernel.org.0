Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BFC22AE71
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgGWLzA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 07:55:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:55822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWLzA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 07:55:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C136AD1E;
        Thu, 23 Jul 2020 11:55:07 +0000 (UTC)
Date:   Thu, 23 Jul 2020 13:54:57 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
Message-ID: <20200723115457.GA26679@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200722114729.4210-1-pvorel@suse.cz>
 <1595428021.5311.93.camel@linux.ibm.com>
 <20200722144510.l5qwn62dlanbuul4@altlinux.org>
 <20200722145047.GB18945@dell5510>
 <1595431869.5311.102.camel@linux.ibm.com>
 <1595503098.5211.85.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595503098.5211.85.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> After renaming "ChangeLog" to "NEWS" as discussed, autotools now
> complains about the missing "ChangeLog" file.

> automake has a number of flavors[1][2].  The "foreign" flavor, which
> can be supplied as an option to AM_INIT_AUTOMAKE, doesn't require the
> NEWS, COPYING, AUTHORS, ChangeLog, or README files to exist.

> Although renaming the files didn't help, it makes sense.  The patch
> does both - renames ChangeLog and uses the "foreign" option.

Thanks for fixing it. foreign flavor fits our needs better than gnu.
Autotools "features" like this (having strange gnu flavor as the default)
explain why people keep introducing new build systems like Meson (which brings
other problems).

Kind regards,
Petr

> Mimi

> [1] https://www.gnu.org/software/automake/manual/automake.html#index-automake-options
> [2] https://autotools.io/automake/options.html
