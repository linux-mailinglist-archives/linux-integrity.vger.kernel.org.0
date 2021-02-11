Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDA319222
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 19:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhBKSV1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 13:21:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232640AbhBKSTj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 13:19:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BIC9fe013532;
        Thu, 11 Feb 2021 13:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kBmFU0YCpofm9gB012qjiaFnmfB6/JRiWUFH28MqETs=;
 b=ssSMpJ5QNkgGUXaA40VEnjn8mJlfKHi+H6nuemWjlNVF1861jLZ4Kr5to2ZO2qyEU39l
 zXGC4KLRb6EqLotQX3en/c4h9cQkfiLCl9hUkS27waRGiS6MoEWKLYjSsT/bHvnceqBl
 5gP8Azv9tsBu1V4g2quJoS4f51Ff+vUNm7VBXtM7DQmUQnK4tiZaomddUJWBsTUMA2Sw
 /XGH23zRD+H2/Kw+94kxlD++sJ1ZHWQAz/gbseELdWOZdYE3rWmdOt7gZcwJOcURZaL4
 IGXExPw7KzKVrTDg0MFMwqrzoaorjHlVuQptdLZ5aA6nDAiB9CFYqfoQPCZjbUO7e8b5 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36n9na08wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 13:18:47 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BICUXH015626;
        Thu, 11 Feb 2021 13:18:47 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36n9na08wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 13:18:47 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BIDUHG000900;
        Thu, 11 Feb 2021 18:18:47 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 36hjr9qkk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 18:18:47 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BIIkWF7996178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 18:18:46 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F9BA124054;
        Thu, 11 Feb 2021 18:18:46 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F60B124053;
        Thu, 11 Feb 2021 18:18:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 18:18:46 +0000 (GMT)
Subject: Re: [PATCH v7 3/4] x509: Add support for parsing x509 certs with
 ECDSA keys
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     dhowells@redhat.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        patrick@puiterwijk.org, linux-integrity@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20210201151910.1465705-4-stefanb@linux.ibm.com>
 <202102111531.JYJl0c7G-lkp@intel.com>
 <b72f396e-fafa-cff3-cee2-a47ac5274dc4@linux.ibm.com>
Message-ID: <58a980d7-ce90-2333-d5ae-014919e6c5d0@linux.ibm.com>
Date:   Thu, 11 Feb 2021 13:18:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b72f396e-fafa-cff3-cee2-a47ac5274dc4@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102110144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/11/21 12:30 PM, Stefan Berger wrote:
> On 2/11/21 3:03 AM, kernel test robot wrote:
>> Hi Stefan,
>>
>> Thank you for the patch! Yet something to improve:
>>
>>>> crypto/asymmetric_keys/public_key.c:97: undefined reference to 
>>>> `parse_OID'
>
>
> So the issue is that  only ASYMMETRIC_PUBLIC_KEY_SUBTYPE is selected 
> in this config and the selection of OID_REGISTRY is missing. I am not 
> sure whether ASYMMETRIC_PUBLIC_KEY_SUBTYPE should/could select 
> OID_REGISTRY or whether that would be wrong... ?


David,

   if the above is not desired then the following change would let us 
get rid of the offending parse_OID(). The below change is only for NIST 
p192 in this experiment but shows that we need to add additional 
strcmp() cases in x509_check_for_self_signed() since 
cert->sig->pkey_algo is set to "ecdsa". I am not sure whether we should 
derive from the signature which curve was used to create the signature 
so that cert->sig->pkey_algo could be more specific and the simple 
existing strcmp() would pass. So two possible ways to go forward. Which 
way should we go?

    Stefan


diff --git a/crypto/asymmetric_keys/x509_cert_parser.c 
b/crypto/asymmetric_keys/x509_cert_parser.c
index 0aff4e584b11..71d83bb345c4 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -505,6 +505,8 @@ int x509_extract_key_data(void *context, size_t hdrlen,
                         ctx->cert->pub->pkey_algo = "sm2";
                         break;
                 case OID_id_prime192v1:
+                       ctx->cert->pub->pkey_algo = "ecdsa-nist-p192";
+                       break;
                 case OID_id_prime256v1:
                         ctx->cert->pub->pkey_algo = "ecdsa";
                         break;
diff --git a/crypto/asymmetric_keys/x509_public_key.c 
b/crypto/asymmetric_keys/x509_public_key.c
index ae450eb8be14..3ebeed195b61 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -129,7 +129,10 @@ int x509_check_for_self_signed(struct 
x509_certificate *cert)
         }

         ret = -EKEYREJECTED;
-       if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
+printk(KERN_INFO "%s: %s ==? %s\n", __func__, cert->pub->pkey_algo, 
cert->sig->pkey_algo);
+       if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0 &&
+           strncmp(cert->pub->pkey_algo, "ecdsa-nist-p", 12) != 0 &&
+           strcmp(cert->sig->pkey_algo, "ecdsa") != 0)
                 goto out;

         ret = public_key_verify_signature(cert->pub, cert->sig);


>
>
>     Stefan
>
