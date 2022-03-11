Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D944D6A6F
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Mar 2022 00:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiCKWqs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 17:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCKWq0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869082E86F6;
        Fri, 11 Mar 2022 14:37:18 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BJgiEv026670;
        Fri, 11 Mar 2022 21:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=c4oKa8YHconhNmykPPJwtaqGobzI4xAAjjShykA4Yy4=;
 b=P4fMWLfPd6F+D1ws06rfxwKmj76Hh5u47Nmtjykkn7GbNk4rKldp0Wtb/BoInpxFw7dE
 TB9Cjmxd2a4ncFxSbAblt/yP5iPYXemyo3zBNSg34WgCbJO2cK0XZWDx8/AWgDse4vw5
 O0eZ1t1WTHP+QGAKfTQw5So2uX5dQYo40OuWgbNUebN7idHJf+CKIBVjYdlEZrhru9r/
 V5eHTGXnYQ3W99RzAgPX5dI8RT88dtg18iaMUYZKsRRfn2lW9z3N4l44eDyZFOaPvgiV
 FGAf9Hc8pwNXI8fz77iEYdRYL2YG77/p9/WbNeAvjJfC6UtBfSfAmoQ8B8I0D4SokxRP xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqtfgpa6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:03:20 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22BKpO7I020866;
        Fri, 11 Mar 2022 21:03:19 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqtfgpa6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:03:19 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22BL3Gua024566;
        Fri, 11 Mar 2022 21:03:18 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3emgamjwy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:03:18 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22BL3Gxx38994426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 21:03:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB2B328059;
        Fri, 11 Mar 2022 21:03:16 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89C2B2805A;
        Fri, 11 Mar 2022 21:03:13 +0000 (GMT)
Received: from [9.211.110.168] (unknown [9.211.110.168])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 21:03:13 +0000 (GMT)
Message-ID: <f92ec4d8-47c0-ece5-3c52-caeb8265881c@linux.vnet.ibm.com>
Date:   Fri, 11 Mar 2022 16:03:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v11 0/4] integrity: support including firmware ".platform"
 keys at build time
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Masahiro Yamada <masahiroy@kernel.org>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
 <4afae87c-2986-6b0e-07be-954dd4937afd@linux.ibm.com>
 <f78d11fefd13bd17748e36621acee9c2f27a77f6.camel@kernel.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <f78d11fefd13bd17748e36621acee9c2f27a77f6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Heow9UKywaWt9NTO6YuP7NDv5g_6SmDY
X-Proofpoint-GUID: e7V-kq4jBh8gRnlsxn6EdPMwfBVMWcS8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_08,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/11/22 11:42, Jarkko Sakkinen wrote:
> On Fri, 2022-03-11 at 10:11 +0530, Nageswara Sastry wrote:
>>
>> On 11/03/22 3:14 am, Nayna Jain wrote:
>>> Some firmware support secure boot by embedding static keys to verify the
>>> Linux kernel during boot. However, these firmware do not expose an
>>> interface for the kernel to load firmware keys onto the ".platform"
>>> keyring, preventing the kernel from verifying the kexec kernel image
>>> signature.
>>>
>>> This patchset exports load_certificate_list() and defines a new function
>>> load_builtin_platform_cert() to load compiled in certificates onto the
>>> ".platform" keyring.
>>>
>>> Changelog:
>>> v11:
>>> * Added a new patch to conditionally build extract-cert if
>>> PLATFORM_KEYRING is enabled.
>>>
>> Tested the following four patches with and with out setting
>> CONFIG_INTEGRITY_PLATFORM_KEYS
>>
>> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> OK, I added it:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

Thanks Jarkko. Masahiro Yamada would prefer to revert the original 
commit 340a02535ee785c64c62a9c45706597a0139e972 i.e. move extract-cert 
back to the scripts/ directory.

I am just posting v12 which includes Masahiro feedback. Nageswara has 
already tested v12 version as well.

I am fine either way 1.) Adding v11 and then separately handling of 
reverting of the commit or 2.) Adding v12 version which includes the 
revert. I leave the decision on you as to which one to upstream.

Thanks & Regards,

     - Nayna

