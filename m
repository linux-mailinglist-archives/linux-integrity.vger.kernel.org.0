Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10946C067
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhLGQOV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 11:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239488AbhLGQON (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 11:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638893443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRuhMEvh5y04pVDZ1GcGtb8K0Y4SblDcdZyDgF/tcjA=;
        b=aSO3RQi1dU0B1BR0fVN/lY6ENtIMtq68gSTHZUNUDjFGdD7eKD1DVH7dMomYUvZsmiPrPz
        cK7/kQ5xFa0kaZhsZGMLYf7Pa2+3yZJWd8roe0VISoXCOXwQ/xDSn+zU3C8xEjx0Kaa74/
        XjJOs4iHYBTB2ejobx5G1nKwKSB8JEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-559-RhqUZOdDO7OBgmU9unhUqg-1; Tue, 07 Dec 2021 11:10:31 -0500
X-MC-Unique: RhqUZOdDO7OBgmU9unhUqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8693F801B25;
        Tue,  7 Dec 2021 16:10:25 +0000 (UTC)
Received: from rhtmp (unknown [10.39.192.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F3E25BE0C;
        Tue,  7 Dec 2021 16:10:17 +0000 (UTC)
Date:   Tue, 7 Dec 2021 17:10:14 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, kexec@lists.infradead.org,
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
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] KEXEC_SIG with appended signature
Message-ID: <20211207171014.2cfc4a54@rhtmp>
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
References: <cover.1637862358.git.msuchanek@suse.de>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michal,

i finally had the time to take a closer look at the series. Except for
the nit in patch 4 and my personal preference in patch 6 the code looks
good to me.

What I don't like are the commit messages on the first commits. In my
opinion they are so short that they are almost useless. For example in
patch 2 there is absolutely no explanation why you can simply copy the
s390 over to ppc. Or in patch 3 you are silently changing the error
code in kexec from EKEYREJECT to ENODATA. So I would appreciate it if
you could improve them a little.

Thanks
Philipp

On Thu, 25 Nov 2021 19:02:38 +0100
Michal Suchanek <msuchanek@suse.de> wrote:

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

