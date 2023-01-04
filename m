Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43D65D179
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 12:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjADLdt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 06:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjADLds (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 06:33:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA1F0D;
        Wed,  4 Jan 2023 03:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5BFF613E9;
        Wed,  4 Jan 2023 11:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A6DC433EF;
        Wed,  4 Jan 2023 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672832026;
        bh=4LX8ySPAS/dr/hJWVCAwW0xJ1a9yy3B2zuAS7iq9iy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFLTJdtSXLs14beqlYBetKAOMJjMgg0Z0qWG574Td8JDgBg9iCxX1bEjRUFwU8qfO
         gbwOS5zoc0N9T5ECtyELlL+YHmiFDzBRmqp5i7GeEBd+qQy3zkmrPawW8gip17eNxp
         P6iMN8psct7btmH+cSSAKdXwhyfzUv+heMw5UytH5IUB6F0BwBS9rdiOxI/gFM40WG
         rF15rpx7Cqi0UeaGWJepgU5JRP2jqZS1pJmSnVOoCN6KkIcibH5HxCu0B5kl5v1I63
         jrJanrjxDsPTNMOEon/L4iCcv6sP8yIZv24EubbgYvFKIyxa84kmZuf5Xu0rG41T/9
         55hL9vZrs1ezg==
Date:   Wed, 4 Jan 2023 11:33:42 +0000
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
Subject: Re: [PATCH v3 02/10] KEYS: Add missing function documentation
Message-ID: <Y7VkFqQ1He/RXY1N@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-3-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003401.4086781-3-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 13, 2022 at 07:33:53PM -0500, Eric Snowberg wrote:
> Compiling with 'W=1' results in warnings that 'Function parameter or member
> not described'
> 
> Add the missing parameters for
> restrict_link_by_builtin_and_secondary_trusted and
> restrict_link_to_builtin_trusted.
> 
> Use /* instead of /** for get_builtin_and_secondary_restriction, since
> it is a static function.
> 
> Fix wrong function name restrict_link_to_builtin_trusted brought by:
> commit d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  certs/system_keyring.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 5042cc54fa5e..e531b88bc570 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -33,7 +33,11 @@ extern __initconst const unsigned long system_certificate_list_size;
>  extern __initconst const unsigned long module_cert_size;
>  
>  /**
> - * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
> + * restrict_link_by_builtin_trusted - Restrict keyring addition by built in CA
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restriction_key: A ring of keys that can be used to vouch for the new cert.
>   *
>   * Restrict the addition of keys into a keyring based on the key-to-be-added
>   * being vouched for by a key in the built in system keyring.
> @@ -50,7 +54,11 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  /**
>   * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
> - *   addition by both builtin and secondary keyrings
> + *   addition by both builtin and secondary keyrings.
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restrict_key: A ring of keys that can be used to vouch for the new cert.
>   *
>   * Restrict the addition of keys into a keyring based on the key-to-be-added
>   * being vouched for by a key in either the built-in or the secondary system
> @@ -75,7 +83,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  					  secondary_trusted_keys);
>  }
>  
> -/**
> +/*
>   * Allocate a struct key_restriction for the "builtin and secondary trust"
>   * keyring. Only for use in system_trusted_keyring_init().
>   */
> -- 
> 2.27.0
> 

Should this have a fixes tag?

BR, Jarkko
