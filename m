Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B016691737
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 04:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjBJDkI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Feb 2023 22:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBJDkI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Feb 2023 22:40:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8605D1FA;
        Thu,  9 Feb 2023 19:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88FA2B819FF;
        Fri, 10 Feb 2023 03:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F047DC433D2;
        Fri, 10 Feb 2023 03:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676000404;
        bh=PkQNZ61PThpabc8ucOGsHYTgTgK5ISaOZFUWRrwEHZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpockpxSM/VwYow3+mOPdFK+qGuJsHFHSIzx8IsINl1vq7+PPiORm14y2Geku4fCP
         rehsJ12bfEL25+KctJJeGFFS71CfvtF7WWGZ1YlvAgBXQhyFIR+Rq051R0L2hLgCJW
         8XbQ51H/agj8b8MgTNCT727QwES9rYzWFr3h68Yxli/k0eqYVEBvjkJotPm/1PZni9
         BlVESNo1ApIfALv0xKIEH4Ia2TJ7T/zpCpQos26kJRq47NnFsYpUlydt0LuRTVLwss
         DtuQa6zJUDqor45TbyrZVg06Z5X5KUX93bqqlb6cNT/EbXLlvl84USAil0LNoXL6wR
         WQvoaTHM/9LAQ==
Date:   Fri, 10 Feb 2023 05:40:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 2/6] KEYS: Add missing function documentation
Message-ID: <Y+W8ke7+Uiwd8yWC@kernel.org>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-3-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207025958.974056-3-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 06, 2023 at 09:59:54PM -0500, Eric Snowberg wrote:
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
