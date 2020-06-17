Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74F21FD94F
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 01:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQXAB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 19:00:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:64561 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQXAB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 19:00:01 -0400
IronPort-SDR: dbVe1X9CKanCll5QFYzKAFokS7x4maukl1hSco/PKYJQuSHB4UXWTyPV1RuE/K+btEB4XLnWLO
 KiK0/3plSfkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:00:00 -0700
IronPort-SDR: CVlOQDTs4fFwuz81BDxT0UdqNTs9GBB0jBFLZyV3CEYCZ4YSjnFiPVhE1N7tpDR+DPTOvNf7n1
 W+9nf+1dkoWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="309636101"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2020 15:59:57 -0700
Date:   Thu, 18 Jun 2020 01:59:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Binbin Zhou <zhoubinbin@uniontech.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        christophe.ricard@gmail.com, zhoubb.aaron@gmail.com
Subject: Re: [PATCH v2] tpm/st33zp24: fix spelling mistake "drescription" ->
 "description"
Message-ID: <20200617225956.GB62794@linux.intel.com>
References: <20200617010038.32493-1-zhoubinbin@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617010038.32493-1-zhoubinbin@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 17, 2020 at 09:00:38AM +0800, Binbin Zhou wrote:
> Trivial fix, the spelling of "drescription" is incorrect
> in function comment.
> 
> Fix this.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@uniontech.com>

Thanks queued.

/Jarkko
