Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1B1818E3
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2020 13:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgCKM6l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Mar 2020 08:58:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729320AbgCKM6l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Mar 2020 08:58:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BCtlvx014086;
        Wed, 11 Mar 2020 08:58:35 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ypywu1fhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 08:58:35 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02BCsnS1027972;
        Wed, 11 Mar 2020 12:58:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 2ypjxr4x3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 12:58:34 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02BCwXJT8127112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 12:58:33 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AABB6124054;
        Wed, 11 Mar 2020 12:58:33 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8397A124052;
        Wed, 11 Mar 2020 12:58:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Mar 2020 12:58:33 +0000 (GMT)
Subject: Re: [PATCH v6 1/3] tpm: of: Handle IBM,vtpm20 case when getting log
 parameters
To:     kbuild test robot <lkp@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org, jarkko.sakkinen@linux.intel.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com
References: <20200304132243.179402-2-stefanb@linux.vnet.ibm.com>
 <202003110648.y1djA66Z%lkp@intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <361c9000-fb0a-a34a-9322-4e6fbe738ab4@linux.ibm.com>
Date:   Wed, 11 Mar 2020 08:58:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <202003110648.y1djA66Z%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_05:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110082
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/10/20 6:56 PM, kbuild test robot wrote:
> Hi Stefan,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on jss-tpmdd/next]
> [also build test ERROR on powerpc/next linux/master linus/master v5.6-rc5 next-20200310]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/Enable-vTPM-2-0-for-the-IBM-vTPM-driver/20200305-042731
> base:   git://git.infradead.org/users/jjs/linux-tpmdd next
> config: xtensa-randconfig-a001-20200310 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=9.2.0 make.cross ARCH=xtensa
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

I suppose I would only add this Report-by if this was an issue upstream?!


