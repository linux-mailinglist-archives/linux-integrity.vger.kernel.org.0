Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036E76CF5BC
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Mar 2023 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC2V6e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 17:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC2V6d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 17:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1126A2D42;
        Wed, 29 Mar 2023 14:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 858F061E68;
        Wed, 29 Mar 2023 21:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEC4C433D2;
        Wed, 29 Mar 2023 21:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680127110;
        bh=lW+gm1x4d5QdzyzW9QD2rMqvfjW4i8bagFNrq+DW0nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvN1x2mUXYTcrHkUkDkg4pnvJQ2Hrbu1i9QEXZ/CrCVfq9IaXgvYKmDMc0iig4A3l
         dnuu6LmLYkS1mPfKC6ZvOiF08rd7nFjQBGT8GLICfA3LGOvOogOUa+X7DuxaSzR9Zc
         2EuPQLHyvD+scbExp/wrs88G0rnDrGBjV9UpS1ftGbudjiMuomclbXkTJDtgMuUwqG
         T0n9aY+LsMWblVGNLmoYLe2VoGYvgZ9nO2hsGuyf3EHtxwVhAWaxG4neJVD+wyKDuV
         hXgDTpFvIMnVhGbGRcmq3oFQdbYrmwJOOIuPTPq85VYH2rIhyGn5zqZFlPm1pNhBZq
         1O6mARd2GAnYQ==
Date:   Thu, 30 Mar 2023 00:58:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "erpalmer@linux.vnet.ibm.com" <erpalmer@linux.vnet.ibm.com>,
        "coxu@redhat.com" <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] KEYS: CA link restriction
Message-ID: <20230329215827.zkacqq3j772gkvre@kernel.org>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
 <20230302164652.83571-6-eric.snowberg@oracle.com>
 <ZAz8QlynTSMD7kuE@kernel.org>
 <07FFED83-501D-418C-A4BB-862A547DD7B0@oracle.com>
 <20230320182822.6xyh6ibatrz5yrhb@kernel.org>
 <84d46fb108f6ce2a322b6486529fc6dd0f8deea5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d46fb108f6ce2a322b6486529fc6dd0f8deea5.camel@linux.ibm.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 20, 2023 at 04:35:33PM -0400, Mimi Zohar wrote:
> On Mon, 2023-03-20 at 20:28 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 20, 2023 at 05:35:05PM +0000, Eric Snowberg wrote:
> > > 
> > > 
> > > > On Mar 11, 2023, at 3:10 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > 
> > > > On Thu, Mar 02, 2023 at 11:46:51AM -0500, Eric Snowberg wrote:
> > > >> Add a new link restriction.  Restrict the addition of keys in a keyring
> > > >> based on the key to be added being a CA.
> > > >> 
> > > >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > >> ---
> > > >> crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
> > > >> include/crypto/public_key.h       | 15 ++++++++++++
> > > >> 2 files changed, 53 insertions(+)
> > > >> 
> > > >> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> > > >> index 6b1ac5f5896a..48457c6f33f9 100644
> > > >> --- a/crypto/asymmetric_keys/restrict.c
> > > >> +++ b/crypto/asymmetric_keys/restrict.c
> > > >> @@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_keyring,
> > > >> 	return ret;
> > > >> }
> > > >> 
> > > >> +/**
> > > >> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> > > >> + * @dest_keyring: Keyring being linked to.
> > > >> + * @type: The type of key being added.
> > > >> + * @payload: The payload of the new key.
> > > >> + * @trust_keyring: Unused.
> > > >> + *
> > > >> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> > > >> + * certificate as being ok to link.
> > > >> + *
> > > >> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> > > >> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> > > >> + * crypto, or some other error if there is a matching certificate but
> > > >> + * the signature check cannot be performed.
> > > >> + */
> > > >> +int restrict_link_by_ca(struct key *dest_keyring,
> > > >> +			const struct key_type *type,
> > > >> +			const union key_payload *payload,
> > > >> +			struct key *trust_keyring)
> > > >> +{
> > > >> +	const struct public_key *pkey;
> > > >> +
> > > >> +	if (type != &key_type_asymmetric)
> > > >> +		return -EOPNOTSUPP;
> > > >> +
> > > >> +	pkey = payload->data[asym_crypto];
> > > >> +	if (!pkey)
> > > >> +		return -ENOPKG;
> > > >> +	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> > > >> +		return -ENOKEY;
> > > >> +	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> > > >> +		return -ENOKEY;
> > > >> +	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> > > >> +		return -ENOKEY;
> > > > 
> > > > nit: would be more readable, if conditions were separated by
> > > > empty lines.
> > > 
> > > Ok, I will make this change in the next round.  Thanks.
> > 
> > Cool! Mimi have you tested these patches with IMA applied?
> 
> Yes, it's working as expected.

OK, I will pick these.

BR, Jarkko
