Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63E1FC03D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFPUu2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:50:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:47230 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgFPUu2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:50:28 -0400
IronPort-SDR: IH6Wvd7E4FYnpcYpGxbLXLRC8IKkP40KbDBgErfm8ABEy5+UaX6PSxum+JI+VkZNkdfgKfG8Tl
 iUJxCXiyNH1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:50:27 -0700
IronPort-SDR: YXL74oi5sxm+GZRM+/OQ7AXfpbGqE7eizgU++fL1fgFr+ZmJQ4pVv+TFAUaIUi6bKz72VRNgfQ
 PpPnH414kAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="277050009"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 13:50:19 -0700
Date:   Tue, 16 Jun 2020 23:50:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>, sumit.garg@linaro.org
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
Message-ID: <20200616205017.GC20943@linux.intel.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <20200604175851.758-2-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604175851.758-2-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 08:58:49PM +0300, Maxim Uvarov wrote:
> With the evolving use-cases for TEE bus, now it's required to support
> multi-stage enumeration process. But using a simple index doesn't
> suffice this requirement and instead leads to duplicate sysfs entries.
> So instead switch to use more informative device UUID for sysfs entry
> like:
> /sys/bus/tee/devices/optee-ta-<uuid>
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Sumit, are you able to test these easily?

/Jarkko
