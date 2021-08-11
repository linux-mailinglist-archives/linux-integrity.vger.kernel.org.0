Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF40D3E9B66
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 01:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhHKXxu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 19:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232704AbhHKXxu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 19:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628726005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPg2mPCrG5eiYWHzAPF6g3XmZSOjCvY2z9TrWWe5t/A=;
        b=cIhS3Q9IsIS2uE9bL8dbQP3UfV/3UlOoJ6FzfUQTC9AwG6jkHDxE+OW5oXAZ0CXBLUi7d2
        wKWZ4P6gK5oktxYT498EzSh2Szic6JEg1KXAE0CzPCuuW2pN0eztLhJht/28m2srR8yJLq
        WXhraIR1tL6ZhnUHRDTQ01PsQiSIsuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-z19s7aj5OQWt6nhmsQ0Z3w-1; Wed, 11 Aug 2021 19:53:23 -0400
X-MC-Unique: z19s7aj5OQWt6nhmsQ0Z3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 978991008060;
        Wed, 11 Aug 2021 23:53:22 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B067620DE;
        Wed, 11 Aug 2021 23:53:17 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>
Cc:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v7 0/5] IMA: restrict the accepted digest algorithms for the security.ima xattr
Date:   Wed, 11 Aug 2021 19:53:15 -0400
Message-ID: <2072391.irdbgypaU6@x2>
Organization: Red Hat
In-Reply-To: <f06d6b278bf228d21bf3ec01da8173e6518557f9.camel@linux.ibm.com>
References: <20210811114037.201887-1-simon.thoby@viveris.fr> <f06d6b278bf228d21bf3ec01da8173e6518557f9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

On Wednesday, August 11, 2021 3:40:51 PM EDT Mimi Zohar wrote:
> On Wed, 2021-08-11 at 11:40 +0000, THOBY Simon wrote:
> Other than the two questions on " IMA: add a policy option to restrict
> xattr hash algorithms on appraisal" patch, the patch set is looking
> good.
> 
> thanks,
> 
> Mimi
> 
> > Here is also a short description of the new audit messages, but I can
> > send it in a followup mail if that is not the proper place:
> > 
> > When writing the xattr with an algorithm not built in the kernel (here
> > the
> > kernel was built with CONFIG_CRYPTO_MD5 unset), e.g. with
> > 
> > "evmctl ima_hash -a md5 /usr/bin/strace":
> > 	audit(1628066120.418:121): pid=1344 uid=0 auid=0 ses=1
> > 	subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=set_data
> > 	cause=unavailable-hash-algorithm comm="evmctl" name="/usr/bin/strace"
> > 	dev="dm-0" ino=2632657 res=0 errno=0> 

Is this audit event accurate? I seem to be seeing name=value=value. I'm 
hoping this is a copy/paste/mail client issue.

-Steve


> > With the same command and the policy rule
> > 
> > "appraise func=SETXATTR_CHECK appraise_algos=sha256,sha384,sha512", we 
get:
> > 	audit(1628066210.141:127): pid=1362 uid=0 auid=0 ses=1
> > 	subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=set_data
> > 	cause=denied-hash-algorithm comm="evmctl" name="/usr/bin/strace"
> > 	dev="dm-0" ino=2632657 res=0 errno=0> 
> > Note that the cause is now 'denied-hash-algorithm' instead of
> > 'unavailable-hash-algorithm'. We get that audit message for any algorithm
> > outside of sha256/384/512 (including algorithms not compiled in the
> > kernel
> > like MD5). In a sense, 'denied-hash-algorithm' takes predecence over
> > 'unavailable-hash-algorithm'.
> > 
> > When appraising files, e.g. trying to execute a file whose xattr was
> > hashed with sha1 while the policy rule
> > 
> > "appraise func=BPRM_CHECK fowner=0 appraise_algos=sha256" is enabled:
> > 	audit(1628066349.230:130): pid=1369 uid=0 auid=0 ses=1
> > 	subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > 	op=collect_data cause=denied-hash-algorithm comm="bash"
> > 	name="/usr/bin/strace" dev="dm-0" ino=2632657 res=0 errno=0> 
> > This series is based on the following repo/branch:
> >  repo:
> >  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.g
> >  it branch: next-integrity-testing
> >  commit e37be5343ae2b9419aea1442b07e5d2428b437b4 ("Merge branch
> >  'ima-buffer-measurement-changes-v4' into next-integrity")
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit




