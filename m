Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59789124E74
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLRQ4e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 11:56:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39574 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfLRQ4d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 11:56:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so3074698wrt.6
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qbVTsR54H6AMQsB5QLZrbdwDN4kpS+HACD311JISl7w=;
        b=G5yC8bKma8+W7VtY4hg6xyyFd3mz0mCVxUsDitnVTyxu4+nXkGRN8CcA13briD5Fro
         DgS8gSIIjVh3ocDahCyGpBSYEf/YYQXWG+fxvRl38YFxBbIewwkogD8gzprUdfGtVO1s
         CjWDu4DeiDdYCGyHVW/CNI2JB4im1puSz4rAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qbVTsR54H6AMQsB5QLZrbdwDN4kpS+HACD311JISl7w=;
        b=H5ek8laXBov8O56Oe+TlOx1znJhG2EOuuIZJxldwTZHFQpHlr1e+qRXe8CMK/FvNYy
         6sZcQIZV7oLl9H+dhRXi0vchSR63OWDsvXlAaHm2d03HXahxoxX6HxzdQ1NHfw1j4E0E
         KOqE5BLHihM2aBSVX8hVPEuqnd/ov+CoKRzwIBesz7DpFAH5N0c+sa5vHXVfu6fj9W/X
         5BYYI2hRu6bgY5qn/WZ7rEFCS3gPjmvnSwdVQORJdQPWMODt+SlHKYLE8fKcwugkySIJ
         5bpJ3bUovy6UqhGehfU/8+ipqk7lOmWk+gsF3rxCFArJpwfzUKyVRQOu0RFs5tznZFqL
         lzKA==
X-Gm-Message-State: APjAAAVHsSawGYw/UrAJ/2bfGKkWW/phceJmd2aj//XyQoqQmNmpbJiy
        +mFH7Dl8RWAdQnn/sy4BFuYl+Q==
X-Google-Smtp-Source: APXvYqy5xx6yDW4obLgxNVFChNHjAfYmmMhvCzmCKywobZ5xBBVjS7ZeoAytl4J+w+NgwcEstGBX8w==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr3985830wrr.226.1576688191510;
        Wed, 18 Dec 2019 08:56:31 -0800 (PST)
Received: from ?IPv6:2620:0:105f:304:c29:4454:35de:5c04? ([2620:0:105f:304:c29:4454:35de:5c04])
        by smtp.gmail.com with ESMTPSA id q68sm3556726wme.14.2019.12.18.08.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:56:30 -0800 (PST)
Message-ID: <63f057fb98351324c8fc6210c42f3cbd76e85a68.camel@chromium.org>
Subject: Re: [PATCH] integrity: Expose data structures required for
 include/linux/integrity.h
From:   Florent Revest <revest@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Cc:     jmorris@namei.org, serge@hallyn.com, revest@google.com,
        allison@lohutok.net, armijn@tjaldur.nl, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kpsingh@chromium.org
Date:   Wed, 18 Dec 2019 17:56:29 +0100
In-Reply-To: <1576679307.4579.401.camel@linux.ibm.com>
References: <20191217134748.198011-1-revest@chromium.org>
         <e9e366d3-6c5d-743b-ffde-6b95b85884a2@schaufler-ca.com>
         <1576624105.4579.379.camel@linux.ibm.com>
         <2ae5127d76cbf78140fb2d6108c9ec70c7d8ae5d.camel@chromium.org>
         <1576676087.4579.396.camel@linux.ibm.com>
         <1576679307.4579.401.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-18 at 09:28 -0500, Mimi Zohar wrote:
> [Cc'ing Matthew]
> 
> On Wed, 2019-12-18 at 08:34 -0500, Mimi Zohar wrote:
> > On Wed, 2019-12-18 at 12:03 +0100, Florent Revest wrote:
> > > On Tue, 2019-12-17 at 18:08 -0500, Mimi Zohar wrote:
> > > > On Tue, 2019-12-17 at 08:25 -0800, Casey Schaufler wrote:
> > > > > On 12/17/2019 5:47 AM, Florent Revest wrote:
> > > > > > From: Florent Revest <revest@google.com>
> > > > > > 
> > > > > > include/linux/integrity.h exposes the prototype of
> > > > > > integrity_inode_get().
> > > > > > However, it relies on struct integrity_iint_cache which is
> > > > > > currently
> > > > > > defined in an internal header,
> > > > > > security/integrity/integrity.h.
> > > > > > 
> > > > > > To allow the rest of the kernel to use integrity_inode_get,
> > > > > 
> > > > > Why do you want to do this?
> > > > 
> > > > ditto
> > > 
> > > My team works on KRSI (eBPF MAC policies presented at LSS by KP
> > > Singh).
> > > https://lkml.org/lkml/2019/9/10/393 We identified file hashes
> > > gathered
> > > from the integrity subsystem as an interesting field that we
> > > could
> > > potentially someday expose to eBPF programs through helpers.
> > > 
> > > One of the reason behind writing KRSI is to replace a custom
> > > kernel
> > > auditing module that currently needs to redefine those structures
> > > to
> > > access them. I imagine other kernel modules could benefit from a
> > > file
> > > hash API too.
> > > 
> > > This is the least intrusive patch I could come up with that
> > > allows us
> > > to lookup a hash from an inode. I was surprised to find that
> > > integrity_inode_get was exposed but not the structures it
> > > returns.
> > > 
> > > If the community is interested in a different file hash API, I'd
> > > be
> > > happy to iterate on this patch based on your feedback.
> > 
> > There's a major difference between returning just the file hash and
> > making the integrity_iint_cache structure public. 

Certainly!
I am new to this subsystem so I just wanted to get the discussion
started. I am happy to make a more specific function.

> > Peter Moody's original code queried the cache[1].  Why do you need
> > access to the structure itself?
> > FYI, if/when we get to IMA namespacing, the cache structure will
> > change.
> > 
> > [1] ima: add the ability to query ima for the hash of a given file.
> 
> If you're using Peter's patch, or something similar, I'd appreciate
> your taking the time to upstream it.

Thank you for pointing me to Peter's patch! No one in my team was aware
of his work on this. Ugh!
It appears that Peter left the company while trying to upstream his
patch and the situation just got stuck there for 4+ years now.

If you are still positive about the idea of a ima_file_hash function, I
will take his v6 patch (this is the latest I could find on the
sourceforce archives of linux-ima-devel), rebase it, take your comments
into account and send a new version by the end of the week.

> Mimi
> 
> > > > > >  this patch
> > > > > > moves the definition of the necessary structures from a
> > > > > > private
> > > > > > header
> > > > > > to a global kernel header.

