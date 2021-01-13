Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711352F5471
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 22:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbhAMVDu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 16:03:50 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:42726 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728932AbhAMVCO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 16:02:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D0F711280937;
        Wed, 13 Jan 2021 13:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610571757;
        bh=fE4Zcfq/Y4akqpkapJYGe64eKFJFZOMq55tpgFz7vVs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dl4yC8ZtzcsUIGnJEZLCCSO6SL4K+hUbygwLH50SE/qHCnZUBXjYJbiVY1M9dcPXl
         /kIL3wmstaREA7lwPLYkf8iOA3cDxIwsATy8uCbu42ScydQItnxfc8xk7ME/xytV+E
         2ku1pYYnoS9EIreFKn+V/0rw7w07p/Fz78clOybk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nxOEhDK8RJzd; Wed, 13 Jan 2021 13:02:37 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6C1111280935;
        Wed, 13 Jan 2021 13:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610571757;
        bh=fE4Zcfq/Y4akqpkapJYGe64eKFJFZOMq55tpgFz7vVs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dl4yC8ZtzcsUIGnJEZLCCSO6SL4K+hUbygwLH50SE/qHCnZUBXjYJbiVY1M9dcPXl
         /kIL3wmstaREA7lwPLYkf8iOA3cDxIwsATy8uCbu42ScydQItnxfc8xk7ME/xytV+E
         2ku1pYYnoS9EIreFKn+V/0rw7w07p/Fz78clOybk=
Message-ID: <f2ce12077098dc87c7fb7fd52f3b8f0cf93509e7.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 0/1] add sysfs exports for TPM 2 PCR registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Date:   Wed, 13 Jan 2021 13:02:36 -0800
In-Reply-To: <X/9cqbUN263oR8gZ@linux.intel.com>
References: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
         <X/9cqbUN263oR8gZ@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-01-13 at 22:48 +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 12, 2021 at 05:59:57PM -0800, James Bottomley wrote:
> > This represents v5 which has the spelling mistake fixed and the
> > WARN
> > on unrecognized TPM hash algorithm becoming a dev_err.
> > 
> > We've had a fairly extensive discussion and iterated to agreement
> > on
> > the output format, which becomes our ABI being one single compact
> > hex
> > representation of the hash value per file according to sysfs rules,
> > with the file hierarchy going under
> > 
> >   /sys/class/tpm/tmp<x>/pcr-<hash>/<pcr number>
> > 
> > So to get the value of PCR 7 in the sha256 bank of the default TPM
> > I'd do
> > 
> >    cat /sys/class/tpm/tpm0/pcr-sha256/7
> >    2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42
> > 
> > If you need the binary hash of a set of PCRs, as is required for
> > TPM
> > policy statements that lock to PCRs, you'd use something like:
> > 
> >   cat /sys/class/tpm/tpm0/pcr-sha256/{1,6,7}|xxd -r -p|sha256sum
> > 
> > Which produces the binary hash of PCRs 1, 6 and 7 in that order.
> > 
> > Note that this patch also adds the sha1 bank for TPM 1.2 in the
> > same
> > manner (one file per PCR) but does not remove the existing pcrs
> > file
> > which has the space separated all PCRs in one file format of
> > 
> >   PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7
> > 69 
> >   PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30
> > BE 
> >   ...
> > 
> > 
> > James
> > 
> > ---
> > 
> > James Bottomley (1):
> >   tpm: add sysfs exports for all banks of PCR registers
> > 
> >  drivers/char/tpm/tpm-sysfs.c | 179
> > +++++++++++++++++++++++++++++++++++
> >  include/linux/tpm.h          |   9 +-
> >  2 files changed, 187 insertions(+), 1 deletion(-)
> > 
> > -- 
> > 2.26.2
> > 
> 
> After clearing out Greg's remarks, can you use jarkko@kernel.org
> for the next version?

Sorry, it's a force of habit process: i go back to version n-1 and copy
the to and cc list ... so the promise to sent to kernel.org didn't get
realised.

I'll just do a resend since there are no changes requested.

James


