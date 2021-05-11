Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2BB37B2B3
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 01:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEKXkU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 19:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXkT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 19:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58A28616ED;
        Tue, 11 May 2021 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620776352;
        bh=opdv1vl7F9qgMxjqwo7kS8bgDqLanKuizbh/7bPX1d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3NSyN2UVXQiYlvizM1YqCinboJ8Wfii4PUN8SQhqD2QB0Xdnv7Ykj1YG8mKI7Cpf
         gqfrvt2QHJN8Ujb8u7niKauxwRL0mVCx3tBXUXRMSb4TkETeZUY00rBLWwMa5AejPn
         lRUxCviwZNMoyS78geR89xun0Oi6LkcYwVkK4L0kchVgOB7Em0xQPMoXYjF7F2m5OJ
         NCRaol8+SGYnCe4+bFkSkhbX2Fis4hbFXVVlByLTCe9UazKq750ROu3np0ksNhWiYb
         CJgjqTdVc74bnX/H/W2Oce8NWva5s3HorKX2DRFNGN5SbuCLZ9aebr0f2/b8UVYcUS
         fE2bTwZsUkPfQ==
Date:   Wed, 12 May 2021 02:39:10 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/1] trusted-keys: match tpm_get_ops on all return
 paths
Message-ID: <YJsVnjXYEokBC1N6@kernel.org>
References: <20210429192156.770145-1-list.lkml.keyrings@me.benboeckel.net>
 <20210429192156.770145-2-list.lkml.keyrings@me.benboeckel.net>
 <YJmf4Q0l+MTFEaEo@erythro.dev.benboeckel.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJmf4Q0l+MTFEaEo@erythro.dev.benboeckel.internal>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 10, 2021 at 05:04:33PM -0400, Ben Boeckel wrote:
> On Thu, Apr 29, 2021 at 15:21:56 -0400, Ben Boeckel wrote:
> > From: Ben Boeckel <mathstuf@gmail.com>
> > 
> > The `tpm_get_ops` call at the beginning of the function is not paired
> > with a `tpm_put_ops` on this return path.
> > 
> > Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> > ---
> >  security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 617fabd4d913..0165da386289 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -336,9 +336,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  			rc = -EPERM;
> >  	}
> >  	if (blob_len < 0)
> > -		return blob_len;
> > -
> > -	payload->blob_len = blob_len;
> > +		rc = blob_len;
> > +	else
> > +		payload->blob_len = blob_len;
> >  
> >  	tpm_put_ops(chip);
> >  	return rc;
> 
> Ping? Is this going to make 5.13? This fixes an issue that is in
> 5.13-rc1.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
