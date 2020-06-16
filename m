Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7516D1FC03B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgFPUtO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:49:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:47138 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgFPUtO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:49:14 -0400
IronPort-SDR: ymqL3eC86ilM4nyJOkF9jkGIoP5UhiptXSF+7PxBHZxlAElQqR5SCZwQcZ3W9xxOIepm6hCshq
 WHFEFtB34MHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:49:13 -0700
IronPort-SDR: xWQRGpn93NFPe9P31leGAjkrPOMU3lAAEvT7VcVXXb1O5ZNn91csfk46e5/esxgn6oBMpeRjtU
 aj/hBzztyJRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="277049433"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 13:49:07 -0700
Date:   Tue, 16 Jun 2020 23:49:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200616204906.GB20943@linux.intel.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> ping.
> Patchset was reviewed and all comments are codeverd. Optee-os patches
> were merged. These kernel patches look like they are hanging
> somewhere...
> 
> Thanks,
> Maxim.

I'm checking them atm.

/Jarkko
