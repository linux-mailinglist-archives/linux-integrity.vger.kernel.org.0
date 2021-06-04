Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05EA39B89A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jun 2021 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFDMB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Jun 2021 08:01:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3154 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhFDMBz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Jun 2021 08:01:55 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FxLkj2XTPz6G7RN;
        Fri,  4 Jun 2021 19:53:33 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:00:07 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 4 Jun 2021 14:00:07 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>
Subject: RE: [integrity:next-integrity-testing 5/9]
 security/integrity/ima/ima_template_lib.c:616:22: sparse: sparse: incorrect
 type in assignment (different base types)
Thread-Topic: [integrity:next-integrity-testing 5/9]
 security/integrity/ima/ima_template_lib.c:616:22: sparse: sparse: incorrect
 type in assignment (different base types)
Thread-Index: AQHXWRsJfgQoclYuG0mUhYWGxeRPJasDvx7w
Date:   Fri, 4 Jun 2021 12:00:07 +0000
Message-ID: <860a7b2810ad425cb1175b6ea2f76c08@huawei.com>
References: <202106041605.ujAVeENC-lkp@intel.com>
In-Reply-To: <202106041605.ujAVeENC-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.212.129]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: kernel test robot [mailto:lkp@intel.com]
> Sent: Friday, June 4, 2021 10:23 AM
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
> integrity.git next-integrity-testing
> head:   d721c15fd519c08819fbc6de39b713e2ed1d9894
> commit: f8216f6b957f5657c5f4c97f4b037120c6f236bc [5/9] ima: Define new
> template field imode
> config: nios2-randconfig-s031-20210604 (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
> integrity.git/commit/?id=f8216f6b957f5657c5f4c97f4b037120c6f236bc
>         git remote add integrity
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>         git fetch --no-tags integrity next-integrity-testing
>         git checkout f8216f6b957f5657c5f4c97f4b037120c6f236bc
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0
> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1
> ARCH=nios2
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    security/integrity/ima/ima_template_lib.c:100:44: sparse: sparse: cast to
> restricted __le16
>    security/integrity/ima/ima_template_lib.c:107:44: sparse: sparse: cast to
> restricted __le32
>    security/integrity/ima/ima_template_lib.c:114:44: sparse: sparse: cast to
> restricted __le64
>    security/integrity/ima/ima_template_lib.c:135:60: sparse: sparse: restricted
> __le32 degrades to integer
>    security/integrity/ima/ima_template_lib.c:230:49: sparse: sparse: cast to
> restricted __le32
>    security/integrity/ima/ima_template_lib.c:571:28: sparse: sparse: incorrect
> type in assignment (different base types) @@     expected unsigned int
> [assigned] id @@     got restricted __le16 [usertype] @@
>    security/integrity/ima/ima_template_lib.c:571:28: sparse:     expected
> unsigned int [assigned] id
>    security/integrity/ima/ima_template_lib.c:571:28: sparse:     got restricted
> __le16 [usertype]
>    security/integrity/ima/ima_template_lib.c:573:28: sparse: sparse: incorrect
> type in assignment (different base types) @@     expected unsigned int
> [assigned] id @@     got restricted __le32 [usertype] @@
>    security/integrity/ima/ima_template_lib.c:573:28: sparse:     expected
> unsigned int [assigned] id
>    security/integrity/ima/ima_template_lib.c:573:28: sparse:     got restricted
> __le32 [usertype]
> >> security/integrity/ima/ima_template_lib.c:616:22: sparse: sparse:
> incorrect type in assignment (different base types) @@     expected unsigned
> short [assigned] [usertype] mode @@     got restricted __le16 [usertype]
> @@
>    security/integrity/ima/ima_template_lib.c:616:22: sparse:     expected
> unsigned short [assigned] [usertype] mode
>    security/integrity/ima/ima_template_lib.c:616:22: sparse:     got restricted
> __le16 [usertype]
> 
> vim +616 security/integrity/ima/ima_template_lib.c
> 
>    599
>    600	/*
>    601	 *  ima_eventinodemode_init - include the inode mode as part of the
> template
>    602	 *  data
>    603	 */
>    604	int ima_eventinodemode_init(struct ima_event_data *event_data,
>    605				    struct ima_field_data *field_data)
>    606	{
>    607		struct inode *inode;
>    608		umode_t mode;
>    609
>    610		if (!event_data->file)
>    611			return 0;
>    612
>    613		inode = file_inode(event_data->file);
>    614		mode = inode->i_mode;
>    615		if (ima_canonical_fmt)
>  > 616			mode = cpu_to_le16(mode);

int ima_eventinodemode_init(struct ima_event_data *event_data,
			    struct ima_field_data *field_data)
{
	struct inode *inode;
	__le16 mode;

	if (!event_data->file)
		return 0;

	inode = file_inode(event_data->file);
	if (ima_canonical_fmt)
		mode = cpu_to_le16(inode->i_mode);
	else
		mode = (__force __le16)inode->i_mode;

	return ima_write_template_field_data((char *)&mode, sizeof(mode),
					     DATA_FMT_UINT, field_data);
}

Is this correct?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
