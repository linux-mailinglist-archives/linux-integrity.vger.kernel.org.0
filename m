Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE828865A
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbgJIJuE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 05:50:04 -0400
Received: from smtp-8faf.mail.infomaniak.ch ([83.166.143.175]:39463 "EHLO
        smtp-8faf.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgJIJuE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 05:50:04 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4C73G20ms8zlhJG2;
        Fri,  9 Oct 2020 11:50:02 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4C73G12Gytzllmh6;
        Fri,  9 Oct 2020 11:50:01 +0200 (CEST)
Subject: Re: [PATCH v1] dm verity: Add support for signature verification with
 2nd keyring
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201002071802.535023-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <bda2ffd7-3b7c-33a4-667f-a3435e112fc1@digikod.net>
Date:   Fri, 9 Oct 2020 11:50:03 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20201002071802.535023-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

What do you think about this patch?

Regards,
 Mickaël

On 02/10/2020 09:18, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add a new DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING configuration
> to enable dm-verity signatures to be verified against the secondary
> trusted keyring.  This allows certificate updates without kernel update
> and reboot, aligning with module and kernel (kexec) signature
> verifications.
> 
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Cc: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Milan Broz <gmazyland@gmail.com>
> ---
>  drivers/md/Kconfig                | 13 ++++++++++++-
>  drivers/md/dm-verity-verify-sig.c |  9 +++++++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 30ba3573626c..63870fdfe8ce 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -530,11 +530,22 @@ config DM_VERITY_VERIFY_ROOTHASH_SIG
>  	bool "Verity data device root hash signature verification support"
>  	depends on DM_VERITY
>  	select SYSTEM_DATA_VERIFICATION
> -	  help
> +	---help---
>  	  Add ability for dm-verity device to be validated if the
>  	  pre-generated tree of cryptographic checksums passed has a pkcs#7
>  	  signature file that can validate the roothash of the tree.
>  
> +	  By default, rely on the builtin trusted keyring.
> +
> +	  If unsure, say N.
> +
> +config DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
> +	bool "Verity data device root hash signature verification with secondary keyring"
> +	depends on DM_VERITY_VERIFY_ROOTHASH_SIG
> +	depends on SECONDARY_TRUSTED_KEYRING
> +	---help---
> +	  Rely on the secondary trusted keyring to verify dm-verity signatures.
> +
>  	  If unsure, say N.
>  
>  config DM_VERITY_FEC
> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
> index 614e43db93aa..29385dc470d5 100644
> --- a/drivers/md/dm-verity-verify-sig.c
> +++ b/drivers/md/dm-verity-verify-sig.c
> @@ -119,8 +119,13 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>  	}
>  
>  	ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
> -				sig_len, NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
> -				NULL, NULL);
> +				sig_len,
> +#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
> +				VERIFY_USE_SECONDARY_KEYRING,
> +#else
> +				NULL,
> +#endif
> +				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
>  
>  	return ret;
>  }
> 
