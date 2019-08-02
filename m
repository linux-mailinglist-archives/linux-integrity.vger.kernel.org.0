Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1472C80118
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406079AbfHBTiL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 15:38:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:16635 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403792AbfHBTiL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 15:38:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 12:38:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="201764551"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2019 12:38:03 -0700
Date:   Fri, 2 Aug 2019 22:38:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Subject: Re: [RFC/RFT v2 1/2] KEYS: trusted: create trusted keys subsystem
Message-ID: <20190802193802.jn56jhoz5crebggt@linux.intel.com>
References: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
 <1563449086-13183-2-git-send-email-sumit.garg@linaro.org>
 <20190801172310.cldcftfdoh5vyfjg@linux.intel.com>
 <CAFA6WYM+FQuXA9Saj5+ffOGsc-shhiF5Uos4g14Qndvu6w97Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYM+FQuXA9Saj5+ffOGsc-shhiF5Uos4g14Qndvu6w97Sg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 02, 2019 at 11:20:09AM +0530, Sumit Garg wrote:
> On Thu, 1 Aug 2019 at 22:54, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, Jul 18, 2019 at 04:54:45PM +0530, Sumit Garg wrote:
> > > Move existing code to trusted keys subsystem. Also, rename files with
> > > "tpm" as suffix which provides the underlying implementation.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > What about TPM2 trusted keys code?
> 
> Isn't TPM2 code located here: "drivers/char/tpm/"? Would you like to
> move that code under trusted keys subsystem only?

Yeah, we need a design decision here. What I care is that they should
be in the same subsystem. I did trusted keys directly to TPM 2.0 subsys
because the subsystem was not too robust back then.

Right now I think it would be feasible to implement TPM2 trusted keys
outside TPM driver since the whole transmit functionality is way more
robust.

/Jarkko
