Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3E5248BD8
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHRQog (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 12:44:36 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51844 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbgHRQoc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 12:44:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 322428EE183;
        Tue, 18 Aug 2020 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597769072;
        bh=+den8/2MPIGeIowlY7axdLE4UxCmYMOM4Cip9eopdEY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xsc6lJoEaLSL/6gJl6pMqg/SaKz2AbSOdFQy7ri6X2SzM5dZRHbZH0LZFFAaul7UW
         r4bxBB6ZAkeS3fnPKS/xEXBRYwtsw6IKxAHuub/EwZku9gEiANI113U+QA/GQ23HRS
         v4rdIGCh1FGIie+ZHFglS4vdEMycEl5049sVb7dI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yzxZl3ep0Ss9; Tue, 18 Aug 2020 09:44:32 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BAD828EE17F;
        Tue, 18 Aug 2020 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597769071;
        bh=+den8/2MPIGeIowlY7axdLE4UxCmYMOM4Cip9eopdEY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Yd7mUTy7D0TRYwYMOFv/yCjF43pImsTj+re9eG52NRDPI2nY7iZxUwg6mADhBeSOc
         4Khy2Iby+MXuN+s+Z2OIV6Q5ZY5S0rJIp+6xd7FG1X3O2O4tyydUKURBO/VLqlf52h
         GUq14KyjP6Rt5J7czcqgDGWEDQJ8VG5aO4TujRf4=
Message-ID: <1597769070.3898.36.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date:   Tue, 18 Aug 2020 09:44:30 -0700
In-Reply-To: <20200818161955.GD137138@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-18 at 19:19 +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > plugged in to a PCR read function which is TPM version agnostic,
> > > so this works also for TPM 1.2 but the hash is only sha1 in that
> > > case.
> > > 
> > > Note: the macros used to create the hashes emit spurious
> > > checkpatch warnings.  Do not try to "fix" them as checkpatch
> > > recommends, otherwise they'll break.
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership
> > > .com>
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > 
> > I have hard time understanding why this is required.
> > 
> > You can grab the information through /dev/tpm0 just fine.
> 
> I just think it is principally wrong to add sysfs files if they don't
> have any measurable value other than perhaps some convenience.

That's pretty much the whole point of sysfs (and procfs): to add
convenient extraction of information even if it could potentially be
obtained by other sources.  For instance, the whole reason we add a lot
of the broken out inquiry data in SCSI via sysfs is precisely so users
don't have to go prodding devices with direct SCSI commands, which are
pretty much analagous to TPM device commands.

The question you should be asking isn't whether the information *could*
be obtained by other means, but whether providing it in this form
facilitates current operations and whether the interface would have
users.

> It is trival to write only a libc dependent program that outputs
> PCRs.

Not for someone who understands only scripting.  There are two
problems: firstly the actual construction of TPM commands is somewhat
complex and pretty much impossible even for shells like bash to
construct and secondly without a TSS installed, the tpm and tpmrm
devices are root owned and 0600 permissioned, so a non-root user simply
can't use them.

> I think this is essentially an user space problem that is getting
> sorted out with kernel code.

So you'd argue that a kernel shouldn't provide a filesystem because
it's simply a seekable key/value retrieval system provided over storage
devices (and there are plenty of databases that do it for you on raw
devices from userspace)?

A big point of a Kernel is to provide a load of convenience interfaces
to users even if users could, in theory, do it all themselves.  A
filesystem is actually a classic example because the directory
structure and file API make data organization and retrieval relatively
easy for the average user, whereas just presenting them with a SCSI
command interface and telling them to use it would be an instant
blocker for most of them.

The question, again, is not whether a user *could* do this another way
but whether the interface provided makes a task (or set of tasks)
easier, whether the API provided is easy to use and finally, whether
the interface will actually attract any users.

James

