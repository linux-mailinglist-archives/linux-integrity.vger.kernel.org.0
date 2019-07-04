Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6775F560
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 11:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGDJUh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 05:20:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:65358 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfGDJUh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 05:20:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 02:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="158237252"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2019 02:20:31 -0700
Message-ID: <497a8afaa41cd26d3069acb5532075207512889c.camel@linux.intel.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Date:   Thu, 04 Jul 2019 12:20:30 +0300
In-Reply-To: <20190629150145.GL11506@sasha-vm>
References: <20190625201341.15865-1-sashal@kernel.org>
         <20190625201341.15865-2-sashal@kernel.org>
         <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
         <20190629150145.GL11506@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-06-29 at 11:01 -0400, Sasha Levin wrote:
> On Thu, Jun 27, 2019 at 02:31:35AM +0300, Jarkko Sakkinen wrote:
> > On Tue, 2019-06-25 at 16:13 -0400, Sasha Levin wrote:
> > > +static const uuid_t ftpm_ta_uuid =
> > > +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
> > > +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
> > > +
> > > +/**
> > > + * ftpm_tee_tpm_op_recv - retrieve fTPM response.
> > > + *
> > 
> > Should not have an empty line here.
> > 
> > > + * @chip: the tpm_chip description as specified in driver/char/tpm/tpm.h.
> > > + * @buf: the buffer to store data.
> > > + * @count: the number of bytes to read.
> 
> Jarkko, w.r.t your comment above, there is an empty line between the
> function name and variables in drivers/char/tpm, and in particular
> tpm_crb.c which you authored and I used as reference. Do you want us to
> diverge here?

There is divergence and that was the first thing I've contributed to
the TPM driver. I use this as the reference for formatting function
descriptions these days:

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

According to that the legit way to format would be:

* ftpm_tee_tpm_op_recv() - retrieve fTPM response.
* @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h.
* @buf:		the buffer to store data.
* @count:	the number of bytes to read.

Since it is both a callback to an interface defined elsewhere
and a static function and it does not document anything useful,
I would just remove this comment. I'd do it for all callbacks
that are part of tpm_call_ops.

/Jarkko

