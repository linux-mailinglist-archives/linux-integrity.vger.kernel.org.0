Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5527FE40B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2019 18:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfKOReN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Nov 2019 12:34:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:58421 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbfKOReN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Nov 2019 12:34:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 09:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="195453275"
Received: from sgaffney-mobl3.amr.corp.intel.com (HELO localhost) ([10.252.4.81])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2019 09:34:08 -0800
Date:   Fri, 15 Nov 2019 19:34:07 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] tpm: remove tpm_dev_wq_lock
Message-ID: <20191115173407.GC21300@linux.intel.com>
References: <20191014193942.GH15552@linux.intel.com>
 <20191028202419.GA7214@linux.intel.com>
 <20191028202637.GB7214@linux.intel.com>
 <20191104143957.onsfuvmwfuvmfuu6@linutronix.de>
 <20191104173709.qqmdiacytyimbqhx@cantor>
 <20191104174450.dlxlgixizej5orqr@linutronix.de>
 <20191104182732.md3t6xbumg53wkcl@cantor>
 <20191107161041.h7pgtlmj5zbi4frs@linutronix.de>
 <20191107183503.GA8418@linux.intel.com>
 <20191114111612.r7los6v7lpmiujcw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114111612.r7los6v7lpmiujcw@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 14, 2019 at 12:16:12PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-07 20:35:03 [+0200], Jarkko Sakkinen wrote:
> > On Thu, Nov 07, 2019 at 05:10:41PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2019-11-04 11:27:32 [-0700], Jerry Snitselaar wrote:
> > > > On Mon Nov 04 19, Sebastian Andrzej Siewior wrote:
> > > > > On 2019-11-04 10:37:09 [-0700], Jerry Snitselaar wrote:
> > > > > > It looks like checkpatch is expecting the word commit to precede the hash on the same line.
> > > > > > I get no errors with the following:
> > > > > 
> > > > > That would explain it. That is however not what the TIP tree and other
> > > > > people do not to mention that reading wise it makes sense to keep the
> > > > > word `commit' as part of the sentence and add the hash in the next line.
> > > > > 
> > > > 
> > > > Yes it reads better. What about the following?
> > > > 
> > > > Added in commit 9e1b74a63f776 ("tpm: add support for nonblocking
> > > > operation"), but never actually used it.
> > > > 
> > > > And then add the Fixes: line above the Cc: and Signed-off-by: ?
> > > 
> > > Can please get over with? It is a simple patch. It has simple
> > > description.
> > 
> > https://lore.kernel.org/linux-integrity/20191028202419.GA7214@linux.intel.com/
> > 
> > I'm also cool with cc stable as long as the commit is message has the
> > correct format.
> 
> This is _really_ getting ridiculous. Holding back a simple patch just
> because checkpatch says that the word `commit' is not in a new line. It
> is more readable that way not to mention line with the commit id is
> getting really long. This is a stupid checkpatch rule which is enforced
> here.

I'm not sure why formatting a commit message properly is ridicilous.

If it is a bug fix, then it should have fixes tag.

/Jarkko
