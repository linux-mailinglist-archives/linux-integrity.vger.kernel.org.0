Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C309E7A11
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJ1U0m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Oct 2019 16:26:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:14303 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfJ1U0m (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Oct 2019 16:26:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 13:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="210951683"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2019 13:26:39 -0700
Date:   Mon, 28 Oct 2019 22:26:37 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191028202637.GB7214@linux.intel.com>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
 <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
 <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028202419.GA7214@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 28, 2019 at 10:24:19PM +0200, Jarkko Sakkinen wrote:
> On Mon, Oct 14, 2019 at 10:39:42PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Oct 10, 2019 at 06:03:13PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-02-11 16:11:45 [+0200], Jarkko Sakkinen wrote:
> > > > On Mon, Feb 11, 2019 at 11:58:35AM +0100, Sebastian Andrzej Siewior wrote:
> > > > > Added in commit
> > > > > 
> > > > >   9e1b74a63f776 ("tpm: add support for nonblocking operation")
> > > > > 
> > > > > but never actually used it.
> > > > > 
> > > > > Cc: Philip Tricca <philip.b.tricca@intel.com>
> > > > > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > 
> > > > You should use Fixes-tag e.g.
> > > > 
> > > > Fixes: <12 first chars from SHA-1> ("<short summary>")
> > > 
> > > Is this the only reason why it has not been picked up? A fixes line
> > > which triggers stable backports for something that does need to be
> > > backported?
> > 
> > Fully agree with you. Frankly, I don't really remember anymore why I
> > responded that way. My guess is that I responded that to a worng patch.
> > 
> > Please just ping immediatelly. Sometimes when dealing with dozens of
> > patches this kind of human error might happen.
> > 
> > In any case, the patch is applied.
> 
> OK, so. Gave a relook at this:
> 
> This gives checkpatch.pl error:
> 
> 0012-tpm-remove-tpm_dev_wq_lock.patch
> -------------------------------------
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 9e1b74a63f77 ("tpm: add support for nonblocking operation")'
> #8: 
>   9e1b74a63f776 ("tpm: add support for nonblocking operation")
> 
> total: 1 errors, 0 warnings, 7 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Please send me a new patch with a legit fixes line. It is a fix to
> regression even if it is a cosmetic one.
> 
> I'll drop the current patch from my tree and apply a new one once
> I get it from you.
> 
> Thanks.
> 
> /Jarkko

AFAIK cc stable triggers stable backport, not fixes line alone (not
100% sure about this though). Anyway even my original response was
meant to this patch I recall now that I bumped into that checkpatch
error.

/Jarkko
