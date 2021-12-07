Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3446C1D2
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbhLGRf6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 12:35:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60796 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbhLGRf6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 12:35:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DF2B621B3A;
        Tue,  7 Dec 2021 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638898345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p08l+Qiu75dUbkbrDOZgOW1nBpHuW/LpB0uPvXqmigg=;
        b=cH4AxDh7Z5spAiCFuPHAKizEL1PsQcuD6sHy/nDy6g6DqJxWj6EKz9trYz9SGJPlcnDGb8
        9bDOPN4fQWIT+Snc356AncuT877BC9fLVRUEESgMaCpLUQ6mQ3DLrgvBE5l/VAwWgPb/Gd
        DydMC8itHDTzzR0LreU778OxrU87fbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638898345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p08l+Qiu75dUbkbrDOZgOW1nBpHuW/LpB0uPvXqmigg=;
        b=S/L+c98qLLuIOJFQUyXpN3vhB98AZn1gpW5qWmNanBuCQ6j06b/XWIz1noRFtgEfQIaB3q
        LER5Q9QzIbV0TYCA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 05243A3B83;
        Tue,  7 Dec 2021 17:32:23 +0000 (UTC)
Date:   Tue, 7 Dec 2021 18:32:21 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Philipp Rudo <prudo@redhat.com>
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
Message-ID: <20211207173221.GM117207@kunlun.suse.cz>
References: <cover.1637862358.git.msuchanek@suse.de>
 <20211207171014.2cfc4a54@rhtmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207171014.2cfc4a54@rhtmp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 07, 2021 at 05:10:14PM +0100, Philipp Rudo wrote:
> Hi Michal,
> 
> i finally had the time to take a closer look at the series. Except for
> the nit in patch 4 and my personal preference in patch 6 the code looks
> good to me.
> 
> What I don't like are the commit messages on the first commits. In my
> opinion they are so short that they are almost useless. For example in
> patch 2 there is absolutely no explanation why you can simply copy the
> s390 over to ppc.

They use the same signature format. I suppose I can add a note saying
that.

> Or in patch 3 you are silently changing the error
> code in kexec from EKEYREJECT to ENODATA. So I would appreciate it if

Not sure what I should do about this. The different implementations use
different random error codes, and when they are unified the error code
clearly changes for one or the other.

Does anything depend on a particular error code returned?

Thanks

Michal

> you could improve them a little.
> 
> Thanks
> Philipp
> 
> On Thu, 25 Nov 2021 19:02:38 +0100
> Michal Suchanek <msuchanek@suse.de> wrote:
> 
> > Hello,
> > 
> > This is resend of the KEXEC_SIG patchset.
> > 
> > The first patch is new because it'a a cleanup that does not require any
> > change to the module verification code.
> > 
> > The second patch is the only one that is intended to change any
> > functionality.
> > 
> > The rest only deduplicates code but I did not receive any review on that
> > part so I don't know if it's desirable as implemented.
> > 
> > The first two patches can be applied separately without the rest.
> > 
> > Thanks
> > 
> > Michal
> > 
> > Michal Suchanek (6):
> >   s390/kexec_file: Don't opencode appended signature check.
> >   powerpc/kexec_file: Add KEXEC_SIG support.
> >   kexec_file: Don't opencode appended signature verification.
> >   module: strip the signature marker in the verification function.
> >   module: Use key_being_used_for for log messages in
> >     verify_appended_signature
> >   module: Move duplicate mod_check_sig users code to mod_parse_sig
> > 
> >  arch/powerpc/Kconfig                     | 11 +++++
> >  arch/powerpc/kexec/elf_64.c              | 14 ++++++
> >  arch/s390/kernel/machine_kexec_file.c    | 42 ++----------------
> >  crypto/asymmetric_keys/asymmetric_type.c |  1 +
> >  include/linux/module_signature.h         |  1 +
> >  include/linux/verification.h             |  4 ++
> >  kernel/module-internal.h                 |  2 -
> >  kernel/module.c                          | 12 +++--
> >  kernel/module_signature.c                | 56 +++++++++++++++++++++++-
> >  kernel/module_signing.c                  | 33 +++++++-------
> >  security/integrity/ima/ima_modsig.c      | 22 ++--------
> >  11 files changed, 113 insertions(+), 85 deletions(-)
> > 
> 
