Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E11FC073
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgFPU4e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:56:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:17159 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbgFPU4c (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:56:32 -0400
IronPort-SDR: q/+IbCPKVdoLd+BWN6Lw2qhL8NsleWXCoF9JmSYOvgMol1wmT5eJodFfLj6Eof2wjxkA4FI3a4
 Q/255c8OOo+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:56:31 -0700
IronPort-SDR: zf4Y53dBEKcPjx6uKdVxaG8UVZm5RahWwZ6yADqa/Q4ka8CvTaxT+4y+0lBWaj5BR7QPTya7p2
 WV/0A01nxZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="277051782"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 13:56:26 -0700
Date:   Tue, 16 Jun 2020 23:56:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCHv8 2/3] optee: enable support for multi-stage bus
 enumeration
Message-ID: <20200616205624.GE20943@linux.intel.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <20200604175851.758-3-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604175851.758-3-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 08:58:50PM +0300, Maxim Uvarov wrote:
> Some drivers (like ftpm) can operate only after tee-supplicant
> runs because of tee-supplicant provides things like storage
> services (rpmb, shm).  This patch splits probe of non tee-supplicant
> dependable drivers to the early stage, and after tee-supplicant run
> probe other drivers.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Looks good to me but Jens should really go this through in detail. I'm
not the decision maker on this one.

/Jarkko
