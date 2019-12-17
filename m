Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA1122190
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 02:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfLQBcm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 20:32:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:30587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLQBcm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 20:32:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="415282581"
Received: from chauvina-mobl1.ger.corp.intel.com ([10.251.85.48])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2019 17:32:37 -0800
Message-ID: <a7595cde0003f5799977353d2436e621928d0723.camel@linux.intel.com>
Subject: Re: [PATCH =v2 1/3] tpm: fix invalid locking in NONBLOCKING mode
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        mingo@redhat.com, jeffrin@rajagiritech.edu.in,
        linux-integrity@vger.kernel.org, will@kernel.org, peterhuewe@gmx.de
In-Reply-To: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 17 Dec 2019 03:32:33 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 09:48 -0800, Tadeusz Struk wrote:
> When an application sends TPM commands in NONBLOCKING mode
> the driver holds chip->tpm_mutex returning from write(),
> which triggers: "WARNING: lock held when returning to user space".
> To fix this issue the driver needs to release the mutex before
> returning and acquire it again in tpm_dev_async_work() before
> sending the command.

This is way better, thank you. I'll put this to my rc3 PR.

> 
> Cc: stable@vger.kernel.org
> Fixes: 9e1b74a63f776 (tpm: add support for nonblocking operation)
> Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

