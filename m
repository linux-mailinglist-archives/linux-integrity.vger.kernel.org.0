Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C98D218CD5
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgGHQUX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 12:20:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:21896 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbgGHQUW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 12:20:22 -0400
IronPort-SDR: OC2kW4fLquX+oPNMLHJf/9msQBZDYEEqnWInFz4Vtsh91B42yP65AU5hJAS/h+bVU7VN3XINJC
 Y9phUg9/4qqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="209379719"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="209379719"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:20:22 -0700
IronPort-SDR: gNf7C9Z2YX16Oxep5C8FDryKYcNh04YCXz9q1EE5RqNXBD0PzTqhyFoji8C62lK+bDl3ZWfBux
 m0qh6WBLiqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="283846524"
Received: from jschirra-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.201])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2020 09:20:18 -0700
Date:   Wed, 8 Jul 2020 19:20:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3 0/2] synquacer: add TPM support
Message-ID: <20200708162017.GB549022@linux.intel.com>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708131424.18729-1-masahisa.kojima@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 08, 2020 at 10:14:22PM +0900, Masahisa Kojima wrote:
> This adds support for driving the TPM on Socionext SynQuacer platform
> using the driver for a memory mapped TIS frame.
> 
> v3:
> - prepare new module to handle TPM MMIO access on SynQuacer platform
> 
> v2:
> - don't use read/write_bytes() to implement read/write16/32 since that uses
>   the wrong address
> 
> Cc: jarkko.sakkinen@linux.intel.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: ardb@kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: peterhuewe@gmx.de
> Cc: jgg@ziepe.ca
> 
> Masahisa Kojima (2):
>   tpm: tis: add support for MMIO TPM on SynQuacer
>   dt-bindings: Add SynQucer TPM MMIO as a trivial device
> 
>  .../devicetree/bindings/trivial-devices.yaml  |   2 +
>  drivers/char/tpm/Kconfig                      |  12 ++
>  drivers/char/tpm/Makefile                     |   1 +
>  drivers/char/tpm/tpm_tis_synquacer.c          | 196 ++++++++++++++++++
>  4 files changed, 211 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
> 
> -- 
> 2.20.1
> 

Overally the code looks great. You've run it through checkpatch.pl?

/Jarkko
