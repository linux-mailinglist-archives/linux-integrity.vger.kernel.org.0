Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635661D2DCE
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgENLFb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:05:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:24211 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLFb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:05:31 -0400
IronPort-SDR: W8MgbRY7hrIedxv8XmxWrm+oqE2e48nKqlMY3AXx9bRlR75A0fn9ejGJJ527NI7fbMCgru2W8X
 2SodI9W7xBOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 04:05:30 -0700
IronPort-SDR: w0MadmGGvy/1pnfpiZYhtHgNO2uTk9eJ22jVhh0llLsYmnG3SszoGWen1fZolnLOyPoB5Fax5h
 /xGYI7hWa9Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="251628387"
Received: from apogrebi-mobl2.ger.corp.intel.com ([10.249.39.119])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2020 04:05:27 -0700
Message-ID: <8bde92d77e32e85b66017c4b9d72008067c16bd9.camel@linux.intel.com>
Subject: Re: [PATCH RESEND] tpm: eventlog: Replace zero-length array with
 flexible-array member
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Thu, 14 May 2020 14:05:27 +0300
In-Reply-To: <20200513231416.GQ4897@embeddedor>
References: <20200507040912.GA31382@embeddedor>
         <20200513213905.GB31974@linux.intel.com> <20200513231416.GQ4897@embeddedor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-13 at 18:14 -0500, Gustavo A. R. Silva wrote:
> On Thu, May 14, 2020 at 12:39:05AM +0300, Jarkko Sakkinen wrote:
> > > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > > [2] https://github.com/KSPP/linux/issues/21
> > > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > > [4] https://github.com/KSPP/linux/issues/43
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> 
> Hi Jarkko,
> 
> Thanks for your RB.
> 
> There is a v2 of this patch:
> 
> https://lore.kernel.org/lkml/20200508163826.GA768@embeddedor/
> 
> Thanks
> --
> Gustavo

Yup,

http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/47c18d91f4adb2ca164c8dbee861543b4466167d

Does this look correct?


/Jarkko

