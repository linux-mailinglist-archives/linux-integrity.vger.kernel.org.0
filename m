Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B08DB23E
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Oct 2019 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfJQQXC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Oct 2019 12:23:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:18968 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731834AbfJQQXC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Oct 2019 12:23:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 09:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="279931044"
Received: from eshoguli-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.19.56])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2019 09:22:53 -0700
Date:   Thu, 17 Oct 2019 19:22:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v3] tpm/tpm_ftpm_tee: add shutdown call back
Message-ID: <20191017162251.GB6667@linux.intel.com>
References: <20191016163114.985542-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016163114.985542-1-pasha.tatashin@soleen.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 16, 2019 at 12:31:14PM -0400, Pavel Tatashin wrote:
> Add shutdown call back to close existing session with fTPM TA
> to support kexec scenario.
> 
> Add parentheses to function names in comments as specified in kdoc.
> 
> Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

LGTM

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I have no means to test this though. It still needs a tested-by.

/Jarkko
