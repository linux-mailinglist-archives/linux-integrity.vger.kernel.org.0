Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1171FB866
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgFPP4A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 11:56:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41206 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733131AbgFPPz5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 11:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592322956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GMvFt9x/GME+tYUTng0QoYKwCh/XoVUUjz+YXccVf9k=;
        b=Rix2pl7O64W4uD1zXV3b8GB/hQEG/jiMJ/dnB1avC8mVxFsaDtckW9Xon74ExM1FicfEf1
        4olhmdwo4cCqoq7yDX2zd4cJkTLPvqjIJ3SZE0F7iIaG1rTIV87AHehTB9hWaJD13WOEet
        AXxuZQgWmLU8NpjiyeEJAsHAbb0uHfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Vc28Lxq8P5CWEsmSzSE5_g-1; Tue, 16 Jun 2020 11:55:52 -0400
X-MC-Unique: Vc28Lxq8P5CWEsmSzSE5_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2B8DE918;
        Tue, 16 Jun 2020 15:55:50 +0000 (UTC)
Received: from x2.localnet (ovpn-113-82.phx2.redhat.com [10.3.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 845DE60C05;
        Tue, 16 Jun 2020 15:55:44 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
Date:   Tue, 16 Jun 2020 11:55:42 -0400
Message-ID: <1717101.NiBDiG0Zly@x2>
Organization: Red Hat
In-Reply-To: <958966b6-9972-051f-a7d5-cd6d1beb3244@linux.microsoft.com>
References: <20200611000400.3771-1-nramas@linux.microsoft.com> <6643272.rC52FQZPYE@x2> <958966b6-9972-051f-a7d5-cd6d1beb3244@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tuesday, June 16, 2020 11:43:31 AM EDT Lakshmi Ramasubramanian wrote:
> On 6/16/20 8:29 AM, Steve Grubb wrote:
> >>>>> The idea is a good idea, but you're assuming that "result" is always
> >>>>> errno.  That was probably true originally, but isn't now.  For
> >>>>> example, ima_appraise_measurement() calls xattr_verify(), which
> >>>>> compares the security.ima hash with the calculated file hash.  On
> >>>>> failure, it returns the result of memcmp().  Each and every code path
> >>>>> will need to be checked.
> >>>> 
> >>>> Good catch Mimi.
> >>>> 
> >>>> Instead of "errno" should we just use "result" and log the value given
> >>>> in the result parameter?
> >>> 
> >>> That would likely collide with another field of the same name which is
> >>> the
> >>> operation's results. If it really is errno, the name is fine. It's
> >>> generic
> >>> enough that it can be reused on other events if that mattered.
> >> 
> >> Steve, what is the historical reason why we have both "res" and
> >> "result" for indicating a boolean success/fail?  I'm just curious how
> >> we ended up this way, and who may still be using "result".
> > 
> > I think its pam and some other user space things did this. But because of
> > mixed machines in datacenters supporting multiple versions of OS, we have
> > to leave result alone. It has to be 0,1 or success/fail. We cannot use
> > it for errno.
> 
> As Mimi had pointed out, since the value passed in result parameter is
> not always an error code, "errno" is not an appropriate name.
> 
> Can we add a new field, say, "op_result" to report the result of the
> specified operation?

Sure. But since it is errno sometimes, how would we know when to translate 
it?

-Steve



