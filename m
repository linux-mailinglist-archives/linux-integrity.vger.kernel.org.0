Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7831D2394
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 02:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgENAZ1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 20:25:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:53240 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732946AbgENAZ0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 20:25:26 -0400
IronPort-SDR: pw48jvxnERiPyZBSrKdMTKCsAM/mOxATAGPHq+ahdRvbcbobJR3CJmk+E8d8dCqr2XfgWJM5cf
 6NZtcSQQgggg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 17:25:26 -0700
IronPort-SDR: LmigXyC+PKXEwMmfY0sVl4rNnEd46L+o3kglBun/40P0Ry5MzcqKSfH2nUh0qUui+AXBzt99h0
 L6gOZAQubFMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="262661894"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2020 17:25:20 -0700
Message-ID: <07bb6080f8be9f6613f460e2d6e19f3d456e219c.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org
Date:   Thu, 14 May 2020 03:25:14 +0300
In-Reply-To: <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
         <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusked keys
> support in case platform doesn't posses a TPM device.
> 
> So this patch tries to add generic trusted keys framework where underlying
> implemtations like TPM, TEE etc. could be easily plugged-in.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I tend to agree how this is implemented and could merge it as such.

I'm just thinking if we could refine this patch in a way that instead of
copying TRUSTED_DEBUG macro we could just replace pr_info() statements
with pr_debug()?

/Jarkko

