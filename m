Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520BDB55F6
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 21:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfIQTKb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 15:10:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:23673 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfIQTKb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 15:10:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 12:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="386644742"
Received: from vcazacux-wtg.ger.corp.intel.com (HELO localhost) ([10.252.38.72])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2019 12:10:27 -0700
Date:   Tue, 17 Sep 2019 22:10:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vanya Lazeev <ivan.lazeev@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20190917190950.GG10244@linux.intel.com>
References: <20190914171743.22786-1-ivan.lazeev@gmail.com>
 <20190916055130.GA7925@linux.intel.com>
 <20190916200029.GA27567@hv-1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916200029.GA27567@hv-1.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 16, 2019 at 11:00:30PM +0300, Vanya Lazeev wrote:
> On Mon, Sep 16, 2019 at 08:51:30AM +0300, Jarkko Sakkinen wrote:
> > On Sat, Sep 14, 2019 at 08:17:44PM +0300, ivan.lazeev@gmail.com wrote:
> > > +	struct list_head acpi_resources, crb_resources;
> > 
> > Please do not create crb_resources. I said this already last time.
> 
> But then, if I'm not mistaken, it will be impossible to track pointers
> to multiple remaped regions. In this particular case, it
> doesn't matter, because both buffers are in different ACPI regions,
> and using acpi_resources only to fix buffer will be enough.
> However, this creates incosistency between single- and
> multiple-region cases: in the latter iobase field of struct crb_priv
> doesn't make any difference. Am I understanding the situation correctly?
> Will such fix be ok?

So why you need to track pointers other than in initialization as devm
will take care of freeing them. Just trying to understand the problem.

/Jarkko
