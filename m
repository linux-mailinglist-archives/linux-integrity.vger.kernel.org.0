Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66433A015
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Mar 2021 19:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhCMSy1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Mar 2021 13:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234010AbhCMSyB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Mar 2021 13:54:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B6A864E54;
        Sat, 13 Mar 2021 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615661640;
        bh=dtTTV+VVbKloOkZi/YJoe4WeJyqRG9Bw5zr3PMuCf2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZKVF2ZTvqaXPVO9xoRKUDha4Q9Fa8/b+TFPAaJZrOKHKK4iclg77Dw4PO/cogJrl
         /VfWLz7xGjCe2AXfWj3sySxd8mGAj7PP7ctGTq9nBOzI8pPDlzAOd4i0Y+yqDflLKg
         d99e+UEezv72vzIOKNzzp74JnTGA7MgEOLhQ6KfOTeTaeFMdzqpUb7y3wDxENTSNZ9
         aYVyP1titZNsGoDxY42JQg59EGkPxChohkL2riQtMZ70gnOLqc99uTXNozirs6jtwf
         ND+1OgU/SRCpU24nWV3MDJqWxQlnSeF9QWZXBbLDARm8rHvam5FL2QOU1qZ0NUq9+N
         XgObzYwYt9Abg==
Date:   Sat, 13 Mar 2021 20:53:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 2/5] certs: Check that builtin blacklist hashes are
 valid
Message-ID: <YE0KMGjI+L6elHF2@kernel.org>
References: <20210312171232.2681989-1-mic@digikod.net>
 <20210312171232.2681989-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312171232.2681989-3-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 12, 2021 at 06:12:29PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add and use a check-blacklist-hashes.awk script to make sure that the
> builtin blacklist hashes set with CONFIG_SYSTEM_BLACKLIST_HASH_LIST will
> effectively be taken into account as blacklisted hashes.  This is useful
> to debug invalid hash formats, and it make sure that previous hashes
> which could have been loaded in the kernel, but silently ignored, are
> now noticed and deal with by the user at kernel build time.
> 
> This also prevent stricter blacklist key description checking (provided
> by following commits) to failed for builtin hashes.
> 
> Update CONFIG_SYSTEM_BLACKLIST_HASH_LIST help to explain the content of
> a hash string and how to generate certificate ones.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Snowberg <eric.snowberg@oracle.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210312171232.2681989-3-mic@digikod.net


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
> 
> Changes since v5:
> * Rebase on keys-next and fix conflict as previously done by David
>   Howells.
> * Enable to use a file path relative to the kernel source directory.
>   This align with the handling of CONFIG_SYSTEM_TRUSTED_KEYS,
>   CONFIG_MODULE_SIG_KEY and CONFIG_SYSTEM_REVOCATION_KEYS.
> 
> Changes since v3:
> * Improve commit description.
> * Update CONFIG_SYSTEM_BLACKLIST_HASH_LIST help.
> * Remove Acked-by Jarkko Sakkinen because of the above changes.
> 
> Changes since v2:
> * Add Jarkko's Acked-by.
> 
> Changes since v1:
> * Prefix script path with $(scrtree)/ (suggested by David Howells).
> * Fix hexadecimal number check.
> ---
>  MAINTAINERS                        |  1 +
>  certs/.gitignore                   |  1 +
>  certs/Kconfig                      |  7 ++++--
>  certs/Makefile                     | 17 +++++++++++++-
>  scripts/check-blacklist-hashes.awk | 37 ++++++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/check-blacklist-hashes.awk
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 773a362e807f..a18fd3d283c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4118,6 +4118,7 @@ L:	keyrings@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/admin-guide/module-signing.rst
>  F:	certs/
> +F:	scripts/check-blacklist-hashes.awk
>  F:	scripts/extract-cert.c
>  F:	scripts/sign-file.c
>  F:	tools/certs/
> diff --git a/certs/.gitignore b/certs/.gitignore
> index 2a2483990686..42cc2ac24b93 100644
> --- a/certs/.gitignore
> +++ b/certs/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +blacklist_hashes_checked
>  x509_certificate_list
> diff --git a/certs/Kconfig b/certs/Kconfig
> index ab88d2a7f3c7..cf3740c1b22b 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -80,8 +80,11 @@ config SYSTEM_BLACKLIST_HASH_LIST
>  	help
>  	  If set, this option should be the filename of a list of hashes in the
>  	  form "<hash>", "<hash>", ... .  This will be included into a C
> -	  wrapper to incorporate the list into the kernel.  Each <hash> should
> -	  be a string of hex digits.
> +	  wrapper to incorporate the list into the kernel.  Each <hash> must be a
> +	  string starting with a prefix ("tbs" or "bin"), then a colon (":"), and
> +	  finally an even number of hexadecimal lowercase characters (up to 128).
> +	  Certificate hashes can be generated with
> +	  tools/certs/print-cert-tbs-hash.sh .
>  
>  config SYSTEM_REVOCATION_LIST
>  	bool "Provide system-wide ring of revocation certificates"
> diff --git a/certs/Makefile b/certs/Makefile
> index b6db52ebf0be..61e82b8eacd2 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -7,7 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o c
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
>  obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
>  ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
> +
> +quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
> +      cmd_check_blacklist_hashes = $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(2); touch $@
> +
> +$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
> +
> +$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
> +
> +CFLAGS_blacklist_hashes.o += -I$(srctree)
> +
> +targets += blacklist_hashes_checked
> +$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
> +	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> +
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
> +
>  else
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>  endif
> @@ -30,7 +45,7 @@ $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREF
>  	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
>  endif # CONFIG_SYSTEM_TRUSTED_KEYRING
>  
> -clean-files := x509_certificate_list .x509.list x509_revocation_list
> +clean-files := x509_certificate_list .x509.list x509_revocation_list blacklist_hashes_checked
>  
>  ifeq ($(CONFIG_MODULE_SIG),y)
>  ###############################################################################
> diff --git a/scripts/check-blacklist-hashes.awk b/scripts/check-blacklist-hashes.awk
> new file mode 100755
> index 000000000000..107c1d3204d4
> --- /dev/null
> +++ b/scripts/check-blacklist-hashes.awk
> @@ -0,0 +1,37 @@
> +#!/usr/bin/awk -f
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright © 2020, Microsoft Corporation. All rights reserved.
> +#
> +# Author: Mickaël Salaün <mic@linux.microsoft.com>
> +#
> +# Check that a CONFIG_SYSTEM_BLACKLIST_HASH_LIST file contains a valid array of
> +# hash strings.  Such string must start with a prefix ("tbs" or "bin"), then a
> +# colon (":"), and finally an even number of hexadecimal lowercase characters
> +# (up to 128).
> +
> +BEGIN {
> +	RS = ","
> +}
> +{
> +	if (!match($0, "^[ \t\n\r]*\"([^\"]*)\"[ \t\n\r]*$", part1)) {
> +		print "Not a string (item " NR "):", $0;
> +		exit 1;
> +	}
> +	if (!match(part1[1], "^(tbs|bin):(.*)$", part2)) {
> +		print "Unknown prefix (item " NR "):", part1[1];
> +		exit 1;
> +	}
> +	if (!match(part2[2], "^([0-9a-f]+)$", part3)) {
> +		print "Not a lowercase hexadecimal string (item " NR "):", part2[2];
> +		exit 1;
> +	}
> +	if (length(part3[1]) > 128) {
> +		print "Hash string too long (item " NR "):", part3[1];
> +		exit 1;
> +	}
> +	if (length(part3[1]) % 2 == 1) {
> +		print "Not an even number of hexadecimal characters (item " NR "):", part3[1];
> +		exit 1;
> +	}
> +}
> -- 
> 2.30.2
> 
> 
