Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB8618B19
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKCWFi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 18:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKCWFh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 18:05:37 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38F7421E36
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 15:05:36 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0BB7372C983;
        Fri,  4 Nov 2022 01:05:35 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E0DD74A472A;
        Fri,  4 Nov 2022 01:05:34 +0300 (MSK)
Date:   Fri, 4 Nov 2022 01:05:31 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5 02/17] log and reset 'errno' after
 failure to open non-critical files
Message-ID: <20221103220531.ok6bwddhxmq6oxky@altlinux.org>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-3-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20221103183904.103562-3-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Nov 03, 2022 at 02:38:49PM -0400, Mimi Zohar wrote:
> Define a log_errno_reset macro to emit the errno string at or near the
> time of error, similar to the existing log_errno macro, but also reset
> errno to avoid dangling or duplicate errno messages on exit.
> 
> The initial usage is for non-critical file open failures.
> 
> Suggested-by: Vitaly Chikunov <vt@altlinux.org>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  src/evmctl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Vitaly Chikunov <vt@altlinux.org>

> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 0412bc0ac2b0..54123bf20f03 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -166,6 +166,9 @@ struct tpm_bank_info {
>  static char *pcrfile[MAX_PCRFILE];
>  static unsigned npcrfile;
>  
> +#define log_errno_reset(level, fmt, args...) \
> +	{do_log(level, fmt " (errno: %s)\n", ##args, strerror(errno)); errno = 0; }
> +
>  static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
>  {
>  	FILE *fp;
> @@ -1911,8 +1914,10 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
>  	fp = fopen(pcrs, "r");
>  	if (!fp)
>  		fp = fopen(misc_pcrs, "r");
> -	if (!fp)
> +	if (!fp) {
> +		log_errno_reset(LOG_DEBUG, "Failed to read TPM 1.2 PCRs");
>  		return -1;
> +	}
>  
>  	result = read_one_bank(&tpm_banks[0], fp);
>  	fclose(fp);
> @@ -2055,7 +2060,6 @@ static int ima_measurement(const char *file)
>  	int err_padded = -1;
>  	int err = -1;
>  
> -	errno = 0;
>  	memset(zero, 0, MAX_DIGEST_SIZE);
>  
>  	pseudo_padded_banks = init_tpm_banks(&num_banks);
> @@ -2072,6 +2076,8 @@ static int ima_measurement(const char *file)
>  		init_public_keys(imaevm_params.keyfile);
>  	else				/* assume read pubkey from x509 cert */
>  		init_public_keys("/etc/keys/x509_evm.der");
> +	if (errno)
> +		log_errno_reset(LOG_DEBUG, "Failed to initialize public keys");

Library prints appropriate error messages, so this is perhaps just to
clear errno. But it's not necessarily completely failed, but maybe
failure in one key. So I would say "Failure in initializing public
keys" to be precise.

ps.

BTW, init_public_keys API call cannot return error except by errno,
but it does not set it consistently so some errors may be missed.

init_public_keys loops calling read_pub_pkey

                entry->key = read_pub_pkey(keyfile, 1);
                if (!entry->key) {
                        free(entry);
                        continue;
                }

and read_pub_pkey have such code:

        if (!keyfile)
                return NULL;

In that case some key is not read but we don't get any error notification.

I think it's legal, by the right of being library, so set `errno =
EINVAL` there somewhere. But, I'm not sure where - as we should not
clobber existing errno values. Perhaps, errno setting should be added to
libimaevm consistently to all functions, but this is huge task, so I
would not suggest to do it now. Just suggestion for the future
developments, maybe.

Thanks,


>  
>  	/*
>  	 * Reading the PCRs before walking the IMA measurement list
> @@ -2746,6 +2752,8 @@ int main(int argc, char *argv[])
>  	unsigned long keyid;
>  	char *eptr;
>  
> +	errno = 0;	/* initialize global errno */
> +
>  #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>  	OPENSSL_init_crypto(
>  #ifndef DISABLE_OPENSSL_CONF
> -- 
> 2.31.1
