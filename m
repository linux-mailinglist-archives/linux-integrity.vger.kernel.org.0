Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6898012582E
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2019 01:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLSADM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 19:03:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:30626 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLSADM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 19:03:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 16:02:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="248076103"
Received: from jtreacy-mobl1.ger.corp.intel.com ([10.251.82.127])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2019 16:02:56 -0800
Message-ID: <17c3fc41ea6ff890c686489b9977c2d886295d6e.camel@linux.intel.com>
Subject: Re: [PATCH] tpm/ppi: replace assertion code with recovery in
 tpm_eval_dsm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191218134513.GE17227@ziepe.ca>
References: <20191215182314.32208-1-pakki001@umn.edu>
         <20191218134513.GE17227@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 19 Dec 2019 02:02:18 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-18 at 09:45 -0400, Jason Gunthorpe wrote:
> On Sun, Dec 15, 2019 at 12:23:14PM -0600, Aditya Pakki wrote:
> > In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
> > By returning NULL to the callers, instead of crashing, the error
> > can be better handled.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> >  drivers/char/tpm/tpm_ppi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > index b2dab941cb7f..4b6f6a9c0b48 100644
> > +++ b/drivers/char/tpm/tpm_ppi.c
> > @@ -42,7 +42,9 @@ static inline union acpi_object *
> >  tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
> >  	     union acpi_object *argv4, u64 rev)
> >  {
> > -	BUG_ON(!ppi_handle);
> > +	if (!ppi_handle)
> > +		return NULL;
> 
> If it can't happen the confusing if should either be omitted entirely
> or written as 
> 
> if (WARN_ON(!ppi_handle))
>        return NULL;
> 
> Leaving it as apparently operational code just creates confusion for
> the reader that now has the task to figure out why ppi_handle can be
> null.
> 
> I favour not including tests for impossible conditions. The kernel
> will crash immediately if ppi_handle is null anyhow.
> 
> Jason

Absolutely should be changed WARN_ON() as it never should happen. I'll
update the patch before sending PR to Linus since I have it already
applied.

Thanks Jason for the remark!

/Jarkko

