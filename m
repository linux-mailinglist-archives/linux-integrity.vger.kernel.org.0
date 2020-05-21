Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171EF1DC6B1
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2020 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgEUFt7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 May 2020 01:49:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:40024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgEUFt7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 May 2020 01:49:59 -0400
IronPort-SDR: V8nCkvOS2i7bJVWnDxjmARpdWf7aLHnMNGGr84/SDTeTNg2fYVXx40VCGkXL/kMCoggUz4lJXw
 L6+s7d1WxbXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 22:49:59 -0700
IronPort-SDR: RzIGOtQ+baA9i1EkK4LHm61fbWr2Z0/9hYrynMXSW6By41ypzYZwjYMawWeoeUKwyWVF/1nnpK
 PtMhLTp8qnXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="253880916"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 22:49:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jbe5c-000BRS-2q; Thu, 21 May 2020 13:49:56 +0800
Date:   Thu, 21 May 2020 13:49:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     kbuild-all@lists.01.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [RFC PATCH] optee: __optee_enumerate_devices() can be static
Message-ID: <20200521054932.GA42084@f61f8b3f25ca>
References: <20200518133459.28019-2-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518133459.28019-2-maxim.uvarov@linaro.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 8263b308efd56..d4931dad07aaa 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -87,7 +87,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
 	return rc;
 }
 
-int __optee_enumerate_devices(u32 func)
+static int __optee_enumerate_devices(u32 func)
 {
 	const uuid_t pta_uuid =
 		UUID_INIT(0x7011a688, 0xddde, 0x4053,
