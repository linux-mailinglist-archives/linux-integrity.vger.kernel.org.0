Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6C98417
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Aug 2019 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfHUTMw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Aug 2019 15:12:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:22807 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfHUTMw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Aug 2019 15:12:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="178596098"
Received: from kumarsh1-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.104])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2019 12:12:43 -0700
Date:   Wed, 21 Aug 2019 22:12:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
Message-ID: <20190821191242.7z3en7om2few4tao@linux.intel.com>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <20190819165400.xsgpbtbj26y7d2wb@linux.intel.com>
 <CAFA6WYMCjKCf=aCVEXrQtZJ57V+2MCLNZKov6t37unzgpLmc0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMCjKCf=aCVEXrQtZJ57V+2MCLNZKov6t37unzgpLmc0A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 20, 2019 at 11:16:46AM +0530, Sumit Garg wrote:
> I agree here that 5/5 should go along with TEE patch-set. But if you
> look at initial v1 patch-set, the idea was to get feedback on trusted
> keys abstraction as a standalone patch along with testing using a TPM
> (1.x or 2.0).
> 
> Since Mimi has tested this patch-set with TPM (1.x & 2.0), I am happy
> to merge 5/5 with TEE patch-set. But it would be nice if I could get
> feedback on 5/5 before I send next version of TEE patch-set.

OK, that is understandable. I'll check it out tomorrow.

/Jarkko
