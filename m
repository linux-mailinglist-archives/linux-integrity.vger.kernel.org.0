Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22657140633
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2020 10:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAQJgP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jan 2020 04:36:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:4096 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgAQJgO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jan 2020 04:36:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 01:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,329,1574150400"; 
   d="scan'208";a="218852465"
Received: from jsakkine-mobl1.fi.intel.com ([10.237.66.138])
  by orsmga008.jf.intel.com with ESMTP; 17 Jan 2020 01:27:10 -0800
Message-ID: <814543e26623f13481254d63cceb673a3b40531a.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Update mailing list contact information in
 sysfs-class-tpm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Fri, 17 Jan 2020 11:27:09 +0200
In-Reply-To: <20200113142319.r2gfnmw254owobue@cantor>
References: <20191025193628.31004-1-jsnitsel@redhat.com>
         <20191028205338.GI8279@linux.intel.com>
         <20200113142319.r2gfnmw254owobue@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-13 at 07:23 -0700, Jerry Snitselaar wrote:
> On Mon Oct 28 19, Jarkko Sakkinen wrote:
> > On Fri, Oct 25, 2019 at 12:36:28PM -0700, Jerry Snitselaar wrote:
> > > All of the entries in Documentation/ABI/stable/sysfs-class-tpm
> > > point to the old tpmdd-devel mailing list. This patch
> > > updates the entries to point to linux-intergrity.
> > > 
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: linux-integrity@vger.kernel.org
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > /Jarkko
> 
> Hi Jarkko,
> 
> Should we put this into 5.6 as well?

Yes.

Thanks, I'll create a PR over the weekend.

/Jarkko

