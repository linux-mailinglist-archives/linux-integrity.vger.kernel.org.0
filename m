Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F592229E0
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgGPR2a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 13:28:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:43526 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPR2a (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 13:28:30 -0400
IronPort-SDR: MzJqVoL1VOyOjiind47ZVmhYJzlgUXn9XK2EYpX3xDhAdzd81nk4ftOT0cUSYTxqD6uRrML2Nq
 p2skPS7/SzcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234304876"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="234304876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:28:16 -0700
IronPort-SDR: m6l+In8vox4es+mEgJ3YiEtcoyQ32y11TCHILjoKLi+6FWQ5SLHj8wHaSUphRUksGd+FQOj1rd
 SfPuP8TDs5VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="325205940"
Received: from unknown (HELO localhost) ([10.249.34.156])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 10:28:12 -0700
Date:   Thu, 16 Jul 2020 20:28:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Guenter Roeck <groeck@google.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
Message-ID: <20200716172811.GB14135@linux.intel.com>
References: <20200710002209.6757-1-apronin@chromium.org>
 <20200710114000.GD2614@linux.intel.com>
 <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
 <20200714113205.GA1461506@linux.intel.com>
 <CABXOdTcAZjG8aQvs+M72CFe9rAdBKZH+6x=C1Ha2aX_w0gXiHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTcAZjG8aQvs+M72CFe9rAdBKZH+6x=C1Ha2aX_w0gXiHw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 14, 2020 at 08:48:38AM -0700, Guenter Roeck wrote:
> On Tue, Jul 14, 2020 at 4:32 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, Jul 10, 2020 at 11:25:44AM -0700, Andrey Pronin wrote:
> > > > Why does not tpm_del_char_device need this?
> > >
> > > "Not" is a typo in the sentence above, right? tpm_del_char_device *does*
> > > need the fix. When tpm_class_shutdown is called it sets chip->ops to
> > > NULL. If tpm_del_char_device is called after that, it doesn't check if
> > > chip->ops is NULL (normal kernel API and char device API calls go
> > > through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
> > > call tpm2_shutdown(), which tries sending the command and dereferences
> > > chip->ops.
> >
> > It's a typo, yes. Sorry about that.
> >
> > tpm_class_shutdown() is essentially tail of tpm_del_char_device().
> >
> > To clean things up, I'd suggest dropping tpm_del_char_device() and
> > call tpm_class_shutdown() in tpm_chip_unregisters() along, and open
> > coding things that prepend it in tpm_del_char_device().
> >
> 
> Personally I would have preferred two separate patches, one to fix the
> immediate problem (with Cc: stable) and one for the cleanup, but I
> guess merging both into one is ok as long as it is marked for stable.
> 
> Thanks,
> Guenter

Not sure about stable as this issue does not afaik concern earlier
kernel versions?

/Jarkko
