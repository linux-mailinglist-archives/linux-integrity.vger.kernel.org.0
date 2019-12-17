Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BAE1221D0
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 03:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfLQCGo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 21:06:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:51523 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLQCGo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 21:06:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 18:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="205315700"
Received: from chauvina-mobl1.ger.corp.intel.com ([10.251.85.48])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2019 18:06:41 -0800
Message-ID: <67dd5c51becbe4500f5db297d5845c9c3c5db285.camel@linux.intel.com>
Subject: Re: [PATCH URGENT FIX] security: keys: trusted: fix lost handle
 flush
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <1576173515.15886.7.camel@HansenPartnership.com>
References: <1576173515.15886.7.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 17 Dec 2019 04:05:25 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 12:58 -0500, James Bottomley wrote:
> The original code, before it was moved into security/keys/trusted-keys
> had a flush after the blob unseal.  Without that flush, the volatile
> handles increase in the TPM until it becomes unusable and the system
> either has to be rebooted or the TPM volatile area manually flushed. 
> Fix by adding back the lost flush, which we now have to export because
> of the relocation of the trusted key code may cause the consumer to be
> modular.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: 2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Will collect to my rc3 PR, thank you.

/Jarkko

