Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9685611764F
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLITvx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 14:51:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:31913 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfLITvx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 14:51:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 11:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="215200585"
Received: from nshalmon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.8.146])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2019 11:51:46 -0800
Date:   Mon, 9 Dec 2019 21:51:44 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v4 1/1] tpm/tpm_ftpm_tee: add shutdown call back
Message-ID: <20191209195144.GF19243@linux.intel.com>
References: <20191204154038.2276810-1-pasha.tatashin@soleen.com>
 <20191204154038.2276810-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204154038.2276810-2-pasha.tatashin@soleen.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 04, 2019 at 10:40:38AM -0500, Pavel Tatashin wrote:
> Add shutdown call back to close existing session with fTPM TA
> to support kexec scenario.
> 
> Add parentheses to function names in comments as specified in kdoc.
> 
> Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Sasha Levin <sashal@kernel.org>

LGTM, can apply the patch soon'ish.

/Jarkko
