Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A991E9E9
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEOIOv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 May 2019 04:14:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:42327 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOIOv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 May 2019 04:14:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 01:14:50 -0700
X-ExtLoop1: 1
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2019 01:14:46 -0700
Date:   Wed, 15 May 2019 11:14:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v3 2/2] ftpm: add documentation for ftpm driver
Message-ID: <20190515081455.GB7708@linux.intel.com>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190415155636.32748-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415155636.32748-3-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 15, 2019 at 11:56:36AM -0400, Sasha Levin wrote:
> This patch adds basic documentation to describe the new fTPM driver.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
> ---
>  Documentation/security/tpm/index.rst        |  1 +
>  Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
> 
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
> index af77a7bbb070..15783668644f 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -4,4 +4,5 @@ Trusted Platform Module documentation
>  
>  .. toctree::
>  
> +   tpm_ftpm_tee
>     tpm_vtpm_proxy
> diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
> new file mode 100644
> index 000000000000..29c2f8b5ed10
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
> +
> +This document describes the firmware Trusted Platform Module (fTPM)
> +device driver.
> +
> +Introduction
> +============
> +
> +This driver is a shim for a firmware implemented in ARM's TrustZone
> +environment. The driver allows programs to interact with the TPM in the same
> +way the would interact with a hardware TPM.
> +
> +Design
> +======
> +
> +The driver acts as a thin layer that passes commands to and from a TPM
> +implemented in firmware. The driver itself doesn't contain much logic and is
> +used more like a dumb pipe between firmware and kernel/userspace.
> +
> +The firmware itself is based on the following paper:
> +https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
> +
> +When the driver is loaded it will expose ``/dev/tpmX`` character devices to
> +userspace which will enable userspace to communicate with the firmware tpm
> +through this device.
> -- 
> 2.19.1
> 

Actually this would a better place at least with some words to describe
what is TEE. I'm, for example, confused whether there is only single TEE
in existence always used with TZ or is this some MS specific TEE.

Otherwise, looks legit.

/Jarkko
