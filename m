Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414986EB367
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjDUVMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjDUVMF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 17:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1405B3;
        Fri, 21 Apr 2023 14:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D590C652FA;
        Fri, 21 Apr 2023 21:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEB5C433EF;
        Fri, 21 Apr 2023 21:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682111523;
        bh=PAOoIU6HaP+dNtnNsbCXQ8sw9/H/z7hjv1lJ3ORbvxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jePOQTa0sfmvjhSWAEmpkRnbTF/ETBNc1qzMc+qjIB9xW/vx/o0xRkyg1ajg54vOS
         HMJ5R1PWc1GnC1SvDrVNBjfHJ+KnYkPDK4KAoTyqGzCZWlON59OUAFgEUFUsapUE0l
         QTYacVcekJ8VQlT5fjFTligNTnILJo8EDfztXiktOfOug+mut4f48NpG5HAWZJBYXk
         Ewjt5EpATs5Tzf3yXz9JJOhpoKytKUuSgJpU8JZZZQ0V69ZmScwbHff/s6onQstssJ
         1ff4rTxsp2rnujUvPt+kVI/Ju/XhBhZQPxds5orhDguE5OBhauRfkgfjyLkOyqKIle
         0c3vTkrfOp+nA==
Date:   Sat, 22 Apr 2023 00:12:00 +0300
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
Message-ID: <ZEL8IKYhMdOvpWa1@kernel.org>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
 <20230302164652.83571-6-eric.snowberg@oracle.com>
 <ZAz8QlynTSMD7kuE@kernel.org>
 <07FFED83-501D-418C-A4BB-862A547DD7B0@oracle.com>
 <20230320182822.6xyh6ibatrz5yrhb@kernel.org>
 <84d46fb108f6ce2a322b6486529fc6dd0f8deea5.camel@linux.ibm.com>
 <20230329232735.dvmxvwis2psbvyw5@kernel.org>
 <55b5c21ee1cf47aff0b2e5a94ec65fe326c8d6ba.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b5c21ee1cf47aff0b2e5a94ec65fe326c8d6ba.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 30, 2023 at 02:01:52AM -0400, Mimi Zohar wrote:
> On Thu, 2023-03-30 at 02:27 +0300, Jarkko Sakkinen wrote:
> > On Mon, Mar 20, 2023 at 04:35:33PM -0400, Mimi Zohar wrote:
> > > On Mon, 2023-03-20 at 20:28 +0200, Jarkko Sakkinen wrote:
> > > > On Mon, Mar 20, 2023 at 05:35:05PM +0000, Eric Snowberg wrote:
> > > > > 
> > > > > 
> > > > > > On Mar 11, 2023, at 3:10 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > > 
> > > > > > On Thu, Mar 02, 2023 at 11:46:51AM -0500, Eric Snowberg wrote:
> > > > > >> Add a new link restriction.  Restrict the addition of keys in a keyring
> > > > > >> based on the key to be added being a CA.
> > > > > >> 
> > > > > >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > > > >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > >> ---
> > > > > >> crypto/asymmetric_keys/restrict.c | 38 +++++++++++++++++++++++++++++++
> > > > > >> include/crypto/public_key.h       | 15 ++++++++++++
> > > > > >> 2 files changed, 53 insertions(+)
> > > > > >> 
> > > > > >> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> > > > > >> index 6b1ac5f5896a..48457c6f33f9 100644
> > > > > >> --- a/crypto/asymmetric_keys/restrict.c
> > > > > >> +++ b/crypto/asymmetric_keys/restrict.c
> > > > > >> @@ -108,6 +108,44 @@ int restrict_link_by_signature(struct key *dest_keyring,
> > > > > >> 	return ret;
> > > > > >> }
> > > > > >> 
> > > > > >> +/**
> > > > > >> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> > > > > >> + * @dest_keyring: Keyring being linked to.
> > > > > >> + * @type: The type of key being added.
> > > > > >> + * @payload: The payload of the new key.
> > > > > >> + * @trust_keyring: Unused.
> > > > > >> + *
> > > > > >> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> > > > > >> + * certificate as being ok to link.
> > > > > >> + *
> > > > > >> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> > > > > >> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> > > > > >> + * crypto, or some other error if there is a matching certificate but
> > > > > >> + * the signature check cannot be performed.
> > > > > >> + */
> > > > > >> +int restrict_link_by_ca(struct key *dest_keyring,
> > > > > >> +			const struct key_type *type,
> > > > > >> +			const union key_payload *payload,
> > > > > >> +			struct key *trust_keyring)
> > > > > >> +{
> > > > > >> +	const struct public_key *pkey;
> > > > > >> +
> > > > > >> +	if (type != &key_type_asymmetric)
> > > > > >> +		return -EOPNOTSUPP;
> > > > > >> +
> > > > > >> +	pkey = payload->data[asym_crypto];
> > > > > >> +	if (!pkey)
> > > > > >> +		return -ENOPKG;
> > > > > >> +	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> > > > > >> +		return -ENOKEY;
> > > > > >> +	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> > > > > >> +		return -ENOKEY;
> > > > > >> +	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> > > > > >> +		return -ENOKEY;
> > > > > > 
> > > > > > nit: would be more readable, if conditions were separated by
> > > > > > empty lines.
> > > > > 
> > > > > Ok, I will make this change in the next round.  Thanks.
> > > > 
> > > > Cool! Mimi have you tested these patches with IMA applied?
> > > 
> > > Yes, it's working as expected.
> > 
> > Thank you. Please check that I filled additional tags correctly:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> > 
> > I will then put these also to my 'next' branch and they will get mirrored
> > to linux-next.
> 
> Thanks, Jarkko.  The tags look good.

Hi, sorry for radio silence. I've been transitioning to a new job.

Commits are in my next branch, and I will include them to my PR.

BR, Jarkko
