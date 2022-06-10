Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B154F546999
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbiFJPlZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 11:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFJPk0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 11:40:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A804A2A7A99;
        Fri, 10 Jun 2022 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654875588; x=1686411588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/xmB8i0JAfRDDmS2bDtJaItU5JaDKmsDXCMEkxCBqs=;
  b=ZJJFghvQmEJ6Rny04u6SgV/9WTHBagJy5KS+a0ZP0in+7dhj/wWn9dK4
   kk/U1wK6uQHo7geaBEQuAZx6VRb9FCK87KdjY599rePxpT0ApRngXhBHA
   i3VUE7xRnZ/JjN63YTROOLL/ct44e/qZzlp64DX1N2n1mkbEletxEThz1
   5nFde6ykvP6eIdeLFqZnLswXLRvDugAx7/QxwTZc+w1eiSGpaI4+BFKNN
   Rva/Y1nOh8XMmEpykY/Rfe5loeo0ihSd9yi6t+4BQKw0bA/jZ1G3DLLGt
   e7D9GCQzcy6XR683Gtk1etSMJy7A8eU0crEYQziDLfj7ZQF46KucEKsRF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="339414288"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="339414288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 08:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="616522242"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2022 08:39:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzgjf-000I45-Fe;
        Fri, 10 Jun 2022 15:39:43 +0000
Date:   Fri, 10 Jun 2022 23:38:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v6 3/3] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Message-ID: <202206102314.V0zCPT2v-lkp@intel.com>
References: <20220608173113.9232-4-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608173113.9232-4-Alexander.Steffen@infineon.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alexander,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on robh/for-next v5.19-rc1 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Steffen/tpm_tis_i2c/20220609-013636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git f2906aa863381afb0015a9eb7fefad885d4e5a56
config: riscv-randconfig-c004-20220609 (https://download.01.org/0day-ci/archive/20220610/202206102314.V0zCPT2v-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/char/tpm/tpm_tis_i2c.c:379:3-8: No need to set .owner here. The core will do it.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
