Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ECC49BC7A
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiAYTus (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 14:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiAYTuq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 14:50:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE82C061744;
        Tue, 25 Jan 2022 11:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XnOpHOntQOg5wjymzDOHXiPanYFDFvY26sbX++O0fnA=; b=VELGeg2hS4JKT8txctMPaShzdT
        ZaTFITxIlYbm2Uj12Qxez0OYx7e1MYq2UoZXodMrCxvGeygRgn7gKfoteE1diO3iyBZJ8KUdAXnkd
        eVAkqTeoOFrGj3sLsiX9+iWSotgN5NABPqUvVZLsX7KpOqjNgZ/+r6lfu3muAyMmARu6UsZ4kKGJk
        IUwfX9k2+58not7Pl+Jj6UBm1ZuLWYel2TbXXc/qQqvVDrr1tJEXuVK2i/LQlI0eoA+KQtMZLL+rc
        82XvPYvLKUvHncE/yTFMR8MgTBVyT8p5PPrgBmYj2GxjTIvZFopD3jmNjkMNdUZk2hHBKLycT/68x
        dZlX6Vag==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCRpw-009QFo-M3; Tue, 25 Jan 2022 19:50:40 +0000
Date:   Tue, 25 Jan 2022 11:50:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
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
Subject: Re: [PATCH v4 1/6] s390/kexec_file: Don't opencode appended
 signature check.
Message-ID: <YfBUkIlvQc0U0ylo@bombadil.infradead.org>
References: <cover.1641822505.git.msuchanek@suse.de>
 <940cd6a0e88793060cdf5ddb7880c03564b38bdd.1641822505.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <940cd6a0e88793060cdf5ddb7880c03564b38bdd.1641822505.git.msuchanek@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 10, 2022 at 02:49:53PM +0100, Michal Suchanek wrote:
> Module verification already implements appeded signature check.
> 
> Reuse it for kexec_file.
> 
> The kexec_file implementation uses EKEYREJECTED error in some cases when
> there is no key and the common implementation uses ENOPKG or EBADMSG
> instead.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
> v3: Philipp Rudo <prudo@redhat.com>: Update the commit with note about
> change of return value
> ---
>  arch/s390/kernel/machine_kexec_file.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8f43575a4dd3..c944d71316c7 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
>  	struct module_signature *ms;
>  	unsigned long sig_len;
> +	int ret;
>  
>  	/* Skip signature verification when not secure IPLed. */
>  	if (!ipl_secure_flag)
> @@ -45,25 +46,12 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	kernel_len -= marker_len;
>  
>  	ms = (void *)kernel + kernel_len - sizeof(*ms);
> -	kernel_len -= sizeof(*ms);
> +	ret = mod_check_sig(ms, kernel_len, "kexec");
> +	if (ret)
> +		return ret;
>  
>  	sig_len = be32_to_cpu(ms->sig_len);
> -	if (sig_len >= kernel_len)
> -		return -EKEYREJECTED;

There is a small minor fix here, where by using mod_check_sig() now
decreased the kernel_len by the sizeof(*ms). It is minor though.

> -	kernel_len -= sig_len;
> -
> -	if (ms->id_type != PKEY_ID_PKCS7)
> -		return -EKEYREJECTED;

More importantly is the return value used here changes but given the
Ack by Heiko I suspect this if fine and does not break old userspace,
the only change here is the possible error value returned by the
kexec_file_load() system call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

   Luis
