Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75232F0D3
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCERKh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:10:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhCERKZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:10:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1D3A64FEB;
        Fri,  5 Mar 2021 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964225;
        bh=ZbUmbeyViI1aMx0qhAABPe3bh24mZykWQNUrEnJQvRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFMrmOdZWLVVYyLiTC8XCJQpptaq1XTJ7Sw2NWIB4gxMCDcSYotRRzJgoQmvKdiKy
         Es76iGfgUWH7MPrEJtbWOYXW5kODDfVt5Ylga52cNYHZHcD7ULzGH/cHrQvVl4KmL+
         46hb2ZqKaA4G0jHyges85C8YfejjbAZqttU67yHHD0dPhZvTirVWKpNWKLCPlqLhio
         AhsWBsspngLLtF8BhLdub4uAtIqMmYUa/NCCF3A+q/YLOolEbdbc4368tHHtVh7mC/
         PHw8S/IoEwY8E1AprKIkr1x+ajUCl/bcs28ezI7IR6qPMn7gtB3elXjKk97oa90hLU
         5UwdWWGK39qCQ==
Date:   Fri, 5 Mar 2021 19:10:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 8/9] x509: Add OID for NIST P384 and extend parser
 for it
Message-ID: <YEJl7Q9jA0VLHpe9@kernel.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-9-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005203.3547587-9-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 07:52:02PM -0500, Stefan Berger wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> 
> * crypto/asymmetric_keys/x509_cert_parser.c
>   - prepare x509 parser to load nist_secp384r1
> 
> * include/linux/oid_registry.h
>   - add OID_id_secp384r1
> 
> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Yet another "diffstat".

/Jarkko

> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
>  include/linux/oid_registry.h              | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index f5d547c6dfb5..526c6a407e07 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -510,6 +510,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>  		case OID_id_prime256v1:
>  			ctx->cert->pub->pkey_algo = "ecdsa-nist-p256";
>  			break;
> +		case OID_id_secp384r1:
> +			ctx->cert->pub->pkey_algo = "ecdsa-nist-p384";
> +			break;
>  		default:
>  			return -ENOPKG;
>  		}
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index 3583908cf1ca..d656450dfc66 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -64,6 +64,7 @@ enum OID {
>  
>  	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
>  	OID_sha1,			/* 1.3.14.3.2.26 */
> +	OID_id_secp384r1,		/* 1.3.132.0.34 */
>  	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
>  	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
>  	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
> -- 
> 2.29.2
> 
> 
