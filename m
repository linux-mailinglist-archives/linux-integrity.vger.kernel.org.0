Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DD574EE
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 01:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFZXeA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 19:34:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:40775 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfFZXd7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 19:33:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 16:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="188839403"
Received: from mwsinger-mobl3.ger.corp.intel.com ([10.252.48.211])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2019 16:33:55 -0700
Message-ID: <4bb41de0cd2b0bf89a20dd55576acf15594ae8de.camel@linux.intel.com>
Subject: Re: [PATCH v7 2/2] fTPM: add documentation for ftpm driver
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org
Date:   Thu, 27 Jun 2019 02:34:06 +0300
In-Reply-To: <20190625201341.15865-3-sashal@kernel.org>
References: <20190625201341.15865-1-sashal@kernel.org>
         <20190625201341.15865-3-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-25 at 16:13 -0400, Sasha Levin wrote:
> This patch adds basic documentation to describe the new fTPM driver.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/security/tpm/index.rst        |  1 +
>  Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
> 
> diff --git a/Documentation/security/tpm/index.rst
> b/Documentation/security/tpm/index.rst
> index af77a7bbb070..15783668644f 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -4,4 +4,5 @@ Trusted Platform Module documentation
>  
>  .. toctree::
>  
> +   tpm_ftpm_tee
>     tpm_vtpm_proxy
> diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst
> b/Documentation/security/tpm/tpm_ftpm_tee.rst
> new file mode 100644
> index 000000000000..48de0dcec0f6
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
> @@ -0,0 +1,31 @@
> +=============================================
> +Firmware TPM Driver
> +=============================================
> +
> +| Authors:
> +| Thirupathaiah Annapureddy <thiruan@microsoft.com>
> +| Sasha Levin <sashal@kernel.org>

The way I see it this thing should not exist here at all but the
first patch should have co-developed-by in addition to
signed-off-by from you. Otherwise looks good. The list of authors
is againt something that Git does better than humans.

/Jarkko

