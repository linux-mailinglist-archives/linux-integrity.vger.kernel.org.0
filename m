Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9375366066
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfGKUJH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 16:09:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:19840 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfGKUJH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 16:09:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 13:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="317784255"
Received: from mmoerth-mobl6.ger.corp.intel.com (HELO localhost) ([10.249.35.82])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2019 13:09:01 -0700
Date:   Thu, 11 Jul 2019 23:08:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190711200858.xydm3wujikufxjcw@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705204746.27543-1-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 05, 2019 at 04:47:44PM -0400, Sasha Levin wrote:
> Changes from v7:
> 
>  - Address Jarkko's comments.
> 
> Sasha Levin (2):
>   fTPM: firmware TPM running in TEE
>   fTPM: add documentation for ftpm driver
> 
>  Documentation/security/tpm/index.rst        |   1 +
>  Documentation/security/tpm/tpm_ftpm_tee.rst |  27 ++
>  drivers/char/tpm/Kconfig                    |   5 +
>  drivers/char/tpm/Makefile                   |   1 +
>  drivers/char/tpm/tpm_ftpm_tee.c             | 350 ++++++++++++++++++++
>  drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
>  6 files changed, 424 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
>  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
>  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
> 
> -- 
> 2.20.1
> 

I applied the patches now. Appreciate a lot the patience with these.
Thank you.

/Jarkko
