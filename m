Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D854688A8
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Dec 2021 01:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhLEAWM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Dec 2021 19:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhLEAWL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Dec 2021 19:22:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3AC061751;
        Sat,  4 Dec 2021 16:18:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD54960F56;
        Sun,  5 Dec 2021 00:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A368C341C2;
        Sun,  5 Dec 2021 00:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638663524;
        bh=BfwN181/ucvPs+qqkXLqvD+Y0D/G/XS4t6OFMg7vhYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3VyEjpqmg+V6VXQzLH08lJ8nmsu2H0REv+FA4dSSnLpH/k0iHMMHbrIBL474eZdZ
         7KX7/Pg/gCkBpjQFP5caYX/r5ZT0M1mp9agmcOvw/V7Doecv9pcXeLLYcklDoPYdcr
         eRhSAP6dvqtWUuGj4GDSuNub8Mvb+YmObA6Ax1QdPMIM3bdYyqNUEQpbUgrHMIC6RW
         vSBc1zTUU6oepW7FNuQvKgMKj4qbuhxVCOEMeDDHbS9+6lgdqYNT+5qfxNsBwwN9cK
         4GS/oaMZCSDwZ38ezEQGoAvf8fP8URoqScyA75jWzOKGqZWTiYIbG8VKyLbhGjV8nd
         Ixf+ceB9BpKRQ==
Date:   Sun, 5 Dec 2021 02:18:40 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 4/5] crypto: caam - add in-kernel interface for blob
 generator
Message-ID: <YawFYFV8xGIPZvUJ@iki.fi>
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
 <3ea6e5c37559eddfdc51f26c4dff0abbbc894839.1633946449.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea6e5c37559eddfdc51f26c4dff0abbbc894839.1633946449.git-series.a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 11, 2021 at 12:02:37PM +0200, Ahmad Fatoum wrote:
> The CAAM can be used to protect user-defined data across system reboot:
> 
>   - When the system is fused and boots into secure state, the master
>     key is a unique never-disclosed device-specific key
>   - random key is encrypted by key derived from master key
>   - data is encrypted using the random key
>   - encrypted data and its encrypted random key are stored alongside
>   - This blob can now be safely stored in non-volatile memory
> 
> On next power-on:
>   - blob is loaded into CAAM
>   - CAAM writes decrypted data either into memory or key register
> 
> Add functions to realize encrypting and decrypting into memory alongside
> the CAAM driver.
> 
> They will be used in a later commit as a source for the trusted key
> seal/unseal mechanism.
> 
> Reviewed-by: David Gstir <david@sigma-star.at>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

What is CAAM? This is missing.

/Jarkko
