Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6950544328
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jun 2022 07:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiFIFad (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 01:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiFIFac (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 01:30:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B131228714;
        Wed,  8 Jun 2022 22:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DC1FB82C1F;
        Thu,  9 Jun 2022 05:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B63C34114;
        Thu,  9 Jun 2022 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654752629;
        bh=UPd29q5HWT+IXQLp3cxU4COiMwXAghPMXBh9HBWf3Ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1awn6iWRpQKh7vS9DefuUSRw8Hococ8EHfx7JDebWZcKYzojQBUE6mc3bb13agbk
         uaDYxUvF/6zNY2BjrdZwUHXcWkDiUR1Rt/C9sFrPJX3PM8/ASKqvjrdwi64LrAoqTd
         UrhDAMQhI5dyazxl99NvitNVc5J/+CyePuqorcVfcToD7ATYQITE0zSab2ds5i9u0U
         wUw0C7niX9O4/CJuTRxPvk/Uzq14kgW5U/1+eoeO51iiyRIa5XLFosXpQJwHpKDH11
         18BCPxXDIypiEv3xKYEsbriPhGt6IjGbTB5GQZ4k8NI53/hrltoPBq2gLVeibQTBAF
         p3InvYON5AYtw==
Date:   Thu, 9 Jun 2022 08:28:30 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Jianglei Nie <niejianglei2021@163.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Message-ID: <YqGE/v0Zgi+g4gY6@iki.fi>
References: <20220608131732.550234-1-niejianglei2021@163.com>
 <YqCmVi3J10Tcx0Wk@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqCmVi3J10Tcx0Wk@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 08, 2022 at 01:38:35PM +0000, Jonathan McDowell wrote:
> On Wed, Jun 08, 2022 at 09:17:32PM +0800, Jianglei Nie wrote:
> > tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
> > but it is never freed, which leads to a memory leak. Free the memory
> > chunk with kfree() in the return path.
> 
> This change only does the kfree in the success path; "out" just returns
> the error without freeing the memory.

A valid point.

> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  security/keys/trusted-keys/trusted_tpm2.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 0165da386289..8b7ab22950d1 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -32,6 +32,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  			   struct trusted_key_options *options,
> >  			   u8 *src, u32 len)
> >  {
> > +	int err;
> >  	const int SCRATCH_SIZE = PAGE_SIZE;
> >  	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);

Also, the fix is half-way there, it does not have OOM
check for scratch.

I.e. I'd change the declaration as:

        u8 *scratch;

And later on after declarations:

        scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
        if (!scratch)
                return -ENOMEM; 

> >  	u8 *work = scratch, *work1;
> > @@ -57,8 +58,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  		unsigned char bool[3], *w = bool;
> >  		/* tag 0 is emptyAuth */
> >  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> > -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> > -			return PTR_ERR(w);
> > +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> > +			err = PTR_ERR(w);
> > +			goto out;
> > +		}
> >  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> >  	}
> >  
> > @@ -69,8 +72,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  	 * trigger, so if it does there's something nefarious going on
> >  	 */
> >  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> > -		 "BUG: scratch buffer is too small"))
> > -		return -EINVAL;
> > +		 "BUG: scratch buffer is too small")) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> >  
> >  	work = asn1_encode_integer(work, end_work, options->keyhandle);
> >  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> > @@ -79,10 +84,16 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  	work1 = payload->blob;
> >  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
> >  				     scratch, work - scratch);
> > -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> > -		return PTR_ERR(work1);
> > +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +	kfree(scratch);
> >  
> >  	return work1 - payload->blob;
> > +
> > +out:
> > +	return err;

I.e.

        kfree(scratch);
        return work1 - payload->blob;

err:
        kfree(scratch);
        return ret;


> >  }
> >  
> >  struct tpm2_key_context {
> > -- 
> > 2.25.1

BR, Jarkko
