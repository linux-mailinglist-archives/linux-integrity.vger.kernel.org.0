Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688E3D7F4F
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhG0Udt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 16:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232340AbhG0Uds (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 16:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627418028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tp5fB6VxG+WAT0uq+WsG9T4sfTRcerAMWdLsqTsihHI=;
        b=eSCYXXDGqW+ZRP9/rRm/ef1uv3SrR5AaGljs9HNnU3wfqlVbK5nukX7CMUzAncmtUcvx96
        2Y8PhOdFDE58NCHj6NIIBguhj58xEg5e9kAMch8KG4S9qI5qYH8jLGMOsUYMDDCiKAvzaB
        Ls3FOAaStCuxl6oawu/EA+pp6GLu9XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-bvsGNfZcOGm16VoDWgQEQQ-1; Tue, 27 Jul 2021 16:33:46 -0400
X-MC-Unique: bvsGNfZcOGm16VoDWgQEQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968221006C81;
        Tue, 27 Jul 2021 20:33:45 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D90E4101E249;
        Tue, 27 Jul 2021 20:33:34 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id 6703B41FBD41; Tue, 27 Jul 2021 21:33:37 +0100 (BST)
Date:   Tue, 27 Jul 2021 21:33:37 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Thore Sommer <public@thson.de>
Cc:     tusharsu@linux.microsoft.com, agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using
 IMA
Message-ID: <20210727203337.GA81220@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: Thore Sommer <public@thson.de>,
        tusharsu@linux.microsoft.com, agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
References: <c833339e-c4bf-6e78-5719-cd902fa8426f@linux.microsoft.com>
 <20210727101802.779067-1-public@thson.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727101802.779067-1-public@thson.de>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
 03798903. Registered Office: Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 27, 2021 at 12:18:02PM +0200, Thore Sommer wrote:
> No new IMA measurement is generated if dm-verity verification fails. This is
> unfortunate because to make the dm-verity measurements useful we need to be
> notified when hash_failed is set to true. We will need something like
> "device_update" where we remeasure the device state if it has changed.
 
Measurements in the current patchset are only triggered by ioctl calls
initiated by userspace.

Having other triggering mechanisms - such as hooking into internal
events when something unexpected happens - could be considered for
follow-on patches.

> Creating a dm-verity device with mount then removing it and now if you create it
> again no measurement is generated. Is that the expected behavior?  

Each of the relevant dm ioctls should be logged separately each time.  If that's
not happening it might need fixing.

> Is there a reason that suspend is not measured?

A suspend doesn't change the configuration so falls outside the criteria
for this patch set.  (If there is some need for it, it would be covered
by the need to measure internal events that I mentioned above.)
 
> What can happen in between a "table_load" and "device_resume" that is security
> relevant?

The table prepared by the load can be cleared.  That would change the
effect of the resume.
 
> Not directly device mapper related, but it would be nice to also measure the
> mount points and a mapping to the device IDs. 

Again, that would be for future patches building on these ones.

Alasdair

