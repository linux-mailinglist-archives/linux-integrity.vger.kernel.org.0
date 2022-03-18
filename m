Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738B14DE37D
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Mar 2022 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbiCRV0h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Mar 2022 17:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiCRV0g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Mar 2022 17:26:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C3712E741;
        Fri, 18 Mar 2022 14:25:17 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22IIW7vq033023;
        Fri, 18 Mar 2022 21:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zRbPg1Tx2tDNI7lXo72lciqg1DdD0NPW0gBMTsN9jhw=;
 b=bfPcVWePpfnwjNO9QMEBkrSMAzJByYnFl7Tyl78XLYiOjAtfnDQvTGgTHeGTMhpWsApy
 uF9Lw8TQiYwMdWbFy0eKynaRIL7JhL8RWbgcv4QUVpRMXnC1ctMKgo+kEwP2saRgBTl+
 yD0FDPsLNaOYlcbBwQdm/jSn3J6t6eoSEqARDLp1ff1u941/tVQQhO1Yv0Wm7eGvFelH
 61NbpTSjTdz6KiZdMJi9oEcEyIYk0Gip5YsIpZ+AcyBmYrep+yUdOwqGQCTQ8rbtIBWm
 gBemUGQZfTtpvShA9xiQtBmAx5MUpfROcZjnfvgAP2lEqb3hkQFhhhzCJuzOGoapdEVQ Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev074ynf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 21:25:12 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22ILJQQ5008202;
        Fri, 18 Mar 2022 21:25:11 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev074ynet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 21:25:11 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22ILDqMt011724;
        Fri, 18 Mar 2022 21:25:10 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3erk5afu89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 21:25:10 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22ILP8m326935714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 21:25:08 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8267C13605D;
        Fri, 18 Mar 2022 21:25:08 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3A2F136059;
        Fri, 18 Mar 2022 21:25:07 +0000 (GMT)
Received: from [9.211.157.42] (unknown [9.211.157.42])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 18 Mar 2022 21:25:07 +0000 (GMT)
Message-ID: <57d7034a-fb5c-444e-a709-4f993459688e@linux.vnet.ibm.com>
Date:   Fri, 18 Mar 2022 17:25:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v11 0/4] integrity: support including firmware ".platform"
 keys at build time
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Nageswara Sastry <rnsastry@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Masahiro Yamada <masahiroy@kernel.org>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
 <4afae87c-2986-6b0e-07be-954dd4937afd@linux.ibm.com>
 <f78d11fefd13bd17748e36621acee9c2f27a77f6.camel@kernel.org>
 <f92ec4d8-47c0-ece5-3c52-caeb8265881c@linux.vnet.ibm.com>
 <YjLlYTs+2ep80zoK@iki.fi>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <YjLlYTs+2ep80zoK@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IkzPowucMttYl2FgGLxv67O761TYy2Gu
X-Proofpoint-ORIG-GUID: Lgq4WlscjYm1-zu86nVD2JR3DE1M-mai
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_14,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/17/22 03:38, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 04:03:12PM -0500, Nayna wrote:
>> On 3/11/22 11:42, Jarkko Sakkinen wrote:
>>> ".platform" keyring.
>>>>> Changelog:
>>>>> v11:
>>>>> * Added a new patch to conditionally build extract-cert if
>>>>> PLATFORM_KEYRING is enabled.
>>>>>
>>>> Tested the following four patches with and with out setting
>>>> CONFIG_INTEGRITY_PLATFORM_KEYS
>>>>
>>>> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
>>> OK, I added it:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>> Thanks Jarkko. Masahiro Yamada would prefer to revert the original commit
>> 340a02535ee785c64c62a9c45706597a0139e972 i.e. move extract-cert back to the
>> scripts/ directory.
>>
>> I am just posting v12 which includes Masahiro feedback. Nageswara has
>> already tested v12 version as well.
>>
>> I am fine either way 1.) Adding v11 and then separately handling of
>> reverting of the commit or 2.) Adding v12 version which includes the revert.
>> I leave the decision on you as to which one to upstream.
>>
>> Thanks & Regards,
>>
>>      - Nayna
>>
> I already sent PR for v5.18. Too many late changes to include this, which
> means that v12 is the way to go.

Assuming v12 looks good, could you please queue it now ?

Thanks & Regards,

     - Nayna

