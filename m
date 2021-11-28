Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E47460716
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Nov 2021 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhK1PXY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Nov 2021 10:23:24 -0500
Received: from mail.hallyn.com ([178.63.66.53]:60072 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhK1PVX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Nov 2021 10:21:23 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 12891A17; Sun, 28 Nov 2021 09:18:06 -0600 (CST)
Date:   Sun, 28 Nov 2021 09:18:06 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux.dev,
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
Subject: Re: [RFC 1/3] userns: add uuid field
Message-ID: <20211128151805.GA15306@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
 <20211128044558.GA11794@mail.hallyn.com>
 <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e32a6897877ed600de64b3d664dc6014389dbe4.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 28, 2021 at 08:29:21AM -0500, James Bottomley wrote:
> On Sat, 2021-11-27 at 22:45 -0600, Serge E. Hallyn wrote:
> > On Sat, Nov 27, 2021 at 04:45:47PM +0000, James Bottomley wrote:
> > > As a precursor to namespacing IMA a way of uniquely identifying the
> > > namespace to appear in the IMA log is needed.  This log may be
> > > transported away from the running system and may be analyzed even
> > > after the system has been rebooted.  Thus we need a way of
> > > identifying namespaces in the log which is unique.  UUID, being
> > > designed probabilistically never to repeat, fits this bill so add
> > > it to the user_namespace which we'll also use for namespacing IMA.
> > 
> > If the logs run across 5 boots, is it important to you that the
> > uuid be unique across all 5 boots?  Would it suffice to have a
> > per-boot unique count and report that plus some indicator of the
> > current boot (like boot time in jiffies)?
> 
> For the purposes of IMA it's only really important to have the uuid be
> unique within the particular log ... i.e. unique per boot.  However,
> given the prevalence of uuids elsewhere and the fact we have no current
> per-boot unique label for the namespace (the inode number could
> repeat), it seemed reasonable to employ uuids for this rather than
> invent a different identifier.  Plus IMA isn't going to complain if we
> have a globally unique identifier ...

Ok - Note I'm not saying I heavily object, but I'm mildly concerned
about users who happen to spin off a lot of user namespaces for
quick jobs being penalized.  I suspect Eric will also worry about the
namespacing implications - i.e. people *will* want to start restoring
user namespaces with a previously used uuid.

So given that 'unique per boot' is sufficient, what would be the problem
with simply adding a simple ever-increasing unique atomix count to the
struct user_namespace?

-serge
