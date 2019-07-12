Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42C16727D
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGLPea (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 11:34:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:47700 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfGLPea (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 11:34:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 08:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; 
   d="scan'208";a="174477892"
Received: from yanbeibe-mobl2.ger.corp.intel.com ([10.249.32.118])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2019 08:34:25 -0700
Message-ID: <730715760b20d9a76aa93c3ebc39a62045c9ee34.camel@linux.intel.com>
Subject: Re: [PATCH] fTPM: fix PTR_ERR() usage
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 18:34:24 +0300
In-Reply-To: <20190712114951.912328-1-arnd@arndb.de>
References: <20190712114951.912328-1-arnd@arndb.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-12 at 13:49 +0200, Arnd Bergmann wrote:
> A last minute change must have confused PTR_ERR() and ERR_PTR():
> 
> drivers/char/tpm/tpm_ftpm_tee.c:236:15: error: incompatible pointer to integer
> conversion passing 'struct tee_context *' to parameter of type 'long' [-
> Werror,-Wint-conversion]
>                 if (ERR_PTR(pvt_data->ctx) == -ENOENT)
> drivers/char/tpm/tpm_ftpm_tee.c:239:18: error: incompatible pointer to integer
> conversion passing 'struct tee_context *' to parameter of type 'long' [-
> Werror,-Wint-conversion]
>                 return ERR_PTR(pvt_data->ctx);
> 
> Fixes: c975c3911cc2 ("fTPM: firmware TPM running in TEE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Arnd, thanks.

I squashed this to the associated commit.

I also fine-tuned the commit messages a bit (tag, imperative form).

Started also wondering tha tpm_ftpm_tee is a too generic name given that
this is for ARM TZ only. Would it make sense to rename it as something
like tpm_ftpm_tee_arm? Other proposals are welcome. Just made something
up.


/Jarkko

