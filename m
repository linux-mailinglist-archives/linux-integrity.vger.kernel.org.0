Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC51FC001
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgFPU3E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:29:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731425AbgFPU3D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592339341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PuFuQg6K4e8+oPcKh4HKkSbhQEN3+Z7Dt+MuhnK0tiM=;
        b=QVwD5v87tlgcmO4H0p8qZurzxWvn6QmqBeyqbDRtKeXm4tFXkyLPpjZ3XnAY9riho2g2cp
        nF3rdHH9bQwamlM3P9ob1KD/fre+Xt33qE1T+xfJOXz78e13yiEvjGwRE1jemMW6TJ29ev
        Aruavogdm7ehUHavpB5yqulk0Tp6Q2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-g5CUkErUN0yKgA33gmgSYw-1; Tue, 16 Jun 2020 16:28:59 -0400
X-MC-Unique: g5CUkErUN0yKgA33gmgSYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1AF58AB398;
        Tue, 16 Jun 2020 20:28:52 +0000 (UTC)
Received: from x2.localnet (ovpn-113-201.phx2.redhat.com [10.3.113.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06D8D6C1A0;
        Tue, 16 Jun 2020 20:28:51 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
Date:   Tue, 16 Jun 2020 16:28:47 -0400
Message-ID: <2644117.Ritcz3IfYv@x2>
Organization: Red Hat
In-Reply-To: <1592337220.11061.239.camel@linux.ibm.com>
References: <20200611000400.3771-1-nramas@linux.microsoft.com> <1717101.NiBDiG0Zly@x2> <1592337220.11061.239.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tuesday, June 16, 2020 3:53:40 PM EDT Mimi Zohar wrote:
> On Tue, 2020-06-16 at 11:55 -0400, Steve Grubb wrote:
> > On Tuesday, June 16, 2020 11:43:31 AM EDT Lakshmi Ramasubramanian wrote:
> > > On 6/16/20 8:29 AM, Steve Grubb wrote:
> > > >>>>> The idea is a good idea, but you're assuming that "result" is
> > > >>>>> always errno.  That was probably true originally, but isn't now. 
> > > >>>>> For example, ima_appraise_measurement() calls xattr_verify(),
> > > >>>>> which compares the security.ima hash with the calculated file
> > > >>>>> hash.  On failure, it returns the result of memcmp().  Each and
> > > >>>>> every code path will need to be checked.
> > > >>>> 
> > > >>>> Good catch Mimi.
> > > >>>> 
> > > >>>> Instead of "errno" should we just use "result" and log the value
> > > >>>> given in the result parameter?
> > > >>> 
> > > >>> That would likely collide with another field of the same name which
> > > >>> is the operation's results. If it really is errno, the name is fine.
> > > >>> It's generic enough that it can be reused on other events if that
> > > >>> mattered.
> > > >> 
> > > >> Steve, what is the historical reason why we have both "res" and
> > > >> "result" for indicating a boolean success/fail?  I'm just curious
> > > >> how we ended up this way, and who may still be using "result".
> > > > 
> > > > I think its pam and some other user space things did this. But
> > > > because of mixed machines in datacenters supporting multiple versions
> > > > of OS, we have to leave result alone. It has to be 0,1 or success/
> > > > fail. We cannot use it for errno.
> > > 
> > > As Mimi had pointed out, since the value passed in result parameter is
> > > not always an error code, "errno" is not an appropriate name.
> > > 
> > > Can we add a new field, say, "op_result" to report the result of the
> > > specified operation?
> > 
> > Sure. But since it is errno sometimes, how would we know when to
> > translate it?
> 
> Perhaps the solution is not to imply "res" is "errno", but pass it as
> a separate "errno" field.

That's what is done on syscalls. There is success and exit where they both 
have different meaning sometimes but otherwise they agree.

> Then only include "errno" in the audit message when it isn't zero.  This
> assumes that some audit messages for the same audit number include errno,
> while others do not.

We normally do not like to have fields that swing in and out because then its 
hard to know exactly what's in the event. When an event has different fields 
under special conditions, then we just say call it a new event. Split it into 
2 or 3 instead forcing it all into 1. And we also do not like fields that 
change meaning. Because then intepretation becomes hard. Or other people 
wishing to record the same info in another event have to follow the same 
pattern.

So, if you really need this field, the give some name like err_code or errno 
or anything not taken. And just fill it out every time. Its OK to be 0. If 
this only happens under some special operation, then make it a new event and 
fill it out only for that operation/event.

Best Regards,
-Steve


> With this solution, the existing integrity_audit_msg() could become a
> wrapper for the new function.
> 
> Mimi




