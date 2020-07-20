Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3800226CC5
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgGTRDP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 13:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726989AbgGTRDO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 13:03:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KH1P4J136235;
        Mon, 20 Jul 2020 13:03:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d5h4uqu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 13:03:03 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KH1rOx138946;
        Mon, 20 Jul 2020 13:03:02 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d5h4uqtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 13:03:02 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KH0o6q009402;
        Mon, 20 Jul 2020 17:03:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 32brq87gwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 17:03:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KH2xEv18874680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 17:02:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D619C7805E;
        Mon, 20 Jul 2020 17:02:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51ABA78064;
        Mon, 20 Jul 2020 17:02:58 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.78.37])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 17:02:58 +0000 (GMT)
Subject: Re: [PATCH v3 07/12] ima: Fail rule parsing when
 appraise_flag=blacklist is unsupportable
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-8-tyhicks@linux.microsoft.com>
 <76d2b27b-3b59-1852-046a-b1718c62b167@linux.vnet.ibm.com>
 <20200717181133.GM3673@sequoia>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <bdd8d85e-8ae9-6095-bb58-24653862f682@linux.vnet.ibm.com>
Date:   Mon, 20 Jul 2020 13:02:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717181133.GM3673@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007200111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/17/20 2:11 PM, Tyler Hicks wrote:
> On 2020-07-17 13:40:22, Nayna wrote:
>> On 7/9/20 2:19 AM, Tyler Hicks wrote:
>>> The "appraise_flag" option is only appropriate for appraise actions
>>> and its "blacklist" value is only appropriate when
>>> CONFIG_IMA_APPRAISE_MODSIG is enabled and "appraise_flag=blacklist" is
>>> only appropriate when "appraise_type=imasig|modsig" is also present.
>>> Make this clear at policy load so that IMA policy authors don't assume
>>> that other uses of "appraise_flag=blacklist" are supported.
>>>
>>> Fixes: 273df864cf74 ("ima: Check against blacklisted hashes for files with modsig")
>>> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>>> Cc: Nayna Jain <nayna@linux.ibm.com>
>>> ---
>>>
>>> * v3
>>>     - New patch
>>>
>>>    security/integrity/ima/ima_policy.c | 13 ++++++++++++-
>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>>> index 81da02071d41..9842e2e0bc6d 100644
>>> --- a/security/integrity/ima/ima_policy.c
>>> +++ b/security/integrity/ima/ima_policy.c
>>> @@ -1035,6 +1035,11 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>>>    		return false;
>>>    	}
>>> +	/* Ensure that combinations of flags are compatible with each other */
>>> +	if (entry->flags & IMA_CHECK_BLACKLIST &&
>>> +	    !(entry->flags & IMA_MODSIG_ALLOWED))
>>> +		return false;
>>> +
>>>    	return true;
>>>    }
>>> @@ -1371,8 +1376,14 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>>    				result = -EINVAL;
>>>    			break;
>>>    		case Opt_appraise_flag:
>>> +			if (entry->action != APPRAISE) {
>>> +				result = -EINVAL;
>>> +				break;
>>> +			}
>>> +
>>>    			ima_log_string(ab, "appraise_flag", args[0].from);
>>> -			if (strstr(args[0].from, "blacklist"))
>>> +			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
>>> +			    strstr(args[0].from, "blacklist"))
>>>    				entry->flags |= IMA_CHECK_BLACKLIST;
>> If IMA_APPRAISE_MODSIG is disabled, it will allow the following rule to
>> load, which is not as expected.
>>
>> "appraise func=xxx_CHECK appraise_flag=blacklist appraise_type=imasig"
>>
>> Missing is the "else" condition to immediately reject the policy rule.
> Thanks for the review. You're right. This change is needed:
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9842e2e0bc6d..cf3ddb38dfa8 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1385,6 +1385,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
>   			    strstr(args[0].from, "blacklist"))
>   				entry->flags |= IMA_CHECK_BLACKLIST;
> +			else
> +				result = -EINVAL;
>   			break;
>   		case Opt_permit_directio:
>   			entry->flags |= IMA_PERMIT_DIRECTIO;
>
Reviewed-by: Nayna Jain<nayna@linux.ibm.com>

Tested-by: Nayna Jain<nayna@linux.ibm.com>

Thanks & Regards,

       - Nayna

