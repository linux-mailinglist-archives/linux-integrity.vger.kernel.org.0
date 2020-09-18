Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49D1270939
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Sep 2020 01:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIRXrX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Sep 2020 19:47:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40200 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgIRXrX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Sep 2020 19:47:23 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 19:47:22 EDT
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE10D8EE247;
        Fri, 18 Sep 2020 16:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600472417;
        bh=LVCybSKEUsY/yTj8vxPFuJd/L8e+xEr5DFBF0QVY88o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cn9QjQ/mNenqFUXF+E/I+KAfFV2BgxIGkzFo63A73dfuQB0JFxOCgGk7d67KrsSnV
         PvAxCw2siuQOUWXVMRQcD7AQe3Inmw3sHNrS2at3D0Ih6hSDKHRzcM5ResRqK0pVPn
         vZ1Iz99QZnRgow4KIqKRdzw6K1mD8dhlKLaJSEOQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dpO9D3bMSlB0; Fri, 18 Sep 2020 16:40:17 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AE9928EE120;
        Fri, 18 Sep 2020 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600472417;
        bh=LVCybSKEUsY/yTj8vxPFuJd/L8e+xEr5DFBF0QVY88o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cn9QjQ/mNenqFUXF+E/I+KAfFV2BgxIGkzFo63A73dfuQB0JFxOCgGk7d67KrsSnV
         PvAxCw2siuQOUWXVMRQcD7AQe3Inmw3sHNrS2at3D0Ih6hSDKHRzcM5ResRqK0pVPn
         vZ1Iz99QZnRgow4KIqKRdzw6K1mD8dhlKLaJSEOQ=
Message-ID: <1600472415.10078.30.camel@HansenPartnership.com>
Subject: Re: [PATCH v11 1/3] security: keys: trusted: add PCR policy to TPM2
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Fri, 18 Sep 2020 16:40:15 -0700
In-Reply-To: <20200914193712.GA3612@linux.intel.com>
References: <20200912173938.9714-1-James.Bottomley@HansenPartnership.com>
         <20200912173938.9714-2-James.Bottomley@HansenPartnership.com>
         <20200914193712.GA3612@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-14 at 22:37 +0300, Jarkko Sakkinen wrote:
> No sure why this is v11. I don't think we have reviewed this series
> that many times.

It was originally with the other patch set from the very beginning, so
it's definitely been sent 11 times.

> On Sat, Sep 12, 2020 at 10:39:36AM -0700, James Bottomley wrote:
> > This commit adds the ability to specify a PCR lock policy to TPM2
> > keys.  There is a complexity in that the creator of the key must
> > chose either to use a PCR lock policy or to use authentication.  At
> > the current time they can't use both due to a complexity with the
> > way authentication works when policy registers are in use.  The way
> > to construct a pcrinfo statement for a key is simply to use the
> > TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
> > hash of all their values in order of ascending PCR number.
> > 
> > For simplicity, we require the policy name hash and the hash used
> > for the PCRs to be the same.  Thus to construct a policy around the
> > value
> 
> It would be better to write "name hash algorithm" and "policy hash
> algorithm".

For simplicity we require the hash of the PCRs to use the same
algorithm as the policy hash

> > of the resettable PCR 16 using the sha1 bank, first reset the pcr
> > to
> 
>                                                                 ~~~
> 								PCR
> 
> > zero giving a hash of all zeros as:
> > 
> > 6768033e216468247bd031a0a2d9876d79818f8f
> > 
> > Then the TPMS_PCR_SELECT value for PCR 16 is
> > 
> > 03000001
> > 
> > So create a new 32 byte key with a policy policy locking the key to
> > this value of PCR 16 with a parent key of 81000001 would be:
> > 
> > keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1
> > pcrinfo=030000016768033e216468247bd031a0a2d9876d79818f8f" @u
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > 
> 
> Extra newline.

git am just elides this, but I can fix it and the other phrases up.]

[...]
> > 
> > +int tpm2_key_policy(void *context, size_t hdrlen,
> > +		  unsigned char tag,
> > +		  const void *value, size_t vlen)
> > +{
> > +	struct tpm2_key_context *ctx = context;
> > +
> > +	ctx->policies[ctx->policy_count] = value;
> > +	ctx->policy_len[ctx->policy_count++] = vlen;
> > +
> > +	return 0;
> > +}
> 
> As non-static symbols, and in general to make the code more
> understandable, must be documeted.

Will add docbook comment.

James

