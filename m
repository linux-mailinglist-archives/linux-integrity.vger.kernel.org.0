Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F0CB1A2
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfJCWFa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 18:05:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:41466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfJCWFa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 15:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="191396927"
Received: from okiselev-mobl1.ccr.corp.intel.com (HELO localhost) ([10.251.93.117])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2019 15:05:23 -0700
Date:   Fri, 4 Oct 2019 01:05:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191003220522.GC30511@linux.intel.com>
References: <20191002201212.32395-1-ivan.lazeev@gmail.com>
 <20191003120302.GB10038@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003120302.GB10038@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 03:03:02PM +0300, Jarkko Sakkinen wrote:
> You could get away without iores_range by having an extra
> terminator entry in the iores_array.
> 
> Overally this starts to look good.

I'd also advice you to memset it with zeros so that you don't need to
have a variable for number of entries.

/Jarkko
