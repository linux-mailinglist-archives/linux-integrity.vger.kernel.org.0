Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26E35EB9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfFEOJi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 10:09:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:61236 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFEOJi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 10:09:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:09:37 -0700
X-ExtLoop1: 1
Received: from araresx-wtg1.ger.corp.intel.com (HELO localhost) ([10.252.46.102])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2019 07:09:33 -0700
Date:   Wed, 5 Jun 2019 17:09:31 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190605140848.GB11331@linux.intel.com>
References: <20190530152758.16628-1-sashal@kernel.org>
 <20190530152758.16628-2-sashal@kernel.org>
 <CAFA6WYM1NrghG9qxUhrm76kopvBx9nmCL9XnRs11ysb2Yr0+Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYM1NrghG9qxUhrm76kopvBx9nmCL9XnRs11ysb2Yr0+Qw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 04, 2019 at 11:45:52AM +0530, Sumit Garg wrote:
> Is this well tested? I see this misleading error multiple times as
> follows although TEE driver works pretty well.
> 
> Module built with "CONFIG_TCG_FTPM_TEE=y"
> 
> [    1.436878] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> [    1.509471] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> [    1.517268] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> [    1.525596] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> 
> -Sumit

No testing done from my part.

/Jarkko
