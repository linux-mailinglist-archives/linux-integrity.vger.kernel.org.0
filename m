Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B399CF3466
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfKGQKs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Nov 2019 11:10:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48541 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbfKGQKs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Nov 2019 11:10:48 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iSkMr-000133-2S; Thu, 07 Nov 2019 17:10:41 +0100
Date:   Thu, 7 Nov 2019 17:10:41 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191107161041.h7pgtlmj5zbi4frs@linutronix.de>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
 <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
 <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
 <20191028202637.GB7214@linux.intel.com>
 <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
 <20191104173709.qqmdiacytyimbqhx@cantor>
 <20191104174450.dlxlgixizej5orqr@linutronix.de>
 <20191104182732.md3t6xbumg53wkcl@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104182732.md3t6xbumg53wkcl@cantor>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-11-04 11:27:32 [-0700], Jerry Snitselaar wrote:
> On Mon Nov 04 19, Sebastian Andrzej Siewior wrote:
> > On 2019-11-04 10:37:09 [-0700], Jerry Snitselaar wrote:
> > > It looks like checkpatch is expecting the word commit to precede the hash on the same line.
> > > I get no errors with the following:
> > 
> > That would explain it. That is however not what the TIP tree and other
> > people do not to mention that reading wise it makes sense to keep the
> > word `commit' as part of the sentence and add the hash in the next line.
> > 
> 
> Yes it reads better. What about the following?
> 
> Added in commit 9e1b74a63f776 ("tpm: add support for nonblocking
> operation"), but never actually used it.
> 
> And then add the Fixes: line above the Cc: and Signed-off-by: ?

Can please get over with? It is a simple patch. It has simple
description.

Sebastian
