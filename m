Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7461D2DDB
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgENLH2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:07:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:33839 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgENLH0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:07:26 -0400
IronPort-SDR: Jn+Qcb0X3Q/1ebRGg7liqHw2AnvY912DDkF9jWdP7dQ21sLaBOXb0oev/OR+A8wHQSjEsrvhed
 zNImoKGvn5Bg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 04:07:26 -0700
IronPort-SDR: NNCwADVFQUcxBZLYUpG1hJFAxTF4QOgOG6KDFKEPf1V+kiewRZEem1y8SdAF1MykMCnXbE5w8z
 hJ4U+aL2f5vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="251628792"
Received: from apogrebi-mobl2.ger.corp.intel.com ([10.249.39.119])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2020 04:07:21 -0700
Message-ID: <f202ab902acd527a0ab4b1fec9abeef892706cb6.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm: eventlog: Replace zero-length array with
 flexible-array member
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 May 2020 14:07:21 +0300
In-Reply-To: <20200514002339.GR4897@embeddedor>
References: <20200508163826.GA768@embeddedor>
         <202005112224.9EFD07F5@keescook>
         <2a77f3bc9e7ed88343bbd206eaf25f10a697de90.camel@linux.intel.com>
         <20200514002339.GR4897@embeddedor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-13 at 19:23 -0500, Gustavo A. R. Silva wrote:
> On Thu, May 14, 2020 at 03:08:58AM +0300, Jarkko Sakkinen wrote:
> > > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Thank you.
> > 
> > I applied this patch, will include it to the next PR.
> > 
> 
> Awesome. :)

NP, sorry for the latencies! 

Right now SGX is very near getting pulled. That might cause some
*temporary* latencies in my review queue during the phase of this
month and maybe early next month. After that things should return
to normal.

/Jarkko

