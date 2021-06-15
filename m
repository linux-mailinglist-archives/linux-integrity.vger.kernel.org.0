Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD343A7FC1
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhFONb7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 09:31:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231531AbhFONb0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 09:31:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FDBKdM183864;
        Tue, 15 Jun 2021 09:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QfulhpUc8H1ZmdFwziQVk+3b6SIL1SJEk4IiLZ5at9E=;
 b=fnIy9yF7MD56dPRFTOyGmWkMmDGh2zRxPuCcZ0JjOWdI5QVuevHT315w+s2pk04hx9FA
 CoUwy7WG8/NTTDBIXzhWa9Eqke7U+DAlb5RhehE8UIuZ0B3XuDlIgL0z0IlhuuquwIBg
 Q4kvsRv7OWq6U41/6uv1/Leuskf2cKCNaT1GveCoVxdu7xWgZgc79AaXEGU9roHgGLig
 MYV/djVSHJGMgrw2YGpv4envuxpf57hUCsZh+biU/YJ1zLYC7gM+Yc8fXPuML9NBNL+i
 DgSCAHp9WtaGnDxIt8KvwvCCebZc5FgqP12LFD3u69vzP+coFLL8chMpdnA8hjq9Zfuh 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396un4u14b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 09:29:11 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15FDEFMf194153;
        Tue, 15 Jun 2021 09:29:11 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396un4u13y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 09:29:11 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15FDPG97000686;
        Tue, 15 Jun 2021 13:29:10 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 3954gk3eym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 13:29:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15FDT9rT18547118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 13:29:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F30ABE056;
        Tue, 15 Jun 2021 13:29:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDAC7BE059;
        Tue, 15 Jun 2021 13:29:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jun 2021 13:29:08 +0000 (GMT)
Subject: Re: [PATCH v6 4/4] certs: Adjustment due to 'Check whether openssl
 tool is available'
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
 <20210610125623.1553792-5-stefanb@linux.ibm.com>
 <20210614192329.dhhahvi5gtnlgbln@kernel.org>
 <b355a2f2-78e7-61b4-2040-9ea3f8de0f73@linux.ibm.com>
 <20210615130629.doay3piolfjcg6ss@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <6b1cf012-a68e-82df-4cc8-c1f9685d1603@linux.ibm.com>
Date:   Tue, 15 Jun 2021 09:29:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210615130629.doay3piolfjcg6ss@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kMQk88MlWVDDOmff10dYo5aLnY7_krPe
X-Proofpoint-GUID: mDGGSvTAkUZffz3xqU16ata0YuEFdA45
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_04:2021-06-14,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106150085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/15/21 9:06 AM, Jarkko Sakkinen wrote:
> On Mon, Jun 14, 2021 at 03:28:56PM -0400, Stefan Berger wrote:
>> On 6/14/21 3:23 PM, Jarkko Sakkinen wrote:
>>> On Thu, Jun 10, 2021 at 08:56:23AM -0400, Stefan Berger wrote:
>>>> Adjust the previous patch due to fixes applied to the first patch
>>>> in the series.
>>>>
>>>> Fixes: 46449892e6e5 ("certs: Add support for using elliptic curve keys for signing modules")
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>>>    certs/Makefile | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/certs/Makefile b/certs/Makefile
>>>> index dc9f354dd5f8..4eb69bdadc79 100644
>>>> --- a/certs/Makefile
>>>> +++ b/certs/Makefile
>>>> @@ -66,16 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
>>>>    ifeq ($(openssl_available),yes)
>>>>    X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
>>>> +endif
>>>>    # Support user changing key type
>>>>    ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
>>>>    keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
>>>> +ifeq ($(openssl_available),yes)
>>>>    $(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>>>>    endif
>>>> +endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
>>>>    ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
>>>> +ifeq ($(openssl_available),yes)
>>>>    $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>>>>    endif
>>>> +endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
>>>>    $(obj)/signing_key.pem: $(obj)/x509.genkey
>>>>    	@$(kecho) "###"
>>>> -- 
>>>> 2.29.2
>>>>
>>>>
>>> Please check that they are applied correctly, thanks.
>> No, they are not applied correctly. 2/2 shows this here:
>>
>>
>>   ifeq ($(openssl_available),yes)
>>   X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
>> +endif
>> +
>>
>>
>> This endif is in 2/4 in v6 and should appear on your git in 1/2. How did it
>> get into 2/2?
>>
>> https://lkml.org/lkml/2021/6/10/493
> I assumed that the two other commits are exact same as in v4 because
> appropriate tags were mssing.

What's in your git repo now looks good.


     Stefan

>
> /Jarkko
