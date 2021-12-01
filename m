Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013524644FF
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 03:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbhLACle (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 21:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346222AbhLACl2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 21:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638326287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0n5k4sl9AYBphe6cujkRUTAtSAAGA+Ca8Fn1jgb3kw=;
        b=N3mzgk9UowmoT9bOELTegEg+modpoOEo2XRxoZTD2ZXoKI8rBY5ktzlsSp7cEDex0f4GM5
        PbSWp/f4WI7VrjtC8cbiIG/PUy4NLouem1PL0surhgLCqlVQxmJtyJR33k858Un97cROcV
        jgl/5eajJjl23AtbjXmW4lJNzUyD28c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-420-PtZgyoLZM6iWg_vjmPTmng-1; Tue, 30 Nov 2021 21:38:04 -0500
X-MC-Unique: PtZgyoLZM6iWg_vjmPTmng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 133C5102C7EB;
        Wed,  1 Dec 2021 02:37:59 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ADC560C13;
        Wed,  1 Dec 2021 02:37:50 +0000 (UTC)
Date:   Wed, 1 Dec 2021 10:37:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] KEXEC_SIG with appended signature
Message-ID: <20211201023747.GN21646@MiWiFi-R3L-srv>
References: <cover.1637862358.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 11/25/21 at 07:02pm, Michal Suchanek wrote:
> Hello,
> 
> This is resend of the KEXEC_SIG patchset.
> 
> The first patch is new because it'a a cleanup that does not require any
> change to the module verification code.
> 
> The second patch is the only one that is intended to change any
> functionality.
> 
> The rest only deduplicates code but I did not receive any review on that
> part so I don't know if it's desirable as implemented.

Do you have the link of your 1st version?

And after going through the whole series, it doesn't tell what this
patch series intends to do in cover-letter or patch log.

Thanks
Baoquan

> 
> The first two patches can be applied separately without the rest.
> 
> Thanks
> 
> Michal
> 
> Michal Suchanek (6):
>   s390/kexec_file: Don't opencode appended signature check.
>   powerpc/kexec_file: Add KEXEC_SIG support.
>   kexec_file: Don't opencode appended signature verification.
>   module: strip the signature marker in the verification function.
>   module: Use key_being_used_for for log messages in
>     verify_appended_signature
>   module: Move duplicate mod_check_sig users code to mod_parse_sig
> 
>  arch/powerpc/Kconfig                     | 11 +++++
>  arch/powerpc/kexec/elf_64.c              | 14 ++++++
>  arch/s390/kernel/machine_kexec_file.c    | 42 ++----------------
>  crypto/asymmetric_keys/asymmetric_type.c |  1 +
>  include/linux/module_signature.h         |  1 +
>  include/linux/verification.h             |  4 ++
>  kernel/module-internal.h                 |  2 -
>  kernel/module.c                          | 12 +++--
>  kernel/module_signature.c                | 56 +++++++++++++++++++++++-
>  kernel/module_signing.c                  | 33 +++++++-------
>  security/integrity/ima/ima_modsig.c      | 22 ++--------
>  11 files changed, 113 insertions(+), 85 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

