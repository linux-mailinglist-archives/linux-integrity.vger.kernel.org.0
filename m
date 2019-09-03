Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346C2A6D51
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfICPx0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 11:53:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:25926 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbfICPx0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 11:53:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 08:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="182169421"
Received: from vkuppusa-mobl2.ger.corp.intel.com ([10.252.39.67])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2019 08:53:23 -0700
Message-ID: <3e7265a4f11ca0f822633cf961466253e3661373.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/3] tpm: provide a way to override the chip returned
 durations
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue, 03 Sep 2019 18:53:18 +0300
In-Reply-To: <20190902142735.6280-3-jsnitsel@redhat.com>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
         <20190902142735.6280-3-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-09-02 at 07:27 -0700, Jerry Snitselaar wrote:
> Patch adds method ->update_durations to override returned
> durations in case TPM chip misbehaves for TPM 1.2 drivers.
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> (!update_durations path)

/Jarkko

