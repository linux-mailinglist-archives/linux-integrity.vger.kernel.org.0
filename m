Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578F81995E7
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgCaMBe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 08:01:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:57920 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgCaMBe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 08:01:34 -0400
IronPort-SDR: d9ROuewT2xCZ6nlyY5/smLR+nSlJlrsYE4RZZYTr1Hq9KJTR0mdO2XXE47fcEH3N2FwbqEV9Oz
 5nbtzAEHxM4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 05:01:33 -0700
IronPort-SDR: VMipwQDvzzjmcVAxC89TFAjfb3kqh6Mptuej9tNXBogG/WOEWnpjZTEBnlGHxWHUqGECANmN+x
 VllCkeGeHMsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="237679081"
Received: from tking1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.59.94])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2020 05:01:27 -0700
Date:   Tue, 31 Mar 2020 15:01:25 +0300
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
Message-ID: <20200331120125.GE8295@linux.intel.com>
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

Thanks for doing this. Looks like a lot of effort has gone to this.

Giving better feedback later.

/Jarkko
