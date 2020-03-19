Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E166618BBAF
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCSP40 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 11:56:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727217AbgCSP4Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 11:56:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JFWNTp153786;
        Thu, 19 Mar 2020 11:56:14 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7adh6b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 11:56:14 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02JFivNo016822;
        Thu, 19 Mar 2020 15:56:13 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 2yrpw71hyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 15:56:13 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02JFuCei53543402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 15:56:12 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA3E1BE051;
        Thu, 19 Mar 2020 15:56:12 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40272BE04F;
        Thu, 19 Mar 2020 15:56:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Mar 2020 15:56:12 +0000 (GMT)
Subject: Re: [PATCH] tpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as
 module
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sachinp@linux.vnet.ibm.com, mpe@ellerman.id.au
References: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
 <20200318194247.GC48177@linux.intel.com>
 <4b2949a9-b251-906d-d513-1b2ccef758a0@linux.ibm.com>
 <20200319142714.GB3703@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <17b5d98c-76b2-63c0-798a-920d91fec618@linux.ibm.com>
Date:   Thu, 19 Mar 2020 11:56:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319142714.GB3703@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_05:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003190067
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/19/20 10:27 AM, Jarkko Sakkinen wrote:
> On Wed, Mar 18, 2020 at 03:53:54PM -0400, Stefan Berger wrote:
>> On 3/18/20 3:42 PM, Jarkko Sakkinen wrote:
>>> On Tue, Mar 17, 2020 at 09:08:19AM -0400, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> This patch fixes the following problem when the ibmvtpm driver
>>>> is built as a module:
>>>>
>>>> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
>>>> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
>>>> make: *** [Makefile:1298: modules] Error 2
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Hi, wrong tag (we use "tpm:"), missing fixes tag and please cc stable.
>>> Thanks.
>> I did not add the fixes tag because I do not know the final commit hash, or
>> is it the final commit hash once it is in linux-next? I doubt it with all
>> the merging that can occur.
> Can you send me a new version after rc1 is out?

Michael Ellerman (cc'ed) told me that the fixes tag should 'work' once 
the bad patch is in linux-next. So I reposted yesterday (with a stray 
'q' in the title :-( ):

https://lkml.org/lkml/2020/3/18/1283


    Stefan

>
> /Jarkko


