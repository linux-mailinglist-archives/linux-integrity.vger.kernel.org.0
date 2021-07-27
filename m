Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185B93D6C41
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 05:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhG0CYJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234410AbhG0CYI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:24:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 918AE60F37;
        Tue, 27 Jul 2021 03:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627355076;
        bh=NoNG3HMOoFeriKHuTX27SrspK+aiELmkIyT/xa1pg0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vr6cMg1ii8OiAHffWs0zpPUodH3YMHRGkx2JxfoPafdAVo/IrNXa1yuUeoyl0x3Fg
         DNduHObK6Digzik63bYtw831teVRZx3rCttdsO8cnyDp7aYf1OIoY4Qv4G/Y6GepCh
         ewOdixo20NCtjSDHATTw1WcCr9UfF7O+IQGcbW/wV+gU2A7UgI0EC3wiXAjO34J2Tk
         6rEGdDScF+037Oz9NpQqKVfzfr9DtKhxiiioDrXhb5zAUuJzVt8oydQsHFB2Aifu6a
         bgS7ILG+ALeHx0lgP1aMEKkBKpYC4SH5DyVIsJAHCC98Prx6oeDKva910y8rzj3Wk9
         hxpYtDrwyyMKw==
Date:   Tue, 27 Jul 2021 06:04:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        Andreas Rammhold <andreas@rammhold.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: fix use as module when CONFIG_TCG_TPM=m
Message-ID: <20210727030433.3dwod2elwtdkhwsc@kernel.org>
References: <20210721160258.7024-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721160258.7024-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 21, 2021 at 06:02:59PM +0200, Ahmad Fatoum wrote:
> Since commit 5d0682be3189 ("KEYS: trusted: Add generic trusted keys
> framework"), trusted.ko built with CONFIG_TCG_TPM=CONFIG_TRUSTED_KEYS=m
> will not register the TPM trusted key type at runtime.
> 
> This is because, after that rework, CONFIG_DEPENDENCY of the TPM
> and TEE backends were checked with #ifdef, but that's only true
> when they're built-in.
> 
> Fix this by introducing two new boolean Kconfig symbols:
> TRUSTED_KEYS_TPM and TRUSTED_KEYS_TEE with the appropriate
> dependencies and use them to check which backends are available.
> 
> This also has a positive effect on user experience:
> 
>  - It's now possible to use TEE trusted keys without CONFIG_TCG_TPM
>  - It's now possible to enable CONFIG_TCG_TPM, but exclude TPM from
>    available trust sources
>  - TEE=m && TRUSTED_KEYS=y no longer leads to TEE support
>    being silently dropped
> 
> Any code depending on the TPM trusted key backend or symbols exported
> by it will now need to explicitly state that it
> 
>   depends on TRUSTED_KEYS && TRUSTED_KEYS_TPM
> 
> The latter to ensure the dependency is built and the former to ensure
> it's reachable for module builds. This currently only affects
> CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE, so it's fixed up here as well.
> 
> Reported-by: Andreas Rammhold <andreas@rammhold.de>
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Is it absolutely need to do all this *just* to fix the bug?

For a pure bug fix the most essential thing is to be able the backport
it to stable kernels.

I don't really care at all about extra niceties ("it's now possible
stuff).

This looks like a bug fix and improvements bundle into a single patch.

/Jarkko
