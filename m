Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A551701FC
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2020 16:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBZPKN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 10:10:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:24464 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgBZPKN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 10:10:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 07:10:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="410644291"
Received: from avgorshk-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.15.208])
  by orsmga005.jf.intel.com with ESMTP; 26 Feb 2020 07:10:08 -0800
Date:   Wed, 26 Feb 2020 17:10:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH V3] tpm_tis_spi: use new 'delay' structure for SPI
 transfer delays
Message-ID: <20200226150944.GD3407@linux.intel.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
 <20191217091615.12764-1-alexandru.ardelean@analog.com>
 <9991700815c02b3227a5902e4cae1afe5200b0ff.camel@linux.intel.com>
 <b790461b49685082f843c59cd047836e13744285.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b790461b49685082f843c59cd047836e13744285.camel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 26, 2020 at 07:51:06AM +0000, Ardelean, Alexandru wrote:
> On Tue, 2019-12-17 at 14:04 +0200, Jarkko Sakkinen wrote:
> > [External]
> > 
> > On Tue, 2019-12-17 at 11:16 +0200, Alexandru Ardelean wrote:
> > > In a recent change to the SPI subsystem [1], a new 'delay' struct was added
> > > to replace the 'delay_usecs'. This change replaces the current
> > > 'delay_usecs' with 'delay' for this driver.
> > > 
> > > The 'spi_transfer_delay_exec()' function [in the SPI framework] makes sure
> > > that both 'delay_usecs' & 'delay' are used (in this order to preserve
> > > backwards compatibility).
> > > 
> > > [1] commit bebcfd272df6485 ("spi: introduce `delay` field for
> > > `spi_transfer` + spi_transfer_delay_exec()")
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> 
> ping on this patch

My bad. Sorry. It is now applied.

/Jarkko
