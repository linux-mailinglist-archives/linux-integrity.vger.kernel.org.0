Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBC6B6154
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 23:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCKWIq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 17:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCKWIp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 17:08:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40128D03;
        Sat, 11 Mar 2023 14:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44285B801C0;
        Sat, 11 Mar 2023 22:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94435C433EF;
        Sat, 11 Mar 2023 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678572520;
        bh=cvXfDDykxxfYGk46M0OkqXKmbkOI0nsIQUPWX8yb3+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RleDyoWNClDXmEcoLzMOqB0UGdNLxOxo2SKBsQW08qYkkWTVzqNJ+OiIFglUFR5C7
         GzI/d/HH21GYsGw/8T/lTnhI7DPgS0SVkzd+W594rg7CKO8Yvd++1YGuJJlbY/Mvo2
         uIQLUywKmjuqz4ys8nu1En4C5sD7GptOk3dZjldhw0nVoyhxl4X0H8mBlZqM+QWDhv
         0ymmkEB2Da/rTpt1JMKOaSD51ziDxfh0I4vlyYZCy4l4+GhjHTsJv6P7ATsUqVJLSR
         9iAPKynbWJBp+d1WvCQKm3WMMFEGDDmTNIGn7TR8P+F/8akmrGtllCIMM0M9krS8Y/
         +A54btyAbaZRA==
Date:   Sun, 12 Mar 2023 00:08:38 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 2/6] KEYS: Add missing function documentation
Message-ID: <ZAz75hRBDw9b+USq@kernel.org>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
 <20230302164652.83571-3-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302164652.83571-3-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 02, 2023 at 11:46:48AM -0500, Eric Snowberg wrote:
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
> Fix wrong function name restrict_link_to_builtin_trusted.
> 
> Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  certs/system_keyring.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 5042cc54fa5e..a7a49b17ceb1 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -33,7 +33,11 @@ extern __initconst const unsigned long system_certificate_list_size;
>  extern __initconst const unsigned long module_cert_size;
>  
>  /**
> - * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
> + * restrict_link_by_builtin_trusted - Restrict keyring addition by built-in CA
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
> + *   addition by both built-in and secondary keyrings.
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

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

BR, Jarkko
