Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F631E9B75
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgFABt0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 May 2020 21:49:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:22829 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgFABtZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 May 2020 21:49:25 -0400
IronPort-SDR: lsQJJOy3ppvsoqvD5BofmiCpxG0SMtEAMPdcha2THraE5PywnF4qoLDYdySIt2nNjw36h+zuGP
 zkpRcs8q2LbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 18:49:25 -0700
IronPort-SDR: G8TWX6iXdk/4d+4f6VPft/oWdfQBV0QSMk+kBKcQHqpg6fRWrCSlUzD+KGZnENP5t0hqDMSNsx
 9q6O5DzR2ahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="293016889"
Received: from dytagah-mobl.amr.corp.intel.com (HELO localhost) ([10.252.58.236])
  by fmsmga004.fm.intel.com with ESMTP; 31 May 2020 18:49:23 -0700
Date:   Mon, 1 Jun 2020 04:49:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCHv5 1/3] optee: do drivers initialization before and after
 tee-supplicant run
Message-ID: <20200601014901.GB794847@linux.intel.com>
References: <20200529082701.13457-1-maxim.uvarov@linaro.org>
 <20200529082701.13457-2-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529082701.13457-2-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 29, 2020 at 11:26:59AM +0300, Maxim Uvarov wrote:
> Some drivers (like ftpm) can operate only after tee-supplicant
> runs because of tee-supplicant provides things like storage
> services.  This patch splits probe of non tee-supplicant dependable
> drivers to the early stage, and after tee-supplicant run probe other
> drivers.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>

$ scripts/get_maintainer.pl drivers/tee 
Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE SUBSYSTEM)
tee-dev@lists.linaro.org (open list:TEE SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

tee-dev is missing. Please resend.

/Jarkko
