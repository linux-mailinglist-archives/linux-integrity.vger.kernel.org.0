Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F965D16C
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjADLbn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 06:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjADLbm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 06:31:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557AEAF;
        Wed,  4 Jan 2023 03:31:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97772B810FA;
        Wed,  4 Jan 2023 11:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3661C433D2;
        Wed,  4 Jan 2023 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672831898;
        bh=VgAXciag9TzqrbcrI2xLeki43co0yEKZUHdTYmAlYPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaCvyZ9SN5MjBzF491yLiUrG6aIlOgG3B3Sco4CrslbxmQHfPEYapIkZrbgm3j4Xt
         /KuyeA9kQ5U0O+HGYfDe9zjZ9tK7yBaKZoZ2kxnwCwTx2rL3Ru+EDfFjQgFnOoAI1o
         /evWjQ+OXk9HOp/0yWsvNO2b5PIUBp0eytuxjfQSuJF68SAeb+4ceyBPQoMMXHqVNt
         DJnxAZzJ+BvCopT6QzdMhj429j2bI6o/vY96Q16IdPEtrLjP2RMkKbNtf9SCLh87Eq
         4FiDQEDVbBiMpJqQovGuB1aZrq3geee0lRHbnrano1PslXM0jdGwOwlh8y+0IEhkYh
         FZOXDVdk8D1gA==
Date:   Wed, 4 Jan 2023 11:31:34 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 01/10] KEYS: Create static version of
 public_key_verify_signature
Message-ID: <Y7Vjlof68d0WRKdc@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-2-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003401.4086781-2-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 13, 2022 at 07:33:52PM -0500, Eric Snowberg wrote:
> The kernel test robot reports undefined reference to
> public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
> not defined. Create a static version in this case and return -EINVAL.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/crypto/public_key.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 68f7aa2a7e55..6d61695e1cde 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
>  extern int verify_signature(const struct key *,
>  			    const struct public_key_signature *);
>  
> +#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
>  int public_key_verify_signature(const struct public_key *pkey,
>  				const struct public_key_signature *sig);
> +#else
> +static inline
> +int public_key_verify_signature(const struct public_key *pkey,
> +				const struct public_key_signature *sig)
> +{
> +	return -EINVAL;
> +}
> +#endif
>  
>  #endif /* _LINUX_PUBLIC_KEY_H */
> -- 
> 2.27.0
> 

Should this have fixes tag?

BR, Jarkko

