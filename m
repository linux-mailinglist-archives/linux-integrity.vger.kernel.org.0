Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6E94B0B
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHSQ54 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 12:57:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:17569 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSQ54 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 12:57:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="179474734"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by fmsmga007.fm.intel.com with ESMTP; 19 Aug 2019 09:57:50 -0700
Date:   Mon, 19 Aug 2019 19:57:50 +0300
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
Subject: Re: [RFC/RFT v4 2/5] KEYS: trusted: use common tpm_buf for TPM1.x
 code
Message-ID: <20190819165750.h4zlqtjubwm7tohg@linux.intel.com>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565682784-10234-3-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 13, 2019 at 01:23:01PM +0530, Sumit Garg wrote:
> Utilize common heap based tpm_buf code for TPM1.x trusted keys rather
> than using stack based tpm1_buf code. Also, remove tpm1_buf code.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
