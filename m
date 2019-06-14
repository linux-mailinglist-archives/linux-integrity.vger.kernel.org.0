Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6DF46301
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNPgk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 11:36:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:45350 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPgk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 11:36:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:36:39 -0700
X-ExtLoop1: 1
Received: from mdumitrx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.32.245])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2019 08:36:30 -0700
Date:   Fri, 14 Jun 2019 18:36:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Subject: Re: [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys
Message-ID: <20190614153622.GG11241@linux.intel.com>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-7-git-send-email-sumit.garg@linaro.org>
 <20190613153414.GG18488@linux.intel.com>
 <CAFA6WYP7qi_NBRUDBhcEAEzJY-iFvJdXqtCtgQxqAvPSXDjEng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYP7qi_NBRUDBhcEAEzJY-iFvJdXqtCtgQxqAvPSXDjEng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 14, 2019 at 11:07:23AM +0530, Sumit Garg wrote:
> On Thu, 13 Jun 2019 at 21:04, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, Jun 13, 2019 at 04:00:32PM +0530, Sumit Garg wrote:
> > > Provide documentation for usage of TEE based Trusted Keys via existing
> > > user-space "keyctl" utility. Also, document various use-cases.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Sorry missed this patch. Anyway, I don't think we want multiple trusted
> > keys subsystems. You have to fix the existing one if you care to get
> > these changes in. There is no really other way around this.
> >
> 
> I understand your point.
> 
> When I initially looked at trusted key implementation, it seemed to be
> tightly coupled to use TPM device. So I implemented a parallel
> implementation to get initial feedback (functionality-wise) on this
> new approach.

Yeah, I completely get this. My feedback this is: we can definitely
consider TEE based trusted keys, and I know that trusted.ko is a mess,
but still that is the only right long-term path. Think about the
positive side: if you as a side-effect can make it cleaner and more
versatile, your patch set will improve the quality of the kernel as a
whole i.e. you benefit larger audience than just TEE user base :-)

> I will work on abstraction of trusted key apis to use either approach.
> But is it fine with you if I send if I send a separate RFC patch for
> abstraction and later once reviewed I will incorporate that patch in
> this patch-set.
> 
> It will be really helpful if you could help to test that abstraction
> patch with a real TPM device as I doesn't posses one to test.

I can, yes.

/Jarkko
