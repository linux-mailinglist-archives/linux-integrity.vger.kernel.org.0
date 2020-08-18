Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11E3247DE9
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 07:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHRFf4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 01:35:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:22953 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRFf4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 01:35:56 -0400
IronPort-SDR: icffeZuFEdVjyq7oI3jJFuioTws3hcPeFFe9z8KzD6hdTc/PT58Xi5R0xy4tHcrGfd47przLG7
 DyvSVtPaR8Yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219161416"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="219161416"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:35:55 -0700
IronPort-SDR: cUW3rrrCczWoO47ZhAOljb4xm0Fk44rpcFuxBok4vDxM4uloESqVj2Xpglsp05BeCYNWS2I3sT
 iXxf90WRwryg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="441108844"
Received: from lcrossx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.46.217])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2020 22:35:54 -0700
Date:   Tue, 18 Aug 2020 08:35:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1] tpm: use %*ph to print small buffer
Message-ID: <20200818053551.GB119714@linux.intel.com>
References: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
 <20200731204308.GD27841@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731204308.GD27841@dell5510>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 31, 2020 at 10:43:08PM +0200, Petr Vorel wrote:
> Hi,
> 
> > Use %*ph format to print small buffer as hex string.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

Thanks, I'll add this to the commit.

/Jarkko
