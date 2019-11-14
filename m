Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F186FC52A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 12:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKNLQU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 06:16:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNLQU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 06:16:20 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iVD6i-0000Nj-2P; Thu, 14 Nov 2019 12:16:12 +0100
Date:   Thu, 14 Nov 2019 12:16:12 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191114111612.r7los6v7lpmiujcw@linutronix.de>
References: <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
 <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
 <20191028202637.GB7214@linux.intel.com>
 <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
 <20191104173709.qqmdiacytyimbqhx@cantor>
 <20191104174450.dlxlgixizej5orqr@linutronix.de>
 <20191104182732.md3t6xbumg53wkcl@cantor>
 <20191107161041.h7pgtlmj5zbi4frs@linutronix.de>
 <20191107183503.GA8418@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107183503.GA8418@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-11-07 20:35:03 [+0200], Jarkko Sakkinen wrote:
> On Thu, Nov 07, 2019 at 05:10:41PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-11-04 11:27:32 [-0700], Jerry Snitselaar wrote:
> > > On Mon Nov 04 19, Sebastian Andrzej Siewior wrote:
> > > > On 2019-11-04 10:37:09 [-0700], Jerry Snitselaar wrote:
> > > > > It looks like checkpatch is expecting the word commit to precede the hash on the same line.
> > > > > I get no errors with the following:
> > > > 
> > > > That would explain it. That is however not what the TIP tree and other
> > > > people do not to mention that reading wise it makes sense to keep the
> > > > word `commit' as part of the sentence and add the hash in the next line.
> > > > 
> > > 
> > > Yes it reads better. What about the following?
> > > 
> > > Added in commit 9e1b74a63f776 ("tpm: add support for nonblocking
> > > operation"), but never actually used it.
> > > 
> > > And then add the Fixes: line above the Cc: and Signed-off-by: ?
> > 
> > Can please get over with? It is a simple patch. It has simple
> > description.
> 
> https://lore.kernel.org/linux-integrity/20191028202419.GA7214@linux.intel.com/
> 
> I'm also cool with cc stable as long as the commit is message has the
> correct format.

This is _really_ getting ridiculous. Holding back a simple patch just
because checkpatch says that the word `commit' is not in a new line. It
is more readable that way not to mention line with the commit id is
getting really long. This is a stupid checkpatch rule which is enforced
here.

> /Jarkko

Sebastian
