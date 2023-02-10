Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA9691751
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 04:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBJDsX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Feb 2023 22:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBJDsW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Feb 2023 22:48:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36BF5D3EE;
        Thu,  9 Feb 2023 19:48:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EBB861C63;
        Fri, 10 Feb 2023 03:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8134CC433EF;
        Fri, 10 Feb 2023 03:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676000900;
        bh=MaSAZXV/No0UcjiEoj7F+YrE0sF6n9bZwMI1L9WNbnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zikd3dn2iPso54IY5J+qyhagDKwMEhpEdpwULPpgWF69WJiQ2iYpM6vCjsB0UqeT+
         GYnRzdKAMqLU9sUKlkqy4I6ca2dbY/xTk8kEaCQbGhBOZfVbsyyVTfsYVLHBdtLjMS
         1C7RkHgSEk0cravR4dznaAsQ6RBZ2rhxQNliOfbtWfiyQFaGjjbdm0d5Q0Eh5+ekYk
         dYSeBqDHEaL3C5ZHt3RBbIQ1BbP3iEIlUwgCWS0s1uQ1BQ6W4yWlbdFvXd7RtN20Wn
         jy8PGZW8cQyLCAO6DETLtEPDjCwTYQ2BwnI2qapIbhx/jXvvGVJ2CJC9IyildPIjxl
         Sd1FahUAlEl+w==
Date:   Fri, 10 Feb 2023 05:48:18 +0200
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
Subject: Re: [PATCH v4 4/6] KEYS: X.509: Parse Key Usage
Message-ID: <Y+W+glb35hn9AS7H@kernel.org>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-5-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207025958.974056-5-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 06, 2023 at 09:59:56PM -0500, Eric Snowberg wrote:
> Parse the X.509 Key Usage.  The key usage extension defines the purpose of
> the key contained in the certificate.
> 
>    id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }
> 
>       KeyUsage ::= BIT STRING {
>            digitalSignature        (0),
>            contentCommitment       (1),
>            keyEncipherment         (2),
>            dataEncipherment        (3),
>            keyAgreement            (4),
>            keyCertSign             (5),
>            cRLSign                 (6),
>            encipherOnly            (7),
>            decipherOnly            (8) }
> 
> If the keyCertSign or digitalSignature is set, store it in the
> public_key structure.  This will be used in a follow on patch that
> requires knowing the certificate key usage type.

It would be better to shortly explain why we want to know key usage
type, rather than give zero information with "follow on patch".

> 
> Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 28 +++++++++++++++++++++++
>  include/crypto/public_key.h               |  2 ++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 77547d4bd94d..0a7049b470c1 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -579,6 +579,34 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_keyUsage) {
> +		/*
> +		 * Get hold of the keyUsage bit string
> +		 * v[1] is the encoding size
> +		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
> +		 * v[2] is the number of unused bits in the bit string
> +		 *       (If >= 3 keyCertSign is missing when v[1] = 0x02)
> +		 * v[3] and possibly v[4] contain the bit string
> +		 *
> +		 * From RFC 5280 4.2.1.3:
> +		 *   0x04 is where keyCertSign lands in this bit string
> +		 *   0x80 is where digitalSignature lands in this bit string
> +		 */
> +		if (v[0] != ASN1_BTS)
> +			return -EBADMSG;
> +		if (vlen < 4)
> +			return -EBADMSG;
> +		if (v[2] >= 8)
> +			return -EBADMSG;
> +		if (v[3] & 0x80)
> +			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_DIGITALSIG;
> +		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
> +			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_KEYCERTSIGN;
> +		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
> +			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_KEYCERTSIGN;
> +		return 0;
> +	}
> +
>  	if (ctx->last_oid == OID_authorityKeyIdentifier) {
>  		/* Get hold of the CA key fingerprint */
>  		ctx->raw_akid = v;
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index c401762850f2..03c3fb990d59 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -30,6 +30,8 @@ struct public_key {
>  	const char *pkey_algo;
>  	unsigned long key_eflags;	/* key extension flags */
>  #define KEY_EFLAG_CA		0	/* set if the CA basic constraints is set */
> +#define KEY_EFLAG_DIGITALSIG	1	/* set if the digitalSignature usage is set */
> +#define KEY_EFLAG_KEYCERTSIGN	2	/* set if the keyCertSign usage is set */
>  };
>  
>  extern void public_key_free(struct public_key *key);
> -- 
> 2.27.0
> 

BR, Jarkko
