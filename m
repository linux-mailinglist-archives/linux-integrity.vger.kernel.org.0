Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DDF6B15D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfGPVtx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 17:49:53 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57504 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbfGPVtv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 17:49:51 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7032472CC64;
        Wed, 17 Jul 2019 00:49:49 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 44BCA4A4A29;
        Wed, 17 Jul 2019 00:49:49 +0300 (MSK)
Date:   Wed, 17 Jul 2019 00:49:49 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima_evm_utils: limit duplicate "Failed to open
 keyfile" messages
Message-ID: <20190716214948.6ycejuln6q376ngc@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
 <1563287417-31780-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563287417-31780-2-git-send-email-zohar@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 16, 2019 at 10:30:17AM -0400, Mimi Zohar wrote:
> Unlike the user provided list of public keys, we don't know which
> default public key file to use until verify_hash().  As a result, the
> "Failed to open keyfile" message may be repeated multiple times.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  src/libimaevm.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 472ab53c7b42..793643331f4b 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -296,18 +296,49 @@ err:
>  	return err;
>  }
>  
> +/*
> + * Keep track of missing keyfile names.
> + *
> + * Return 1 for found, return 0 for not found.
> + */
> +static int lookup_keyfile_name(const char *keyfile_name)
> +{
> +	struct keyfile_name_entry {
> +		struct keyfile_name_entry *next;
> +		char name[];
> +	} *entry;
> +	static struct keyfile_name_entry *keyfile_names = NULL;
> +
> +	for (entry = keyfile_names; entry != NULL; entry = entry->next) {
> +		if (strcmp(entry->name, keyfile_name) == 0)
> +			return 1;
> +	}
> +
> +	entry = malloc(sizeof(struct keyfile_name_entry) +
> +			strlen(keyfile_name) + 1);
> +	if (entry) {
> +		strcpy(entry->name, keyfile_name);
> +		entry->next = keyfile_names;
> +		keyfile_names = entry;
> +	}
> +	return 0;
> +}
> +
>  EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
>  {
>  	FILE *fp;
>  	X509 *crt = NULL;
>  	EVP_PKEY *pkey = NULL;
> +	int found;
>  
>  	if (!keyfile)
>  		return NULL;
>  
>  	fp = fopen(keyfile, "r");
>  	if (!fp) {
> -		log_err("Failed to open keyfile: %s\n", keyfile);
> +		found = lookup_keyfile_name(keyfile);
> +		if (!found)
> +			log_err("Failed to open keyfile: %s\n", keyfile);
>  		return NULL;


Now filename list is decoupled from keys themselves. Also we have key
list creation in init_public_keys(). Maybe we should just always call
init_public_keys for verify operations?

Thanks,

>  	}
>  
> -- 
> 2.7.5
