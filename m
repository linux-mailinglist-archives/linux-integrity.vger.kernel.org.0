Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0761E6B129
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 23:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfGPVh2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 17:37:28 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48440 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfGPVh2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 17:37:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D6A2772CA65;
        Wed, 17 Jul 2019 00:37:24 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id BA6794A4A29;
        Wed, 17 Jul 2019 00:37:24 +0300 (MSK)
Date:   Wed, 17 Jul 2019 00:37:24 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] ima_evm_utils: erroneous "verification failed: 0
 (invalid padding)" message
Message-ID: <20190716213724.bay6dt5sjwdpucmb@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 16, 2019 at 10:30:16AM -0400, Mimi Zohar wrote:
> When keys are not provided, the default key is used to verify the file
> signature, resulting in this erroneous message.  Before using the default
> key to verify the file signature, verify the keyid is correct.

1. What is default key when keys are not provided?
2. I don't see keyid verification in the patch.
3. Now we have so complicated keyfile handling.

> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  src/libimaevm.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index ae487f9fe36c..472ab53c7b42 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -302,6 +302,9 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
>  	X509 *crt = NULL;
>  	EVP_PKEY *pkey = NULL;
>  
> +	if (!keyfile)
> +		return NULL;
> +
>  	fp = fopen(keyfile, "r");
>  	if (!fp) {
>  		log_err("Failed to open keyfile: %s\n", keyfile);
> @@ -569,27 +572,25 @@ static int get_hash_algo_from_sig(unsigned char *sig)
>  int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig,
>  		int siglen)
>  {
> -	const char *key;
> -	int x509;
> +	const char *key = NULL;
>  	verify_hash_fn_t verify_hash;
>  
>  	/* Get signature type from sig header */
>  	if (sig[0] == DIGSIG_VERSION_1) {
>  		verify_hash = verify_hash_v1;
> +
>  		/* Read pubkey from RSA key */
> -		x509 = 0;
> +		if (!params.keyfile)
> +			key = "/etc/keys/pubkey_evm.pem";
>  	} else if (sig[0] == DIGSIG_VERSION_2) {
>  		verify_hash = verify_hash_v2;
> +
>  		/* Read pubkey from x509 cert */
> -		x509 = 1;
> +		if (!params.keyfile)
> +			init_public_keys("/etc/keys/x509_evm.der");

Also, in "ima-evm-utils: Preload public keys for ima_verify" I call
init_public_keys in cmd_verify_ima() which calls this verify_hash().

So there will be double calling of init_public_keys().

ps. Btw, I think we should remove this verify_hash_fn_t indirect call
trick and replace it with two normal calls in each if branch.

verify_hash() calling verify_hash() obscures cscope, and with direct
calls it will be easier to parse. I may send patch for this.

Thanks,


>  	} else
>  		return -1;
>  
> -	/* Determine what key to use for verification*/
> -	key = params.keyfile ? : x509 ?
> -			"/etc/keys/x509_evm.der" :
> -			"/etc/keys/pubkey_evm.pem";
> -
>  	return verify_hash(file, hash, size, sig, siglen, key);
>  }
>  
> -- 
> 2.7.5
