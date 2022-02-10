Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925154B197F
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Feb 2022 00:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345690AbiBJXae (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Feb 2022 18:30:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345643AbiBJXad (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Feb 2022 18:30:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399925F4E;
        Thu, 10 Feb 2022 15:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VDWZ1wyLkqnqT/23Ht0M/a/jxjSGdpdjwIwIjoTRRRI=; b=2qwKcjjD3mCCh/1mVgk1hdA+xC
        o2mTeS3P/3a/J49I96p9n7gshQPUYwIog5WvpAFPL31pFS8p2fRNxgmU8mEX5RoaNTgPuZnXMDfLZ
        JWZ1ZbigBEZevMhTDtYwDT28JH8nWX3HftkxCd5K7OmQ/7bRzk06Mhs+kn2Xh5QGjm6JwLn8Ik+Nn
        z4536VqIxXodC18gOtdY4kjUl8LClWDdhQxHTG+8VLLoqNd7ENE89lRlK/bMSBVTPJwoy+TnOd1Iq
        71uF/rfluUzxshhkFlCJzD8kq9rzIK5fF7MRS32xDLlMRMmy474AtN1n1zA+pqAb6gpeyqrHVfGv2
        iKoIQMYg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIItQ-005Awh-D2; Thu, 10 Feb 2022 23:30:28 +0000
Date:   Thu, 10 Feb 2022 15:30:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        David Howells <dhowells@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
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
Subject: Re: [PATCH v5 0/6] KEXEC_SIG with appended signature
Message-ID: <YgWgFMRdpLvBiht7@bombadil.infradead.org>
References: <cover.1641900831.git.msuchanek@suse.de>
 <YfBd/EDGUx9UIHcb@bombadil.infradead.org>
 <87pmnwlkaa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmnwlkaa.fsf@mpe.ellerman.id.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 09, 2022 at 03:46:05PM +1100, Michael Ellerman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> > On Tue, Jan 11, 2022 at 12:37:42PM +0100, Michal Suchanek wrote:
> >> Hello,
> >> 
> >> This is a refresh of the KEXEC_SIG series.
> >> 
> >> This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
> >> with appended signatures in the kernel.
> >> 
> >> powerpc supports IMA_KEXEC but that's an exception rather than the norm.
> >> On the other hand, KEXEC_SIG is portable across platforms.
> >> 
> >> For distributions to have uniform security features across platforms one
> >> option should be used on all platforms.
> >> 
> >> Thanks
> >> 
> >> Michal
> >> 
> >> Previous revision: https://lore.kernel.org/linuxppc-dev/cover.1637862358.git.msuchanek@suse.de/
> >> Patched kernel tree: https://github.com/hramrach/kernel/tree/kexec_sig
> >> 
> >> Michal Suchanek (6):
> >>   s390/kexec_file: Don't opencode appended signature check.
> >>   powerpc/kexec_file: Add KEXEC_SIG support.
> >>   kexec_file: Don't opencode appended signature verification.
> >>   module: strip the signature marker in the verification function.
> >>   module: Use key_being_used_for for log messages in
> >>     verify_appended_signature
> >>   module: Move duplicate mod_check_sig users code to mod_parse_sig
> >
> > What tree should this go through? I'd prefer if over through modules
> > tree as it can give a chance for Aaron Tomlin to work with this for his
> > code refactoring of kernel/module*.c to kernel/module/
> 
> Yeah that's fine by me, the arch changes are pretty minimal and unlikely
> to conflict much.

Ok sounds good thanks.

  Luis
