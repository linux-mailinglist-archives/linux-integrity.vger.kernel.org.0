Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF51C1E9FAA
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFAH7E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 03:59:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:18499 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFAH7D (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 03:59:03 -0400
IronPort-SDR: uiY0A0VytvnSwkq3l514NQH9dmvTm0wJdtfZcV6ZUTuSnMirxLzZTn5U1/q2MkFcUfYc+0Bjtp
 4fxS+7ik+4Gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 00:59:03 -0700
IronPort-SDR: 09aW9iTYUGUBcpkzuLOZY2widKe5zXQd/1QlMoIW8XH/av028rKI3f0h+6CCKsibYZFAnofQZh
 Qkj81McoN1qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,460,1583222400"; 
   d="scan'208";a="311880765"
Received: from yhanin-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.43.17])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2020 00:59:00 -0700
Date:   Mon, 1 Jun 2020 10:59:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv5 1/3] optee: do drivers initialization before and after
 tee-supplicant run
Message-ID: <20200601075900.GA84773@linux.intel.com>
References: <20200529082701.13457-1-maxim.uvarov@linaro.org>
 <20200529082701.13457-2-maxim.uvarov@linaro.org>
 <20200601014901.GB794847@linux.intel.com>
 <CAD8XO3Ztoz8scEq9Rt_SMHCU6pSgf6NGSX+UNLQPy=0g56EXVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8XO3Ztoz8scEq9Rt_SMHCU6pSgf6NGSX+UNLQPy=0g56EXVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 01, 2020 at 10:13:40AM +0300, Maxim Uvarov wrote:
> On Mon, 1 Jun 2020 at 04:49, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, May 29, 2020 at 11:26:59AM +0300, Maxim Uvarov wrote:
> > > Some drivers (like ftpm) can operate only after tee-supplicant
> > > runs because of tee-supplicant provides things like storage
> > > services.  This patch splits probe of non tee-supplicant dependable
> > > drivers to the early stage, and after tee-supplicant run probe other
> > > drivers.
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> > > Suggested-by: Arnd Bergmann <arnd@linaro.org>
> >
> > $ scripts/get_maintainer.pl drivers/tee
> > Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE SUBSYSTEM)
> > tee-dev@lists.linaro.org (open list:TEE SUBSYSTEM)
> > linux-kernel@vger.kernel.org (open list)
> >
> > tee-dev is missing. Please resend.
> >
> > /Jarkko
> 
> tee-dev@ is in CC.

Oops. I'm sorry, missed it.

/Jarkko
