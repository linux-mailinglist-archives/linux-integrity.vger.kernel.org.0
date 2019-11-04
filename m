Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F168EEE2BB
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2019 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDOkD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Nov 2019 09:40:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDOkD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Nov 2019 09:40:03 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iRdWP-0007px-6u; Mon, 04 Nov 2019 15:39:57 +0100
Date:   Mon, 4 Nov 2019 15:39:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
 <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
 <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
 <20191028202637.GB7214@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191028202637.GB7214@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

sorry for that late reply, was traveling…

On 2019-10-28 22:26:37 [+0200], Jarkko Sakkinen wrote:
> > OK, so. Gave a relook at this:
> > 
> > This gives checkpatch.pl error:
> > 
> > 0012-tpm-remove-tpm_dev_wq_lock.patch
> > -------------------------------------
> > ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 9e1b74a63f77 ("tpm: add support for nonblocking operation")'
> > #8: 
> >   9e1b74a63f776 ("tpm: add support for nonblocking operation")
> > 
> > total: 1 errors, 0 warnings, 7 lines checked
> > 
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> > 
> > Please send me a new patch with a legit fixes line. It is a fix to
> > regression even if it is a cosmetic one.
> > 
> > I'll drop the current patch from my tree and apply a new one once
> > I get it from you.

Can you please explain what is wrong with that one? It is exactly as
suggested by the error line.

> > Thanks.
> > 
> > /Jarkko
> 
> AFAIK cc stable triggers stable backport, not fixes line alone (not
> 100% sure about this though). Anyway even my original response was
> meant to this patch I recall now that I bumped into that checkpatch
> error.

The cc: for stable and fixes are high indicators for it to be
considered. These days even a few keywords in the commit message might
let Sasha's script decide to pick/suggest a patch for stable.

> /Jarkko

Sebastian
