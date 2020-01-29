Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7B14CB59
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2020 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2NXh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jan 2020 08:23:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:50808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgA2NXh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jan 2020 08:23:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 05:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="222450020"
Received: from ckelly-mobl.ger.corp.intel.com ([10.252.25.54])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2020 05:23:34 -0800
Message-ID: <2377039f3fd8cd1eb3ff12616cb4f82afdf4a632.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] tpm1_bios_measurements_next should increase
 position index
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>, linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Wed, 29 Jan 2020 15:23:33 +0200
In-Reply-To: <3b24cec6-efb9-8dd4-fa1e-19e04798b067@virtuozzo.com>
References: <3b24cec6-efb9-8dd4-fa1e-19e04798b067@virtuozzo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-23 at 10:48 +0300, Vasily Averin wrote:
> if seq_file .next fuction does not change position index,
> read after non-zero llseek can generate unexpected output.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

* Should be "tpm: tpm1_bios_measurements_next should increase position index"
* Sentences in English start with a capital letter.
* Should probably have Fixes tag.
* Shoud have "Cc: stable@vger.kernel.org" tag.

Same remarks for TPM2 patch.

/Jarkko

