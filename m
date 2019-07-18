Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D966D759
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2019 01:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGRXpC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 19:45:02 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37490 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfGRXpB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 19:45:01 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8130672CA65;
        Fri, 19 Jul 2019 02:44:58 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 707A74A4A29;
        Fri, 19 Jul 2019 02:44:58 +0300 (MSK)
Date:   Fri, 19 Jul 2019 02:44:58 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] ima_evm_utils: erroneous "verification failed: 0
 (invalid padding)" message
Message-ID: <20190718234458.kknaqae2spbyvsu6@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <1563492600-23396-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563492600-23396-1-git-send-email-zohar@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

Ah. Excuse me basing my patches on v2. I never received v3 with your
changes, don't know why.

On Thu, Jul 18, 2019 at 07:30:00PM -0400, Mimi Zohar wrote:
> When public keys are specified on the boot command line (--key <public
> key file>, [<public key file>, ...]), the appropriate public key is used

Probably spaces should be removed in specification of `--key'.

> to verify EVM or file signatures.  If no keys are specified, the default
> x509_evm.der or x509_evm.pem file is used to verify the DIGSIG_VERSION_2

s/x509_evm.pem/pubkey_evm.pem/

> or DIGSIG_VERSION_1 signatures respectively, without first checking the
> keyids.  Instead of emitting a "verification failed: 0 (invalid
> padding)" message, an "unknown keyid" message would be clearer.
> 
> To address this problem, when no public keys are specified, this patch
> loads the x509_evm.der default public key onto the "public_keys" list,
> while the x509_evm.pem continues to be passed to verify_hash_v1()

And here.

Thanks,

> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog:
> - reverted most of the v3 changes, but kept the patch description and the
> cmd_verify_evm() change, in order to pick up Vitaly's patches.
> 
> 
>  src/evmctl.c    | 14 +++++++++++---
>  src/libimaevm.c | 17 +++++++----------
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 61808d276419..9e0926f10404 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -838,6 +838,11 @@ static int cmd_verify_evm(struct command *cmd)
>  		return -1;
>  	}
>  
> +	if (params.keyfile)	/* Support multiple public keys */
> +		init_public_keys(params.keyfile);
> +	else			/* assume read pubkey from x509 cert */
> +		init_public_keys("/etc/keys/x509_evm.der");
> +
>  	err = verify_evm(file);
>  	if (!err && params.verbose >= LOG_INFO)
>  		log_info("%s: verification is OK\n", file);
> @@ -879,8 +884,10 @@ static int cmd_verify_ima(struct command *cmd)
>  	char *file = g_argv[optind++];
>  	int err;
>  
> -	if (params.keyfile)
> +	if (params.keyfile)	/* Support multiple public keys */
>  		init_public_keys(params.keyfile);
> +	else			/* assume read pubkey from x509 cert */
> +		init_public_keys("/etc/keys/x509_evm.der");
>  
>  	errno = 0;
>  	if (!file) {
> @@ -1602,9 +1609,10 @@ static int ima_measurement(const char *file)
>  		return -1;
>  	}
>  
> -	/* Support multiple public keys */
> -	if (params.keyfile)
> +	if (params.keyfile)	/* Support multiple public keys */
>  		init_public_keys(params.keyfile);
> +	else			/* assume read pubkey from x509 cert */
> +		init_public_keys("/etc/keys/x509_evm.der");
>  
>  	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
>  		ima_extend_pcr(pcr[entry.header.pcr], entry.header.digest,
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index ae487f9fe36c..afd21051b09a 100644
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
> @@ -569,27 +572,21 @@ static int get_hash_algo_from_sig(unsigned char *sig)
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
> -		/* Read pubkey from x509 cert */
> -		x509 = 1;
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
