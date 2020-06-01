Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5174D1EA503
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgFANcE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 09:32:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgFANcE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 09:32:04 -0400
Received: from lhreml708-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D8C7F830D4BD72C4AD55;
        Mon,  1 Jun 2020 14:32:01 +0100 (IST)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml708-chm.china.huawei.com (10.201.108.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 1 Jun 2020 14:32:01 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 1 Jun 2020 15:32:00 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Mon, 1 Jun 2020 15:32:00 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [linux-next:master 2476/12912]
 security/integrity/ima/ima_crypto.c:575:12: warning: stack frame size of 1152
 bytes in function 'ima_calc_field_array_hash_tfm'
Thread-Topic: [linux-next:master 2476/12912]
 security/integrity/ima/ima_crypto.c:575:12: warning: stack frame size of 1152
 bytes in function 'ima_calc_field_array_hash_tfm'
Thread-Index: AQHWM51OJrrrIQIHxEWw6O47bQoN8KjDxjoQ
Date:   Mon, 1 Jun 2020 13:32:00 +0000
Message-ID: <9dbec9465bda4f8995a42593eb0db010@huawei.com>
References: <202005270415.1CwCqOaL%lkp@intel.com>
In-Reply-To: <202005270415.1CwCqOaL%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.69.111]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: kbuild test robot [mailto:lkp@intel.com]
> security/integrity/ima/ima_crypto.c:575:12: warning: stack frame size of
> 1152 bytes in function 'ima_calc_field_array_hash_tfm'
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> master
> head:   b0523c7b1c9d0edcd6c0fe6d2cb558a9ad5c60a8
> commit: 1ea973df6e2166d1a576cabe5d08925d3261ff9d [2476/12912] ima:
> Calculate and extend PCR with digests in ima_template_entry
> config: mips-randconfig-r012-20200526 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
> 3393cc4cebf9969db94dc424b7a2b6195589c33b)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         git checkout 1ea973df6e2166d1a576cabe5d08925d3261ff9d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> ARCH=mips
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> security/integrity/ima/ima_crypto.c:575:12: warning: stack frame size of
> 1152 bytes in function 'ima_calc_field_array_hash_tfm' [-Wframe-larger-
> than=]
> static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
> ^
> 1 warning generated.

It seems that the problem is caused by the definition of
 SHASH_DESC_ON_STACK:

+#define SHASH_DESC_ON_STACK(shash, ctx)                                  \
+       char __##shash##_desc[sizeof(struct shash_desc) +         \
+               crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \

CRYPTO_MINALIGN_ATTR is equal to __attribute__ ((__aligned__(128))).

It is defined in include/linux/crypto.h:

#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN

#define CRYPTO_MINALIGN_ATTR __attribute__ ((__aligned__(CRYPTO_MINALIGN)))


I found in include/linux/slab.h:

#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
#define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
#else
#define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
#endif

If I set ARCH_KMALLOC_MINALIGN to __alignof__(unsigned long long)
the warning message disappears.

Herbert, can you please have a look?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> vim +/ima_calc_field_array_hash_tfm +575
> security/integrity/ima/ima_crypto.c
> 
> 3bcced39ea7d1b0 Dmitry Kasatkin 2014-02-26  571
> 3323eec921efd81 Mimi Zohar      2009-02-04  572  /*
> a71dc65d30a4724 Roberto Sassu   2013-06-07  573   * Calculate the hash of
> template data
> 3323eec921efd81 Mimi Zohar      2009-02-04  574   */
> a71dc65d30a4724 Roberto Sassu   2013-06-07 @575  static int
> ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
> 7ca79645a1f8837 Roberto Sassu   2020-03-25  576
> 		 struct ima_template_entry *entry,
> 6d94809af6b0830 Roberto Sassu   2020-03-25  577
> 		 int tfm_idx)
> 3323eec921efd81 Mimi Zohar      2009-02-04  578  {
> 6d94809af6b0830 Roberto Sassu   2020-03-25  579
> 	SHASH_DESC_ON_STACK(shash, ima_algo_array[tfm_idx].tfm);
> 7ca79645a1f8837 Roberto Sassu   2020-03-25  580  	struct
> ima_template_desc *td = entry->template_desc;
> 7ca79645a1f8837 Roberto Sassu   2020-03-25  581  	int num_fields =
> entry->template_desc->num_fields;
> a71dc65d30a4724 Roberto Sassu   2013-06-07  582  	int rc, i;
> 3323eec921efd81 Mimi Zohar      2009-02-04  583
> 6d94809af6b0830 Roberto Sassu   2020-03-25  584  	shash->tfm =
> ima_algo_array[tfm_idx].tfm;
> 3323eec921efd81 Mimi Zohar      2009-02-04  585
> 357aabed626fe3f Behan Webster   2014-04-04  586  	rc =
> crypto_shash_init(shash);
> a71dc65d30a4724 Roberto Sassu   2013-06-07  587  	if (rc != 0)
> a71dc65d30a4724 Roberto Sassu   2013-06-07  588  		return rc;
> a71dc65d30a4724 Roberto Sassu   2013-06-07  589
> a71dc65d30a4724 Roberto Sassu   2013-06-07  590  	for (i = 0; i <
> num_fields; i++) {
> e3b64c268b485f5 Roberto Sassu   2014-02-03  591  		u8
> buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
> e3b64c268b485f5 Roberto Sassu   2014-02-03  592  		u8
> *data_to_hash = field_data[i].data;
> e3b64c268b485f5 Roberto Sassu   2014-02-03  593  		u32 datalen
> = field_data[i].len;
> 98e1d55d033eed2 Andreas Steffen 2016-12-19  594  		u32
> datalen_to_hash =
> 98e1d55d033eed2 Andreas Steffen 2016-12-19  595
> 	    !ima_canonical_fmt ? datalen : cpu_to_le32(datalen);
> e3b64c268b485f5 Roberto Sassu   2014-02-03  596
> b6f8f16f41d9286 Roberto Sassu   2013-11-08  597  		if
> (strcmp(td->name, IMA_TEMPLATE_IMA_NAME) != 0) {
> 357aabed626fe3f Behan Webster   2014-04-04  598  			rc =
> crypto_shash_update(shash,
> 98e1d55d033eed2 Andreas Steffen 2016-12-19  599
> 			(const u8 *) &datalen_to_hash,
> 98e1d55d033eed2 Andreas Steffen 2016-12-19  600
> 			sizeof(datalen_to_hash));
> b6f8f16f41d9286 Roberto Sassu   2013-11-08  601  			if (rc)
> b6f8f16f41d9286 Roberto Sassu   2013-11-08  602
> 	break;
> e3b64c268b485f5 Roberto Sassu   2014-02-03  603  		} else if
> (strcmp(td->fields[i]->field_id, "n") == 0) {
> e3b64c268b485f5 Roberto Sassu   2014-02-03  604
> 	memcpy(buffer, data_to_hash, datalen);
> e3b64c268b485f5 Roberto Sassu   2014-02-03  605
> 	data_to_hash = buffer;
> e3b64c268b485f5 Roberto Sassu   2014-02-03  606
> 	datalen = IMA_EVENT_NAME_LEN_MAX + 1;
> b6f8f16f41d9286 Roberto Sassu   2013-11-08  607  		}
> 357aabed626fe3f Behan Webster   2014-04-04  608  		rc =
> crypto_shash_update(shash, data_to_hash, datalen);
> a71dc65d30a4724 Roberto Sassu   2013-06-07  609  		if (rc)
> a71dc65d30a4724 Roberto Sassu   2013-06-07  610
> 	break;
> a71dc65d30a4724 Roberto Sassu   2013-06-07  611  	}
> a71dc65d30a4724 Roberto Sassu   2013-06-07  612
> a71dc65d30a4724 Roberto Sassu   2013-06-07  613  	if (!rc)
> 6d94809af6b0830 Roberto Sassu   2020-03-25  614  		rc =
> crypto_shash_final(shash, entry->digests[tfm_idx].digest);
> a71dc65d30a4724 Roberto Sassu   2013-06-07  615
> a71dc65d30a4724 Roberto Sassu   2013-06-07  616  	return rc;
> 3323eec921efd81 Mimi Zohar      2009-02-04  617  }
> 3323eec921efd81 Mimi Zohar      2009-02-04  618
> 
> :::::: The code at line 575 was first introduced by commit
> :::::: a71dc65d30a472409f05d247f4eab91b14acf2f5 ima: switch to new
> template management mechanism
> 
> :::::: TO: Roberto Sassu <roberto.sassu@polito.it>
> :::::: CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
