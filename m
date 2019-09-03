Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2C6A6D57
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfICPyy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 11:54:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:13511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICPyx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 11:54:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 08:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="184796465"
Received: from vkuppusa-mobl2.ger.corp.intel.com ([10.252.39.67])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 08:54:51 -0700
Message-ID: <dc2926f6ac1abbf785b627e6186d75eaaf2f9371.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/3] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20190902142735.6280-4-jsnitsel@redhat.com>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
         <20190902142735.6280-4-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 03 Sep 2019 18:54:41 +0300
User-Agent: Evolution 3.32.2-1 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-09-02 at 07:27 -0700, Jerry Snitselaar wrote:
> There was revealed a bug in the STM TPM chipset used in Dell R415s.
> Bug is observed so far only on chipset firmware 1.2.8.28
> (1.2 TPM, device-id 0x0, rev-id 78). After some number of
> operations chipset hangs and stays in inconsistent state:
> 
> tpm_tis 00:09: Operation Timed out
> tpm_tis 00:09: tpm_transmit: tpm_send: error -5
> 
> Durations returned by the chip are the same like on other
> firmware revisions but apparently with specifically 1.2.8.28 fw
> durations should be reset to 2 minutes to enable tpm chip work
> properly. No working way of updating firmware was found.
> 
> This patch adds implementation of ->update_durations method
> that matches only STM devices with specific firmware version.
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> (!update_durations path)

/Jarkko

