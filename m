Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1514952FA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jan 2022 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377265AbiATROE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jan 2022 12:14:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1377264AbiATRNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jan 2022 12:13:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KGBp7w027507;
        Thu, 20 Jan 2022 17:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cy6JvmbrB4OvjBhbkd9zN86yJGoLMa3Ke4n5j516s7E=;
 b=YB719x6l25BChElHxBCWxertUHOFGLYeeSXcKK0caSm/ocdx6Br2pxoOy6Oi3WFWTqM+
 ym/S52KqMplJoLl3natOzm1odGz0xIXj8Py9ciKZJaAZpIM6R7tXB3DYFp8Fxvu6OM8F
 SyEV4ValtXCOp0QFjzm+lxLsRhCm0fHpK8fEDbuXMgp6mwMoHw2vF328NcKbFsq7Zmch
 suDGcbgYNvZ1QIghDcx8syoeBaNXu9QKb1len3B5iEo1vyigE48czVdSVFU8eVFbhPu4
 32vbKV5CZMqtnaPnJLB5pRQ54zYPSiMEPb1iQIolYvX4GFNOroNFAEVy2YSMmPtj+3jW Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dqb1sse8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:13:42 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20KHBFvJ003183;
        Thu, 20 Jan 2022 17:13:42 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dqb1sse8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:13:42 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KH2BsX023368;
        Thu, 20 Jan 2022 17:13:41 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3dknwd54u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:13:41 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KHDdju30278014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 17:13:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2A69B2074;
        Thu, 20 Jan 2022 17:13:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9CF5B2065;
        Thu, 20 Jan 2022 17:13:34 +0000 (GMT)
Received: from [9.211.61.238] (unknown [9.211.61.238])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 17:13:34 +0000 (GMT)
Message-ID: <533aa459-f28b-2888-ef9f-3036ece5f023@linux.vnet.ibm.com>
Date:   Thu, 20 Jan 2022 12:13:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
Content-Language: en-US
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <20211229215330.4134835-1-yaelt@google.com>
 <e29dc7de-b656-7c27-2294-fb4936e99e69@linux.vnet.ibm.com>
 <CAKoutNspnn-VuKsxODYdX4P68vCpRveRFG=FKCVG9Vu-vev4fg@mail.gmail.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <CAKoutNspnn-VuKsxODYdX4P68vCpRveRFG=FKCVG9Vu-vev4fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aZr-kX8pR7U3kzzJouKo7AS08-npRhe7
X-Proofpoint-GUID: 1rp5NW1T7eVrMQmUmT2IZzyZxrUpL-dD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/13/22 14:01, Yael Tiomkin wrote:
> On Mon, Jan 10, 2022 at 11:04 AM Nayna <nayna@linux.vnet.ibm.com> wrote:
>>
>> On 12/29/21 16:53, Yael Tiomkin wrote:
>>> The encrypted.c class supports instantiation of encrypted keys with
>>> either an already-encrypted key material, or by generating new key
>>> material based on random numbers. This patch defines a new datablob
>>> format: [<format>] <master-key name> <decrypted data length>
>>> <decrypted data> that allows to instantiate encrypted keys using
>>> user-provided decrypted data, and therefore allows to perform key
>>> encryption from userspace. The decrypted key material will be
>>> inaccessible from userspace.
>>>
>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>> Signed-off-by: Yael Tiomkin <yaelt@google.com>
>>> ---
>>>
>>> Notes:
>>>       v -> v2: fixed compilation error.
>>>
>>>       v2 -> v3: modified documentation.
>>>
>>>       v3 -> v4: modified commit message.
>>>
>>>    .../security/keys/trusted-encrypted.rst       | 25 ++++++--
>>>    security/keys/encrypted-keys/encrypted.c      | 62 +++++++++++++------
>>>    2 files changed, 63 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
>>> index 80d5a5af62a1..f614dad7de12 100644
>>> --- a/Documentation/security/keys/trusted-encrypted.rst
>>> +++ b/Documentation/security/keys/trusted-encrypted.rst
>>> @@ -107,12 +107,13 @@ Encrypted Keys
>>>    --------------
>>>
>>>    Encrypted keys do not depend on a trust source, and are faster, as they use AES
>>> -for encryption/decryption. New keys are created from kernel-generated random
>>> -numbers, and are encrypted/decrypted using a specified ‘master’ key. The
>>> -‘master’ key can either be a trusted-key or user-key type. The main disadvantage
>>> -of encrypted keys is that if they are not rooted in a trusted key, they are only
>>> -as secure as the user key encrypting them. The master user key should therefore
>>> -be loaded in as secure a way as possible, preferably early in boot.
>>> +for encryption/decryption. New keys are created either from kernel-generated
>>> +random numbers or user-provided decrypted data, and are encrypted/decrypted
>>> +using a specified ‘master’ key. The ‘master’ key can either be a trusted-key or
>>> +user-key type. The main disadvantage of encrypted keys is that if they are not
>>> +rooted in a trusted key, they are only as secure as the user key encrypting
>>> +them. The master user key should therefore be loaded in as secure a way as
>>> +possible, preferably early in boot.
>>>
>>>
>>>    Usage
>>> @@ -199,6 +200,8 @@ Usage::
>>>
>>>        keyctl add encrypted name "new [format] key-type:master-key-name keylen"
>>>            ring
>>> +    keyctl add encrypted name "new [format] key-type:master-key-name keylen
>>> +        decrypted-data" ring
>>>        keyctl add encrypted name "load hex_blob" ring
>>>        keyctl update keyid "update key-type:master-key-name"
>>>
>>> @@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
>>>        82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0
>>>        24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
>>>
>>> +Instantiate an encrypted key "evm" using user-provided decrypted data::
>>> +
>>> +    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted_data.blob`" @u
>>> +    794890253
>>> +
>>> +    $ keyctl print 794890253
>>> +    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b382d
>>> +    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0247
>>> +    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
>>> +
>>>    Other uses for trusted and encrypted keys, such as for disk and file encryption
>>>    are anticipated.  In particular the new format 'ecryptfs' has been defined
>>>    in order to use encrypted keys to mount an eCryptfs filesystem.  More details
>>> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
>>> index 87432b35d771..baf6fba5e05e 100644
>>> --- a/security/keys/encrypted-keys/encrypted.c
>>> +++ b/security/keys/encrypted-keys/encrypted.c
>>> @@ -159,6 +159,7 @@ static int valid_master_desc(const char *new_desc, const char *orig_desc)
>>>     *
>>>     * datablob format:
>>>     * new [<format>] <master-key name> <decrypted data length>
>>> + * new [<format>] <master-key name> <decrypted data length> <decrypted data>
>>>     * load [<format>] <master-key name> <decrypted data length>
>>>     *     <encrypted iv + data>
>>>     * update <new-master-key name>
>>> @@ -170,7 +171,7 @@ static int valid_master_desc(const char *new_desc, const char *orig_desc)
>>>     */
>>>    static int datablob_parse(char *datablob, const char **format,
>>>                          char **master_desc, char **decrypted_datalen,
>>> -                       char **hex_encoded_iv)
>>> +                       char **hex_encoded_iv, char **decrypted_data)
>>>    {
>>>        substring_t args[MAX_OPT_ARGS];
>>>        int ret = -EINVAL;
>>> @@ -231,6 +232,8 @@ static int datablob_parse(char *datablob, const char **format,
>>>                                "when called from .update method\n", keyword);
>>>                        break;
>>>                }
>>> +             *decrypted_data = strsep(&datablob, " \t");
>>> +
>>>                ret = 0;
>>>                break;
>>>        case Opt_load:
>>> @@ -595,7 +598,8 @@ static int derived_key_decrypt(struct encrypted_key_payload *epayload,
>>>    static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>>                                                         const char *format,
>>>                                                         const char *master_desc,
>>> -                                                      const char *datalen)
>>> +                                                      const char *datalen,
>>> +                                                      const char *decrypted_data)
>>>    {
>>>        struct encrypted_key_payload *epayload = NULL;
>>>        unsigned short datablob_len;
>>> @@ -604,6 +608,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>>        unsigned int encrypted_datalen;
>>>        unsigned int format_len;
>>>        long dlen;
>>> +     int i;
>>>        int ret;
>>>
>>>        ret = kstrtol(datalen, 10, &dlen);
>>> @@ -613,6 +618,20 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>>        format_len = (!format) ? strlen(key_format_default) : strlen(format);
>>>        decrypted_datalen = dlen;
>>>        payload_datalen = decrypted_datalen;
>>> +
>>> +     if (decrypted_data) {
>>> +             if (strlen(decrypted_data) != decrypted_datalen) {
>>> +                     pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
>>> +                     return ERR_PTR(-EINVAL);
>>> +             }
>>> +             for (i = 0; i < strlen(decrypted_data); i++) {
>>> +                     if (!isalnum(decrypted_data[i])) {
>> User-provided decrypted data may have special characters, commonly used
>> in passwords or key phrases, apart from alphanumeric.  Replace isalnum
>> with !iscntrl() to validate against control characters but allow special
>> characters.
>>
>> Thanks & Regards,
>>
>>        - Nayna
>>
> Hi Nayna,
> I wonder if we should use isprint() instead?

I have been thinking more about this. Encrypted keys documentation says, 
"All user level blobs, are displayed and loaded in hex ascii for 
convenience."

Should we use a similar hex ascii encoding for user-provided data?  
Verification would then be isxdigit().

Users should convert their input to hex ascii before passing it to keyctl.

Thanks & Regards,

      - Nayna

