Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED37BBE07C
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2019 16:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438142AbfIYOre (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Sep 2019 10:47:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:61498 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437125AbfIYOre (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Sep 2019 10:47:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 07:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="191360102"
Received: from kmakows-mobl.ger.corp.intel.com (HELO localhost) ([10.249.39.225])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2019 07:47:30 -0700
Date:   Wed, 25 Sep 2019 17:47:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent future
 TPM operations
Message-ID: <20190925144729.GB23867@linux.intel.com>
References: <20190925101532.31280-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925101532.31280-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 25, 2019 at 01:15:29PM +0300, Jarkko Sakkinen wrote:
> commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
> 
> This backport is for v4.14 and v4.19 The backport requires non-racy
> behaviour from TPM 1.x sysfs code. Thus, the dependecies for that
> are included.
> 
> NOTE: 1/3 is only needed for v4.14.
> 
> Cc: linux-integrity@vger.kernel.org
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Vadim Sukhomlinov <sukhomlinov@google.com>
> Link: https://lore.kernel.org/stable/20190712152734.GA13940@kroah.com/

Resend by mistake.

/Jarkko
