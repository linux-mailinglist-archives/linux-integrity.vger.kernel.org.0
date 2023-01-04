Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E588F65D19D
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjADLkf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 06:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjADLke (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 06:40:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212E15720;
        Wed,  4 Jan 2023 03:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40277B81629;
        Wed,  4 Jan 2023 11:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797A8C433F0;
        Wed,  4 Jan 2023 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672832430;
        bh=vRKu+cIxZMKIuSukDoVZ0+AyQBDrcAhZTW8SU8u5IXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZuUxZtdN+pmiaXVRY1xMyiGTc8jQrdxQGDKw1Cs6QPvuhp7t/gCp4gT/TCXaIguS
         csg+3+MMbYBHF2BnIaKv1R0p6aCQ1Dpjf28IsPFcomWcwVtqWNFJxf7Sd21oEkr2vc
         sUPxHr+dTsyseYGGYC/cfLainp76ljutHAJwfrIDU72Ua+1siCqJvlhGXnNtjdnKXN
         CgAn7kneuZYwBRNRBBzbHntXRY8rqd71F/aEbYgEo4A96fOl3Dfv5kXAY2eLjzzmjo
         95Q3WliLtqOIdh5iSUmFqmsnxO7SAKBoaKtv8GOdPDGNrmhLjeAzzYknq1QMDV5S3p
         CRbzhKSSLWzqw==
Date:   Wed, 4 Jan 2023 11:40:26 +0000
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
Subject: Re: [PATCH v3 03/10] KEYS: X.509: Parse Basic Constraints for CA
Message-ID: <Y7VlquGBj3qZe4Xk@kernel.org>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-4-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003401.4086781-4-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 13, 2022 at 07:33:54PM -0500, Eric Snowberg wrote:
> Parse the X.509 Basic Constraints.  The basic constraints extension
> identifies whether the subject of the certificate is a CA.
> 
> BasicConstraints ::= SEQUENCE {
>         cA                      BOOLEAN DEFAULT FALSE,
>         pathLenConstraint       INTEGER (0..MAX) OPTIONAL }
> 
> If the CA is true, store it in the x509_certificate.  This will be used
> in a follow on patch that requires knowing if the public key is a CA.

Please add:

Link: https://www.rfc-editor.org/rfc/rfc5280 # 4.2.1.9. Basic Constraints
 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
>  crypto/asymmetric_keys/x509_parser.h      | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 7a9b084e2043..b4443e507153 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -586,6 +586,15 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_basicConstraints) {
> +		if (vlen < 2 || v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
> +			return -EBADMSG;
> +		if (v[1] != vlen - 2)
> +			return -EBADMSG;

Why this instead of either:

1. Each check in separate if-statement.
2. All in a single statement:
   vlen < 2 || v[0] != (ASN1_CONS_BIT | ASN1_SEQ) || v[1] != vlen - 2

It would be also nice to have some sort of explanation in a comment, given
the cryptic statement and the amount of magic numbers in it. I.e. in plain
English what does the check actually means.


> +		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
> +			ctx->cert->root_ca = true;

Ditto for the explanation part. I have really hard time deciphering this.

> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> index a299c9c56f40..7c5c0ad1c22e 100644
> --- a/crypto/asymmetric_keys/x509_parser.h
> +++ b/crypto/asymmetric_keys/x509_parser.h
> @@ -38,6 +38,7 @@ struct x509_certificate {
>  	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
>  	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
>  	bool		blacklisted;
> +	bool		root_ca;		/* T if basic constraints CA is set */
>  };
>  
>  /*
> -- 
> 2.27.0
> 

BR, Jarkko
