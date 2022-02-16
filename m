Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8194B9310
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Feb 2022 22:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiBPVTx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Feb 2022 16:19:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiBPVTv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Feb 2022 16:19:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B418622496F;
        Wed, 16 Feb 2022 13:19:38 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GL8WJ2032687;
        Wed, 16 Feb 2022 21:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U8SNXnoO2x+3jqNdtP8FT7c218Mnv5NRJH1QCjrm+MM=;
 b=bg5Mqq1fDy3Xulmua3Am4/Hj10arF8Q5A+HuUzwou18kBw58FADxXHoqKgWOBn936i++
 sbkN/iW5EgVZCdpTAdR6+lCNWv59y/orhDIg6zpvuZta7nzCvLP5eAXEUUlnxun+mEbn
 ietG1goSA6hJK3i5G6m2zsDacozzyoD9frhttm+Vs8UEOdpC+yDyjFoNVspJJf8vxF0e
 m+9ydXfvjR8ZDsM30b4vWWq0KthlkxV8wPiTNrPe3V0olyHPROX9FhZaE25sol5hM143
 7vCGVw4x1c6RxlXGlwm3YivlpLYDxltI/oMNizoq5nDoOrRXZ5pqPU1Vt5uDlknyNAMz ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e97qc1naj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 21:19:24 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21GLHrk0006808;
        Wed, 16 Feb 2022 21:19:23 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e97qc1na9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 21:19:23 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GLHuoT024449;
        Wed, 16 Feb 2022 21:19:22 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3e64hcxb57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 21:19:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GLJLm035914166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 21:19:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ECA2BE056;
        Wed, 16 Feb 2022 21:19:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABF57BE058;
        Wed, 16 Feb 2022 21:19:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 21:19:19 +0000 (GMT)
Message-ID: <c1a32f5d-c15d-8127-6254-69946f751bdb@linux.ibm.com>
Date:   Wed, 16 Feb 2022 16:19:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 06/27] ima: Move arch_policy_entry into ima_namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-7-stefanb@linux.ibm.com>
 <bf435ffa5d176213acabb8c576c159d2cbd4d395.camel@linux.ibm.com>
 <c350ccf1-f968-8b01-2f0d-015cabf39781@linux.ibm.com>
 <c4170de11d64d5927a8e2a2e0f7e8a6e69c6a558.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <c4170de11d64d5927a8e2a2e0f7e8a6e69c6a558.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a0JLbt8rZLx9dHrRWrfokUbIihXboZeN
X-Proofpoint-GUID: ErNdkiqOb-tu9Gv7m0Ilrnm1jO72ttaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_10,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/16/22 15:56, Mimi Zohar wrote:
> On Wed, 2022-02-16 at 15:48 -0500, Stefan Berger wrote:
>> On 2/16/22 11:39, Mimi Zohar wrote:
>>> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote
>>>
>>> Let's update the patch description providing a bit more background
>>> info:
>>>
>>> The archictecture specific policy rules, currently defined for EFI and
>>> powerpc, require the kexec kernel image and kernel modules to be
>>> validly signed and measured, based on the system's secure boot and/or
>>> trusted boot mode and the IMA_ARCH_POLICY Kconfig option being enabled.
>>>
>>>> Move the arch_policy_entry pointer into ima_namespace.
>>> Perhaps include something about namespaces being allowed or not allowed
>>> to kexec a new kernel or load kernel modules.
>> Namespaces are not allowed to kexec but special-casing the init_ima_ns
>> in the code to handle namespaces differently makes it much harder to
>> read the code. I would avoid special-casing init_ima_ns as much as
>> possible and therefore I have moved the arch_policy_entry into the
>> ima_namespace.
> Please include this in the patch description, but re-write the last
> line in the 3rd person, like:
>
> To avoid special-casing init_ima_ns, as much as possible, move the
> arch_policy_entry into the ima_namespace.

I took the paragraph on the background as well as this sentence.


>
> thanks,
>
> Mimi
>
>
