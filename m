Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E492528F72C
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 18:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgJOQwq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 12:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730137AbgJOQwm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 12:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602780760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwZ2RO/PthchT0q2HhH4BHmetPcJkEk1Sez5Pbqx4Lk=;
        b=OWcBkZbvm78BbCvKL/QNWSClPya62Oel1HrvJgpX1vmEfa83oZkSy126Uhen/YbPpTklsK
        uxAFad3VC3gHN99G6992V45P5+D4ce0k4Cbeeye6II7noNRGVae7ookIIBYSvg48Xsveu6
        b8Anll1xaJoPYSqWJrbfjhkCny/yXLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-OQB3MFcmNKKVut8qKvf4jQ-1; Thu, 15 Oct 2020 12:52:36 -0400
X-MC-Unique: OQB3MFcmNKKVut8qKvf4jQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C8DF835B74;
        Thu, 15 Oct 2020 16:52:34 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A51DD76649;
        Thu, 15 Oct 2020 16:52:30 +0000 (UTC)
Date:   Thu, 15 Oct 2020 12:52:29 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v2] dm verity: Add support for signature verification
 with 2nd keyring
Message-ID: <20201015165229.GA5513@redhat.com>
References: <20201015150504.1319098-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201015150504.1319098-1-mic@digikod.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 15 2020 at 11:05am -0400,
Mickaël Salaün <mic@digikod.net> wrote:

> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add a new configuration DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
> to enable dm-verity signatures to be verified against the secondary
> trusted keyring.  Instead of relying on the builtin trusted keyring
> (with hard-coded certificates), the second trusted keyring can include
> certificate authorities from the builtin trusted keyring and child
> certificates loaded at run time.  Using the secondary trusted keyring
> enables to use dm-verity disks (e.g. loop devices) signed by keys which
> did not exist at kernel build time, leveraging the certificate chain of
> trust model.  In practice, this makes it possible to update certificates
> without kernel update and reboot, aligning with module and kernel
> (kexec) signature verification which already use the secondary trusted
> keyring.
> 
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Milan Broz <gmazyland@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> ---
> 
> Previous version:
> https://lore.kernel.org/lkml/20201002071802.535023-1-mic@digikod.net/
> 
> Changes since v1:
> * Extend the commit message (asked by Jarkko Sakkinen).
> * Rename the Kconfig "help" keyword according to commit 84af7a6194e4
>   ("checkpatch: kconfig: prefer 'help' over '---help---'").

Can you please explain why you've decided to make this a Kconfig CONFIG
knob?  Why not either add: a dm-verity table argument? A dm-verity
kernel module parameter? or both (to allow a particular default but then
per-device override)?

Otherwise, _all_ DM verity devices will be configured to use secondary
keyring fallback.  Is that really desirable?

Regardless, I really don't see why a Kconfig knob is appropriate.

Mike


> ---
>  drivers/md/Kconfig                | 13 ++++++++++++-
>  drivers/md/dm-verity-verify-sig.c |  9 +++++++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 30ba3573626c..1d68935e45ef 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -530,11 +530,22 @@ config DM_VERITY_VERIFY_ROOTHASH_SIG
>  	bool "Verity data device root hash signature verification support"
>  	depends on DM_VERITY
>  	select SYSTEM_DATA_VERIFICATION
> -	  help
> +	help
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
> +	help
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
> base-commit: bbf5c979011a099af5dc76498918ed7df445635b
> -- 
> 2.28.0
> 

