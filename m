Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295B21FC046
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgFPUyY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:54:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:56944 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgFPUyX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:54:23 -0400
IronPort-SDR: uQW3NjMtTcEXpgU3ckazJ5bW1bnVmAQM85H+h8DjFYReFDAGgf+eYOCXGYRbw32zYcJxPZw5Co
 jyuAImuQY2Tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:54:22 -0700
IronPort-SDR: u937yhbBGU1fwPmrcamDGL0ED3Cdx5A9CcOhhryeXG+51Sr41aKXrbJd9S5OXnNU2KZOyICzwb
 f+VTLXxXpcZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="277051194"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 13:54:17 -0700
Date:   Tue, 16 Jun 2020 23:54:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>, jens.wiklander@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200616205415.GD20943@linux.intel.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
 <20200616204906.GB20943@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616204906.GB20943@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 11:49:13PM +0300, Jarkko Sakkinen wrote:
> On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> > ping.
> > Patchset was reviewed and all comments are codeverd. Optee-os patches
> > were merged. These kernel patches look like they are hanging
> > somewhere...
> > 
> > Thanks,
> > Maxim.
> 
> I'm checking them atm.

I'm a bit confused about the optee patches:

» scripts/get_maintainer.pl drivers/tee/
Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE SUBSYSTEM)
tee-dev@lists.linaro.org (open list:TEE SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Before I can pick the two optee patches they both need ack/reviewed-by
from Jens and also ack from him for me picking them, instead of him.

/Jarkko
