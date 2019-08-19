Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D794B6C
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfHSROc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 13:14:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:13280 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfHSROc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 13:14:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="179474448"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by fmsmga007.fm.intel.com with ESMTP; 19 Aug 2019 09:56:29 -0700
Date:   Mon, 19 Aug 2019 19:56:29 +0300
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
Subject: Re: [RFC/RFT v4 1/5] tpm: move tpm_buf code to include/linux/
Message-ID: <20190819165629.qv7cmg6kiwb6oxig@linux.intel.com>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565682784-10234-2-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 13, 2019 at 01:23:00PM +0530, Sumit Garg wrote:
> Move tpm_buf code to common include/linux/tpm.h header so that it can
> be reused via other subsystems like trusted keys etc.
> 
> Also rename trusted keys TPM 1.x buffer implementation to tpm1_buf to
> avoid any compilation errors.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

A question: did you try to do this as mechanically as you ever could
or did you do any other code changes? I did go through it but it is
possible that I missed something.

In this type of changes it is mandatory be extra strict on not doing
anything extra (the rename you would was not of course extra because
it was necessary to do).

/Jarkko
