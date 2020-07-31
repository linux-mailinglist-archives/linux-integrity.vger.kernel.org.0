Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7426F234889
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGaPda (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 11:33:30 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52706 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaPd3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 11:33:29 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id F327020B490A;
        Fri, 31 Jul 2020 08:33:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F327020B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596209609;
        bh=iBFtIdKfNW7WevJgMwXDlSozapPmGW/K7ITowg5CZkQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SZ00sryeVImHxj2Wt378fyG0n1h9X4J6A57Aj3HQOqUaTBQXB/4/+przd1Y/DUJWz
         uvlpMliYX7N4hUi3qV56RyK3eiUCtshw/KycpfgbM3qOzyQhsb1jPJc4LYjAquQvsI
         aCEZAPKINprd/M2K0/GHaujlNvrW/Ytb3Mtjvqeg=
Subject: Re: [ima-evm-utils: PATCH 3/3] Update the ima_boot_aggregate apsects
 of the "README" and "help" files
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
References: <20200731141432.668318-1-zohar@linux.ibm.com>
 <20200731141432.668318-4-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5db5cd79-87b6-45fe-769a-ca7db41e5cac@linux.microsoft.com>
Date:   Fri, 31 Jul 2020 08:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731141432.668318-4-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/31/20 7:14 AM, Mimi Zohar wrote:
> Add the missing "evmctl ima_boot_aggregate" info to the README.  Update
> the "help" to include the new "--pcrs" option.  In addition, replace
> the "file" option with "TPM 1.2 BIOS event log".  The new format is:
> 
> ima_boot_aggregate [--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]
> 
> Reminder: calculating the TPM PCRs based on the BIOS event log and
> comparing them with the TPM PCRs should be done prior to calculating the
> possible boot_aggregate value(s).
> 
> For TPM 1.2, the TPM 1.2 BIOS event log may be provided as an option
> when calculating the ima_boot_aggregate.  For TPM 2.0, "tsseventextend
> -sim -if <binary_bios_measurements> -ns -v", may be used to validate
> the TPM 2.0 event log.
> 
> (Note: some TPM 2.0's export the BIOS event log in the TPM 1.2 format.)
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   README       | 1 +
>   src/evmctl.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> diff --git a/README b/README
> index b37325f31802..321045d9d52b 100644
> --- a/README
> +++ b/README
> @@ -28,6 +28,7 @@ COMMANDS
>    import [--rsa] pubkey keyring
>    sign [-r] [--imahash | --imasig ] [--portable] [--key key] [--pass password] file
>    verify file
> + ima_boot_aggregate [--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]
>    ima_sign [--sigfile] [--key key] [--pass password] file
>    ima_verify file
>    ima_hash file
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7ad11507487f..de7299d41b2c 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2485,7 +2485,7 @@ struct command cmds[] = {
>   	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
>   	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
>   	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
> -	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
> +	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
>   	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
>   	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
>   	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
> 

