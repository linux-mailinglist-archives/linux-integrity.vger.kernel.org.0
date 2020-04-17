Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EFA1AE8C1
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Apr 2020 01:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDQXyL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Apr 2020 19:54:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:50305 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgDQXyK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Apr 2020 19:54:10 -0400
IronPort-SDR: 7eg1eFXc2vRZb9fVFcA3WPj2xnXTtYzawBpJ+DsWNtFunL5D5rg5wQSAJxbHd9dznqbZ5QgleG
 RPlQO5rk0aCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 16:54:10 -0700
IronPort-SDR: INuBFc2w3pz1Qnx5q0H2bPrsBKKuM+AC451BL0AlRdoaaznmYMNU5uQiAaQTu3ys2Gj1t/n2Tj
 3iSKNTvcAt3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="244840451"
Received: from zhiwang1-mobl5.ger.corp.intel.com (HELO localhost) ([10.252.42.90])
  by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2020 16:54:07 -0700
Date:   Sat, 18 Apr 2020 02:54:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200417235406.GA85230@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <20200416170810.GD199110@linux.intel.com>
 <20200416185433.GA701157@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416185433.GA701157@vader>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 16, 2020 at 11:54:33AM -0700, Omar Sandoval wrote:
> On Thu, Apr 16, 2020 at 08:08:10PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Apr 15, 2020 at 03:45:22PM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > We've encountered a particular model of STMicroelectronics TPM that
> > > transiently returns a bad value in the status register. This causes the
> > > kernel to believe that the TPM is ready to receive a command when it
> > > actually isn't, which in turn causes the send to time out in
> > > get_burstcount(). In testing, reading the status register one extra time
> > > convinces the TPM to return a valid value.
> > > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > 
> > So what is the bad value?
> 
> 0xff. Sorry, I thought it would be clear from the code and comment in
> the patch itself. Would you prefer for me to repeat it in the commit
> message?

It is part of the problem description where as "bad value" does
not have any particular meaning.

/Jarkko
