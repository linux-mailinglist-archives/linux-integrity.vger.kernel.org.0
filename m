Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593171467EC
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 13:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAWM1Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jan 2020 07:27:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:60058 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWM1Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jan 2020 07:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 04:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="220651571"
Received: from wkalinsk-mobl.ger.corp.intel.com ([10.252.23.16])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2020 04:27:20 -0800
Message-ID: <ada03416b1b362fa255feb45257414655d8ab023.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Date:   Thu, 23 Jan 2020 14:27:19 +0200
In-Reply-To: <20200114141647.109347-3-ardb@kernel.org>
References: <20200114141647.109347-1-ardb@kernel.org>
         <20200114141647.109347-3-ardb@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-14 at 15:16 +0100, Ard Biesheuvel wrote:
> When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> window that is backed by the SPI command sequencer in the SPI bus
> controller. This arrangement has the limitation that only byte size
> accesses are supported, and so we'll need to provide a separate set
> of read and write accessors that take this into account.

What is SynQuacer platform?

I'm also missing a resolution why tpm_tis.c is extended to handle both
and not add tpm_tis_something.c instead. It does not follow the pattern
we have in place (e.g. look up tpm_tis_spi.c).

/Jarkko

