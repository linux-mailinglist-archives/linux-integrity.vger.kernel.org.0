Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602624A9AD
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgHSWqT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 18:46:19 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48402 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbgHSWqS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 18:46:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B3B0C8EE3F2;
        Wed, 19 Aug 2020 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597877177;
        bh=pl69dwTZhrluzJRMEI8LbDHyiudH5aG5J3QmfvvGlQk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y5azcYBtWOVnUAycUK+g0r8PFOlxufHEzJrqJN3GhmDtP9cjZcVaS4INSfhHR7aBW
         esebfZ/TCccxvEFHmzeKwfcUaNQa+Sfxlin8ghDAMEnIgg+o/Ku+YkeQDalFfombFF
         V9NjyPqw/ThHqtYCPu+6P1Fv+J7jn/tNiNgldmqg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WHc5sf2K0TlF; Wed, 19 Aug 2020 15:46:17 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 44C1F8EE0E9;
        Wed, 19 Aug 2020 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597877177;
        bh=pl69dwTZhrluzJRMEI8LbDHyiudH5aG5J3QmfvvGlQk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y5azcYBtWOVnUAycUK+g0r8PFOlxufHEzJrqJN3GhmDtP9cjZcVaS4INSfhHR7aBW
         esebfZ/TCccxvEFHmzeKwfcUaNQa+Sfxlin8ghDAMEnIgg+o/Ku+YkeQDalFfombFF
         V9NjyPqw/ThHqtYCPu+6P1Fv+J7jn/tNiNgldmqg=
Message-ID: <1597877175.4030.17.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed, 19 Aug 2020 15:46:15 -0700
In-Reply-To: <20200819215332.GI9942@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <1597769070.3898.36.camel@HansenPartnership.com>
         <20200818171712.GZ24045@ziepe.ca>
         <1597776566.3898.52.camel@HansenPartnership.com>
         <20200819215332.GI9942@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-20 at 00:53 +0300, Jarkko Sakkinen wrote:
> > On Tue, 2020-08-18 at 14:17 -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 18, 2020 at 09:44:30AM -0700, James Bottomley wrote:
> > > 
> > > > The question you should be asking isn't whether the information
> > > > *could* be obtained by other means, but whether providing it in
> > > > this form facilitates current operations and whether the
> > > > interface would have users.
> > > 
> > > Sure. What are the use cases that need PCRs but no other TPM
> > > operations?
> > > 
> > > The cover letter didn't say. As PCR is really only useful in the
> > > context of the local TPM I'm not thinking of anything..
> > 
> > The three use cases I picked up at the Boot and Security MC were:
> > 
> >    1. local log verification: a script can run through the IMA
> > ascii log
> >       and construct the PCR 10 hash which can then be verified
> >    2. Knowing what the PCR values actually are for sealed
> > keys.  With the
> >       current trusted key infrastructure you have to calculate and
> > supply
> >       the hash yourself.  With the new proposed infrastructure, the
> > hash
> >       would be calculated by the seal operation, but you're still
> > going to
> >       need the actual PCR values to debug unseal failures.
> >    3. As a stability check for log shipping: you read the PCR take
> > the log
> >       then read the PCR: if the two reads are the same the PCR
> > backing the
> >       log is stable for quoting.
> > 
> > James
> 
> The proposed sysfs attributes are racy in the sense that PCRs could
> change in-between reading different hashes.

That's not really a problem, is it?  For use case 2. we expect them to
be stable otherwise you're doing the wrong thing sealing to them. For
the IMA PCR you use the stability protocol in 3.

> A blob containing all the hashes would make more sense as it does not
> have this issue.

It doesn't really buy anything though.  If you're verifying the log you
always have the problem that the PCR and the log are at different
points, so you follow the protocol in 3. or read PCR then log and
unwind the log until it matches or you've gone too far.

> If this is for scripts to further process, it is also more efficient
> than printable ASCII text.

I'm not fundamentally opposed to binary attributes, but realistically
if I want the hash of PCRs 1 4 and 6 it's not fundamentally different
to me whether I do

cat /sys/class/tpm/tpm0/pcr-sha256/1 /sys/class/tpm/tpm0/pcr-sha256/4 /sys/class/tpm/tpm0/pcr-sha256/6|sha256sum

or

cat /sys/class/tpm/tpm0/pcr-sha256/1 /sys/class/tpm/tpm0/pcr-sha256/4 /sys/class/tpm/tpm0/pcr-sha256/6|xxd -r -p|sha256sum

The point being the tool to convert the hex output back to binary
already exists and is well known ... and binary attributes have nasty
console properties if you accidentally cat them directly.

James

