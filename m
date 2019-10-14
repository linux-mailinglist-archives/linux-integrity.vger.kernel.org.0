Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70EDCD6A42
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 21:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfJNTjr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 15:39:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:11547 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbfJNTjr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 15:39:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 12:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="189117045"
Received: from kridax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.7.178])
  by orsmga008.jf.intel.com with ESMTP; 14 Oct 2019 12:39:43 -0700
Date:   Mon, 14 Oct 2019 22:39:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191014193942.GH15552@linux.intel.com>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <20190211141145.GD8431@linux.intel.com>
 <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010160313.pdf6ue4r2intbgoh@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 10, 2019 at 06:03:13PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-02-11 16:11:45 [+0200], Jarkko Sakkinen wrote:
> > On Mon, Feb 11, 2019 at 11:58:35AM +0100, Sebastian Andrzej Siewior wrote:
> > > Added in commit
> > > 
> > >   9e1b74a63f776 ("tpm: add support for nonblocking operation")
> > > 
> > > but never actually used it.
> > > 
> > > Cc: Philip Tricca <philip.b.tricca@intel.com>
> > > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > You should use Fixes-tag e.g.
> > 
> > Fixes: <12 first chars from SHA-1> ("<short summary>")
> 
> Is this the only reason why it has not been picked up? A fixes line
> which triggers stable backports for something that does need to be
> backported?

Fully agree with you. Frankly, I don't really remember anymore why I
responded that way. My guess is that I responded that to a worng patch.

Please just ping immediatelly. Sometimes when dealing with dozens of
patches this kind of human error might happen.

In any case, the patch is applied.

/Jarkko
