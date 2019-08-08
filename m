Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4226585756
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfHHAzk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Aug 2019 20:55:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730198AbfHHAzk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Aug 2019 20:55:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x780qLYw083614;
        Wed, 7 Aug 2019 20:55:37 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8680ev21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 20:55:37 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x780pYSw011594;
        Thu, 8 Aug 2019 00:55:36 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 2u51w73n49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 00:55:36 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x780tZ3453477858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 00:55:35 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 373AFBE058;
        Thu,  8 Aug 2019 00:55:35 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6CDABE04F;
        Thu,  8 Aug 2019 00:55:33 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.230.139])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Aug 2019 00:55:33 +0000 (GMT)
References: <201908080752.5U4CXtOx%lkp@intel.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [integrity:next-queued-testing 2/13] include/linux/module_signature.h:32:2: error: unknown type name 'u8'
In-reply-to: <201908080752.5U4CXtOx%lkp@intel.com>
Date:   Wed, 07 Aug 2019 21:55:26 -0300
Message-ID: <871rxwo4qp.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080004
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


kbuild test robot <lkp@intel.com> writes:

> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-queued-testing
> head:   cd3553a6a5047b7a759803ae3ba3991a901b89f8
> commit: a5e7fd15c3b94862ce3639e82cabd2de74a0ad90 [2/13] MODSIGN: Export module signature definitions
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         git checkout a5e7fd15c3b94862ce3639e82cabd2de74a0ad90
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from <command-line>:0:0:
>>> include/linux/module_signature.h:32:2: error: unknown type name 'u8'
>      u8 algo;  /* Public-key crypto algorithm [0] */
>      ^~
>    include/linux/module_signature.h:33:2: error: unknown type name 'u8'
>      u8 hash;  /* Digest algorithm [0] */
>      ^~
>    include/linux/module_signature.h:34:2: error: unknown type name 'u8'
>      u8 id_type; /* Key identifier type [PKEY_ID_PKCS7] */
>      ^~
>    include/linux/module_signature.h:35:2: error: unknown type name 'u8'
>      u8 signer_len; /* Length of signer's name [0] */
>      ^~
>    include/linux/module_signature.h:36:2: error: unknown type name 'u8'
>      u8 key_id_len; /* Length of key identifier [0] */
>      ^~
>    include/linux/module_signature.h:37:2: error: unknown type name 'u8'
>      u8 __pad[3];
>      ^~
>>> include/linux/module_signature.h:38:2: error: unknown type name '__be32'
>      __be32 sig_len; /* Length of signature data */
>      ^~~~~~
>>> include/linux/module_signature.h:41:54: error: unknown type name 'size_t'
>     int mod_check_sig(const struct module_signature *ms, size_t file_len,
>                                                          ^~~~~~

This is the same issue spotted and fixed by Stephen Rothwell here:

https://lore.kernel.org/linux-next/20190806121519.0f8ac653@canb.auug.org.au/

Mimi added his patch to her linux-integrity/next-integrity branch so it
is fixed already.
-- 
Thiago Jung Bauermann
IBM Linux Technology Center
