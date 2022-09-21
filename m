Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38575C05AB
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIURvW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIURvW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 13:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390C89E12D;
        Wed, 21 Sep 2022 10:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66B2630DA;
        Wed, 21 Sep 2022 17:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0EFC433D6;
        Wed, 21 Sep 2022 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663782680;
        bh=VXiZehO8k5frfzE5P3ISP2HDghL9EApuPKkqrRgnTzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qs5uM2aNrf01eP1l8i0TjLjG5XLKrtRVRU23eEWnCazUXfX+33s8vlIgxWRwdIk54
         PyZEy/KJMYC34rzdBWRh4bbeTp6FLhpot9h1pvzvI2FfFy+6AgnF9cjaddic+iCkn1
         Cv+fVrccgkpHAerj+D12kvxmJEW6waLDZ+wnGS4/kvynlHsYetnhYAYr1FIlG6NONO
         hS4Hu7CPUE6Vw5x03wFMclP0zNtddlMy3soWVQucCuQMhHgsTAMDQi5qEs27VWrbkl
         85VYwd2G6qG3lFZDaO1kO6uGYKzLPdrPyHYR2EMCgFdMXICvyO8dWuPvBZfdpacU0C
         Jl+v+rhsah33w==
Date:   Wed, 21 Sep 2022 20:51:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Yael Tzur <yaelt@google.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: fix key instantiation with
 user-provided data
Message-ID: <YytPFLsOHHmHEB5I@kernel.org>
References: <20220919072317.E41421357@mail.steuer-voss.de>
 <YylKR1UQZGhN0+UW@kernel.org>
 <372b91d-5ee6-ae24-2279-0dc7621489c@vosn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372b91d-5ee6-ae24-2279-0dc7621489c@vosn.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 20, 2022 at 09:58:56AM +0200, Nikolaus Voss wrote:
> On Tue, 20 Sep 2022, Jarkko Sakkinen wrote:
> > On Fri, Sep 16, 2022 at 07:45:29AM +0200, Nikolaus Voss wrote:
> > > Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> > > decrypted data") added key instantiation with user provided decrypted data.
> > > The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> > > Fix this to use hex2bin instead.
> > > 
> > > Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> > > Cc: stable <stable@kernel.org>
> > > Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> > > ---
> > >  security/keys/encrypted-keys/encrypted.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> > > index e05cfc2e49ae..1e313982af02 100644
> > > --- a/security/keys/encrypted-keys/encrypted.c
> > > +++ b/security/keys/encrypted-keys/encrypted.c
> > > @@ -627,7 +627,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
> > >  			pr_err("encrypted key: instantiation of keys using provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
> > >  			return ERR_PTR(-EINVAL);
> > >  		}
> > > -		if (strlen(decrypted_data) != decrypted_datalen) {
> > > +		if (strlen(decrypted_data) != decrypted_datalen * 2) {
> > 
> > This looks wrong. What does cap decrypted_data, and why strnlen()
> > is not used?
> 
> This is a plausibility check to ensure the user-specified key length
> (decrypted_datalen) matches the length of the user specified key. strnlen()
> would not add any extra security here, the data has already been copied.

I'd prefer unconditional use of strnlen() because it always
gives you at least some guarantees over deducing why strlen()
is fine in a particular code block.


> > 
> > >  			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
> > 
> > Using pr_err() is probably wrong here and has different prefix
> > than elsewhere in the file (also most of other uses of pr_err()
> > are wrong apparently). Nothing bad is really happening.
> 
> It actually _is_ an error preventing key instatiation. User space keyctl
> cannot be verbose about the reason why instantiation failed so it makes
> sense to be verbose in kernel space. To me, this seems consistent with other
> occurrences of pr_err() in this file, maybe I misunderstood you?

Then it should be pr_info(), or even pr_debug(), given that it is not a
kernel issue.

> Btw, this patch changes neither string length checking nor log levels.

I understand this. It has been my own mistake to ack that pr_err().

However, does not fully apply to strlen() part. Since you are
changing that line anyway, it'd be better to replace strlen()
with strnlen(). This e.g. protects the code block changes in
the context where it is called.

BR, Jarkko
