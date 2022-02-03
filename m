Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFD4A7E6C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Feb 2022 04:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349053AbiBCDmN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 22:42:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241260AbiBCDmM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 22:42:12 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212NJpRS019952;
        Thu, 3 Feb 2022 03:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=f3rcSo6xFfSbEG6+8poTq/pS5elqGatClf0Vu4JQKks=;
 b=h23AOWsooIUMoOPikFzwRIWHVEKck1SYHGUYtmhdvpf5lhAxdUfwdfdYaDu4ZdfB9LR3
 lsmKkelMfnVIhYkvqt0pmZtU6/dqoOkRHUqojHLiKpisGujKKHeQRVNqWTW98r0FiWed
 sHE4wuO0CECY54BYRxVAKG17fd5M173NAaLLlNzojVU90i9dt76VpYXnb5QRu9qvVsjO
 bN1SzkwvcwiFSiBljf5tHhiQYcp1EWmJCbBhAL6LMNMNDe2dKqrafSgqGDtMeNXo4kYH
 geMB+zgxN2oLxgAe66+pB8RdifIQhml+Kz/ndVnZmR3PWVFucwL7Ti7jwU2VUW+tEit8 vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyvexcus6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 03:42:09 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2133UBos000594;
        Thu, 3 Feb 2022 03:42:08 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyvexcurt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 03:42:08 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2133bIwS027997;
        Thu, 3 Feb 2022 03:42:07 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3dvw7bju6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 03:42:07 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2133g6n433030462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 03:42:06 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98241C6057;
        Thu,  3 Feb 2022 03:42:06 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B37DC6059;
        Thu,  3 Feb 2022 03:42:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 03:42:06 +0000 (GMT)
Message-ID: <360a17cd-778e-34de-03bf-5b737a5712c4@linux.ibm.com>
Date:   Wed, 2 Feb 2022 22:42:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Content-Language: en-US
To:     Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
 <20220202212437.mlj4cta4voqiqfpf@altlinux.org>
 <20220202223806.bcfsjtr472kl3jj3@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220202223806.bcfsjtr472kl3jj3@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ScU5gxDfPGpEN9BS8SGUVlas1zuS0kQ7
X-Proofpoint-GUID: Zvy1Bm47VIDcu0id6VlrjPxZ0upPVbSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030017
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/2/22 17:38, Vitaly Chikunov wrote:
> On Thu, Feb 03, 2022 at 12:24:37AM +0300, Vitaly Chikunov wrote:
>> Stefan,
>>
>> On Wed, Feb 02, 2022 at 07:55:43AM -0500, Stefan Berger wrote:
>>> On 2/2/22 01:59, Vitaly Chikunov wrote:
>>>> Rarely used `keyctl pkey_verify' can verify raw signatures, but was
>>>> failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
>>>> does not pass in/out sizes check in keyctl_pkey_params_get_2.
>>>> This in turn because these values cannot be distinguished by a single
>>>> `max_size' callback return value.
>>>> Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
>>>> algorithms.
>>>>
>>>> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>>> How do you use pkey_query?
>>>
>>> $ keyctl padd asymmetric testkey %keyring:test < cert.der
>>> 385037223
>> It should be (for RSA key):
>>
>>    keyctl pkey_query 385037223 0 enc=pkcs1 hash=sha256
>>
>> `0` is placeholder for a password.
>>
>> For example, I generated keys with your eckey-testing/generate.sh, and
>> pkey_query after this patch is applied:
>>    
>>    # keyctl padd asymmetric "" @u < ecdsa-ca/ca.crt.der
>>    66509339
>>    # keyctl pkey_query 66509339 0 enc=x962 hash=sha256
>>    key_size=256
>>    max_data_size=64
>>    max_sig_size=64
>>    max_enc_size=32
>>    max_dec_size=32
> I just thought, we can also set these to 0 if encrypt/decrypt is not
> enabled. Currently, there is no way to detect that encrypt is not
> possible, except by extending that if (strcmp...), but if we going to
> have it, why not correct other info too?


Sounds good.

This here works for signature verification for ECDSA now. [max_data_size 
= len * 2 was not enough]

diff --git a/crypto/asymmetric_keys/public_key.c 
b/crypto/asymmetric_keys/public_key.c
index 4fefb219bfdc..9e47a825b418 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -143,8 +143,26 @@ static int software_key_query(const struct 
kernel_pkey_params *params,

         len = crypto_akcipher_maxsize(tfm);
         info->key_size = len * 8;
-       info->max_data_size = len;
-       info->max_sig_size = len;
+       if (strcmp(alg_name, "ecrdsa") == 0) {
+               /*
+                * For these algos sig size is twice key size.
+                * keyctl uses max_sig_size as minimum input size, and
+                * max_data_size as minimum output size for a signature.
+                */
+               info->max_data_size = len * 2;
+               info->max_sig_size = len * 2;
+       } else if (strncmp(alg_name, "ecdsa-", 6) == 0) {
+               /*
+                * ECDSA encodes the signature in ASN.1 sequence (2 bytes)
+                * with 2 bytes identifying each integer and 1 byte prefixed
+                * to each integer to make it a positive number.
+                */
+               info->max_sig_size = 2 + (2 + 1 + len) * 2;
+               info->max_data_size = 2 + (2 + 1 + len) * 2;
+       } else {
+               info->max_data_size = len;
+               info->max_sig_size = len;
+       }
         info->max_enc_size = len;
         info->max_dec_size = len;
         info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |


