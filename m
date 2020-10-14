Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7959C28E8B4
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 00:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgJNWRt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 18:17:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726747AbgJNWRs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 18:17:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EM175f009369;
        Wed, 14 Oct 2020 18:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c+9zDjHpL3vtB+1ShW9X1hd0HC2V7aI9Ms4WPqRrjEs=;
 b=LAb/eT+pJmgMEF4slQFW7IDZOt6NNalRUcfxkbBPm5FPwAOl3ZclezvyCX/WIcI9BBLk
 U9VLDh0K5iCdmqrOqmJFxYVMBCp4mS2jWLxax6x3mauD9/wUIE7RwG0sFEsWmh5W+ev4
 1tyQwnUmshMsgWn+rtl8jOlXslFwoJ+cVPhG/oSBl6uxuPuzK+rAPb75IkUc9gwb3LVU
 quJjmj9k8rmV3jMsbWpw8OIvZmFvU45Jf/4HRsI4tCYkiLZVoREMMGRcy7O5KQte6NT/
 JypcQPtt3rpievPctgriTv06t6SHobIbBkrXaJLDDKkRs1RpNQ0vRtR5kvWto+v/1L5c /Q== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3469kggncd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 18:17:46 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09EMHHCx006385;
        Wed, 14 Oct 2020 22:17:45 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 345w2jpvm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 22:17:45 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09EMHiut55181794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 22:17:44 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 615C8112063;
        Wed, 14 Oct 2020 22:17:44 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DA12112061;
        Wed, 14 Oct 2020 22:17:44 +0000 (GMT)
Received: from [9.80.236.207] (unknown [9.80.236.207])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Oct 2020 22:17:44 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] ima-evm-utils: Change env variable TPM_SERVER_TYPE
 for tpm_server
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
 <20201012234416.20995-2-kgoldman@us.ibm.com>
 <ac8d885af1f79a8d1e2c137654b9924693b328b1.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <fc912ea2-ef89-7fc4-8bf2-5f107b8cfc7e@linux.ibm.com>
Date:   Wed, 14 Oct 2020 18:17:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <ac8d885af1f79a8d1e2c137654b9924693b328b1.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140149
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/14/2020 6:04 PM, Mimi Zohar wrote:
> Hi Ken,
> 
> On Mon, 2020-10-12 at 19:44 -0400, Ken Goldman wrote:
>> The default value raw is appropriate for 'swtpm'.  tpm_server
>> uses the Microsoft packet encapsulation, so the env variable
>> must have the value mssim.
>>
>> Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
> 
> Thank you for noticing this regression.
> 
>> ---
>>   tests/boot_aggregate.test | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
>> index 1c7b1f2..b109a32 100755
>> --- a/tests/boot_aggregate.test
>> +++ b/tests/boot_aggregate.test
>> @@ -35,6 +35,7 @@ else
>>   	export TPM_COMMAND_PORT=2321
>>   	export TPM_PLATFORM_PORT=2322
>>   	export TPM_SERVER_NAME="localhost"
>> +	# swtpm uses the raw, unencapsulated packet format
>>   	export TPM_SERVER_TYPE="raw"
> 
> Instead of adding a comment here, how about only exporting
> TPM_SERVER_TYPE for "swtpm".

That certainly works.  I thought the idea was, "Make the
smallest change that fixes the problem."   Moving that
line under swtpm is a reasonable alternative.

I'd leave the comment.  I suspect many people
don't know about the Microsoft TPM packet format,
so the line would otherwise be confusing.

> 
>>   
>>   fi
>> @@ -73,6 +74,8 @@ swtpm_start() {
>>   			SWTPM_PPID=$!
>>   		fi
>>   	elif [ -n "${swtpm}" ]; then
>> +	        # tpm_server uses the Microsoft simulator encapsulated packet format
>> +                export TPM_SERVER_TYPE="mssim"
> 
> Exporting TPM_SERVER_TYPE like this is causing openssl/tumbleweed to
> fail.
> 

That's odd.  Are you saying that openssl uses the env variable
TPM_SERVER_TYPE?  What in openssl fails?  What's the error
message.

