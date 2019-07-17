Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764E06BFBD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfGQQit (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 12:38:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbfGQQit (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 12:38:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44AB4AF92;
        Wed, 17 Jul 2019 16:38:47 +0000 (UTC)
Date:   Wed, 17 Jul 2019 18:38:51 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: Re: [PATCH v1 0/5] ima-evm-utils: Assorted fixes and improvements
Message-ID: <20190717163851.GA22235@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190707234837.4866-1-vt@altlinux.org>
 <1562599850.11461.43.camel@linux.ibm.com>
 <20190709154333.33345iepccstscpv@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709154333.33345iepccstscpv@altlinux.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Vitaly,

> Mimi,

> On Mon, Jul 08, 2019 at 11:30:50AM -0400, Mimi Zohar wrote:
> > [Cc'ing Roberto, Petr, Thiago, Prakhar]
> > Now that we're including ALL the kernel exported hash_info algorithms,
> > a colleague suggested defining a list of deprecated hash algorithms.
> >  Instead of preventing the usage of these deprecated hash algorithms,
> > initially I would start out with a warning.  It would be helpful to
> > indicate which standard deprecated the hash algorithm and year.  At
> > some point, we might want to prevent their usage in signing files, but
> > not verifying file signatures.
Looks useful to me.

> I think this is not a problem, because user explicitly states which hash
> algorithm he wants to use. Except for SHA1, which is also silent
> fallback algorithm. I think this fallback mechanism should be removed.
Agree with removing fallback mechanism.

> Also, return values of sign_hash/ima_calc_hash/etc are not defined
> clearly and callers have weird checks such as `if (len <= 1)`. I think
> this should be conceptually simplified and made them `return -1` on any
> error.


> > evmctl "ima_measurement" doesn't support custom template definitions.
> > Also missing is support for verifying the "ima-buf" kexec command boot
> > command line and the "ima-modsig" template appended signature.

> > David Jacobson started writing a regression framework and posted a v2
> > version.  I'd really appreciate help with cleaning up that code. 

> Maybe tests should be integrated into ima-evm-utils too.
https://patchwork.kernel.org/project/linux-integrity/list/?series=95303

> Thanks,

Kind regards,
Petr
