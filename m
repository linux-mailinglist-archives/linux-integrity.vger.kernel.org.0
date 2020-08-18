Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC5248E67
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRTDr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 15:03:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54076 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgHRTDq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 15:03:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8B5108EE183;
        Tue, 18 Aug 2020 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597777425;
        bh=U86VxjWVs2zZrmWwTQgMyTpPtwLgDWZ4xw+/gCJRIT4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G7fBrAchlui6VYKgwxkt8biso/v95IzKhVoBxWhZ56+UYRgUXvZDNTaIuEUyBFoyy
         5ZdJjL2rvmS4mTZNTKfxyI7YUl1WHPipAJqzv69IrcBASuJswP+/U9jM9dwwA4bhcO
         4HL8SRa2uq0Vd+TMPlVlhpKnIrEXJetWlyRF5/IQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uDK8a4mS1jO5; Tue, 18 Aug 2020 12:03:45 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1CD308EE17F;
        Tue, 18 Aug 2020 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597777425;
        bh=U86VxjWVs2zZrmWwTQgMyTpPtwLgDWZ4xw+/gCJRIT4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G7fBrAchlui6VYKgwxkt8biso/v95IzKhVoBxWhZ56+UYRgUXvZDNTaIuEUyBFoyy
         5ZdJjL2rvmS4mTZNTKfxyI7YUl1WHPipAJqzv69IrcBASuJswP+/U9jM9dwwA4bhcO
         4HL8SRa2uq0Vd+TMPlVlhpKnIrEXJetWlyRF5/IQ=
Message-ID: <1597777424.3898.60.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 18 Aug 2020 12:03:44 -0700
In-Reply-To: <20200818183603.GC1152540@nvidia.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-18 at 15:36 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 02:26:04PM -0400, Mimi Zohar wrote:
> > On Tue, 2020-08-18 at 13:46 -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 18, 2020 at 07:26:30PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Aug 18, 2020 at 07:19:57PM +0300, Jarkko Sakkinen
> > > > wrote:
> > > > > On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen
> > > > > wrote:
> > > > > > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley
> > > > > > wrote:
> > > > > > > Create sysfs per hash groups with 24 PCR files in them
> > > > > > > one group, named pcr-<hash>, for each agile hash of the
> > > > > > > TPM.  The files are plugged in to a PCR read function
> > > > > > > which is TPM version agnostic, so this works also for TPM
> > > > > > > 1.2 but the hash is only sha1 in that case.
> > > > > > > 
> > > > > > > Note: the macros used to create the hashes emit spurious
> > > > > > > checkpatch warnings.  Do not try to "fix" them as
> > > > > > > checkpatch recommends, otherwise they'll break.
> > > > > > > 
> > > > > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPar
> > > > > > > tnership.com>
> > > > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > > > 
> > > > > > I have hard time understanding why this is required.
> > > > > > 
> > > > > > You can grab the information through /dev/tpm0 just fine.
> > > > > 
> > > > > I just think it is principally wrong to add sysfs files if
> > > > > they don't have any measurable value other than perhaps some
> > > > > convenience.
> > > > > 
> > > > > It is trival to write only a libc dependent program that
> > > > > outputs PCRs.
> > > > > 
> > > > > I think this is essentially an user space problem that is
> > > > > getting sorted out with kernel code.
> > > > 
> > > > Jason, what do you make of this? I recall that it was you who I
> > > > discussed with about this topic when TPM 2.0 support was first
> > > > upstreamed.
> > > 
> > > TPM 2.0 broke all the userspace so it made sense to get rid of
> > > the non-conforming sysfs files from TPM v1.x time as part of the
> > > userspace API. That was the main reason to not continue forward
> > > with PCR in userspace.
> > > 
> > > As far as doing it properly as this patch does.. I agree with you
> > > that sysfs files should have some reason to be added, espcially
> > > if it causes quite big code cost as this does. eg to drive a udev
> > > rule decision.
> > > 
> > > Why is PCRs so special it needs to be in sysfs? What is userspace
> > > going to do with this information?
> > 
> > The original IMA LTP "boot_aggregate" regression test is dependent
> > on the exported TPM event log and PCRs.  Similar support is needed
> > for TPM 2.0.  There isn't just a single userspace application for
> > reading PCRs.  As soon as we add support for one userspace
> > application,  support for the other applications is requested.  So
> > instead of a having a simple regression test with a single method
> > of reading PCRs, we're now required to support multiple userspace
> > applications.
> 
> But this test already has a C program as part of the boot aggregate
> test, why is it such a problem to use a C program to also read the
> PCRs?
> 
> As Jarkko says it is not so hard

It's not so hard for system programmer who owns the root account, like
the people who hang out on this list.  For your average user, a root
only device you're expected to send and receive binary packets of big
endian data over is a textbook definition of an unusable interface.

I can potentially buy arguments that ordinary users can get this
information from TSS based toolkits (although both the Intel and the
IBM TSS seem to go out of their way to make it hard to extract). Or
even that the average user has no use for the information (although
I've given three examples).  However, it's not realistic to expect that
the average user start speaking binary packet protocols from shell
scripts.

James

