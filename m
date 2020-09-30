Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA127EB59
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgI3Otz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 10:49:55 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:32794 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729767AbgI3Otz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 10:49:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A73A28EE14D;
        Wed, 30 Sep 2020 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601477394;
        bh=TvP7s5XtsfpB2dpAskNg0N42/e2s1CPr/YVReRaKh4U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HoKrxgt4Bxz380Q55vq8Bk/U4Wvm7HGARzTyRUSAUp/aHfe0mlPwmFNj9q+7R74CF
         aLmajkmlU2H82w6eU/GaJb84YehWYTJL0fGbsThU91OLhXZn0ia8TSx/0PQ7HT4SEi
         XX6nXCu37m1BroOgi29FGTnbhVLk9eHSqDha+oEc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3DYRRwicsEAW; Wed, 30 Sep 2020 07:49:54 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BAB608EE0E2;
        Wed, 30 Sep 2020 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601477394;
        bh=TvP7s5XtsfpB2dpAskNg0N42/e2s1CPr/YVReRaKh4U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HoKrxgt4Bxz380Q55vq8Bk/U4Wvm7HGARzTyRUSAUp/aHfe0mlPwmFNj9q+7R74CF
         aLmajkmlU2H82w6eU/GaJb84YehWYTJL0fGbsThU91OLhXZn0ia8TSx/0PQ7HT4SEi
         XX6nXCu37m1BroOgi29FGTnbhVLk9eHSqDha+oEc=
Message-ID: <b8de8923e026525589c97b3cb7691a557c0a292f.camel@HansenPartnership.com>
Subject: Re: [PATCH v13 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Wed, 30 Sep 2020 07:49:51 -0700
In-Reply-To: <20200930111102.GB5145@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
         <20200922022809.7105-5-James.Bottomley@HansenPartnership.com>
         <20200930111102.GB5145@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-30 at 14:11 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 21, 2020 at 07:28:08PM -0700, James Bottomley wrote:
> > Modify the TPM2 key format blob output to export and import in the
> > ASN.1 form for TPM2 sealed object keys.  For compatibility with
> > prior trusted keys, the importer will also accept two TPM2B
> > quantities representing the public and private parts of the
> > key.  However, the export via keyctl pipe will only output the
> > ASN.1 format.
> > 
> > The benefit of the ASN.1 format is that it's a standard and thus
> > the exported key can be used by userspace tools
> > (openssl_tpm2_engine, openconnect and tpm2-tss-engine).  The format
> > includes policy specifications, thus it gets us out of having to
> > construct policy handles in userspace and the format includes the
> > parent meaning you don't have to keep passing it in each time.
> > 
> > This patch only implements basic handling for the ASN.1 format, so
> > keys with passwords but no policy.
> > 
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> 
> I did the test for 3/5 with this patch applied (actually all patches
> in this series) so I can safely
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I have one wish though before giving reviewed-by.
> 
> In my recent trusted keys fixes I took the convention trusted_tpm_*
> for TPM trusted keys functions. I think we should start doing that
> for all functions:
> 
> 1. For interface functions trusted_tpm_*
> 2. TPM1: trusted_tpm1_*
> 2. TPM2: trusted_tpm2_*

I'm not such a fan of this: we've discussed moving some of the
functions around because we expect to grow consumers.  We really don't
want to be having to rename everything as we move it, so I'd far prefer
the name were related to the function rather than the location in the
kernel tree.

> This is to manage chaos with TEE Trusted Keys in future and make the
> distinction with TPM subsystem functions, and make it easier to grep
> and trace this stuff with the various tracing tools.
> 
> This anyway needs one more rebase on top of the fixes that I did.
> 
> BTW, what is the situation with the ARM compilation issue?

It was fixed in this incarnation.

James


