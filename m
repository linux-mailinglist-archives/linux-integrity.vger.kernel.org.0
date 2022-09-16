Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E905BABF0
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Sep 2022 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiIPLCp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Sep 2022 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiIPLCE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Sep 2022 07:02:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29D89CE1;
        Fri, 16 Sep 2022 03:54:25 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GAKN8U026781;
        Fri, 16 Sep 2022 10:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mg0UTcI5E/v0w9/TCr34MIXg52j4DcHINPw+UJ0oefo=;
 b=BN4Ejap20mhIUqHhvClsnbcYTvX/oKfAINCxX4uMXdcXtKB0UJ3Fp7JAklPOkfivRvwA
 92/bfLGAeZkiLw44fnQbcwAjewXdvp60CgSyE4zTn9kFjMVLFXXe3h+69wxUE1OJ4IZa
 TJ1aF9cJj319aoWSNmPpUjCBKWECePPBZtUPh+ilZVuGMlm1hOx1AzaNm5SAS25xkX8K
 fIeVNQPi5AqMpn+toe7HpakeXmnApEaUSUi0uTWf0dWeaHPVo3Ockw4VVIyPsBhd0ieF
 9kfXfMBGqC+2GnwmORHTJYEJ3HxoJHzWj4kSXX+JnufHfXIikcXZxgbvp2wa4UrTsCDk Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmq9xgyjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:54:05 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28GAn5Mo026431;
        Fri, 16 Sep 2022 10:54:04 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmq9xgyj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:54:04 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GAqES5029355;
        Fri, 16 Sep 2022 10:54:03 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3jm91qnewh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:54:03 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GAs15q2753054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 10:54:01 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5D3FAC05E;
        Fri, 16 Sep 2022 10:54:01 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59ABEAC059;
        Fri, 16 Sep 2022 10:54:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Sep 2022 10:54:01 +0000 (GMT)
Message-ID: <556b21f9-56ae-7ff6-c38a-9ca856438a66@linux.ibm.com>
Date:   Fri, 16 Sep 2022 06:54:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v14 00/26] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
 <7234a3e5-8b3c-3ac4-2e06-c6cffa46c10e@schaufler-ca.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7234a3e5-8b3c-3ac4-2e06-c6cffa46c10e@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: psa_H7AZO5CVadP95nY4_CFDSnbWGj6d
X-Proofpoint-GUID: hSPHw-RTBrN3LpZcTZFA6UaCbsVLnhsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160074
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/15/22 20:56, Casey Schaufler wrote:
> On 9/15/2022 12:31 PM, Stefan Berger wrote:
>> The goal of this series of patches is to start with the namespacing of
>> IMA and support auditing within an IMA namespace (IMA-ns) as the first
>> step.
>>
>> In this series the IMA namespace is piggybacking on the user namespace
>> and therefore an IMA namespace is created when a user namespace is
>> created, although this is done late when SecurityFS is mounted inside
>> a user namespace. The advantage of piggybacking on the user namespace
>> is that the user namespace can provide the keys infrastructure that IMA
>> appraisal support will need later on.
>>
>> We chose the goal of supporting auditing within an IMA namespace since it
>> requires the least changes to IMA. Following this series, auditing within
>> an IMA namespace can be activated by a root running the following lines
>> that rely on a statically linked busybox to be installed on the host for
>> execution within the minimal container environment:
>>
>> As root (since audit rules may now only be set by root):
> 
> How about calling out the required capabilities? You don't need
> to be root, you need a specific set of capabilities. It would be
> very useful for the purposes of understanding the security value
> of the patch set to know this.
> 
CAP_AUDIT_WRITE?
