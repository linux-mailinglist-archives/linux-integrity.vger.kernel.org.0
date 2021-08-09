Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB63E4C44
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhHISjc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 14:39:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232130AbhHISjb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 14:39:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179IY0Jv055109;
        Mon, 9 Aug 2021 14:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6MQI+U+zBKtMcprEw3OjNrtfQcqBpiEGAf1gUiRNayY=;
 b=MvkxwEoPixkwiNv2hsYE2hy1vlD70KATKSUaqURUfIPD26AigO1HnqVocBvmAp1KcRCH
 WrMtFmOs0mtJKNn9XZUuEpURZsyy+3uwmPXZdiSCKrMXe/r0BxdWx6bxjhdBhOUl3jFp
 MgRAiNCnLiOBDsFxmex8Zs0ns47ElIO6KM5+NAB+jSAF8e0Ea+nIEYrjJRR0YWt6t6Ti
 VQBTbzRTueKo00YaL6Cs3Q4Y0IJXiYg5xHA8e2kjNd1bCkUUUla5/Z/xWO7gezI+vGD3
 bbLa1GWSybebXocgsdy19v2Uq5Ajv7g0tb/IHuBq+Txutag6gF3z+JZzTqulatYPtLgi /Q== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aa736sddd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 14:39:09 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179IXHcl022038;
        Mon, 9 Aug 2021 18:39:08 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 3aapj912vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 18:39:08 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179Id7nt29688128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 18:39:07 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7781E6E068;
        Mon,  9 Aug 2021 18:39:07 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD716E066;
        Mon,  9 Aug 2021 18:39:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 18:39:06 +0000 (GMT)
Subject: Re: [PATCH 2/4] libimaevm: Add support for pkcs11 private keys for
 signing a v2 hash
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
References: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
 <20210809151026.195038-3-stefanb@linux.vnet.ibm.com>
 <e282548fa640013130ba7a51329658d552471110.camel@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8a259318-e676-77bd-1253-b5070f8496dc@linux.ibm.com>
Date:   Mon, 9 Aug 2021 14:39:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e282548fa640013130ba7a51329658d552471110.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6BVlK5FfkBO8E9avNu65Ub92EEr3tvpc
X-Proofpoint-ORIG-GUID: 6BVlK5FfkBO8E9avNu65Ub92EEr3tvpc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_07:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090131
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/9/21 11:27 AM, James Bottomley wrote:

> On Mon, 2021-08-09 at 11:10 -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Add support for pkcs11 private keys for signing a v2 hash.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   README          |  1 +
>>   src/evmctl.c    |  1 +
>>   src/libimaevm.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
>> --
>>   3 files changed, 50 insertions(+), 11 deletions(-)
>>
>> diff --git a/README b/README
>> index 1cc027f..2bb363c 100644
>> --- a/README
>> +++ b/README
>> @@ -48,6 +48,7 @@ OPTIONS
>>         --xattr-user   store xattrs in user namespace (for testing
>> purposes)
>>         --rsa          use RSA key type and signing scheme v1
>>     -k, --key          path to signing key (default:
>> /etc/keys/{privkey,pubkey}_evm.pem)
>> +                     or a pkcs11 URI
>>         --keyid n      overwrite signature keyid with a 32-bit value
>> in hex (for signing)
>>         --keyid-from-cert file
>>                        read keyid value from SKID of a x509 cert file
>> diff --git a/src/evmctl.c b/src/evmctl.c
>> index 58f8e66..2e85f8b 100644
>> --- a/src/evmctl.c
>> +++ b/src/evmctl.c
>> @@ -2503,6 +2503,7 @@ static void usage(void)
>>   		"      --xattr-user   store xattrs in user namespace
>> (for testing purposes)\n"
>>   		"      --rsa          use RSA key type and signing
>> scheme v1\n"
>>   		"  -k, --key          path to signing key (default:
>> /etc/keys/{privkey,pubkey}_evm.pem)\n"
>> +		"                     or a pkcs11 URI\n"
>>   		"      --keyid n      overwrite signature keyid with a
>> 32-bit value in hex (for signing)\n"
>>   		"      --keyid-from-cert file\n"
>>   		"                     read keyid value from SKID of a
>> x509 cert file\n"
>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>> index 8e96157..b84e5b8 100644
>> --- a/src/libimaevm.c
>> +++ b/src/libimaevm.c
>> @@ -60,6 +60,7 @@
>>   #include <openssl/x509.h>
>>   #include <openssl/x509v3.h>
>>   #include <openssl/err.h>
>> +#include <openssl/engine.h>
>>   
>>   #include "imaevm.h"
>>   #include "hash_info.h"
>> @@ -803,21 +804,57 @@ static EVP_PKEY *read_priv_pkey(const char
>> *keyfile, const char *keypass)
>>   {
>>   	FILE *fp;
>>   	EVP_PKEY *pkey;
>> +	ENGINE *e;
>>   
>> -	fp = fopen(keyfile, "r");
>> -	if (!fp) {
>> -		log_err("Failed to open keyfile: %s\n", keyfile);
>> -		return NULL;
>> -	}
>> -	pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
>> -	if (!pkey) {
>> -		log_err("Failed to PEM_read_PrivateKey key file: %s\n",
>> -			keyfile);
>> -		output_openssl_errors();
>> +	if (!strncmp(keyfile, "pkcs11:", 7)) {
>> +		if (!imaevm_params.keyid) {
>> +			log_err("When using a pkcs11 URI you must
>> provide the keyid with an option\n");
>> +			return NULL;
>> +		}
>> +
>> +		ENGINE_load_builtin_engines();
>> +		e = ENGINE_by_id("pkcs11");
>> +		if (!e) {
>> +			log_err("Failed to load pkcs11 engine\n");
>> +			goto err_pkcs11;
>> +		}
>> +		if (!ENGINE_init(e)) {
>> +			log_err("Failed to initialize the pkcs11
>> engine\n");
>> +			goto err_pkcs11;
>> +		}
>> +		if (keypass) {
>> +			if (!ENGINE_ctrl_cmd_string(e, "PIN", keypass,
>> 0)) {
>> +				log_err("Failed to set the PIN for the
>> private key\n");
>> +				goto err_pkcs11;
>> +			}
>> +		}
>> +		pkey = ENGINE_load_private_key(e, keyfile, NULL, NULL);
>> +		if (!pkey) {
>> +			log_err("Failed to load private key %s\n",
>> keyfile);
>> +			goto err_pkcs11;
>> +		}
>> +	} else {
>> +		fp = fopen(keyfile, "r");
>> +		if (!fp) {
>> +			log_err("Failed to open keyfile: %s\n",
>> keyfile);
>> +			return NULL;
>> +		}
>> +		pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void
>> *)keypass);
>> +		if (!pkey) {
>> +			log_err("Failed to PEM_read_PrivateKey key
>> file: %s\n",
>> +				keyfile);
>> +			output_openssl_errors();
>> +		}
>> +
>> +		fclose(fp);
> This looks a bit narrow.  Isn't the problem that *any* engine key might
> be a specifier not a file?  In which case the generic fix is not to
> validate file existence if an engine is present on the command line.
> That way you can specify any engine key and the pkcs11 key simply
> becomes a special case of this.
>
> If you insist on not having to specify --engine for pkcs11 keys then
> you do the prefix check earlier on and set the engine to pkcs11 (if
> it's not already set to something else).

I had thought about it but what kept me from wanting to use the engine 
in evmctl is the crossing into the library and having to extend the 
library API there just for this purpose or extending the global variable 
'imaevm_params', which is less than ideal as well.


    Stefan


>
> James
>
>
