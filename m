Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955AF8656D
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfHHPQB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 11:16:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:63160 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHPQB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 11:16:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 08:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="350203764"
Received: from sandersb-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.239])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2019 08:15:51 -0700
Date:   Thu, 8 Aug 2019 18:15:50 +0300
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
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-ID: <20190808151500.ypfcqowklalu76uq@linux.intel.com>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
 <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
 <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 08, 2019 at 06:51:38PM +0530, Sumit Garg wrote:
> It seems to be a functional change which I think requires proper unit
> testing. I am afraid that I don't posses a TPM device to test this and
> also very less conversant with tpm_buf code.
> 
> So what I have done here is to rename existing TPM 1.x trusted keys
> code to use tpm1_buf.
> 
> And I would be happy to integrate a tested patch if anyone familiar
> could work on this.

I can test it on TPM 1.2.

/Jarkko
