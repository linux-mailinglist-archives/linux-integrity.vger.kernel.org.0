Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8D46158A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 13:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhK2M4M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 07:56:12 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36150 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232822AbhK2MyM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 07:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638190254;
        bh=p51CiI6kvkB7i3xNd9hwj5ti8bRYeypYxaIDHt2VT6g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=h1n5K2mU9XRvKCiCOjUYqS78hwhAYk5xyGdlXik45XNXdxToIs1ePTn6OvZNFLTrs
         gJH/CZm4TXEchNp/U36ABYkEc8eSMELJky+GG0BXiLqzpx8Y+yeI6iHeIXGFcpo5Qm
         UMpY2BJktGDAbIyyLX449ECqAQdOZRqd5NB0bSCk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C344F1280636;
        Mon, 29 Nov 2021 07:50:54 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 35x5n_PyVwyX; Mon, 29 Nov 2021 07:50:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638190254;
        bh=p51CiI6kvkB7i3xNd9hwj5ti8bRYeypYxaIDHt2VT6g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=h1n5K2mU9XRvKCiCOjUYqS78hwhAYk5xyGdlXik45XNXdxToIs1ePTn6OvZNFLTrs
         gJH/CZm4TXEchNp/U36ABYkEc8eSMELJky+GG0BXiLqzpx8Y+yeI6iHeIXGFcpo5Qm
         UMpY2BJktGDAbIyyLX449ECqAQdOZRqd5NB0bSCk=
Received: from [IPv6:2601:5c4:4300:c551::c447] (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 81C841280518;
        Mon, 29 Nov 2021 07:50:53 -0500 (EST)
Message-ID: <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Date:   Mon, 29 Nov 2021 07:50:52 -0500
In-Reply-To: <20211129045834.GB20606@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
         <20211129045834.GB20606@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
> On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley wrote:
> > Currently we get one entry in the IMA log per unique file
> > event.  So, if you have a measurement policy and it measures a
> > particular binary it will not get measured again if it is
> > subsequently executed. For Namespaced IMA, the correct behaviour
> > seems to be to log once per inode per namespace (so every unique
> > execution in a namespace gets a separate log entry).  Since logging
> > once per inode per namespace is
> 
> I suspect I'll need to do a more in depth reading of the existing
> code, but I'll ask the lazy question anyway (since you say "the
> correct behavior seems to be") - is it actually important that
> files which were appraised under a parent namespace's policy already
> should be logged again?

I think so.  For a couple of reasons, assuming the namespace eventually
gets its own log entries, which the next incremental patch proposed to
do by virtualizing the securityfs entries.  If you don't do this:

   1. The namespace log will be incomplete in a random way depending on
      what execution preceded it.  This violates the principle of least
      surprise, because you at least expect the IMA log to be consistent
      per set of executions.
   2. A malicious namespace owner can use the missing information in their
      log to infer the execution of others, which is an information leak
      IMA tries to prevent by keeping the log readable only by root.

>   Since you used the word "log" I'm assuming this isn't building a
> running hash like a tpm pcr where skipping one would invalidate
> rmeote attestation?

Their is only one IMA log, so each entry must be extended through the
PCR to keep the quote correct.  That means each per namespace entry
does extend the PCR.  However, since the entire entry is logged and the
namespace uuid is part of the entry, the entry hash is different for
each, so the IMA rule about duplicate log entries doesn't apply, if
that was the worry?

James


