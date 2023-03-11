Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1D6B615B
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 23:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCKWJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 17:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCKWJ0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 17:09:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DD2C657;
        Sat, 11 Mar 2023 14:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEBCDB80A4C;
        Sat, 11 Mar 2023 22:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE68C433D2;
        Sat, 11 Mar 2023 22:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678572562;
        bh=NgiWMNJtkUzRU0XTwb1NsTnqkVQlYUjvRD15pzpC4s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWCGY0D1/Eo0cUanlTMdyhEM54kgkwQT/LLlSgElasmgDyPTEC2r8NovdlA+Wqg9A
         0nygExiSACkdi1bEYXwXvMryoLjOF+iDT3VUGnldO6jRAdm2sQBE2Lzq6sw+bH5jux
         IufqCSCe2VcBoTegQMMe8+t2uWYzPJc+1ARt5QtIlKkK2ITpOiI/BmX0s5RJepng80
         8DViZM5EJNY0KfZ2/UhGcoWaVGZSy0wH82DXiAfaLCbEOo5dSR3dsJlrzu4em2sJiB
         lTQAXLZ1T3ENrDl2MIGJEPvE4pbuf/YeGRg04VXtMknckD5MRb/9SfnUQftrZkhqdj
         5Mi/qzrb6p6NQ==
Date:   Sun, 12 Mar 2023 00:09:19 +0200
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
Subject: Re: [PATCH v5 4/6] KEYS: X.509: Parse Key Usage
Message-ID: <ZAz8DztGzR/W+VWL@kernel.org>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
 <20230302164652.83571-5-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302164652.83571-5-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 02, 2023 at 11:46:50AM -0500, Eric Snowberg wrote:
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
> public_key structure. Having the purpose of the key being stored
> during parsing, allows enforcement on the usage field in the future.
> This will be used in a follow on patch that requires knowing the
> certificate key usage type.
> 
> Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
