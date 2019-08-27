Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E3B9E9EA
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfH0NsP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 09:48:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:16441 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0NsP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 09:48:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 06:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="380922218"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.169])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2019 06:48:09 -0700
Date:   Tue, 27 Aug 2019 16:48:08 +0300
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
Subject: Re: [PATCH v5 1/4] tpm: move tpm_buf code to include/linux/
Message-ID: <20190827134808.4mtnzugshylnqwss@linux.intel.com>
References: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
 <1566392345-15419-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566392345-15419-2-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 21, 2019 at 06:29:02PM +0530, Sumit Garg wrote:
> Move tpm_buf code to common include/linux/tpm.h header so that it can
> be reused via other subsystems like trusted keys etc.
> 
> Also rename trusted keys TPM 1.x buffer implementation to tpm1_buf to
> avoid any compilation errors.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
