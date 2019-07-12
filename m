Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58BA66508
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 05:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfGLDgG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 23:36:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:3347 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfGLDgG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 23:36:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 20:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,481,1557212400"; 
   d="scan'208";a="193621127"
Received: from gonegri-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.192])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2019 20:36:02 -0700
Date:   Fri, 12 Jul 2019 06:35:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org,
        groeck@chromium.org, gregkh@linuxfoundation.org,
        sukhomlinov@google.com, Arnd Bergmann <arnd@arndb.de>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM
 operations
Message-ID: <20190712033556.4pze65z7cxga5tdu@linux.intel.com>
References: <20190711162919.23813-1-dianders@chromium.org>
 <20190711163915.GD25807@ziepe.ca>
 <20190711183533.lypj2gwffwheq3qu@linux.intel.com>
 <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
 <20190711194626.GI25807@ziepe.ca>
 <20190712033138.tonhpqy4yfdlkvs4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712033138.tonhpqy4yfdlkvs4@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 12, 2019 at 06:31:38AM +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 11, 2019 at 04:46:26PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 11, 2019 at 10:43:13PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Jul 11, 2019 at 09:35:33PM +0300, Jarkko Sakkinen wrote:
> > > > > Careful with this, you can't backport this to any kernels that don't
> > > > > have the sysfs ops locking changes or they will crash in sysfs code.
> > > > 
> > > > Oops, I was way too fast! Thanks Jason.
> > > 
> > > Hmm... hold on a second.
> > > 
> > > How would the crash realize? I mean this is at the point when user space
> > > should not be active. 
> > 
> > Not strictly, AFAIK
> > 
> > > Secondly, why the crash would not realize with
> > > TPM2? The only thing the fix is doing is to do the same thing with TPM1
> > > essentially.
> > 
> > TPM2 doesn't use the unlocked sysfs path
> 
> Gah, sorry :-) I should have known that.
> 
> I can go through the patches needed when I come back from my leave after
> two weeks.

It might require a number of patches but maybe it makes also overally sense
to fix the racy sysfs code in stable kernels.

/Jarkko
