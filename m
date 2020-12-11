Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C17A2D7407
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 11:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392157AbgLKKhv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 05:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391516AbgLKKhR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 05:37:17 -0500
Date:   Fri, 11 Dec 2020 12:36:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607682996;
        bh=BRZS5nXnwYhgoP19iUYWZOQLdrsuQXTKNWUg3UCsC1E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVCFcShfylaXBFX5PnCG5paBrp/6eCQ9IMvAY/s1AjaZ82EGXq/MwWbqR3I4//rUM
         dm2NojWfPzzA8AFjS5TvuOIKmpzW0x/akYuWEF/X0d4nq6gJDyxSagwE3hBOgPLdJB
         /RXS8FFvET7SyYLOfd/2is712MTtZt/jqvxFFnntt1jHmPOFrB+yV3wRJVnGL7yugJ
         1U61cNlgew06kq3PtnKTW0Jwk/3UKswf628fy2rM0sVc2rnUvtLw8XPjR7/SzYj5Es
         FMS9XnANIIyBLa8YoUvuNTNUjnnCnVjQbGXnDwvoHI2gLnq4PUaIeOwlC6d3Vx3oZt
         hscL/O2IrOQ2A==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     sumit.garg@linaro.org, Elaine Palmer <erpalmerny@gmail.com>,
        jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Kenneth Goldman <kgoldman@us.ibm.com>, gcwilson@linux.ibm.com,
        zgu@us.ibm.com, stefanb@us.ibm.com, NAYNA JAIN1 <naynjain@ibm.com>
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Message-ID: <20201211103627.GB12091@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
 <81A6B61D-3811-4957-B270-52AE5FA6DE4F@gmail.com>
 <20201204153037.GC4922@kernel.org>
 <ba6cd934bf7460cf6e9fc101a759a63fdd4e6e9b.camel@linux.ibm.com>
 <20201208174906.GA58572@kernel.org>
 <b2465d27f3683331019c5a9b6d0856304d992a0a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2465d27f3683331019c5a9b6d0856304d992a0a.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 09, 2020 at 11:50:19AM -0500, Mimi Zohar wrote:
> On Tue, 2020-12-08 at 19:49 +0200, Jarkko Sakkinen wrote:
> > On Tue, Dec 08, 2020 at 10:02:57AM -0500, Mimi Zohar wrote:
> 
> > > > Please also use a proper email client and split your paragraphs into
> > > > at most 80 character lines with new line characters when writing email.
> > > > I prefer to use 72 character line length so that there's some space
> > > > for longer email threads.
> > > 
> > > Sure, we'll re-post the suggested documentation changes/additions.
> > > 
> > > Mimi
> > 
> > So. Wouldn't it be a better idea to post a patch that Sumit could
> > squash to his (and add co-developed-by tag)?
> 
> I just posted it on Elaine's behalf.
>   
> Mimi

I responded. It's good that this feedback came as I think the whole
thing does not have the correct label for it.

/Jarkko
