Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E466056A521
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiGGOMk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiGGOMk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:12:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2E2CC9E;
        Thu,  7 Jul 2022 07:12:36 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267DoK4o033255;
        Thu, 7 Jul 2022 14:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fcx2vaYpLimBdEBYsnGNhtx56Y7bddCHHHVLh18fXpU=;
 b=UU7lc1KFOycR//lVyNmVObRB2eMZj9Wp3Mh/yc3HG7HtdcY7IOekOtT5MKh0JxCwejvv
 M+Iul70whE8rwXIQ6mRnpUUZgvOntIEsJqt9bxnLXx4U4ZAsCHNFNkrB4k6Pp656vfOY
 rYPR3OnQJY08Hc8ACbGfQh+ox/hzhfcqYLM4vHJ5qEAziDMMa7OQzrrX+2t1Cg4GeG30
 XiJ3Kq+L6R8NMseAiCA4cg51X4jepXz5cU1WycX+mdHfxGV0cF9Qsj7gUg81h5UftlOD
 vAiFDPzx8fhJtB0DrsoBMelJGH3qceh8EbjlmmPwZ2FtKF86IrAaUdBh3FWXpMPp7aD6 QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60qp0s3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:12:14 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267Ds61f004934;
        Thu, 7 Jul 2022 14:12:14 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60qp0s2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:12:14 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267E5lEU016355;
        Thu, 7 Jul 2022 14:12:13 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3h4ud7pn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:12:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267ECBNQ37093642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:12:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73C4EBE05A;
        Thu,  7 Jul 2022 14:12:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C8CFBE058;
        Thu,  7 Jul 2022 14:12:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:12:10 +0000 (GMT)
Message-ID: <ba9a7f72-3a68-d3fe-a55d-ff1e4ac41e6e@linux.ibm.com>
Date:   Thu, 7 Jul 2022 10:12:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 04/26] ima: Move arch_policy_entry into ima_namespace
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-5-stefanb@linux.ibm.com>
 <20220521024633.GB9107@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220521024633.GB9107@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vKogRgOJWS65HCVdqDHhSNdTehHRaXjo
X-Proofpoint-GUID: XTndIoLAhmDMjP4LgIeE0qvSnmrbQMM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/20/22 22:46, Serge E. Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:11AM -0400, Stefan Berger wrote:

>> @@ -1005,7 +1003,8 @@ void ima_update_policy(struct ima_namespace *ns)
>>   		 * on boot.  After loading a custom policy, free the
>>   		 * architecture specific rules stored as an array.
>>   		 */
>> -		kfree(arch_policy_entry);
>> +		kfree(ns->arch_policy_entry);
>> +		ns->arch_policy_entry = NULL;
> 
> So the thing that prevents multiple racing occurances of the above two lines is
> that ima_open_policy() sets IMA_FS_BUSY (or returns EBUSY) and then removes
> this file before clearing the flag, right?

Correct.

> 
> Seems good.
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> 
>>   	}
>>   	ima_update_policy_flags(ns);
>>   
>> -- 
>> 2.34.1
