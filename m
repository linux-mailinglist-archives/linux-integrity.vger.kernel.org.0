Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979C994B49
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfHSRH6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 13:07:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:27377 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSRH6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 13:07:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 10:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="353304889"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2019 10:07:50 -0700
Date:   Mon, 19 Aug 2019 20:07:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [RFC/RFT v4 4/5] KEYS: trusted: move tpm2 trusted keys code
Message-ID: <20190819170750.7cl7bdmtam3jras4@linux.intel.com>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565682784-10234-5-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 13, 2019 at 01:23:03PM +0530, Sumit Garg wrote:
> Move TPM2 trusted keys code to trusted keys subsystem. The reason
> being it's better to consolidate all the trusted keys code to a single
> location so that it can be maintained sanely.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/char/tpm/tpm-chip.c               |   1 +
>  drivers/char/tpm/tpm-interface.c          |  56 -----
>  drivers/char/tpm/tpm.h                    |  16 --
>  drivers/char/tpm/tpm2-cmd.c               | 308 +-----------------------
>  include/keys/trusted_tpm.h                |   7 +
>  include/linux/tpm.h                       |  56 +++--
>  security/keys/trusted-keys/Makefile       |   1 +
>  security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++

Would prefer trusted_tpm2.c.

/Jarkko
