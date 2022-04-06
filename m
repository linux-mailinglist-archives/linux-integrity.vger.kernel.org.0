Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2654F6C40
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiDFVNq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 17:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiDFVMd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 17:12:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1496D7908;
        Wed,  6 Apr 2022 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649274940; x=1680810940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J20fzEWTWmR3uYtjMGA+kYNrfafUzFxfY0/tWjpo4Js=;
  b=FCLralDZ2y5c+n5eyzl2OiHHACRbmYf7kxeimP94PKNKTJCMsJZFnYmT
   QkvZLQQ/gVtfSI3vrAJR51R4Ey3HTXe7Zv2I0m1NhtKSjPelBG4aLEApJ
   isXm1u1JmRLFbCr1goiTrjdmnSBl+RsXfx3ko6UWBm45u5urLJzTrJOjP
   8uYw4VWQfGcOzgcMYvJhFBnnFN+k8COeytB+D4op3ZUdQRgtDUR1Ts2t8
   wbY1dZKBBHECn0z0ITBo87VIzyZU8RmSQbeOYH10ZkPxz5WNAXJy0aH6l
   xFys/9q120W2eBc4VibibGl6ECGv/g0WTxrzkwxto3wAoI27PqY8YxWKs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241072221"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="241072221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 12:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="697504089"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2022 12:55:34 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncBkc-0004hT-7R;
        Wed, 06 Apr 2022 19:55:34 +0000
Date:   Thu, 7 Apr 2022 03:55:00 +0800
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
Subject: Re: [PATCH 5/7] KEYS: Introduce sig restriction that validates root
 of trust
Message-ID: <202204070321.X7bLj3Ce-lkp@intel.com>
References: <20220406015337.4000739-6-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406015337.4000739-6-eric.snowberg@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: riscv-randconfig-r042-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070321.X7bLj3Ce-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/68d98a175d29032d888f3f5700c43cf771ef17d8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-Snowberg/Add-CA-enforcement-keyring-restrictions/20220407-003209
        git checkout 68d98a175d29032d888f3f5700c43cf771ef17d8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash crypto/asymmetric_keys/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> crypto/asymmetric_keys/restrict.c:111:5: warning: no previous prototype for 'restrict_link_by_rot_and_signature' [-Wmissing-prototypes]
     111 | int restrict_link_by_rot_and_signature(struct key *dest_keyring,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/restrict_link_by_rot_and_signature +111 crypto/asymmetric_keys/restrict.c

   110	
 > 111	int restrict_link_by_rot_and_signature(struct key *dest_keyring,
   112					       const struct key_type *type,
   113					       const union key_payload *payload,
   114					       struct key *trust_keyring)
   115	{
   116		const struct public_key_signature *sig;
   117		struct key *key;
   118		int ret;
   119	
   120		if (!trust_keyring)
   121			return -ENOKEY;
   122	
   123		if (type != &key_type_asymmetric)
   124			return -EOPNOTSUPP;
   125	
   126		sig = payload->data[asym_auth];
   127		if (!sig)
   128			return -ENOPKG;
   129		if (!sig->auth_ids[0] && !sig->auth_ids[1] && !sig->auth_ids[2])
   130			return -ENOKEY;
   131	
   132		if (ca_keyid && !asymmetric_key_id_partial(sig->auth_ids[1], ca_keyid))
   133			return -EPERM;
   134	
   135		/* See if we have a key that signed this one. */
   136		key = find_asymmetric_key(trust_keyring,
   137					  sig->auth_ids[0], sig->auth_ids[1],
   138					  sig->auth_ids[2], false);
   139		if (IS_ERR(key))
   140			return -ENOKEY;
   141	
   142		if (!test_bit(KEY_FLAG_BUILTIN_ROT, &key->flags))
   143			ret = -ENOKEY;
   144		else if (use_builtin_keys && !test_bit(KEY_FLAG_BUILTIN, &key->flags))
   145			ret = -ENOKEY;
   146		else
   147			ret = verify_signature(key, sig);
   148		key_put(key);
   149		return ret;
   150	}
   151	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
