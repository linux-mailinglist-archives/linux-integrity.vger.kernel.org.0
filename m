Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92838234EF2
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Aug 2020 02:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHAAqS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 20:46:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40104 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgHAAqS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 20:46:18 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 31A3D20B4908;
        Fri, 31 Jul 2020 17:46:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31A3D20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596242777;
        bh=aA7mEWGmpBQZdBj7Lt0beWjCZN6WSZotk2WxIijV3yU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ouIqUGbsUwdZJrWXIZkUX3HEdpkmla9ApU7vpWvkPxXogfW7VKpTZb75gIcIcqKxZ
         mRHLRmpKUYMiogw0fUQPH/kyXU37RInF1MGvFm9lvIW/YpSUFXfn1u4jm6wL2NcwwM
         2H1E9AvIR8DK6RY8C/CZL5sYXydEaPPtPRxsdzQg=
Subject: Re: [ima-evm-utils: PATCH 2/3] Rename "--validate" to
 "--ignore-violations"
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
References: <20200731141432.668318-1-zohar@linux.ibm.com>
 <20200731141432.668318-3-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5ada1cee-e2ae-5a7e-8cf3-a538a5037b29@linux.microsoft.com>
Date:   Fri, 31 Jul 2020 17:46:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731141432.668318-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/31/20 7:14 AM, Mimi Zohar wrote:
> IMA records file "Time of Measure, Time of Use (ToMToU)" and "open
> writers" integrity violations by adding a record to the measurement
> list containing one value (0x00's), but extending the TPM with a
> different value (0xFF's).
> 
> To avoid known file integrity violations, the builtin "tcb" measurement
> policy should be replaced with a custom policy as early as possible.
> This patch renames the existing "--validate" option to
> "--ignore-violations".
> 
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   README       |  4 ++--
>   src/evmctl.c | 13 +++++++------
>   2 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> 
> diff --git a/README b/README
> index d8b8f404534b..b37325f31802 100644
> --- a/README
> +++ b/README
> @@ -31,7 +31,7 @@ COMMANDS
>    ima_sign [--sigfile] [--key key] [--pass password] file
>    ima_verify file
>    ima_hash file
> - ima_measurement [--validate] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
> + ima_measurement [--ignore-violations] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
>    ima_fix [-t fdsxm] path
>    sign_hash [--key key] [--pass password]
>    hmac [--imahash | --imasig ] file
> @@ -60,7 +60,7 @@ OPTIONS
>         --m64          force EVM hmac/signature for 64 bit target system
>         --engine e     preload OpenSSL engine e (such as: gost)
>         --pcrs         file containing TPM pcrs, one per hash-algorithm/bank
> -      --validate     ignore ToMToU measurement violations
> +      --ignore-violations ignore ToMToU measurement violations
>         --verify-sig   verify the file signature based on the file hash, both
>                        stored in the template data.
>     -v                 increase verbosity level
> diff --git a/src/evmctl.c b/src/evmctl.c
> index b4d2333fb880..7ad11507487f 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1392,7 +1392,7 @@ struct template_entry {
>   
>   static uint8_t zero[MAX_DIGEST_SIZE];
>   
> -static int validate = 0;
> +static int ignore_violations = 0;
>   
>   static int ima_verify_template_hash(struct template_entry *entry)
>   {
> @@ -1739,7 +1739,7 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
>   		 * size.
>   		 */
>   		if (memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH) == 0) {
> -			if (!validate) {
> +			if (!ignore_violations) {
>   				memset(bank[i].digest, 0x00, bank[i].digest_size);
>   				memset(padded_bank[i].digest, 0x00, padded_bank[i].digest_size);
>   			} else {
> @@ -2467,6 +2467,7 @@ static void usage(void)
>   		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
>   		"      --verify-sig   verify measurement list signatures\n"
>   		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
> +		"      --ignore-violations ignore ToMToU measurement violations"
>   		"  -v                 increase verbosity level\n"
>   		"  -h, --help         display this help and exit\n"
>   		"\n");
> @@ -2483,7 +2484,7 @@ struct command cmds[] = {
>   	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
>   	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
>   	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
> -	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
> +	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
>   	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
>   	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
>   	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
> @@ -2522,7 +2523,7 @@ static struct option opts[] = {
>   	{"verify-sig", 0, 0, 138},
>   	{"engine", 1, 0, 139},
>   	{"xattr-user", 0, 0, 140},
> -	{"validate", 0, 0, 141},
> +	{"ignore-violations", 0, 0, 141},
>   	{"pcrs", 1, 0, 142},
>   	{}
>   
> @@ -2702,8 +2703,8 @@ int main(int argc, char *argv[])
>   			xattr_ima = "user.ima";
>   			xattr_evm = "user.evm";
>   			break;
> -		case 141: /* --validate */
> -			validate = 1;
> +		case 141: /* --ignore-violations */
> +			ignore_violations = 1;
>   			break;
>   		case 142:
>   			if (npcrfile >= MAX_PCRFILE) {
> 

