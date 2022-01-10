Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA0489D0A
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jan 2022 17:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiAJQEY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 11:04:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42896 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236654AbiAJQEX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 11:04:23 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AEU3qh027158;
        Mon, 10 Jan 2022 16:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XompZQzLtbkmqUW9fdSlx7i0OnbVCLoGBZmZzeSsJ7U=;
 b=FAlkU51Z5OTfIlTgm+ydTYh2fRFYr2XEKMOGs8OBUHNzeNNVHRMYg2If66+2s1suCLyV
 wkULHBz5skm9EV7fe/O0fU9RhlrfyajNA9fWn56tNqMqPfwO1VslNqbb4c2VE8CP/fk8
 O+lEb3aXfgOEu6/L6O5rTVMoYn9gp/SjkPFT8gzco2t7dGc7Ll4EbujVY0l4xktfuDh5
 IuxuEYBzOB7gJ/MdjS/ysm3NRfc1iF8CS+hUulFlXKxfc2g4Wf2pJIF0vaJq7liPtjLK
 1KY8f0u39+IV+NXu1YdI0BQGcgCSGPtUsA5JBpmTH0f6y/WOEzc+ZVRNZdsK9DMgKdFP Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfmje67fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:04:15 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20AEgAX6040822;
        Mon, 10 Jan 2022 16:04:15 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfmje67e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:04:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20AFvc6K021202;
        Mon, 10 Jan 2022 16:04:13 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 3df289r2ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:04:13 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20AG4Ccm35520958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 16:04:12 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E262124053;
        Mon, 10 Jan 2022 16:04:12 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D243212405A;
        Mon, 10 Jan 2022 16:04:08 +0000 (GMT)
Received: from [9.211.85.241] (unknown [9.211.85.241])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 16:04:08 +0000 (GMT)
Message-ID: <e29dc7de-b656-7c27-2294-fb4936e99e69@linux.vnet.ibm.com>
Date:   Mon, 10 Jan 2022 11:04:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
Content-Language: en-US
To:     Yael Tiomkin <yaelt@google.com>, linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        corbet@lwn.net, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20211229215330.4134835-1-yaelt@google.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20211229215330.4134835-1-yaelt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rvYTunM6SwFx0tMPkf96ME1jB3uonZAg
X-Proofpoint-ORIG-GUID: nVUIIj41yyDo438Gf_bBG2i6eYwNwFzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_06,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201100113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/29/21 16:53, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. This patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data> that allows to instantiate encrypted keys using
> user-provided decrypted data, and therefore allows to perform key
> encryption from userspace. The decrypted key material will be
> inaccessible from userspace.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yael Tiomkin <yaelt@google.com>
> ---
>
> Notes:
>      v -> v2: fixed compilation error.
>      
>      v2 -> v3: modified documentation.
>      
>      v3 -> v4: modified commit message.
>
>   .../security/keys/trusted-encrypted.rst       | 25 ++++++--
>   security/keys/encrypted-keys/encrypted.c      | 62 +++++++++++++------
>   2 files changed, 63 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 80d5a5af62a1..f614dad7de12 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -107,12 +107,13 @@ Encrypted Keys
>   --------------
>   
>   Encrypted keys do not depend on a trust source, and are faster, as they use AES
> -for encryption/decryption. New keys are created from kernel-generated random
> -numbers, and are encrypted/decrypted using a specified ‘master’ key. The
> -‘master’ key can either be a trusted-key or user-key type. The main disadvantage
> -of encrypted keys is that if they are not rooted in a trusted key, they are only
> -as secure as the user key encrypting them. The master user key should therefore
> -be loaded in as secure a way as possible, preferably early in boot.
> +for encryption/decryption. New keys are created either from kernel-generated
> +random numbers or user-provided decrypted data, and are encrypted/decrypted
> +using a specified ‘master’ key. The ‘master’ key can either be a trusted-key or
> +user-key type. The main disadvantage of encrypted keys is that if they are not
> +rooted in a trusted key, they are only as secure as the user key encrypting
> +them. The master user key should therefore be loaded in as secure a way as
> +possible, preferably early in boot.
>   
>   
>   Usage
> @@ -199,6 +200,8 @@ Usage::
>   
>       keyctl add encrypted name "new [format] key-type:master-key-name keylen"
>           ring
> +    keyctl add encrypted name "new [format] key-type:master-key-name keylen
> +        decrypted-data" ring
>       keyctl add encrypted name "load hex_blob" ring
>       keyctl update keyid "update key-type:master-key-name"
>   
> @@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
>       82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0
>       24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
>   
> +Instantiate an encrypted key "evm" using user-provided decrypted data::
> +
> +    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted_data.blob`" @u
> +    794890253
> +
> +    $ keyctl print 794890253
> +    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b382d
> +    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0247
> +    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
> +
>   Other uses for trusted and encrypted keys, such as for disk and file encryption
>   are anticipated.  In particular the new format 'ecryptfs' has been defined
>   in order to use encrypted keys to mount an eCryptfs filesystem.  More details
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 87432b35d771..baf6fba5e05e 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -159,6 +159,7 @@ static int valid_master_desc(const char *new_desc, const char *orig_desc)
>    *
>    * datablob format:
>    * new [<format>] <master-key name> <decrypted data length>
> + * new [<format>] <master-key name> <decrypted data length> <decrypted data>
>    * load [<format>] <master-key name> <decrypted data length>
>    *     <encrypted iv + data>
>    * update <new-master-key name>
> @@ -170,7 +171,7 @@ static int valid_master_desc(const char *new_desc, const char *orig_desc)
>    */
>   static int datablob_parse(char *datablob, const char **format,
>   			  char **master_desc, char **decrypted_datalen,
> -			  char **hex_encoded_iv)
> +			  char **hex_encoded_iv, char **decrypted_data)
>   {
>   	substring_t args[MAX_OPT_ARGS];
>   	int ret = -EINVAL;
> @@ -231,6 +232,8 @@ static int datablob_parse(char *datablob, const char **format,
>   				"when called from .update method\n", keyword);
>   			break;
>   		}
> +		*decrypted_data = strsep(&datablob, " \t");
> +
>   		ret = 0;
>   		break;
>   	case Opt_load:
> @@ -595,7 +598,8 @@ static int derived_key_decrypt(struct encrypted_key_payload *epayload,
>   static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>   							 const char *format,
>   							 const char *master_desc,
> -							 const char *datalen)
> +							 const char *datalen,
> +							 const char *decrypted_data)
>   {
>   	struct encrypted_key_payload *epayload = NULL;
>   	unsigned short datablob_len;
> @@ -604,6 +608,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>   	unsigned int encrypted_datalen;
>   	unsigned int format_len;
>   	long dlen;
> +	int i;
>   	int ret;
>   
>   	ret = kstrtol(datalen, 10, &dlen);
> @@ -613,6 +618,20 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>   	format_len = (!format) ? strlen(key_format_default) : strlen(format);
>   	decrypted_datalen = dlen;
>   	payload_datalen = decrypted_datalen;
> +
> +	if (decrypted_data) {
> +		if (strlen(decrypted_data) != decrypted_datalen) {
> +			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		for (i = 0; i < strlen(decrypted_data); i++) {
> +			if (!isalnum(decrypted_data[i])) {

User-provided decrypted data may have special characters, commonly used 
in passwords or key phrases, apart from alphanumeric.  Replace isalnum 
with !iscntrl() to validate against control characters but allow special 
characters.

Thanks & Regards,

      - Nayna

