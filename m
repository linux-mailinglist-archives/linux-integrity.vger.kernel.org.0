Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E704005D6
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbhICTbk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 15:31:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5198 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239073AbhICTbj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 15:31:39 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183J8KnI037994
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 15:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tEq6FIqZn38LFaNItUHt6ITzLpQD5pbyCFAjVdBM7yo=;
 b=eRLuDb8KGNR/zlitRo7k4/bHnuaF206s4fhw18+E8V5jPvs4uVU6UXJyH8yc8QUNpDdg
 v3vMpgEKutQmfVBXq0u7OPXA6Fcr6a9jF+tUSFytOsNS8LY6tRripGsSNB26gGv90voy
 8iACl+9LeIvZnGXy1VW9d5IaNQo16tFNvXw31E++CK9FRAdcV8Vx2eNfZeR4lUbn/ITo
 fOauleeeZiePmWJcwvSWjxQjR84bJO6RBIm+U6urcQibfbxMqv+p35dcXhl2IwHWDlQs
 2bluVj7TNeV1UbNIx2/KjjTe10QVFELvl2d2fBeEilSMPpQQVTg8vXapZNqYUMfq5EPB 1Q== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aur57t7hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 15:30:38 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183JT26W000867
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 19:30:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3au6pntbg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 19:30:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183JUawA25362860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 19:30:36 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C2F6124054;
        Fri,  3 Sep 2021 19:30:36 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45ECE124053;
        Fri,  3 Sep 2021 19:30:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 19:30:36 +0000 (GMT)
Subject: Re: [PATCH v2 7/8] tests: Extend sign_verify test with
 pkcs11-specific test
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
 <20210810134557.2444863-8-stefanb@linux.vnet.ibm.com>
 <7a53fd3b1011c0a023ecbf8267db72d219442a53.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <7209c147-1d83-f553-71ed-98195183e2ab@linux.ibm.com>
Date:   Fri, 3 Sep 2021 15:30:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7a53fd3b1011c0a023ecbf8267db72d219442a53.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hJp-TBByVnD2Vm_kSUNB2XSOXbQmb2XT
X-Proofpoint-ORIG-GUID: hJp-TBByVnD2Vm_kSUNB2XSOXbQmb2XT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/3/21 3:11 PM, Mimi Zohar wrote:
> Hi Stefan,
>
> On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Extend the sign_verify test with a pkcs11-specific test.
>> Import softhsm_setup script from my swtpm project and contribute
>> it to this porject under dual license BSD 3-clause and GLP 2.0.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Up to here, the patches were nicely split up.  Just from reading the
> patch description, this patch needs to be split up.

Ok, softhsm_setup will be a separate patch then before function.sh and 
sign_verify.test are being patched.


>
>> ---
>>   tests/functions.sh     |  26 ++++
>>   tests/sign_verify.test |  50 +++++--
>>   tests/softhsm_setup    | 290 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 352 insertions(+), 14 deletions(-)
>>   create mode 100755 tests/softhsm_setup
>>
>> diff --git a/tests/functions.sh b/tests/functions.sh
>> index 91cd5d9..cbb7ea4 100755
>> --- a/tests/functions.sh
>> +++ b/tests/functions.sh
>> @@ -272,3 +272,29 @@ _report_exit() {
>>     fi
>>   }
>>   
>> +_at_exit() {
>> +  _report_exit
>> +  if [ -n "${WORKDIR}" ]; then
>> +    rm -f "${WORKDIR}"
>> +  fi
>> +}
>> +
> It would be nice to have a function comment here.

I can add this.

>
>> +_softhsm_setup() {
>> +  local workdir="$1"
>> +
> ${WORKDIR} is being passed as a parameter.  Why is a local environment
> variable needed?


I prefer to avoid accessing them when they can be passed to functions as 
parameters. I rather only use global variables at the 'top level' and 
then pass them down as parameters to all the lower level functions.


>
>> +  local msg
>> +
>> +  export SOFTHSM_SETUP_CONFIGDIR="${workdir}"
>> +  export SOFTHSM2_CONF="${workdir}/softhsm2.conf"
>> +
>> +  msg=$(./softhsm_setup setup 2>&1)
>> +  if [ $? -eq 0 ]; then
>> +    echo "softhsm_setup setup succeeded: $msg"
>> +    PKCS11_KEYURI=$(echo $msg | sed -n 's|^keyuri: \(.*\)|\1|p')
>> +
>> +    export OPENSSL_ENGINE="-engine pkcs11"
>> +    export OPENSSL_KEYFORM="-keyform engine"
>> +  else
>> +    echo "softhsm_setup setup failed: ${msg}"
>> +  fi
> Should there be a test checking that softhsm_setup is installed before
> using it?   If it's not installed, then the test is "skipped".

softhsm_setup is being contributed to this project via the code above, 
so it should be available.


>
>> +}
>> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
>> index 3b42eec..369765e 100755
>> --- a/tests/sign_verify.test
>> +++ b/tests/sign_verify.test
>> @@ -28,7 +28,8 @@ fi
>>   
>>   ./gen-keys.sh >/dev/null 2>&1
>>   
>> -trap _report_exit EXIT
>> +trap _at_exit EXIT
>> +WORKDIR=$(mktemp -d)
>>   set -f # disable globbing
>>   
>>   # Determine keyid from a cert
>> @@ -132,11 +133,16 @@ check_sign() {
>>     # OPTS (additional options for evmctl),
>>     # FILE (working file to sign).
>>     local "$@"
>> -  local KEY=${KEY%.*}.key
>> +  local key verifykey
> Agreed, don't modify the global variable, use a local one.  Making this
> a separate patch, would simplify review.
> thanks,
>
> Mimi
>
