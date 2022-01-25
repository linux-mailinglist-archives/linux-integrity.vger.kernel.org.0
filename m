Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E349449BCCE
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 21:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiAYUQH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 15:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiAYUQA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 15:16:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F229C06173B;
        Tue, 25 Jan 2022 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IbFB6DTJJ4iMyawf6GaaHr11tjdCfEphnSRzGKo+FKs=; b=hiazood1qkVjV1i29ykJOnWMCG
        pdtGgjfRr96hOK0waryYHqV7CuQ/60g6frDloZA/2zMXXtSSQKnuSTghjdm71KfQj+e/sDTIZCFy3
        9J4RUJMLlw0WDKwiygF+M5IkUWO7f/G+k5Xdcb5vVJlyxSzHEWqFhleKyd5OJsv4RoQMiLKGVuufL
        bCa6XqV+LdXruqudaZhXBJCpikPUHa0HuJfLOSqtAj0qqKnz5Xr7nQGgFiNC+u1JgvdPXuR5lqruO
        Cz9ifdazAA6u/1kbSK6EbkCepDMfDq0vsfcCDZbup3nuIOB8WuAbcvUtjGhMHuzBNhACRfOpBdfOw
        qOUzk6lQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCSEO-009T8k-2u; Tue, 25 Jan 2022 20:15:56 +0000
Date:   Tue, 25 Jan 2022 12:15:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 3/6] kexec_file: Don't opencode appended signature
 verification.
Message-ID: <YfBafIXgnLzf0QMb@bombadil.infradead.org>
References: <cover.1641900831.git.msuchanek@suse.de>
 <7834eb187ef67cd88fc67f10e831130e3717d776.1641900831.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7834eb187ef67cd88fc67f10e831130e3717d776.1641900831.git.msuchanek@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 12:37:45PM +0100, Michal Suchanek wrote:
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index a655923335ae..32db9287a7b0 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -60,5 +60,8 @@ extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
>  				   enum key_being_used_for usage);
>  #endif
>  
> +int verify_appended_signature(const void *data, unsigned long *len,
> +			      struct key *trusted_keys, const char *what);
> +

Looks very non-module specific.

> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> index 8723ae70ea1f..30149969f21f 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module_signing.c
> @@ -14,32 +14,38 @@
>  #include <crypto/public_key.h>
>  #include "module-internal.h"
>  
> -/*
> - * Verify the signature on a module.
> +/**
> + * verify_appended_signature - Verify the signature on a module with the
> + * signature marker stripped.
> + * @data: The data to be verified
> + * @len: Size of @data.
> + * @trusted_keys: Keyring to use for verification
> + * @what: Informational string for log messages
>   */
> -int mod_verify_sig(const void *mod, struct load_info *info)
> +int verify_appended_signature(const void *data, unsigned long *len,
> +			      struct key *trusted_keys, const char *what)
>  {
> -	struct module_signature ms;
> -	size_t sig_len, modlen = info->len;
> +	struct module_signature *ms;

There goes the abstraction, so why not make this clear where we re-use
the struct module_signature for various things and call it as it is,
verify_mod_appended_signature() or some such?

David? Any preference?

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
