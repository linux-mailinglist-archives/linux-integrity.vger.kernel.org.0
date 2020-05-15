Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1A1D41EA
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 02:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgEOAAr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 20:00:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:17357 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgEOAAr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 20:00:47 -0400
IronPort-SDR: qid2dEkSCvK+pyM55tMfjpyqTHN9m5Sqx+mMxHdlRszjyYJxVsFjxkCoU9OJrs4T/UrAm0WAw1
 ZgQr/rp0a4Ew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 17:00:46 -0700
IronPort-SDR: ca6NGik9rwL5TfUuopCMa37yfmw6w+5tfFEmLEcDsO+j+WiMzKp0s+BHsnCUEhu0AryC6eHS/K
 TorQLC+Wgq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="266421400"
Received: from ashadrin-mobl1.ccr.corp.intel.com ([10.249.38.112])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2020 17:00:37 -0700
Message-ID: <956b284c2b144313fd158de75cba510eb98f71bf.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Date:   Fri, 15 May 2020 03:00:25 +0300
In-Reply-To: <CAFA6WYMciZ=qkG3N_9YWzt_DJr2dGwdAy9diMXCJSNjr2o5ONA@mail.gmail.com>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
         <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
         <07bb6080f8be9f6613f460e2d6e19f3d456e219c.camel@linux.intel.com>
         <CAFA6WYMciZ=qkG3N_9YWzt_DJr2dGwdAy9diMXCJSNjr2o5ONA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 16:53 +0530, Sumit Garg wrote:
> On Thu, 14 May 2020 at 05:55, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM device as
> > > an underlying implementation which makes it difficult for implementations
> > > like Trusted Execution Environment (TEE) etc. to provide trusked keys
> > > support in case platform doesn't posses a TPM device.
> > > 
> > > So this patch tries to add generic trusted keys framework where underlying
> > > implemtations like TPM, TEE etc. could be easily plugged-in.
> > > 
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > 
> > I tend to agree how this is implemented and could merge it as such.
> > 
> > I'm just thinking if we could refine this patch in a way that instead of
> > copying TRUSTED_DEBUG macro we could just replace pr_info() statements
> > with pr_debug()?
> 
> AFAIU, TRUSTED_DEBUG being a security sensitive operation is only
> meant to be used in development environments and should be strictly
> disabled in production environments. But it may not always be true
> with pr_debug() with CONFIG_DYNAMIC_DEBUG=y which allows the debug
> paths to be compiled into the kernel which can be enabled/disabled at
> runtime.
> 
> IMO we should keep this TRUSTED_DEBUG macro, so that users are aware
> of its security sensitive nature and need to explicitly enable it to
> debug.

You are absolutely correct.

/Jarkko

