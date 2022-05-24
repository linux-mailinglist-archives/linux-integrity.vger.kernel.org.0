Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316B9532B42
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiEXN0V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 09:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbiEXN0M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 09:26:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFC34B9C;
        Tue, 24 May 2022 06:26:11 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ODBdAm029873;
        Tue, 24 May 2022 13:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hBbcMrX9s6JSpr08mbOB4SZ6XiS2E7eqbNX1M5D5MBY=;
 b=AAAByyi91dHEoGm6NYlZn+wRXYe74rFA7dWvXySO+ATU2V3bumZAlWRKf1gQzvp/8/jf
 hcpaxosyWSDnSokBRoM4uPK7lVeLDGhUUH9/RpySgvv5XLBP7We/g9IYkTsU4sIFOnK3
 f4bi/fvwXZpucg8S9TL43/a1aib1N0iYBTDWGFjO3yW74mIW0I2ASroV65+NkVvNZOvk
 P72SGcnLaQsHzdSxMldx+7Vb/1briIWwYJtJPwqX27MkfbxbPqJiS99MpqLVmDdHSCpA
 +X2/S8NZ2lQqhFzb9e60Vz4JLlntJdYOzngVACRgg680c7lV4j+WqgGKQEDB94frkeQR lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g901ggasw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:25:35 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24ODCcnT032838;
        Tue, 24 May 2022 13:25:34 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g901ggasm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:25:34 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24ODK0DZ013006;
        Tue, 24 May 2022 13:25:33 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3g6qqa66wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:25:33 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ODPWEL30277940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 13:25:32 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C65E6A054;
        Tue, 24 May 2022 13:25:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B8466A04F;
        Tue, 24 May 2022 13:25:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 13:25:30 +0000 (GMT)
Message-ID: <6c16b3b8-cd3f-4175-9269-2c542f7d4188@linux.ibm.com>
Date:   Tue, 24 May 2022 09:25:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 12/26] ima: Only accept AUDIT rules for
 non-init_ima_ns namespaces for now
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
 <20220420140633.753772-13-stefanb@linux.ibm.com>
 <20220522173844.GA24519@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220522173844.GA24519@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6NFAnCdZijNoZg9U7nT1qmCrXylN8GWD
X-Proofpoint-GUID: D-cNVwma8oNMshAs7sKX_m1vlca8muQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_06,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205240066
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/22/22 13:38, Serge E. Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:19AM -0400, Stefan Berger wrote:
>> Only accept AUDIT rules for non-init_ima_ns namespaces for now. Reject
> 
> This sentence gives me trouble - i keep thinking you mean that you'll
> reject AUDIT rules for init_ima_ns :)  Can you rephrase it as something
> like
> 
> For non-init_ima_ns namespaces, only accept AUDIT rules for now.
> 
> :)
> 
>> all rules that require support for measuring, appraisal, and hashing.
>

I kept the title of the patch but the text now states:

For non-init_ima_ns namespaces, only accept AUDIT rules for now. Reject
all rules that require support for measuring, appraisal, and hashing.



>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Acked-by: Christian Brauner <brauner@kernel.org>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>
>> ---
>> v9:
>>    - Jump to err_audit when unsupported rules are detected
>> ---
>>   security/integrity/ima/ima_policy.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 59e4ae5a6361..45a997709200 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -1812,6 +1812,17 @@ static int ima_parse_rule(struct ima_namespace *ns,
>>   			result = -EINVAL;
>>   			break;
>>   		}
>> +
>> +		/* IMA namespace only accepts AUDIT rules */
>> +		if (ns != &init_ima_ns && result == 0) {
>> +			switch (entry->action) {
>> +			case MEASURE:
>> +			case APPRAISE:
>> +			case HASH:
> 
> So... what about DONT_MEASURE and DONT_APPRAISE?

They don't cause IMA to do anything that is not supported at this point 
so I let them pass. If you set these you still don't get a measurements 
or appraisal and that's good at this point..

> 
>> +				result = -EINVAL;
>> +				goto err_audit;
>> +			}
>> +		}
>>   	}
>>   	if (!result && !ima_validate_rule(entry))
>>   		result = -EINVAL;
>> @@ -1824,6 +1835,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
>>   		check_template_modsig(template_desc);
>>   	}
>>   
>> +err_audit:
>>   	audit_log_format(ab, "res=%d", !result);
>>   	audit_log_end(ab);
>>   	return result;
>> -- 
>> 2.34.1
