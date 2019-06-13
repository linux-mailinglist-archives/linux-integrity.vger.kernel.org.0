Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4043BDB
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfFMPcJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:32:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:59856 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfFMPcI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 11:32:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 08:32:07 -0700
X-ExtLoop1: 1
Received: from bbouchn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.22])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2019 08:32:03 -0700
Date:   Thu, 13 Jun 2019 18:32:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, jens.wiklander@linaro.org,
        corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org
Subject: Re: [RFC 4/7] KEYS: trusted: Introduce TEE based Trusted Keys
Message-ID: <20190613153202.GF18488@linux.intel.com>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560421833-27414-5-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 04:00:30PM +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
> 
> Refer to Documentation/tee.txt for detailed information about TEE.
> 
> Approach taken in this patch acts as an alternative to a TPM device in case
> platform doesn't possess one.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

How does this interact with the trusted module? Why there is no update
to security/keys/trusted-encrypted.txt?

Somehow the existing trusted module needs to be re-architected to work
with either. Otherwise, this will turn out to be a mess.

/Jarkko
