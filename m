Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7190646EA69
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 15:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbhLIPBW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 10:01:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhLIPBW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 10:01:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2EB09210FF;
        Thu,  9 Dec 2021 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639061867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7f6qRahiw5jhS0ShhXv7YNAlwGFAuEPvz02wcswTDY=;
        b=gPgeGBOqAj1w2/IfiYiUJZQKOR5J82A1Jcgx9IB9Lg4xy6yn6SJ5BFAlgLdbOLu1hHG7vE
        0panrH92CgFnCxooEeYXPRniRiGQzT2/9Wq8WzmBRRrKzV/iXa5gM6ei/5FlPbBPij83bp
        vqSVzkoMk5Lf/ek96wOP4gFIEnDAhro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639061867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7f6qRahiw5jhS0ShhXv7YNAlwGFAuEPvz02wcswTDY=;
        b=ifKqt7859hHQVpcEXofA567hptOij+KjdqlWOciBCOlO/gkAk2kGLrViK2ee2A72WKzrh7
        l33DkpGEwGJL82CQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 44CA3A3B95;
        Thu,  9 Dec 2021 14:57:45 +0000 (UTC)
Date:   Thu, 9 Dec 2021 15:57:44 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
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
Message-ID: <20211209145744.GQ117207@kunlun.suse.cz>
References: <cover.1637862358.git.msuchanek@suse.de>
 <b5e6ec36-a9ec-22f4-be58-28d48bdc38b4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5e6ec36-a9ec-22f4-be58-28d48bdc38b4@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

On Wed, Dec 08, 2021 at 08:50:54PM -0500, Nayna wrote:
> 
> On 11/25/21 13:02, Michal Suchanek wrote:
> > Hello,
> 
> Hi Michael,
> 
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
> 
> Patch 2 fails to apply on v5.16-rc4. Can you please also include git
> tree/branch while posting the patches ?

Sorry, I did not have a clean base and the Kconfig had another change.

Here is a tree with the changes applied:
https://github.com/hramrach/kernel/tree/kexec_sig

> 
> Secondly, I see that you add the powerpc support in Patch 2 and then modify
> it again in Patch 5 after cleanup. Why not add the support for powerpc after
> the clean up ? This will reduce some rework and also probably simplify
> patches.

That's because I don't know if the later patches will be accepted. By
queueing this patch first it can be applied standalone to ppc tree
without regard for the other patches. It's a copy of the s390 code so it
needs the same rework - not really adding complexity.

Thanks

Michal
