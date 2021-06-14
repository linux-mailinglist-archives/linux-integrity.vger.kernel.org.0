Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5F3A6ED0
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhFNTXA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 15:23:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233541AbhFNTW7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 15:22:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EJIYjC130561;
        Mon, 14 Jun 2021 15:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kF7q8INn1B56W/5xidWtHLd8hUXs2ldW2FBtE5CMzJ0=;
 b=QDTt3TJeL2H3dV7z4xNwAU9wXJca23TpYN3FOaM3HwTzgnL2UQxjPlld37PERyteHt4D
 28bgEI67Ki79YpwHKqZC8Tb2Et3AS53a1a0SdPlCohG3yJXU0xZbtLSWzQlmfkv1MbEr
 Vd0iphOEQY9TSPBLIoea7QJDJiff1GM8D8pbO9VpwOzvMQDYaYWUmJsmUCCGvxVRQsiZ
 gmONxXL7EVHOOg8xK4/d+P2J1CgrQLOiA8zeWJ4rbFn4E1iMOQcZeoUNapK6oM0IR9ON
 74/JNSEIgrGzXdQ6DYhg1ornWTS/CBPMy7qAYFeWF8/Qo4p+36TeTcxPsfnhZw9zgnwo zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396d58r103-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 15:20:47 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15EJIZ3K130586;
        Mon, 14 Jun 2021 15:20:47 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396d58r0yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 15:20:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EJHmFv002442;
        Mon, 14 Jun 2021 19:20:46 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 394mj9xfm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 19:20:46 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EJKi5818940334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 19:20:44 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48716136059;
        Mon, 14 Jun 2021 19:20:44 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5B38136055;
        Mon, 14 Jun 2021 19:20:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 19:20:43 +0000 (GMT)
Subject: Re: [PATCH v6 0/4] Add support for ECDSA-signed kernel modules
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
 <20210614191948.io4waff5aisah36q@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <95fac042-d348-91d9-f6d0-6a1ec21cebe4@linux.ibm.com>
Date:   Mon, 14 Jun 2021 15:20:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210614191948.io4waff5aisah36q@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1KUFHdWQW74me9CylhuzKH4dxPd91nB5
X-Proofpoint-ORIG-GUID: kIXqqFSpZwIwoHjCVwHZDNKhxzJBMO4O
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_13:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/14/21 3:19 PM, Jarkko Sakkinen wrote:
> On Thu, Jun 10, 2021 at 08:56:19AM -0400, Stefan Berger wrote:
>> This series adds support for ECDSA-signed kernel modules. It also
>> attempts to address a kbuild issue where a developer created an ECDSA
>> key for signing kernel modules and then builds an older version of the
>> kernel, when bisecting the kernel for example, that does not support
>> ECDSA keys.
>>
>> The first patch addresses the kbuild issue of needing to delete that
>> ECDSA key if it is in certs/signing_key.pem and trigger the creation
>> of an RSA key. However, for this to work this patch would have to be
>> backported to previous versions of the kernel but would also only work
>> for the developer if he/she used a stable version of the kernel to which
>> this patch was applied. So whether this patch actually achieves the
>> wanted effect is not always guaranteed.
>>
>> The 2nd patch adds the support for the ECSDA-signed kernel modules.
>>
>> This patch depends on the ECDSA support series currently queued here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc
>>
>>    Stefan
>>
>> v6:
>>    - Patch 2/4 is fixing V4's 1/2 and 4/4 is fixing V4's 2/2. Both fixup
>>      patches to be squashed.
>>
>> v5:
>>    - do not touch the key files if openssl is not installed; likely
>>      addresses an issue pointed out by kernel test robot
>>
>> v4:
>>    - extending 'depends on' with MODULES to (IMA_APPRAISE_MODSIG && MODULES)
>>    
>> v3: - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
>>    - added recommendation to use string hash to Kconfig help text
>>
>> v2:
>>    - Adjustment to ECDSA key detector string in 2/2
>>    - Rephrased cover letter and patch descriptions with Mimi
>>
>>
>> Stefan Berger (4):
>>    certs: Trigger creation of RSA module signing key if it's not an RSA
>>      key
>>    certs: Check whether openssl tool is available
>>    certs: Add support for using elliptic curve keys for signing modules
>>    certs: Adjustment due to 'Check whether openssl tool is available'
>>
>>   certs/Kconfig                         | 26 ++++++++++++++++++++++++++
>>   certs/Makefile                        | 21 +++++++++++++++++++++
>>   crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
>>   3 files changed, 55 insertions(+)
>>
>> -- 
>> 2.29.2
>>
>>
> Since you know the commit ID's in
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>
> you could just use fixes-tags and send exactly two patch series. Works
> better with various tools (e.g. https://pypi.org/project/b4/)
>
> /Jarkko


So you are not taking v6's 2/4 and 4/4 ?

