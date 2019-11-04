Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A947EE672
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2019 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKDRo7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Nov 2019 12:44:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfKDRo6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Nov 2019 12:44:58 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iRgPK-0002QI-Pz; Mon, 04 Nov 2019 18:44:50 +0100
Date:   Mon, 4 Nov 2019 18:44:50 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191104174450.dlxlgixizej5orqr@linutronix.de>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
 <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
 <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
 <20191028202637.GB7214@linux.intel.com>
 <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
 <20191104173709.qqmdiacytyimbqhx@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104173709.qqmdiacytyimbqhx@cantor>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-11-04 10:37:09 [-0700], Jerry Snitselaar wrote:
> It looks like checkpatch is expecting the word commit to precede the hash on the same line.
> I get no errors with the following:

That would explain it. That is however not what the TIP tree and other
people do not to mention that reading wise it makes sense to keep the
word `commit' as part of the sentence and add the hash in the next line.

> Added in
> 
>   commit 9e1b74a63f776 ("tpm: add support for nonblocking operation")
> 
> but never actually used it.
> 
> Fixes: 9e1b74a63f776 ("tpm: add support for nonblocking operation")
> Cc: Philip Tricca <philip.b.tricca@intel.com>
> Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
