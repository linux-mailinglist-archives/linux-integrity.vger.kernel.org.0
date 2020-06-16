Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917201FC02D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFPUoO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:44:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:59617 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgFPUoN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:44:13 -0400
IronPort-SDR: 3ltUWAbFILq0lCtfpn/Pw1pZ4tU2KAlK0zNb+GYW3yfG4elZosE4Kcdj6aGi/zj0/J2/L1DTdy
 K9j7bvaIbKVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:44:11 -0700
IronPort-SDR: E6Lv6G59nFNKgevc10B6SxnZJ4f+oC+vzED5SdvjIWlocVgk0GkxSajpzfmK+gVyMHBV6Cx5am
 bCIYzMXI7f4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="273279833"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2020 13:44:07 -0700
Date:   Tue, 16 Jun 2020 23:44:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
Message-ID: <20200616204405.GA20943@linux.intel.com>
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
 <20200601014646.GA794847@linux.intel.com>
 <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
 <20200604094012.GA8989@linux.intel.com>
 <CAD=FV=Vgjs4gALALWYVLEYfbFtXi69FrVYziJ9x=YA5RjrV1ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vgjs4gALALWYVLEYfbFtXi69FrVYziJ9x=YA5RjrV1ww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 06:48:58AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 4, 2020 at 2:40 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, Jun 01, 2020 at 03:54:03PM -0700, Doug Anderson wrote:
> > > Does that answer your question, or were you worried about us needing
> > > to init iobuf[0] to 0 in some other case?
> > >
> > > -Doug
> >
> > No, but it should be treated as a bug fix for CR50 implementation i.e.
> > for 797c0113c9a481d4554988d70b5b52fae657262f, or is there some reason
> > why it shouldn't?
> 
> As talked about in the commit message, I think this is a slight
> cleanup for non-Cr50 too.  Specifically if we end up running through
> the TPM_RETRY loop a second time we weren't re-initting "phy->iobuf[0]
> = 0;"  That means that the 2nd time through the loop we were actually
> sending the TPM back the byte that the TPM sent us the first time
> through the loop.
> 
> Presumably this doesn't matter much, but it still feels nicer not to
> be sending the TPM's bytes back to it when we're not really supposed
> to.
> 
> Also, as mentioned in the commit message, I haven't observed this
> fixing any problems.  I only came up with it from code inspection
> while trying to track something else down.

Thanks, I'm happy how it is.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
