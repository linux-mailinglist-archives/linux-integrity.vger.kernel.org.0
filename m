Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C363D6C2B
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 04:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhG0CQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234440AbhG0CQs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:16:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2290760FEE;
        Tue, 27 Jul 2021 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627354636;
        bh=iQ9FkdbtV/zROAlVG/8PBSjOtj+aTz+AaFmkHdysXtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpyMORbiiNmOKjWizE4f0nrPg8XLbuRguHi7r2Yk5/ja5TNBPSSgPkbqK71qEZOM4
         aNO08v+UoN6JncvrYwPKxxAGtFuCwXHECUZQE7T6aHzDQMea9VkfyPcE3DY1lsbJ6N
         J3a+s5FJrfBW1WyrU7T2aPgif3LxpjpXhcaSO6ajPluBGQ9MouJh7febqXdLFJnFJ6
         8Js9QWy6f0lvhLw7hUI+g/bj2zxzvXELzHRX7VVw7lZ5Iao7oDuxfIllGIG5w7n/4n
         9OFWBhTDivtL+8yv9QBCWonQQTS+6EaBJAXj9JM2mJcXhETM2Q/sDC/vqz3YCI0Tj1
         IWNETP86Bw6Jw==
Date:   Tue, 27 Jul 2021 05:57:14 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Andreas Rammhold <andreas@rammhold.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] KEYS: trusted: Fix trusted key backends when building as
 module
Message-ID: <20210727025714.3zll7spsmo3opont@kernel.org>
References: <20210716081722.4130161-1-andreas@rammhold.de>
 <0a684d56-66d0-184e-4853-9faafa2d243d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a684d56-66d0-184e-4853-9faafa2d243d@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 19, 2021 at 09:10:01AM +0200, Ahmad Fatoum wrote:
> Hello Andreas,
> 
> On 16.07.21 10:17, Andreas Rammhold wrote:
> > Before this commit the kernel could end up with no trusted key sources
> > even thought both of the currently supported backends (tpm & tee) were
> > compoiled as modules. This manifested in the trusted key type not being
> > registered at all.
> 
> I assume (TPM) trusted key module use worked before the TEE rework? If so,
> 
> an appropriate Fixes: Tag would then be in order.
> 
> > When checking if a CONFIG_… preprocessor variable is defined we only
> > test for the builtin (=y) case and not the module (=m) case. By using
> > the IS_ENABLE(…) macro we to test for both cases.
> 
> It looks to me like you could now provoke a link error if TEE is a module
> and built-in trusted key core tries to link against trusted_key_tee_ops.
> 
> One solution for that IS_REACHABLE(). Another is to address the root cause,
> which is the inflexible trusted keys Kconfig description:
> 
> - Trusted keys despite TEE support can still only be built when TCG_TPM is enabled
> - There is no support to have TEE or TPM enabled without using those for
>   enabled trusted keys as well
> - As you noticed, module build of the backend has issues
> 
> I addressed these three issues in a patch[1], a month ago, but have yet to
> receive feedback.

Which of the patches is the bug fix?

/Jarkko
