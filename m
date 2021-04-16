Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68613362950
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Apr 2021 22:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbhDPU0L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Apr 2021 16:26:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245407AbhDPU0K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Apr 2021 16:26:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GK4O3A098559;
        Fri, 16 Apr 2021 16:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KWoS8lDu6oH7fOf5RVeQv0BIkzH2wf5V+ZZhA7MemEk=;
 b=clxL4/N9YluEWSUGWHs/GFwrELywnZ5hUexoUcO7DUVdFRfjjCoEiHrzzt89XooMS3Fs
 GTUFKA399k1oofd9lloF7wVQDZBj1XWthg2t7CoI9Py5ui2dfEH3hYU7HBMarM7VII9n
 F21Tq4S2DX2+hwo0+7O64079JoSAzDPfz8CK0pCYppfMUcpAZximJjrhtJ0podhdy7O1
 nZfQyNhMeLAakJyPNT3g2VCkZbXLQnsbBvH5PENUkwx1H/lloZDMiKbSeK2R48Ld18I3
 sYVrnfEd19o2L6brcmWqqo+bQ0cDD5qUTOFvX54sFOnX16ftW3Xuw4M4+i5xGR7QfWFL YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37y7te1umb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 16:25:29 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13GKJsO2155309;
        Fri, 16 Apr 2021 16:25:28 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37y7te1um4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 16:25:28 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GKM8Jb002839;
        Fri, 16 Apr 2021 20:25:28 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 37uhcngj78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 20:25:28 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13GKPRMM32178482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 20:25:27 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96BF928059;
        Fri, 16 Apr 2021 20:25:27 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A1B428058;
        Fri, 16 Apr 2021 20:25:26 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.211.99.79])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Apr 2021 20:25:26 +0000 (GMT)
Subject: Re: linux-next: Tree for Apr 16 (IMA appraise causing build error)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20210416213625.14542675@canb.auug.org.au>
 <80839e94-f72c-4d2c-6b3a-b68beea72a27@infradead.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <3b06deaa-2ec1-88cd-87aa-970b9fa4315a@linux.vnet.ibm.com>
Date:   Fri, 16 Apr 2021 16:25:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <80839e94-f72c-4d2c-6b3a-b68beea72a27@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XkPBnUb-JVgIlfuOCRV4nc1KmbJXMVTb
X-Proofpoint-GUID: L2nJeYR8gfDplDJJuWoTPQo0twzbj0A2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160140
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/16/21 2:53 PM, Randy Dunlap wrote:
> On 4/16/21 4:36 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20210415:
>>
> I noticed this build error message (on an i386 build):
>
> ../certs/Makefile:52: *** Could not determine digest type to use from kernel config.  Stop.
>
> and when I was checking on why it happened, I noticed that
> # CONFIG_MODULES is not set
>
> and hence
> ifndef CONFIG_MODULE_SIG_HASH
> $(error Could not determine digest type to use from kernel config)
> endif
>
> CONFIG_MODULE_SIG_HASH is not set/enabled/defined.
>
> However, the .config file does have
> CONFIG_IMA_APPRAISE=y
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> CONFIG_IMA_APPRAISE_MODSIG=y
>
> as well as
> CONFIG_MODULE_SIG_FORMAT=y
>
> due to a "select" by IMA_APPRAISE_MODSIG.
> (although I see that MODULE_SIG_FORMAT does not depend on MODULES)
>
>
> Is there anything that you can do (or recommend) to prevent
> the build error?
>
>
>
> BTW, it looks like this:
> config IMA_APPRAISE_REQUIRE_MODULE_SIGS
> 	bool "Appraise kernel modules signatures"
> 	depends on IMA_APPRAISE_BUILD_POLICY
>
> could also depend on MODULES.
>
>
>
> Full i386 randconfig file is attached.


With the new patchset "ima: kernel build support for loading the kernel 
module signing key", there shouldn't be a difference when generating the 
config file between MODULE_SIG and IMA_APPRAISE_MODSIG. Both prompt for 
the hash algorithm.

Can you please explain how you generate randconfig? Do you use make xconfig?

Thanks & Regards,

     - Nayna

