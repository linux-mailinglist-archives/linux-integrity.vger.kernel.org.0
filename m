Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03D3379AAC
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 01:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhEJXUI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 19:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhEJXUI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 19:20:08 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E03C061574;
        Mon, 10 May 2021 16:19:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1AC04128053C;
        Mon, 10 May 2021 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1620688742;
        bh=f905pQyWkLsAp05euszWRJr8cxZx1j0A/Ts4bKkRP00=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=XQZ17b4EHOcvNHKQV/G8NkHCK5QxyRs75nHIZ+NU2BwsXSjaecY1bVumMHyAck4Wn
         60U7vbdMuochf82VrqCSIZzrzb0HDq1OX4D9waKUC7aDU346wWkTEZyCcN94BvGdPG
         T2MCS1JMSBSLHu7/ngRue3NnMf4vLfNdlxA5OMAY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EwNIEwqsrRQ2; Mon, 10 May 2021 16:19:02 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9AA13128053B;
        Mon, 10 May 2021 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1620688741;
        bh=f905pQyWkLsAp05euszWRJr8cxZx1j0A/Ts4bKkRP00=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=QOWswFUiFRIpMgsESW8uArfM77pN5AYcAO2vNZYwPyon+5xq+UNgc3VSaym99y43n
         G44OYK1QAH17v4gZWWBel6GKTmDHsW/kpEtQ5eJsLjQd4bhsCFo4HLnFcIkpFHFsiT
         GUvttcLwC7WAA882wwkHuxKDCYo3LsEQNdrM9oMM=
Message-ID: <c896e4fd24aa649081cb0ce712580a8400ab36d6.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/1] trusted-keys: match tpm_get_ops on all return
 paths
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ben Boeckel <me@benboeckel.net>, keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 10 May 2021 16:19:00 -0700
In-Reply-To: <YJmf4Q0l+MTFEaEo@erythro.dev.benboeckel.internal>
References: <20210429192156.770145-1-list.lkml.keyrings@me.benboeckel.net>
         <20210429192156.770145-2-list.lkml.keyrings@me.benboeckel.net>
         <YJmf4Q0l+MTFEaEo@erythro.dev.benboeckel.internal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-05-10 at 17:04 -0400, Ben Boeckel wrote:
> On Thu, Apr 29, 2021 at 15:21:56 -0400, Ben Boeckel wrote:
> > From: Ben Boeckel <mathstuf@gmail.com>
> > 
> > The `tpm_get_ops` call at the beginning of the function is not
> > paired
> > with a `tpm_put_ops` on this return path.
> > 
> > Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key
> > format for the blobs")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> > ---
> >  security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> > b/security/keys/trusted-keys/trusted_tpm2.c
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

It's not urgent, since it's in an error in the ASN.1 encoder, the only
real way to produce it is if the system runs out of memory, which is
highly unlikely since the allocations are all GFP_KERNEL.  We've also
got another 8 or so weeks before 5.13 so there's time for this to go
through the normal review process.

James


