Return-Path: <linux-integrity+bounces-175-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E947F3A37
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839B0B21881
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8042A51018;
	Tue, 21 Nov 2023 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="brgnIJUn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118971A3
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 15:20:36 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALNCkND020107;
	Tue, 21 Nov 2023 23:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T+gZpLjyOnLeX6X7LBZB+Zore55yds96HhNFTJt6nVM=;
 b=brgnIJUnoOy+SK4lHu8gnQN9YZHTOfqJva9rAf5Up0K993SpB1i0tLOsFd0Ft8dEn09I
 7SZeUMIoXev6COw032MAWMgL7pDT+oVaqFGwqugJ+VzMdmSb/VuzjlVuP1YPABuVJJdz
 XCVGZsHYEu6yE5W7uQa5PLcNLXWjiIiWT6xwICK6hCS+8nfzH/UkHxAL3b5+ydFgJDwQ
 6J1AWt29NeYmbNmzGq/uNHnu9+8qsWm1r5hipdHyCuHEGErjWghsIFHVqWS41iWDYNgz
 TNf9Fg3VPgRS2ZWhlKK0oNqfcu2O3IwffMzdeErOXo5I1CDrqxf6VwWZfqyMgPC7hLya 5Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh6120568-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 23:20:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALM4IUM007433;
	Tue, 21 Nov 2023 23:20:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kt4c97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 23:20:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALNKQEN13894220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 23:20:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926DD58060;
	Tue, 21 Nov 2023 23:20:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A86958056;
	Tue, 21 Nov 2023 23:20:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Nov 2023 23:20:26 +0000 (GMT)
Message-ID: <3aab1167-80bb-4ed9-b200-fbb87586b0a0@linux.ibm.com>
Date: Tue, 21 Nov 2023 18:20:26 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 04/14] tests: Address issues raised by
 shellcheck SC2320
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huaweicloud.com
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
 <20231110202137.3978820-5-stefanb@linux.ibm.com>
 <3083025b210cd5c44e9fa0df578c0b210a690f0c.camel@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <3083025b210cd5c44e9fa0df578c0b210a690f0c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _QxQxkyRpyy1dNjsMckvDr62m2NrF0FF
X-Proofpoint-ORIG-GUID: _QxQxkyRpyy1dNjsMckvDr62m2NrF0FF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_14,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210182



On 11/21/23 18:03, Mimi Zohar wrote:
> Hi Stefan,
> 
> On Fri, 2023-11-10 at 15:21 -0500, Stefan Berger wrote:
>> Address issues raised by shellcheck SC2320:
>>    "This $? refers to echo/printf, not a previous command.
>>     Assign to variable to avoid it being overwritten."
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   tests/Makefile.am              | 2 +-
>>   tests/mmap_check.test          | 8 +++-----
>>   tests/portable_signatures.test | 9 +++------
>>   3 files changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/Makefile.am b/tests/Makefile.am
>> index bcc1ee4..babfa7a 100644
>> --- a/tests/Makefile.am
>> +++ b/tests/Makefile.am
>> @@ -26,7 +26,7 @@ clean-local:
>>   distclean: distclean-keys
>>   
>>   shellcheck:
>> -	shellcheck -i SC2086,SC2181,SC2046 \
>> +	shellcheck -i SC2086,SC2181,SC2046,SC2320 \
>>   		functions.sh gen-keys.sh install-fsverity.sh \
>>   		install-mount-idmapped.sh install-openssl3.sh \
>>   		install-swtpm.sh install-tss.sh softhsm_setup \
>> diff --git a/tests/mmap_check.test b/tests/mmap_check.test
>> index 2dd3433..3d2e1b1 100755
>> --- a/tests/mmap_check.test
>> +++ b/tests/mmap_check.test
>> @@ -97,11 +97,9 @@ check_load_ima_rule() {
>>   
>>   	new_policy=$(mktemp -p "$g_mountpoint")
>>   	echo "$1" > "$new_policy"
>> -	echo "$new_policy" > /sys/kernel/security/ima/policy
>> -	result=$?
>> -	rm -f "$new_policy"
>> -
>> -	if [ "$result" -ne 0 ]; then
>> +	if echo "$new_policy" > /sys/kernel/security/ima/policy; then
>> +		rm -f "$new_policy"
>> +	else
>>   		echo "${RED}Failed to set IMA policy${NORM}"
>>   		return "$HARDFAIL"
>>   	fi
> 
> This isn't equiavlent.  $new_policy was previously always removed.

Uuuh, thanks. Fixed.

> 
>> diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
>> index 9f3339b..5251211 100755
>> --- a/tests/portable_signatures.test
>> +++ b/tests/portable_signatures.test
>> @@ -80,7 +80,6 @@ METADATA_CHANGE_FOWNER_2=3002
>>   
>>   check_load_ima_rule() {
>>   	local rule_loaded
>> -	local result
>>   	local new_policy
>>   
>>   	rule_loaded=$(grep "$1" /sys/kernel/security/ima/policy)
>> @@ -88,11 +87,9 @@ check_load_ima_rule() {
>>   		new_policy=$(mktemp -p "$g_mountpoint")
>>   		echo "$1" > "$new_policy"
>>   		evmctl sign -o -a sha256 --imasig --key "$key_path" "$new_policy" &> /dev/null
>> -		echo "$new_policy" > /sys/kernel/security/ima/policy
>> -		result=$?
>> -		rm -f "$new_policy"
>> -
>> -		if [ "$result" -ne 0 ]; then
>> +		if echo "$new_policy" > /sys/kernel/security/ima/policy; then
>> +			rm -f "$new_policy"
>> +		else
>>   			echo "${RED}Failed to set IMA policy${NORM}"
>>   			return "$FAIL"
>>   		fi
> 
> Same here.
> 

