Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F82EE7DB
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 22:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbhAGVtS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 16:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbhAGVtS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 16:49:18 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71EC0612F4
        for <linux-integrity@vger.kernel.org>; Thu,  7 Jan 2021 13:48:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB32512801C0;
        Thu,  7 Jan 2021 13:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610056117;
        bh=UFPilvVORZKlEk7OHVHIPHxiQfZjA1Xg/wyddkD6jeg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=W2myJw28COEzDtE8GOOrcY8gpCNPeYTeftU/HWXkbD1aG2O/986f92jLL5w7ZuMc5
         QZ2NCZkrg8FL9n6xYVfXuuHAVcyq0m/MRVOLd4+a3E/BaWkYkquRQxrk6SPjpcmSON
         Kbgh4kPO4h/tIU38kp2IZEwnQVNQkMcpLGzTnUMo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LCL2DP6cM0cs; Thu,  7 Jan 2021 13:48:37 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3ECD412801BC;
        Thu,  7 Jan 2021 13:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610056117;
        bh=UFPilvVORZKlEk7OHVHIPHxiQfZjA1Xg/wyddkD6jeg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=W2myJw28COEzDtE8GOOrcY8gpCNPeYTeftU/HWXkbD1aG2O/986f92jLL5w7ZuMc5
         QZ2NCZkrg8FL9n6xYVfXuuHAVcyq0m/MRVOLd4+a3E/BaWkYkquRQxrk6SPjpcmSON
         Kbgh4kPO4h/tIU38kp2IZEwnQVNQkMcpLGzTnUMo=
Message-ID: <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 07 Jan 2021 13:48:36 -0800
In-Reply-To: <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
         <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
         <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
         <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
         <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
         <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 15:51 -0500, Mimi Zohar wrote:
> On Thu, 2021-01-07 at 12:37 -0800, James Bottomley wrote:
> > On Thu, 2021-01-07 at 15:02 -0500, Mimi Zohar wrote:
> > > On Thu, 2021-01-07 at 08:42 -0800, James Bottomley wrote:
[...]
> > > > What about having a log entry that's the current PCR
> > > > value?  Then stretches of the log starting with these entries
> > > > would be independently verifiable provided you had a way of
> > > > trusting the PCR value.  It might be possible to get the TPM to
> > > > add a signed quote as an optional part of the log entry (of
> > > > course this brings other problems like which key do you use for
> > > > the signing and how does it get verified) which would provide
> > > > the trust and would definitively allow you to archive log
> > > > segments and still make the rest of the log useful.
> > > 
> > > The current PCR values are aggregated and stored in the
> > > boot_aggregate record.  As part of the new boot_aggregate record
> > > format, the individual PCR values could be included.
> > 
> > I don't think we care about the boot aggregate ... it's just the
> > initial log entry that ties the boot state to the initial runtime
> > state.  All we need for the proposed entry is the current value of
> > the IMA PCR so provided you trust that value it becomes a base on
> > which the following measurements can build and be trusted.
> 
> The IMA measurement list may contain multiple PCRs, not just the
> default IMA PCR.   Each kexec results in an additional boot_aggregate
> record, but an equivalent record for after truncating the measurement
> list might help.

Right, this would specifically be only of the IMA PCR so you can use it
as a base to begin the hash of the following log segment.  The log can
still contain other boot aggregate entries, but the assumption is that
boot aggregate entries in the prior log have already been evaluated.

> > > But this doesn't address where the offloaded measurement list
> > > will be stored, how long the list will be retained, nor who
> > > guarantees the integrity of the offloaded list.  In addition,
> > > different form factors will have different requirements.
> > 
> > I'm not sure you need any store at all.  The basic idea is that the
> > log is divided into individually verifiable segments.  For auditing
> > purposes you could keep all segments, so you have the entire log,
> > but if you've acted on the prior log entries and you don't have an
> > audit reason to keep them, you could erase that segment of the log
> > because you've placed all your trust in the prior log segments into
> > the PCR entry that forms the base of your current segment.
> > 
> > Essentially the question devolves to what mechanisms can give you
> > this trust in the base PCR log entry.
> 
> 
Not retaining the entire measurement list would limit it's verification
to a single server/system.

Well, it would limit its verification to just that log segment, yes.

I'm thinking in the cloud there are a couple of potential consumers:  

   1. The cloud monitor, which acts on the verified log, such as killing a
      node for trying to execute an unverified binary or emailing the
      guest owner.  This type of consumer doesn't need the historical log,
      they just need to verify the entries they haven't already seen and
      act on them according to whatever policy they're given.
   2. The second type of cloud consumer is the audit case where the
      aggregate hash is used to assure some auditor, some time after the
      actual events, that the entire runtime of the VM was properly
      monitored and the auditor wants to see the log  or a segment of it
      to prove the hash.

Case 1 doesn't need historical storage, case 2 definitely does.  I
think we should support both use cases particularly in the long running
scenario where we need to recover memory.  Having verifiable log
segments seems to satisfy both cases, but what you do with the segments
would vary.

James


