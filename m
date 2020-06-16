Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA61FC087
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 23:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFPU5k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:57:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:61308 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgFPU5k (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:57:40 -0400
IronPort-SDR: 5gcjQoT+PNDZm1ek3QSQQOZNsAdC99jU8u0KEAd4Lr+Rx8i/VyOVgjA2btv4rEX4I82jZfp6Dc
 8aW9wdD9bMXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:57:39 -0700
IronPort-SDR: aGZvAOnGEPGr1XK59sU0e1rUzVAIi2qEubYftAwcjSgOjsPdRMfuaqjAYXdpgUOTMMJltunT/x
 50mHfSwTvxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="277052052"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 13:57:34 -0700
Date:   Tue, 16 Jun 2020 23:57:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCHv8 3/3] tpm_ftpm_tee: register driver on TEE bus
Message-ID: <20200616205732.GF20943@linux.intel.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <20200604175851.758-4-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604175851.758-4-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 08:58:51PM +0300, Maxim Uvarov wrote:
> OP-TEE based fTPM Trusted Application depends on tee-supplicant to
> provide NV RAM implementation based on RPMB secure storage. So this
> dependency can be resolved via TEE bus where we only invoke fTPM
> driver probe once fTPM device is registered on the bus which is only
> true after the tee-supplicant is up and running. Additionally, TEE bus
> provides auto device enumeration.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
