Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860C4A3CEC
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3RY0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 13:24:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:45902 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfH3RYZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 13:24:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 10:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="193397728"
Received: from floriank-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.77])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2019 10:24:07 -0700
Date:   Fri, 30 Aug 2019 20:24:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Subject: Re: [RFC/RFT v4 5/5] KEYS: trusted: Add generic trusted keys
 framework
Message-ID: <20190830172405.rafhm362tsuufbqb@linux.intel.com>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-6-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYO7Z-Enmnqt8zA_+VV_p=mAc+AotTetv9hhf2xHm0mR9g@mail.gmail.com>
 <20190830172031.dm5icfyakko6eqak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830172031.dm5icfyakko6eqak@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 30, 2019 at 08:20:31PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 30, 2019 at 02:49:31PM +0530, Sumit Garg wrote:
> > Any comments/feedback on this patch before I send next version of TEE
> > patch-set with this patch included?
> 
> Unfortunately don't have time before LPC to go deep with the follow up.
> 
> I will look into this in detail after LPC.

I'll ping you once your first row of patches are in my tree so you
can rebase these on top of that.

/JArkko
