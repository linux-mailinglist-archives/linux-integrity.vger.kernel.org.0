Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25571FB625
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgFPP33 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 11:29:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30366 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728917AbgFPP33 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 11:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592321368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prvuib5zQmcv0KtPefPihKfecw6gAeEldQvoe7ZUcw8=;
        b=J+t3P92GsJPs/zExJ6s+CfijxJR0RLrt6yaR56z8cu9vT96ucZPnNQ3oWLliluuLhCT2zG
        tJzEEn4Yu8+gKVAGpwWN21y68xIyHTH9dwlyqCe1CLqJ/qEeRVKwffZCMMquObkUt/awcP
        oy+94OlFb20Q5hDA8pAIZxLLR/2jYS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-mImIVvnyOWiBzs4mNEtzcw-1; Tue, 16 Jun 2020 11:29:26 -0400
X-MC-Unique: mImIVvnyOWiBzs4mNEtzcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C6FA150562;
        Tue, 16 Jun 2020 15:29:25 +0000 (UTC)
Received: from x2.localnet (ovpn-113-82.phx2.redhat.com [10.3.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5559110013D6;
        Tue, 16 Jun 2020 15:29:24 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
Date:   Tue, 16 Jun 2020 11:29:22 -0400
Message-ID: <6643272.rC52FQZPYE@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhT6JSLBD-JMfQbn9eUsUg=juznRz41DTOaia-=WhrAAuA@mail.gmail.com>
References: <20200611000400.3771-1-nramas@linux.microsoft.com> <8800031.dr63W5FlUW@x2> <CAHC9VhT6JSLBD-JMfQbn9eUsUg=juznRz41DTOaia-=WhrAAuA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Monday, June 15, 2020 6:58:13 PM EDT Paul Moore wrote:
> On Mon, Jun 15, 2020 at 6:23 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Friday, June 12, 2020 3:50:14 PM EDT Lakshmi Ramasubramanian wrote:
> > > On 6/12/20 12:25 PM, Mimi Zohar wrote:
> > > > The idea is a good idea, but you're assuming that "result" is always
> > > > errno.  That was probably true originally, but isn't now.  For
> > > > example, ima_appraise_measurement() calls xattr_verify(), which
> > > > compares the security.ima hash with the calculated file hash.  On
> > > > failure, it returns the result of memcmp().  Each and every code path
> > > > will need to be checked.
> > > 
> > > Good catch Mimi.
> > > 
> > > Instead of "errno" should we just use "result" and log the value given
> > > in the result parameter?
> > 
> > That would likely collide with another field of the same name which is
> > the
> > operation's results. If it really is errno, the name is fine. It's
> > generic
> > enough that it can be reused on other events if that mattered.
> 
> Steve, what is the historical reason why we have both "res" and
> "result" for indicating a boolean success/fail?  I'm just curious how
> we ended up this way, and who may still be using "result".

I think its pam and some other user space things did this. But because of 
mixed machines in datacenters supporting multiple versions of OS, we have to 
leave result alone. It has to be 0,1 or success/fail. We cannot use it for 
errno.

-Steve


