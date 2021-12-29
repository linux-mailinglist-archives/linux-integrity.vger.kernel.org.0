Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0D480E13
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Dec 2021 01:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhL2AJD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 19:09:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40368 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhL2AJC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 19:09:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C78C61354;
        Wed, 29 Dec 2021 00:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25358C36AE7;
        Wed, 29 Dec 2021 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640736541;
        bh=zCqpS+H+9hfgX11sHtjTme9mvuOnPzkxY1baQY/gFnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edohT3EE8K1pXMrPy4zALbyiEZeSsGoFYxHNqCRNyQUcAkmWpqU2QnM+pU+ot2/cm
         MsCmNFo9v2QVmiGgjyiq/yVSECR1DMQNU785uDbWqjsAOzORiSf3jIQgqvugEd7K9O
         vyRzzfGXNNywPUMLo2RxvRGi8B+bo6GEYismNkxt5vb1Q2XvKTLAK1pcLs44S1kddf
         gxmOKQfdmi5lNZTYhfo+Uq87SSNS8wsuWLCmV9hl3Zy+FDYDD13AkEf7lqka0MNEhS
         LCB3JkFQrCxTtpHVh3emxOvZ7wHp6SNt5Z1xJWElTP0gWxUM276vj4d92K12ayr0Cg
         5yBG9oRtgzRGw==
Date:   Wed, 29 Dec 2021 02:08:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security:trusted_tpm2: Fix memory leak in
 tpm2_key_encode()
Message-ID: <YcunG4iFQ5s7uJsc@iki.fi>
References: <20211221085404.6769-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221085404.6769-1-niejianglei2021@163.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

KEYS: trusted: Fix memory leak in tpm2_key_encode()

On Tue, Dec 21, 2021 at 04:54:04PM +0800, Jianglei Nie wrote:
> Line 36 (#1) allocates a memory chunk for scratch by kmalloc(), but
> it is never freed through the function, which will lead to a memory
> leak.
> 
> We should kfree() scratch before the function returns (#2, #3 and #4).
> 
> 31 static int tpm2_key_encode(struct trusted_key_payload *payload,
> 32			   struct trusted_key_options *options,
> 33			   u8 *src, u32 len)
> 34 {
> 36	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>       	// #1: kmalloc space
> 50	if (!scratch)
> 51		return -ENOMEM;
> 
> 56	if (options->blobauth_len == 0) {
> 60		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> 61			return PTR_ERR(w); // #2: missing kfree
> 63	}
> 
> 71	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> 72		 "BUG: scratch buffer is too small"))
> 73		return -EINVAL; // #3: missing kfree
> 
>   	// #4: missing kfree: scratch is never used afterwards.
> 82	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> 83		return PTR_ERR(work1);
> 
> 85	return work1 - payload->blob;
> 86 }
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

Please write a proper commit message and not just dump tool output. You
are completely lacking analysis of what the heck you are doing.

E.g. you could just:

"The internal buffer in tpm2_key_encode() is not freed, which leads to a
memory leak. Handle those cases with kfree()."

/Jarkko
