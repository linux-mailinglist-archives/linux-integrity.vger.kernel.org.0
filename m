Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5C5CADB4
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfJCR4I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 13:56:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:37200 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJCR4I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 13:56:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 10:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="205670778"
Received: from jvalevi1-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.93.117])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2019 10:56:04 -0700
Date:   Thu, 3 Oct 2019 20:56:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: migrate pubek_show to struct tpm_buf
Message-ID: <20191003175603.GA19679@linux.intel.com>
References: <20191003112424.9036-1-jarkko.sakkinen@linux.intel.com>
 <20191003112424.9036-2-jarkko.sakkinen@linux.intel.com>
 <20191003113112.GB2447460@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003113112.GB2447460@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 01:31:12PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 03, 2019 at 02:24:22PM +0300, Jarkko Sakkinen wrote:
> > commit da379f3c1db0c9a1fd27b11d24c9894b5edc7c75 upstream
> > 
> > Migrated pubek_show to struct tpm_buf and cleaned up its implementation.
> > Previously the output parameter structure was declared but left
> > completely unused. Now it is used to refer different fields of the
> > output. We can move it to tpm-sysfs.c as it does not have any use
> > outside of that file.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/char/tpm/tpm-sysfs.c | 87 ++++++++++++++++++++----------------
> >  drivers/char/tpm/tpm.h       | 13 ------
> >  2 files changed, 48 insertions(+), 52 deletions(-)
> 
> Again, what kernel tree(s) do you want this, and the other 2 patches
> applied to?  And why?
> 
> thanks,
> 
> greg k-h

D'oh, this is the cover letter:

https://patchwork.kernel.org/cover/11172533/

Looks like somehow forgot to include cc's, which were in the first
version:

Cc: linux-integrity@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Vadim Sukhomlinov <sukhomlinov@google.com>
Link: https://lore.kernel.org/stable/20190712152734.GA13940@kroah.com/

/Jarkko
