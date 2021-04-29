Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEFB36F05D
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 21:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhD2TSm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 15:18:42 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:34908 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238738AbhD2TJW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 15:09:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B4D6B128060F;
        Thu, 29 Apr 2021 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619723315;
        bh=Wr5b4YST9tl/BuuCQuNcLA2CvwkZHmyGHlsVuX6DZQ8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=l73StIMHozzf/YnymVM3GIVZyJdmOM4eJ9AR5UhAIUp9LATjTdvU1Vp863KHVixDP
         tr5Dn0mIkExYdmXbNdjwTbBH9OdJIfGgeL5eUFOKegKs7HXOrdUazUeAdR9m0fSBgT
         I29v9viBAFrF3o7nqoTDFRpSJZC6MlXt0UBnHe5U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ST3JDx_pPKLa; Thu, 29 Apr 2021 12:08:35 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4465612805FA;
        Thu, 29 Apr 2021 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619723315;
        bh=Wr5b4YST9tl/BuuCQuNcLA2CvwkZHmyGHlsVuX6DZQ8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=l73StIMHozzf/YnymVM3GIVZyJdmOM4eJ9AR5UhAIUp9LATjTdvU1Vp863KHVixDP
         tr5Dn0mIkExYdmXbNdjwTbBH9OdJIfGgeL5eUFOKegKs7HXOrdUazUeAdR9m0fSBgT
         I29v9viBAFrF3o7nqoTDFRpSJZC6MlXt0UBnHe5U=
Message-ID: <08179943c02b0952546d01713e24ccba62d1a566.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/1] trusted-keys: match tpm_get_ops on all return paths
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 29 Apr 2021 12:08:34 -0700
In-Reply-To: <YIsC9mT8XmIi/fbB@erythro>
References: <20210429183742.756766-1-list.lkml.keyrings@me.benboeckel.net>
         <20210429183742.756766-2-list.lkml.keyrings@me.benboeckel.net>
         <9eea988ff637af57511107c6c0941bff2aa7c6c5.camel@HansenPartnership.com>
         <YIsC9mT8XmIi/fbB@erythro>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-04-29 at 15:03 -0400, Ben Boeckel wrote:
> On Thu, Apr 29, 2021 at 11:50:50 -0700, James Bottomley wrote:
> > Actually, I think this is a better fix to avoid multiple put and
> > returns.
> > 
> > James
> > 
> > ---
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> > b/security/keys/trusted-keys/trusted_tpm2.c
> > index d225ad140960..cbf2a932577b 100644
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
> Ah, that does look better. I had first added a new label, but that
> didn't seem like an improvement in readability. I grabbed this
> pattern from an early return earlier in the function. But given that
> this is the end (and appears to be unlikely to have more logic
> inserted in the future), this seems more reasonable to me as well. Do
> you want me to respin or just let it up to you at this point?

Can you respin? ... I'm a bit lossy at the moment due to pressure of
work.

Thanks,

James


