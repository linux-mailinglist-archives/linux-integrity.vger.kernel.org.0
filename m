Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB11D407320
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 23:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhIJVyj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 17:54:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:44955 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233480AbhIJVyi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 17:54:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="306748831"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="gz'50?scan'50,208,50";a="306748831"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 14:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="gz'50?scan'50,208,50";a="450654629"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2021 14:53:21 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOoSW-0004kB-BY; Fri, 10 Sep 2021 21:53:20 +0000
Date:   Sat, 11 Sep 2021 05:52:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     kbuild-all@lists.01.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org, seth.forshee@canonical.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH] integrity: support including firmware ".platform" keys
 at build time
Message-ID: <202109110507.ucpEmrwz-lkp@intel.com>
References: <20210910172515.8430-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20210910172515.8430-1-nayna@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nayna,

I love your patch! Perhaps something to improve:

[auto build test WARNING on integrity/next-integrity]
[also build test WARNING on linus/master v5.14 next-20210910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nayna-Jain/integrity-support-including-firmware-platform-keys-at-build-time/20210911-012617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fb58bf03a2f9965a2e0cfdcb16d1bad2fc5f083a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nayna-Jain/integrity-support-including-firmware-platform-keys-at-build-time/20210911-012617
        git checkout fb58bf03a2f9965a2e0cfdcb16d1bad2fc5f083a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   certs/common.c: In function 'load_certificate_list':
   certs/common.c:11:9: error: unknown type name 'key_ref_t'; did you mean 'key_ref_put'?
      11 |         key_ref_t key;
         |         ^~~~~~~~~
         |         key_ref_put
   certs/common.c:31:23: error: implicit declaration of function 'key_create_or_update' [-Werror=implicit-function-declaration]
      31 |                 key = key_create_or_update(make_key_ref(keyring, 1),
         |                       ^~~~~~~~~~~~~~~~~~~~
   certs/common.c:36:46: error: 'KEY_POS_ALL' undeclared (first use in this function)
      36 |                                            ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
         |                                              ^~~~~~~~~~~
   certs/common.c:36:46: note: each undeclared identifier is reported only once for each function it appears in
   certs/common.c:36:61: error: 'KEY_POS_SETATTR' undeclared (first use in this function)
      36 |                                            ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
         |                                                             ^~~~~~~~~~~~~~~
   certs/common.c:37:44: error: 'KEY_USR_VIEW' undeclared (first use in this function)
      37 |                                            KEY_USR_VIEW | KEY_USR_READ),
         |                                            ^~~~~~~~~~~~
   certs/common.c:37:59: error: 'KEY_USR_READ' undeclared (first use in this function)
      37 |                                            KEY_USR_VIEW | KEY_USR_READ),
         |                                                           ^~~~~~~~~~~~
   certs/common.c:38:44: error: 'KEY_ALLOC_NOT_IN_QUOTA' undeclared (first use in this function)
      38 |                                            KEY_ALLOC_NOT_IN_QUOTA |
         |                                            ^~~~~~~~~~~~~~~~~~~~~~
   certs/common.c:39:44: error: 'KEY_ALLOC_BUILT_IN' undeclared (first use in this function)
      39 |                                            KEY_ALLOC_BUILT_IN |
         |                                            ^~~~~~~~~~~~~~~~~~
   certs/common.c:40:44: error: 'KEY_ALLOC_BYPASS_RESTRICTION' undeclared (first use in this function)
      40 |                                            KEY_ALLOC_BYPASS_RESTRICTION);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> certs/common.c:41:28: warning: passing argument 1 of 'IS_ERR' makes pointer from integer without a cast [-Wint-conversion]
      41 |                 if (IS_ERR(key)) {
         |                            ^~~
         |                            |
         |                            int
   In file included from include/linux/rwsem.h:18,
                    from include/linux/key.h:18,
                    from certs/common.c:4:
   include/linux/err.h:34:60: note: expected 'const void *' but argument is of type 'int'
      34 | static inline bool __must_check IS_ERR(__force const void *ptr)
         |                                                ~~~~~~~~~~~~^~~
   In file included from include/linux/kernel.h:19,
                    from certs/common.c:3:
>> certs/common.c:43:40: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
      43 |                                PTR_ERR(key));
         |                                        ^~~
         |                                        |
         |                                        int
   include/linux/printk.h:390:40: note: in definition of macro 'pr_err'
     390 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   In file included from include/linux/rwsem.h:18,
                    from include/linux/key.h:18,
                    from certs/common.c:4:
   include/linux/err.h:29:61: note: expected 'const void *' but argument is of type 'int'
      29 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~
   In file included from include/linux/kernel.h:19,
                    from certs/common.c:3:
>> certs/common.c:46:54: warning: dereferencing 'void *' pointer
      46 |                                   key_ref_to_ptr(key)->description);
         |                                                      ^~
   include/linux/printk.h:410:43: note: in definition of macro 'pr_notice'
     410 |         printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
         |                                           ^~~~~~~~~~~
   certs/common.c:46:54: error: request for member 'description' in something not a structure or union
      46 |                                   key_ref_to_ptr(key)->description);
         |                                                      ^~
   include/linux/printk.h:410:43: note: in definition of macro 'pr_notice'
     410 |         printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
         |                                           ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/IS_ERR +41 certs/common.c

2565ca7f5ec1a9 Eric Snowberg 2021-01-22   6  
2565ca7f5ec1a9 Eric Snowberg 2021-01-22   7  int load_certificate_list(const u8 cert_list[],
2565ca7f5ec1a9 Eric Snowberg 2021-01-22   8  			  const unsigned long list_size,
2565ca7f5ec1a9 Eric Snowberg 2021-01-22   9  			  const struct key *keyring)
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  10  {
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  11  	key_ref_t key;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  12  	const u8 *p, *end;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  13  	size_t plen;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  14  
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  15  	p = cert_list;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  16  	end = p + list_size;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  17  	while (p < end) {
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  18  		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  19  		 * than 256 bytes in size.
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  20  		 */
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  21  		if (end - p < 4)
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  22  			goto dodgy_cert;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  23  		if (p[0] != 0x30 &&
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  24  		    p[1] != 0x82)
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  25  			goto dodgy_cert;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  26  		plen = (p[2] << 8) | p[3];
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  27  		plen += 4;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  28  		if (plen > end - p)
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  29  			goto dodgy_cert;
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  30  
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  31  		key = key_create_or_update(make_key_ref(keyring, 1),
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  32  					   "asymmetric",
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  33  					   NULL,
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  34  					   p,
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  35  					   plen,
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  36  					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  37  					   KEY_USR_VIEW | KEY_USR_READ),
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  38  					   KEY_ALLOC_NOT_IN_QUOTA |
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  39  					   KEY_ALLOC_BUILT_IN |
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  40  					   KEY_ALLOC_BYPASS_RESTRICTION);
2565ca7f5ec1a9 Eric Snowberg 2021-01-22 @41  		if (IS_ERR(key)) {
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  42  			pr_err("Problem loading in-kernel X.509 certificate (%ld)\n",
2565ca7f5ec1a9 Eric Snowberg 2021-01-22 @43  			       PTR_ERR(key));
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  44  		} else {
2565ca7f5ec1a9 Eric Snowberg 2021-01-22  45  			pr_notice("Loaded X.509 cert '%s'\n",
2565ca7f5ec1a9 Eric Snowberg 2021-01-22 @46  				  key_ref_to_ptr(key)->description);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J2SCkAp4GZ/dPZZf--
