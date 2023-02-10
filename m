Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A245F69174C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 04:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjBJDqM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Feb 2023 22:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjBJDqL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Feb 2023 22:46:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A355E5A;
        Thu,  9 Feb 2023 19:46:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A007A61C2C;
        Fri, 10 Feb 2023 03:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F6EC433EF;
        Fri, 10 Feb 2023 03:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676000769;
        bh=SdTCzJ5SE1wCc+dKpUCyb30OZnXseVrJzbdbPDI3zQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRp4xwgxfql92gzCSbtGbF/CtWcEoMqBUsP8NaEbxEUcjMnF4mn8hC4DXhRSXuBs/
         /YYmXWIQ3akhM3EPMt64l0Tv3Xnp750VKOGESXtsX55GpDc85xvHai5ZP/vLNWkLry
         MF0F9vPnvYGwLis+L1bDxQsA3N9pUZxAb3HRIu0DaRbOX/e2nnmYt2Vo/sMxO8blUW
         jTAR+vHfEXt3c2VLncGCtBbYiqY9yl3wBOiH/GZMz+iESZe94cUtsyWEF6rQGpdGEl
         RjqCeG2ert/ykC47aFzigrNvE7QTEGM79BiZMZlsCPgW6ptu3EtPdzIsmffe2WkXyk
         vjSRwxOgtdEAQ==
Date:   Fri, 10 Feb 2023 05:46:06 +0200
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
Subject: Re: [PATCH v4 3/6] KEYS: X.509: Parse Basic Constraints for CA
Message-ID: <Y+W9/rzzfWhidjCU@kernel.org>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-4-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207025958.974056-4-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 06, 2023 at 09:59:55PM -0500, Eric Snowberg wrote:
> Parse the X.509 Basic Constraints.  The basic constraints extension
> identifies whether the subject of the certificate is a CA.
> 
> BasicConstraints ::= SEQUENCE {
>         cA                      BOOLEAN DEFAULT FALSE,
>         pathLenConstraint       INTEGER (0..MAX) OPTIONAL }
> 
> If the CA is true, store it in the public_key.  This will be used
> in a follow on patch that requires knowing if the public key is a CA.
> 
> Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.9
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 22 ++++++++++++++++++++++
>  include/crypto/public_key.h               |  2 ++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 7a9b084e2043..77547d4bd94d 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -586,6 +586,28 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_basicConstraints) {
> +		/*
> +		 * Get hold of the basicConstraints
> +		 * v[1] is the encoding size
> +		 *	(Expect 0x2 or greater, making it 1 or more bytes)
> +		 * v[2] is the encoding type
> +		 *	(Expect an ASN1_BOOL for the CA)
> +		 * v[3] is the contents of the ASN1_BOOL
> +		 *      (Expect 1 if the CA is TRUE)
> +		 * vlen should match the entire extension size
> +		 */
> +		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
> +			return -EBADMSG;
> +		if (vlen < 2)
> +			return -EBADMSG;
> +		if (v[1] != vlen - 2)
> +			return -EBADMSG;
> +		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
> +			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_CA;
> +		return 0;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 6d61695e1cde..c401762850f2 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -28,6 +28,8 @@ struct public_key {
>  	bool key_is_private;
>  	const char *id_type;
>  	const char *pkey_algo;
> +	unsigned long key_eflags;	/* key extension flags */
> +#define KEY_EFLAG_CA		0	/* set if the CA basic constraints is set */
>  };
>  
>  extern void public_key_free(struct public_key *key);
> -- 
> 2.27.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
