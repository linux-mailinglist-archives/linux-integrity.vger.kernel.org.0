Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A26E26A555
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Sep 2020 14:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgIOMel (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Sep 2020 08:34:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:5116 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgIOLpG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Sep 2020 07:45:06 -0400
IronPort-SDR: I3o8WKmWj2oB7LW7um3Men8+BQkh3J9+XjpiM8sneSe77YJYXQCWrDhYMJnHsmjnxdJ/mqYe0a
 rILBm8ZZ9Bkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223423963"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="223423963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 04:44:25 -0700
IronPort-SDR: wGxaFMMhXE7aN+G/jV8BWpSD5EaqGZQXV79bkvIPvy2HCsvufc1TYkTTmeAwlpYL8sTH3YWaX9
 iv+Lxw2m0QGQ==
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="482740278"
Received: from sgwillia-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.40.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 04:44:24 -0700
Date:   Tue, 15 Sep 2020 14:44:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org
Subject: Re: I'm getting panic()s in tpm2_bios_measurements_start()- but
 don't know why
Message-ID: <20200915114411.GA898845@linux.intel.com>
References: <alpine.DEB.2.23.453.2009121522400.7398@xps-7390>
 <20200914173548.GA8011@linux.intel.com>
 <alpine.DEB.2.23.453.2009141042540.4716@xps-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2009141042540.4716@xps-7390>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 14, 2020 at 10:45:33AM -0700, Kenneth R. Crudup wrote:
> 
> On Mon, 14 Sep 2020, Jarkko Sakkinen wrote:
> 
> > What about stack trace?
> 
> It was attached to my original E-mail. But there was nothing special about it,
> the _start is just the standard .start call from "struct seq_operations" so
> that's where the read ends up.
> 
> > Also, are you able to bisect this?
> 
> I'd done a checkout of the commit that introduced this routine, it appears
> to be this way from the start.
> 
> 	-Kenny
> 
> -- 
> Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA

OK, thanks for the recap.

/Jarkko
