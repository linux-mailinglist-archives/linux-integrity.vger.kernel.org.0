Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB9622E91
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKIO7q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Nov 2022 09:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKIO7o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Nov 2022 09:59:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568D5FF1;
        Wed,  9 Nov 2022 06:59:43 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9EdG65031832;
        Wed, 9 Nov 2022 14:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1OLC8F2gQvPMQ0oOkOuCrcwRrG/Zrm3NPiPzZPsskpU=;
 b=pOQwHqVk2ml9gosOqwuvB4a6nCdNvEwMk5b+VyA1YNDG19dp0Up0QzCkDR3UrlH1KVeK
 W+VpmR5hi3EqGQy7JQz/3xvltPvaN21nmHIHOqZF7dp08lDS5IzLiKvspXrzEXgGnudK
 SDTRem3W21sXUmSteJrNkO6CP/YESK9prMKJzQcScfMmsn0OIzvzC/+nQ5/ms4GaFoWv
 C6zwlR5dA2jvfIpz9pn4KlMUrtz6Wt9cLUBQeDyb9aWQJ+80mgQKJHyc9NmloS1dX8Ts
 woFDE0igrytbdMl506NY3NOT/+vfpygQLl/1SqcY21oi+1hNvFRhp3VRYh0Sdq0l3mc5 sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krdg7j02d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:58:32 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A9EdJt5032283;
        Wed, 9 Nov 2022 14:58:32 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krdg7j01u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:58:31 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9Epovd027316;
        Wed, 9 Nov 2022 14:58:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3kngs7eb3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:58:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9EwTPS9175688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 14:58:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 812A458054;
        Wed,  9 Nov 2022 14:58:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED52F58056;
        Wed,  9 Nov 2022 14:58:26 +0000 (GMT)
Received: from [9.211.133.138] (unknown [9.211.133.138])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 14:58:26 +0000 (GMT)
Message-ID: <eecf9ec4-2415-1e41-014e-e145d6ab44b4@linux.vnet.ibm.com>
Date:   Wed, 9 Nov 2022 09:58:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Elaine Palmer <erpalmerny@gmail.com>
Cc:     Coiby Xu <coxu@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "jmorris@namei.org" <jmorris@namei.org>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "erpalmer@linux.ibm.com" <erpalmer@linux.ibm.com>
References: <20221104132035.rmavewmeo6ceyjou@Rk>
 <faa10c58-268f-ddc8-b86c-02c903e29f8a@gmail.com>
 <82E1339C-629A-48F5-99B0-179251BBC708@oracle.com>
From:   Elaine Palmer <erpalmer@linux.vnet.ibm.com>
In-Reply-To: <82E1339C-629A-48F5-99B0-179251BBC708@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KKEX5YqYSKvKVALi2yVz3hqgWQCErAqS
X-Proofpoint-GUID: MpVVNcBdG2Dei_OfkNKrrzEJvGpvCdd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/11/09 9:25 AM, Eric Snowberg wrote:
>
>> On Nov 8, 2022, at 6:24 PM, Elaine Palmer <erpalmerny@gmail.com> wrote:
>>
>>
>>
>> On 2022/11/04 9:20 AM, Coiby Xu wrote:
>>> Hi Eric,
>>>
>>> I wonder if there is any update on this work? I would be glad to do
>>> anything that may be helpful including testing a new version of code.
>>>
>> Hi Coiby,
>>
>> Yes, this discussion got stuck when we couldn't agree on one of the
>> following options:
>>
>> (A) Filter which keys from MOK (or a management system) are loaded
>>     onto the .machine keyring. Specifically, load only keys with
>>     CA+keyCertSign attributes.
>>
>> (B) Load all keys from MOK (or a management system) onto the
>>     .machine keyring. Then, subsequently filter those to restrict
>>     which ones can be loaded onto the .ima keyring specifically.
>>
>> The objection to (A) was that distros would have to go through
>> two steps instead of one to load keys. The one-step method of
>> loading keys was supported by an out-of-tree patch and then by
>> the addition of the .machine keyring.
>>
>> The objection to (B) was that, because the .machine keyring is now
>> linked to the .secondary keyring, it expands the scope of what the
>> kernel has trusted in the past. The effect is that keys in MOK
>> have the same broad scope as keys previously restricted to
>> .builtin and .secondary. It doesn't affect just IMA, but the rest
>> of the kernel as well.
>>
>> I would suggest that we can get unstuck by considering:
>>
>> (C) Defining a systemd (or dracut module) to load keys onto the
>>     .secondary keyring
>>
>> (D) Using a configuration option to specify what types of
>>     .machine keys should be allowed to pass through to the
>>     .secondary keyring.
>>    
>>     The distro could choose (A) by allowing only
>>     CA+keyCertSign keys.
>>
>>     The distro could choose (B) by allowing any kind
>>     of key.
>>
>> We all seemed to agree that enforcing key usage should be
>> implemented and that a useful future effort is to add policies
>> to keys and keyrings, like, "This key can only be used for
>> verifying kernel modules."
>>
>> I hope we can come to an agreement so work can proceed and IMA
>> can be re-enabled.
> I would be open to making the changes necessary to support both (A and B) 
> options.  What type of configuration option would be considered?  Would this 
> be a compile time Kconfig, a Linux boot command line parameter, or another 
> MOK variable?
>
Thank you, Eric.  A compile time Kconfig would be the most secure, yet
would still support (B) when allowed.
