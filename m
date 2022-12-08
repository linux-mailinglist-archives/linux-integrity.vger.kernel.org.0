Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E964688E
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Dec 2022 06:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLHFY1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Dec 2022 00:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLHFYA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Dec 2022 00:24:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B19A13EE;
        Wed,  7 Dec 2022 21:22:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A76A622BB0;
        Thu,  8 Dec 2022 05:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670476926;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACV4rT4gBkGjhfs+VCatmrCp7ZnekU2Vc70HRnY/zuM=;
        b=QPqvb/DpJi4JdY0ueKrbo4U+osPUnwv923TMjuzc5/SBMKsgYXO6z7hzG6qXl8xNmCCYoe
        SpcC5xDWfOKsuDjrzMZzhz/nGOMG65eOB6OdNSm25QdE+xnqtDyL79xyjRLJHO4V1xObLP
        e45h8hBsbKjqKUxshiCCUB1Fo98YfXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670476926;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACV4rT4gBkGjhfs+VCatmrCp7ZnekU2Vc70HRnY/zuM=;
        b=9EUifSzgee1fhYYRgFFhXzVDIy33OVwWogjvHi3jkvinZxR/u5/dXjUaljBdqaI2rKTIT7
        /8sp1dCLLlYQFPDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05BA013254;
        Thu,  8 Dec 2022 05:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id agBPAH50kWOLXwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 08 Dec 2022 05:22:06 +0000
Date:   Thu, 8 Dec 2022 06:22:04 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        noodles@fb.com, tiwai@suse.de, bp@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 02/10] KEYS: Add missing function documentation
Message-ID: <Y5F0fP0MH+LUod4f@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
 <20221207171238.2945307-3-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207171238.2945307-3-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

> Compiling with 'W=1' results in warnings that 'Function parameter or member
> not described'

> Add the missing parameters for
> restrict_link_by_builtin_and_secondary_trusted and
> restrict_link_to_builtin_trusted.

> Use /* instead of /** for get_builtin_and_secondary_restriction, since
> it is a static function.

> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  certs/system_keyring.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 5042cc54fa5e..250148298690 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -33,7 +33,11 @@ extern __initconst const unsigned long system_certificate_list_size;
>  extern __initconst const unsigned long module_cert_size;

>  /**
> - * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
> + * restrict_link_by_builtin_trusted - Restrict keyring addition by built in CA
Hm, wrong function name restrict_link_to_builtin_trusted brought by:
d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")

> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @restriction_key: A ring of keys that can be used to vouch for the new cert.
>   *
>   * Restrict the addition of keys into a keyring based on the key-to-be-added
>   * being vouched for by a key in the built in system keyring.
> @@ -51,6 +55,10 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
>  /**
>   * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
>   *   addition by both builtin and secondary keyrings
nit: missing dot at the end of the sentence (maybe can be fixed before merge).

Obviously correct.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

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

> -/**
> +/*
>   * Allocate a struct key_restriction for the "builtin and secondary trust"
>   * keyring. Only for use in system_trusted_keyring_init().
>   */
