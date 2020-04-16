Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD31ACF10
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgDPRqW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 13:46:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:10730 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgDPRqV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 13:46:21 -0400
IronPort-SDR: iuNe52aiEs5NuXZJDXBVyQDW4ZjNLa+iYhtAjDcDxHaGVYLdTqAKVxVUrlSVYglgDG/qMJhejB
 IDts2bfniNUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:46:21 -0700
IronPort-SDR: YgiUGzOeMW41WCgj58lcvyywAJ8VFffHfyg+MotUV93rXD8YWnSAN7qxNX7jWJ/qRTgJ2ZpPwp
 T9v6ExxYRFDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="244462208"
Received: from otazetdi-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.42.128])
  by fmsmga007.fm.intel.com with ESMTP; 16 Apr 2020 10:46:17 -0700
Date:   Thu, 16 Apr 2020 20:46:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        casey@schaufler-ca.com, janne.karhunen@gmail.com,
        kgoldman@us.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        daniel.thompson@linaro.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source
Message-ID: <20200416174617.GI199110@linux.intel.com>
References: <1585636165-22481-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585636165-22481-1-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 11:59:25AM +0530, Sumit Garg wrote:
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
> 
> - Add a section to demostrate a list of supported devices along with
>   their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
>   source.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Overally this works for me. Can you bundle this with the code
changes. Maybe some details needs to be fine tuned but easier
to look into them in the context of rest of the patches.

/Jarkko
