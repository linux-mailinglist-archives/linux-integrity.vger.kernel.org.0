Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00B23CBDB
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgHEP5W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 11:57:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39084 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgHEPvi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 11:51:38 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 075F820B490A;
        Wed,  5 Aug 2020 08:07:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 075F820B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596640065;
        bh=4htCjq+HrG+6KX6M1fUa9DbFBYUOf9aj/qs9e1AjTKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0Uxi7FLcZAMLbHkrUUJLqtPs/+J67eH9olMkJ8yRQ+mKoiOQem85K1ROoq0JqfZ+
         PbNfl9Y25Kc6toJCSLhPXlRiHyPxYgM7G8aOC0yPMMlY1MtJD3Z8znaXMyBCIlaCC3
         rJroDqCLmL9kOfqQIOKBfIBB4/fE45Cfkifgc+C8=
Date:   Wed, 5 Aug 2020 10:07:32 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
Message-ID: <20200805150732.GA4365@sequoia>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <20200805004331.20652-2-nramas@linux.microsoft.com>
 <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
 <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com>
 <31d00876438d2652890ab8bf6ba2e80f554ca7a4.camel@linux.ibm.com>
 <CAEjxPJ6X+Cqd5QtZBmNm2cujwbg-STfRF7_8i=Ny8yuc6z9BwQ@mail.gmail.com>
 <b7df114e8e0d276e66575b6970a1e459d1dd4196.camel@linux.ibm.com>
 <CAEjxPJ7d1yg659OCU6diXXGqegc_jSzO4ZPhkRqQtJnRn-kC0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7d1yg659OCU6diXXGqegc_jSzO4ZPhkRqQtJnRn-kC0g@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-08-05 10:27:43, Stephen Smalley wrote:
> On Wed, Aug 5, 2020 at 9:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Wed, 2020-08-05 at 09:03 -0400, Stephen Smalley wrote:
> > > On Wed, Aug 5, 2020 at 8:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Wed, 2020-08-05 at 08:46 -0400, Stephen Smalley wrote:
> > > > > On 8/4/20 11:25 PM, Mimi Zohar wrote:
> > > > >
> > > > > > Hi Lakshmi,
> > > > > >
> > > > > > There's still  a number of other patch sets needing to be reviewed
> > > > > > before my getting to this one.  The comment below is from a high level.
> > > > > >
> > > > > > On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
> > > > > > > Critical data structures of security modules need to be measured to
> > > > > > > enable an attestation service to verify if the configuration and
> > > > > > > policies for the security modules have been setup correctly and
> > > > > > > that they haven't been tampered with at runtime. A new IMA policy is
> > > > > > > required for handling this measurement.
> > > > > > >
> > > > > > > Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
> > > > > > > measure the state and the policy provided by the security modules.
> > > > > > > Update ima_match_rules() and ima_validate_rule() to check for
> > > > > > > the new func and ima_parse_rule() to handle the new func.
> > > > > > I can understand wanting to measure the in kernel LSM memory state to
> > > > > > make sure it hasn't changed, but policies are stored as files.  Buffer
> > > > > > measurements should be limited  to those things that are not files.
> > > > > >
> > > > > > Changing how data is passed to the kernel has been happening for a
> > > > > > while.  For example, instead of passing the kernel module or kernel
> > > > > > image in a buffer, the new syscalls - finit_module, kexec_file_load -
> > > > > > pass an open file descriptor.  Similarly, instead of loading the IMA
> > > > > > policy data, a pathname may be provided.
> > > > > >
> > > > > > Pre and post security hooks already exist for reading files.   Instead
> > > > > > of adding IMA support for measuring the policy file data, update the
> > > > > > mechanism for loading the LSM policy.  Then not only will you be able
> > > > > > to measure the policy, you'll also be able to require the policy be
> > > > > > signed.
> > > > >
> > > > > To clarify, the policy being measured by this patch series is a
> > > > > serialized representation of the in-memory policy data structures being
> > > > > enforced by SELinux.  Not the file that was loaded.  Hence, this
> > > > > measurement would detect tampering with the in-memory policy data
> > > > > structures after the policy has been loaded.  In the case of SELinux,
> > > > > one can read this serialized representation via /sys/fs/selinux/policy.
> > > > > The result is not byte-for-byte identical to the policy file that was
> > > > > loaded but can be semantically compared via sediff and other tools to
> > > > > determine whether it is equivalent.
> > > >
> > > > Thank you for the clarification.   Could the policy hash be included
> > > > with the other critical data?  Does it really need to be measured
> > > > independently?
> > >
> > > They were split into two separate functions because we wanted to be
> > > able to support using different templates for them (ima-buf for the
> > > state variables so that the measurement includes the original buffer,
> > > which is small and relatively fixed-size, and ima-ng for the policy
> > > because it is large and we just want to capture the hash for later
> > > comparison against known-good).  Also, the state variables are
> > > available for measurement always from early initialization, whereas
> > > the policy is only available for measurement once we have loaded an
> > > initial policy.
> >
> > Ok, measuring the policy separately from other critical data makes
> > sense.  Instead of measuring the policy, which is large, measure the
> > policy hash.
> 
> I think that was the original approach.  However, I had concerns with
> adding code to SELinux to compute a hash over the policy versus
> leaving that to IMA's existing policy and mechanism.  If that's
> preferred I guess we can do it that way but seems less flexible and
> duplicative.

In AppArmor, we store the sha1 of the raw policy as the policy is
loaded. The hash is exposed to userspace in apparmorfs. See commit
5ac8c355ae00 ("apparmor: allow introspecting the loaded policy pre
internal transform").

It has proved useful as a mechanism for debugging as sometimes the
on-disk policy doesn't match the loaded policy and this can be a good
way to check that while providing support to users. John also mentions
checkpoint/restore in the commit message and I could certainly see how
the policy hashes would be useful in that scenario.

When thinking through how Lakshmi's series could be extended for
AppArmor support, I was thinking that the AppArmor policy measurement
would be a measurement of these hashes that we already have in place.

Perhaps there's some general usefulness in storing/exposing an SELinux
policy hash rather than only seeing it as duplicative property required
this measurement series?

Tyler

