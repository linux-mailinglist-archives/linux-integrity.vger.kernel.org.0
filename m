Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE0537B2BE
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 01:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKXrJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 19:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXrI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 19:47:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FE92616ED;
        Tue, 11 May 2021 23:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620776761;
        bh=0dmp162/xsNE25srlIIbfhkW/kO41/gT68NUM2wciFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyTRZBucYOeqw2vkr6jt8K1K9YKPRokln6A0hKzWn6zXxu1PMhghuGw4iZRuGMbq8
         F6hRFqUa/+D/pWZMg335CKhbZGN0mGL0TY7aRceEgJkCr6LQSj6VIF4kTzLRviRWhY
         wX/x7vfChk+TN1rrR2N1NWQSxd4/iRKZclR99qHn9aFzOnO+BIkYvmO2ZFDT8We0hl
         ZsOcHF0blzsikb++K6f3cWTuw1hn9SZ3izJlueCYIsTujlnX0ymBGI8eGST6DOCUpL
         ZANYL/7tBJTDhUjew7u4m991kYau7sWkZhfak1Rc19lATHSsFhvSivRmQQleIFPtW3
         7f2CqLAO8SJ5Q==
Date:   Wed, 12 May 2021 02:45:59 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/1] trusted-keys: match tpm_get_ops on all return
 paths
Message-ID: <YJsXN47MTF/TpsKX@kernel.org>
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
> 
> --Ben

I applied it, probably will do additional PR for v5.13 in order to fix
some urgent tpm_tis issues, so I'll include this to the same pull
request. Thanks for fixing this!

/Jarkko
