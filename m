Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE265D1B2
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 12:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjADLoE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 06:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjADLoD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 06:44:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BAA446;
        Wed,  4 Jan 2023 03:44:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE4F7B80E65;
        Wed,  4 Jan 2023 11:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C7C433EF;
        Wed,  4 Jan 2023 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672832639;
        bh=FtkrwQKPjIIQt23JL1N2L/B3ATEaO9C/KeRdtMfkWVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HN5AWRVJSrpcHcVcHjUWCvfocTPr2rDXdhKqmiImR4SXWZ9oayeIznJDbRdMUmo9s
         Ol8rvC2Jt7aj2Lk6o3Y7ygHh5qTky88VeXEtlgEgIRY11Zc54kv5YzCcgawvu3kvjc
         PcIo/KirUyZanXaX9mSCYkyAcaGbNnBeirZRyxMHslmIo8DqR8BM50x4HQhMpqidKc
         SsPGE5MQaqJ+5kRH80it/kwXck/uWI//y8oVC69oYyXKRWL9ARsgnTeg9YF6Wt5E5w
         gQ/qOQRNwNBQvDfKtOQxTKZpTQM4ZmZ8F/45r2QRaWUeUDKl6SRvadBO/2GFWDagHX
         F6+nJaSfT28SQ==
Date:   Wed, 4 Jan 2023 11:43:56 +0000
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
Subject: Re: [PATCH v3 04/10] KEYS: X.509: Parse Key Usage
Message-ID: <Y7VmfLUAacYOjn9y@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-5-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003401.4086781-5-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 13, 2022 at 07:33:55PM -0500, Eric Snowberg wrote:
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
> If the keyCertSign is set, store it in the x509_certificate structure.
> This will be used in a follow on patch that requires knowing the
> certificate key usage type.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 22 ++++++++++++++++++++++
>  crypto/asymmetric_keys/x509_parser.h      |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index b4443e507153..edb22cf04eed 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -579,6 +579,28 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_keyUsage) {
> +		/*
> +		 * Get hold of the keyUsage bit string to validate keyCertSign
> +		 * v[1] is the encoding size
> +		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
> +		 * v[2] is the number of unused bits in the bit string
> +		 *       (If >= 3 keyCertSign is missing)
> +		 * v[3] and possibly v[4] contain the bit string
> +		 * 0x04 is where KeyCertSign lands in this bit string (from
> +		 *      RFC 5280 4.2.1.3)
> +		 */
> +		if (v[0] != ASN1_BTS)
> +			return -EBADMSG;
> +		if (vlen < 4)
> +			return -EBADMSG;
> +		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
> +			ctx->cert->kcs_set = true;
> +		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
> +			ctx->cert->kcs_set = true;
> +		return 0;

This is much more easier to follow thanks to explanation.

> +	}
> +
>  	if (ctx->last_oid == OID_authorityKeyIdentifier) {
>  		/* Get hold of the CA key fingerprint */
>  		ctx->raw_akid = v;
> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> index 7c5c0ad1c22e..74a9f929e400 100644
> --- a/crypto/asymmetric_keys/x509_parser.h
> +++ b/crypto/asymmetric_keys/x509_parser.h
> @@ -39,6 +39,7 @@ struct x509_certificate {
>  	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
>  	bool		blacklisted;
>  	bool		root_ca;		/* T if basic constraints CA is set */
> +	bool		kcs_set;		/* T if keyCertSign is set */
>  };
>  
>  /*
> -- 
> 2.27.0
> 

LGTM but I'll hold with reviewed-by's up until the patch set overally
looks good to me and I have actually tested it.

BR, Jarkko
