Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8966185364
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2019 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfHGTDu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Aug 2019 15:03:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:12147 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbfHGTDu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Aug 2019 15:03:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 12:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="177059674"
Received: from geyerral-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.37.199])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2019 12:03:44 -0700
Date:   Wed, 7 Aug 2019 22:03:44 +0300
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
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-ID: <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> Move TPM2 trusted keys code to trusted keys subsystem.

Missing a long description. The reason is that it is better consolidate
all trusted keys code to a single location so that it can be maintained
sanely and it should be stated here.

> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I would suggest adding at least two commits before this:

- A commit that just exports tpm_buf stuff and TPM2 constants to
  include/linux
- A commit that just changes the existing TPM 1.x trusted keys
  code to use tpm_buf.

These should be before the current 1/3 commit.

/Jarkko
