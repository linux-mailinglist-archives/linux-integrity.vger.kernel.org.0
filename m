Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88802C87F4
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 16:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgK3P11 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 10:27:27 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:40162 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbgK3P10 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 10:27:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AA81C1280A6F;
        Mon, 30 Nov 2020 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606750004;
        bh=zumiwSazpK55tNRFGBFzzI3yo5Ly/pV2WfcikY/35C8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Bm6/3oruyIG/x6/IKzHQVm0VJEgsCdQPh10kw3PKHpTDgnVb8ox4T30uKo0egL2Xu
         lCtuwoZB0ZoVJMjx8C9/4Sqr0UG7gH21lhjVsZdZiwdyPIFSrpVtXeWO7i3iohWlvS
         7seFQuDh7Cw02fnmAupgAg7BHgnk2sDoo0bZ4T0s=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GgQ0vFvIaRmn; Mon, 30 Nov 2020 07:26:44 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 52E551280A62;
        Mon, 30 Nov 2020 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606750004;
        bh=zumiwSazpK55tNRFGBFzzI3yo5Ly/pV2WfcikY/35C8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Bm6/3oruyIG/x6/IKzHQVm0VJEgsCdQPh10kw3PKHpTDgnVb8ox4T30uKo0egL2Xu
         lCtuwoZB0ZoVJMjx8C9/4Sqr0UG7gH21lhjVsZdZiwdyPIFSrpVtXeWO7i3iohWlvS
         7seFQuDh7Cw02fnmAupgAg7BHgnk2sDoo0bZ4T0s=
Message-ID: <340647a1c39a0affd994e39f5b0163f60f62b261.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Date:   Mon, 30 Nov 2020 07:26:43 -0800
In-Reply-To: <X8Sq6VPMtOxPAi3N@kroah.com>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
         <X8Sq6VPMtOxPAi3N@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-30 at 09:18 +0100, Greg KH wrote:
> On Sun, Nov 29, 2020 at 02:30:21PM -0800, James Bottomley wrote:
> > Cc to linux-api to get an opinion on two issues.  First the
> > background:
> > 
> > We've had a fairly extensive discussion over on linux-integrity and
> > iterated to the conclusion that the kernel does need to export TPM
> > 2.0 PCR values for use by a variety of userspace integrity
> > programmes including early boot.  The principle clinching argument
> > seems to be that these values are required by non-root systems, but
> > in a default Linux set up the packet marshalled communication
> > device: /dev/tpmrm0, is by default only usable by
> > root.  Historically, TPM 1.2 exported these values via sysfs in a
> > single file containing all 24 values:
> > 
> >   /sys/class/tpm/tpm0/pcrs
> > 
> > with the format
> > 
> >   PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7
> > 69 
> >   PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30
> > BE 
> >   ...
> 
> As you know, this breaks the "one value per file" for sysfs, so
> please, do not add more files that do this.

I haven't ... if you read the below you'll see it's now one value per
file.

> > TPM 2.0 adds more complexity: because of it's "agile" format, each
> > TPM 2.0 is required to support a set of hashes (of which at least
> > sha1 and sha256 are required but quite a few TPM 2.0s have at least
> > two or three more) and maintain 24 PCR registers for each supported
> > hash. The current patch exports each PCR bank under the directory
> > 
> >   /sys/class/tpm/tpm0/pcr-<hash>/<bank>
> > 
> > So the sha256 bank value of PCR 7 can be obtained as
> > 
> >   cat /sys/class/tpm/tpm0/pcr-sha256/7
> >   2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42
> > 
> > And the output is a single non-space separated ascii hex value of
> > the hash.
> > 
> > The issues we'd like input on are:
> > 
> >  1. Should this be in sysfs or securityfs?
> 
> If you want to use sysfs, use one value per file please.

It is ... each PCR gives one hash value per PCR and bank.  That's what
the file above is showing.  The hash values are 20 bytes for sha1, 32
bytes for sha256 and so on.

> >   2. Should we export the values as one value per file (current
> > patch)
> >      or as a binary blob of all 24?
> 
> Binary sysfs files are for "pass-through" mode where the kernel is
> not parsing/manipulating the data at all.  Do these values come
> straight from the hardware?  If so, sure, use a binary blob.  If not,
> then no, do not use that in sysfs as sysfs is to be in text format.

There was a question over whether the hash should be ascii as above
(hex representation) so human readable, or the 20/32/whatever binary
bytes of the hash.  I think we've got that resolved that ascii works.

James


