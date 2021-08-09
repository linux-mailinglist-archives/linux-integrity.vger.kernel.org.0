Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27343E3F24
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 06:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhHIEzw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 00:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhHIEzv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 00:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B3C360FF2;
        Mon,  9 Aug 2021 04:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628484931;
        bh=Xhq31Aj6JwOeLN6Kq+2I1x9CB4ydFudhm88N++LwBg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lABV//HLnmoHidSLNYscM6Asks1mfMOMQce4eq1V4ZcZO8lHWJb26tczrIUudxUBN
         oU9aK87d7nuzaamYxAGJ/PnPUx/PwwtlbB4nCeZHYN3lT0G/9A1By4S8yuTipXRvm0
         ttwLrqpkOMFdBgnaqGkd9t5KxmQxw7HnJwpc065ULVKllzny/32BkP2OS3SAeGbVVO
         2ZgOZt5vbpyAbSJJ1D7rS7qdHJcKNlxpX1i/f2Lw76dfeFnBvfN9EfjIneAOuIUaZE
         gmYYwCXa9u6RwNY2ofDElR29x0wARZ34Iy8do/wG3J6aSpDUB4P5obSwfVaxuZNB3u
         ExBO10A7ZZXig==
Date:   Mon, 9 Aug 2021 07:55:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys Movchan <borysmn@axis.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Message-ID: <20210809045529.wz54przgpqgjs67q@kernel.org>
References: <20210806141808.6537-1-borysmn@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806141808.6537-1-borysmn@axis.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 06, 2021 at 04:18:08PM +0200, Borys Movchan wrote:
> If something went wrong during the TPM firmware upgrade, like power
> failure or the firmware image file get corrupted, the TPM might end
> up in Upgrade or Failure mode upon the next start. The state is
> persistent between the TPM power cycle/restart.
> 
> According to TPM specification:
>  * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
>    to all commands except Field Upgrade related ones.
>  * If the TPM is in Failure mode, it will allow performing TPM
>    initialization but will not provide any crypto operations.
>    Will happily respond to Field Upgrade calls.
> 
> Change the behavior of the tpm2_auto_startup(), so it detects the active
> running mode of the TPM.  It is easy to determine that TPM is in Upgrade
> mode by relying on the fact that tpm2_do_selftest() will return
> TPM2_RC_UPGRADE. In such a case, there is no point to finish the
> start-up procedure as the TPM will not accept any commands, except
> firmware upgrade related.
> 
> On the other hand, if the TPM is in Failure mode, it will successfully
> respond to both tpm2_do_selftest() and tpm2_startup() calls. Although,
> will fail to answer to tpm2_get_cc_attrs_tbl(). Use this fact to
> conclude that TPM is in Failure mode.
> 
> If the chip is in the Upgrade or Failure mode, the function returns -EIO
> error code.
> 
> The return value is checked in the tpm_chip_register() call to determine
> the state of the TPM. If the TPM is not in normal operation mode, set
> the `limited_mode` flag. If the flag is set then the TPM is not able to

Nit: do not use hyphens for limited mode. 'limited_mode' is fine. I'm
also fine with just limited_mode.

> provide any crypto functionality.  Correspondignly, the calls to
> tpm2_get_cc_attrs_tbl(), tpm_add_hwrng() and tpm_get_pcr_allocation()
> will fail. Use the flag to exclude them from the initialization
> sequence.

This is blacklisting. E.g. I'm not sure why all of the sysfs attributes
would still be exported. Some of them use TPM commands. That was just
one random example I came up with.

It's easy to come up other examples, like, why you provide still tpmrm0,
which is dependent on a TPM running normal mode?

This misses completely the rationale for ever acking this change: which
parts of the uapi are export and *why*.

Please whitelist the things that should still work. Even the obvious
ones like /dev/tpm0 (because of TPM_RC_UPGRADE).

This is clearly a faulty and incomplete patch in its current form.

/Jarkko
