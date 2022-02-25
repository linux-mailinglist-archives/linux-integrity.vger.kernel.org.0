Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC164C4F1E
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Feb 2022 20:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiBYTsS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Feb 2022 14:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiBYTsR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Feb 2022 14:48:17 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B6FB878;
        Fri, 25 Feb 2022 11:47:44 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PJIvuK015939;
        Fri, 25 Feb 2022 19:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mfcZmul1/LgH79DlJzxEF9PI3qWC/ZuzsxPFdmLwu6U=;
 b=nZBH7pOluQNEPc046CHObq+32gFDKYcz4rXtWLJT08umEEAt22IusbkBHW0gW5ZZ3cp4
 sBpO0+sL7h7/ZPqgs9cfyfEI1pFoHng0xOelgxVbUC2xlMQ9aQc5nxAb7uCryDOGbj2D
 u+qOII2J2YLxOyqcHD+LfpaEjqbUF9H8Vh25tdgSWm4nyTEl4NjtYuUyjdRxifUf0gFD
 n36Y+97Sa9dJOvvV4Jxxhf8xzs/cURxVoWkjlV5fgDinY4wzmNJOmaDla5QUxLwh86dQ
 +/5+GLgRVQqXeAJNrbPfllvig05dHSvOfbUTh4zyFW0mJsTV9CgK4EAEYXzLdXVifylq ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef55q0gw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 19:47:34 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PJeqcQ014905;
        Fri, 25 Feb 2022 19:47:33 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef55q0gw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 19:47:33 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PJkmQx027597;
        Fri, 25 Feb 2022 19:47:32 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3edr93dym4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 19:47:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PJlWWQ12255580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 19:47:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FE76B2064;
        Fri, 25 Feb 2022 19:47:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2781B2066;
        Fri, 25 Feb 2022 19:47:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 19:47:31 +0000 (GMT)
Message-ID: <127811ae-ef71-d225-0450-710a6ee6afef@linux.ibm.com>
Date:   Fri, 25 Feb 2022 14:47:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Content-Language: en-US
To:     Vitaly Chikunov <vt@altlinux.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <7c9d973f-847e-e8bc-95fb-6c98a98a02e6@linux.ibm.com>
 <YhLOyUgSihcdoNJc@iki.fi> <20220221024357.uilp5y77zpgktl6c@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220221024357.uilp5y77zpgktl6c@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AeNNSejskGSJXGFAlBn_69sZxegEpKTB
X-Proofpoint-ORIG-GUID: 30dXK0UXwlAgZqLddNnrI61Oe76PpqtL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_10,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/20/22 21:43, Vitaly Chikunov wrote:
> On Mon, Feb 21, 2022 at 12:29:13AM +0100, Jarkko Sakkinen wrote:
>> On Wed, Feb 02, 2022 at 10:15:24PM -0500, Stefan Berger wrote:
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
>>>> ---
>>>>    crypto/asymmetric_keys/public_key.c | 15 +++++++++++++--
>>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
>>>> index 4fefb219bfdc..3ffbab07ed2a 100644
>>>> --- a/crypto/asymmetric_keys/public_key.c
>>>> +++ b/crypto/asymmetric_keys/public_key.c
>>>> @@ -143,8 +143,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
>>>>    	len = crypto_akcipher_maxsize(tfm);
>>>>    	info->key_size = len * 8;
>>>> -	info->max_data_size = len;
>>>> -	info->max_sig_size = len;
>>>> +	if (strcmp(alg_name, "ecrdsa") == 0 ||
>>>> +	    strncmp(alg_name, "ecdsa-", 6) == 0) {
>>>> +		/*
>>>> +		 * For these algos sig size is twice key size.
>>>> +		 * keyctl uses max_sig_size as minimum input size, and
>>>> +		 * max_data_size as minimum output size for a signature.
>>>> +		 */
>>>> +		info->max_data_size = len * 2;
>>>> +		info->max_sig_size = len * 2;
>>> I don't know about the data size but following my tests this is not enough
>>> for ECDSA signature size. In ECDSA case the r and s components of the
>>> signature are encode in asn.1, not 'raw'. So there are 2 bytes at the
>>> beginning for sequence identifier , 2 bytes asn.1 for the r component, 1
>>> additional 0-byte to make the r component always a positive number, then the
>>> r component, then 2 bytes asn.1 for the s component, 1 addition 0-byte to
>>> make the s component a positive number, then the s component. Phew.
>>>
>>> info->max_sig_size = 2 + (2 + 1 + len) * 2;
>>>
>>> so for NIST P384 it's: 2 + (2+1+48) * 2 = 104
>>>
>>> Then it works for me as well.
>> Thank you for the trouble of providing this great explanation. This
>> reasoning should be included to the commit message for future reference.
>>
>> It would be also nice to encapsulate this calculation to an inline
>> function.
> I wanted to discuss if there's a better way to do it. For example,
> instead of calculating algorithm specific information in
> software_key_query maybe we should extend akcipher_alg API with a
> pkey_params request (just for keyctl)?
>
> Also, there possible other solution - instead of setting info in
> software_key_query depending on algo (as in this patch), it's possible
> (in a hackish way) just to return larger value from
> akcipher_alg::max_size. But this will possible somewhat confuse keyctl
> users, as, for example, they will see arbitrary value for a key_size.
>
> Currently, this patch is the simplest non-confusing solution, and it's
> in accord with how we calculate algorithm specific things all around
> the code base (outside of algorithm implementation itself).

I don't know the answer to the other questions, but I agree that your 
patch seem to be the simplest non-confusing solution. Are you going to 
repost it, possibly with my ECDSA modifications added?

    Stefan


>
> Thanks,
>
>> /Jarkko
