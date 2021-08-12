Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B253E9B8C
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhHLASa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 20:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhHLAS3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 20:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628727484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eT5LFi20fqGWZ9/oJgp9ntXEKmIPfE+Msk29wwhWKk=;
        b=AgURI4STtzvCnn237W5wKg3BPwrXaHdUr86YAplc63+etvlc5tidtdn92/aTyTZsSX6+Rd
        /lnzmxSJEGXFG7FSmeDxMYxyrybM6TarmKhkdPW1UtWnaSiZTW+3fJVUFOWEs7y+6qrxzD
        7V9ixmQ8pUU9XU7dIbz2Zld1ctHZ6O0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-MZsQ6B3JMNe-J8r6FUFb1Q-1; Wed, 11 Aug 2021 20:18:03 -0400
X-MC-Unique: MZsQ6B3JMNe-J8r6FUFb1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0A388042CF;
        Thu, 12 Aug 2021 00:18:01 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 080395D9C6;
        Thu, 12 Aug 2021 00:17:56 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>
Cc:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v7 0/5] IMA: restrict the accepted digest algorithms for the security.ima xattr
Date:   Wed, 11 Aug 2021 20:17:54 -0400
Message-ID: <3123021.aeNJFYEL58@x2>
Organization: Red Hat
In-Reply-To: <2072391.irdbgypaU6@x2>
References: <20210811114037.201887-1-simon.thoby@viveris.fr> <f06d6b278bf228d21bf3ec01da8173e6518557f9.camel@linux.ibm.com> <2072391.irdbgypaU6@x2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

On Wednesday, August 11, 2021 7:53:15 PM EDT Steve Grubb wrote:
> On Wednesday, August 11, 2021 3:40:51 PM EDT Mimi Zohar wrote:
> > On Wed, 2021-08-11 at 11:40 +0000, THOBY Simon wrote:
> > Other than the two questions on " IMA: add a policy option to restrict
> > xattr hash algorithms on appraisal" patch, the patch set is looking
> > good.
> > 
> > thanks,
> > 
> > Mimi
> > 
> > > Here is also a short description of the new audit messages, but I can
> > > send it in a followup mail if that is not the proper place:
> > > 
> > > When writing the xattr with an algorithm not built in the kernel (here
> > > the kernel was built with CONFIG_CRYPTO_MD5 unset), e.g. with
> > > 
> > > "evmctl ima_hash -a md5 /usr/bin/strace":
> > > 	audit(1628066120.418:121): pid=1344 uid=0 auid=0 ses=1
> > > 	subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=set_data
> > > 	cause=unavailable-hash-algorithm comm="evmctl" name="/usr/bin/
strace"
> > > 	dev="dm-0" ino=2632657 res=0 errno=0>
> 
> Is this audit event accurate? I seem to be seeing name=value=value. I'm
> hoping this is a copy/paste/mail client issue.

Sorry for the noise...I see there is a space in there.

-Steve


