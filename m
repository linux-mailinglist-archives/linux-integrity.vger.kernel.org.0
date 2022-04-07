Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A284F6F64
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 03:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiDGBHO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 21:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiDGBHK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 21:07:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC23CBE1A;
        Wed,  6 Apr 2022 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649293507; x=1680829507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=myer2bVBJAzVTcO8FK/Itx5etIcCeXikEzZUTZdKYyQ=;
  b=CRTGINvpegqE3Ct4eATioeXgEOoVjVJ/SiNTNo7WZNxYuIBo20K4WiLN
   B3hN51N6MQrB51lHpSK3EnWDVlHQxCM+xHvN7bY2ezStPZkj92VOJjyK5
   DKjQaWZFIRHMb+OCBrLkSLMuL4zAqpwYK69p5PxH7qHjfepzFy8nSuLgP
   cR0rKvkNhTVmxTGl/Fsr1Qeuhoa+QNHN+YG+HwX7FDQoFLCmx4QVZyupD
   AqtRwO+UBAjDsbzs5a9heCZ3HmbV+eG7PNeaxOViv73EJshe0yghbz+J4
   DPf8+CW98RMXb+v6aF8cQmGBFJ7AXcYYTWuWnUsAyCPz+w1TOS4pOueG8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="243330976"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="243330976"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="609119120"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 06 Apr 2022 18:05:02 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncGa6-0004ur-5a;
        Thu, 07 Apr 2022 01:05:02 +0000
Date:   Thu, 7 Apr 2022 09:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, jarkko@kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        nramas@linux.microsoft.com, eric.snowberg@oracle.com,
        pvorel@suse.cz, tiwai@suse.de, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 6/7] KEYS: X.509: Flag Intermediate CA certs as built in
Message-ID: <202204070929.nFQNU3B8-lkp@intel.com>
References: <20220406015337.4000739-7-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406015337.4000739-7-eric.snowberg@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 3123109284176b1532874591f7c81f3837bbdc17]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Snowberg/Add-CA-enforcement-keyring-restrictions/20220407-003209
base:   3123109284176b1532874591f7c81f3837bbdc17
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220407/202204070929.nFQNU3B8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b0858df3dd6d627f8fa75cc973f55516372a5c98
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-Snowberg/Add-CA-enforcement-keyring-restrictions/20220407-003209
        git checkout b0858df3dd6d627f8fa75cc973f55516372a5c98
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/file_table.c:28:
>> include/linux/ima.h:189:56: warning: 'union key_payload' declared inside parameter list will not be visible outside of this definition or declaration
     189 |                                            const union key_payload *payload,
         |                                                        ^~~~~~~~~~~
>> include/linux/ima.h:188:57: warning: 'struct key_type' declared inside parameter list will not be visible outside of this definition or declaration
     188 |                                            const struct key_type *type,
         |                                                         ^~~~~~~~


vim +189 include/linux/ima.h

   179	
   180	#ifdef CONFIG_ASYMMETRIC_KEY_TYPE
   181	#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
   182	#define ima_validate_builtin_rot restrict_link_by_rot_builtin_and_secondary_trusted
   183	#else
   184	#define ima_validate_builtin_rot restrict_link_by_rot_builtin_trusted
   185	#endif
   186	#else
   187	static inline int ima_validate_builtin_rot(struct key *dest_keyring,
 > 188						   const struct key_type *type,
 > 189						   const union key_payload *payload,
   190						   struct key *unused){
   191		return -EPERM;
   192	}
   193	#endif
   194	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
