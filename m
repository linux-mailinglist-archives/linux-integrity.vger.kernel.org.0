Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03567D2E44
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2019 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfJJQDV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Oct 2019 12:03:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfJJQDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Oct 2019 12:03:21 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iIauH-0004t3-Se; Thu, 10 Oct 2019 18:03:13 +0200
Date:   Thu, 10 Oct 2019 18:03:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211141145.GD8431@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-02-11 16:11:45 [+0200], Jarkko Sakkinen wrote:
> On Mon, Feb 11, 2019 at 11:58:35AM +0100, Sebastian Andrzej Siewior wrote:
> > Added in commit
> > 
> >   9e1b74a63f776 ("tpm: add support for nonblocking operation")
> > 
> > but never actually used it.
> > 
> > Cc: Philip Tricca <philip.b.tricca@intel.com>
> > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> You should use Fixes-tag e.g.
> 
> Fixes: <12 first chars from SHA-1> ("<short summary>")

Is this the only reason why it has not been picked up? A fixes line
which triggers stable backports for something that does need to be
backported?

> /Jarkko

Sebastian
