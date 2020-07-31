Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09293234880
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGaPb6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 11:31:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52504 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgGaPb5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 11:31:57 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 829CF20B4908;
        Fri, 31 Jul 2020 08:31:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 829CF20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596209516;
        bh=wKI4tm8BsHY8LYeEzv/nzvEug+Swe2w5CJ1UWlDHCno=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NKpKPieHgVtY3wwj/lhmo3Y53HXIXLrMJN42WNGRVySZHdhZkqRcdrRrPYoGaUvMB
         1ji1/zvvDhzC3JJnoW5Z3b2O4+zqNXuukBnvR+4bQLpK7kWEJQb6dzSi/asv+DMfg+
         mNxhTXDRNI4TBzhfQvQ5pyXPwh87wWw0YP424LZ4=
Subject: Re: [ima-evm-utils: PATCH 1/3] Drop the ima_measurement "--verify"
 option
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
References: <20200731141432.668318-1-zohar@linux.ibm.com>
 <20200731141432.668318-2-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <945ffd7c-f42f-2308-281c-19aa6b90983e@linux.microsoft.com>
Date:   Fri, 31 Jul 2020 08:31:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731141432.668318-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/31/20 7:14 AM, Mimi Zohar wrote:
> While walking the IMA measurement list re-calculating the PCRS,
> ima_measurement should always re-calculate the template data digest
> and verify it against the measurement list value.
> 
> This patch removes the "--verify" option.
> 
> On success, return 0.
> 
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   README       |  3 +--
>   src/evmctl.c | 23 ++++++++---------------
>   2 files changed, 9 insertions(+), 17 deletions(-)
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> diff --git a/README b/README
> index 73b38a1f35ba..d8b8f404534b 100644
> --- a/README
> +++ b/README
> @@ -31,7 +31,7 @@ COMMANDS
>    ima_sign [--sigfile] [--key key] [--pass password] file
>    ima_verify file
>    ima_hash file
> - ima_measurement [--validate] [--verify] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
> + ima_measurement [--validate] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
>    ima_fix [-t fdsxm] path
>    sign_hash [--key key] [--pass password]
>    hmac [--imahash | --imasig ] file
> @@ -61,7 +61,6 @@ OPTIONS
>         --engine e     preload OpenSSL engine e (such as: gost)
>         --pcrs         file containing TPM pcrs, one per hash-algorithm/bank
>         --validate     ignore ToMToU measurement violations
> -      --verify       verify the template data digest
>         --verify-sig   verify the file signature based on the file hash, both
>                        stored in the template data.
>     -v                 increase verbosity level
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 448e4a9c8d78..b4d2333fb880 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1393,7 +1393,6 @@ struct template_entry {
>   static uint8_t zero[MAX_DIGEST_SIZE];
>   
>   static int validate = 0;
> -static int verify = 0;
>   
>   static int ima_verify_template_hash(struct template_entry *entry)
>   {
> @@ -1945,7 +1944,7 @@ static int ima_measurement(const char *file)
>   
>   	struct template_entry entry = { .template = 0 };
>   	FILE *fp;
> -	int verified_template_digest = 0;
> +	int invalid_template_digest = 0;
>   	int err_padded = -1;
>   	int err = -1;
>   
> @@ -2075,11 +2074,9 @@ static int ima_measurement(const char *file)
>   				 pseudo_padded_banks);
>   
>   		/* Recalculate and verify template data digest */
> -		if (verify) {
> -			err = ima_verify_template_hash(&entry);
> -			if (err)
> -				verified_template_digest = 1;
> -		}
> +		err = ima_verify_template_hash(&entry);
> +		if (err)
> +			invalid_template_digest = 1;
>   
>   		if (is_ima_template)
>   			ima_show(&entry);
> @@ -2116,7 +2113,7 @@ static int ima_measurement(const char *file)
>   			log_info("Failed to match per TPM bank or SHA1 padded TPM digest(s).\n");
>   	}
>   
> -	if (verified_template_digest) {
> +	if (invalid_template_digest) {
>   		log_info("Failed to verify template data digest.\n");
>   		err = 1;
>   	}
> @@ -2486,7 +2483,7 @@ struct command cmds[] = {
>   	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
>   	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
>   	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
> -	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
> +	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
>   	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
>   	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
>   	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
> @@ -2526,8 +2523,7 @@ static struct option opts[] = {
>   	{"engine", 1, 0, 139},
>   	{"xattr-user", 0, 0, 140},
>   	{"validate", 0, 0, 141},
> -	{"verify", 0, 0, 142},
> -	{"pcrs", 1, 0, 143},
> +	{"pcrs", 1, 0, 142},
>   	{}
>   
>   };
> @@ -2709,10 +2705,7 @@ int main(int argc, char *argv[])
>   		case 141: /* --validate */
>   			validate = 1;
>   			break;
> -		case 142: /* --verify */
> -			verify = 1;
> -			break;
> -		case 143:
> +		case 142:
>   			if (npcrfile >= MAX_PCRFILE) {
>   				log_err("too many --pcrfile options\n");
>   				exit(1);
> 

