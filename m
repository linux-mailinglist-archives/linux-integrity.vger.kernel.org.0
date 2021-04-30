Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1D36FF5E
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 19:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhD3RTy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 13:19:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229990AbhD3RTy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 13:19:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UH5N7I027222;
        Fri, 30 Apr 2021 13:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5j/mvV1bJ1cYXNMW7jMr8ks0FtMhf1AR1gkD/DM9b2s=;
 b=I0xk8h7mnfJ00Uj500S/Cp8bpHp5v27fpxJKc23JG24uxTI/Kpvz+B4lFUsJ6e6C7xdq
 01isZttsh/PYSkTfv09YFZp6R3BF1Z+jmYzEwqbcYRqMEYZ3QGqR8dA+sowcH+5EuqoJ
 sUTB9FhSWDYwYtiTtnWaRJhTlczSIuTVRyc6ZysR3zdd2uByDXxEbR3P+vXGV+yVQMBx
 hL5qnFHpFKkgzaNrB2LdKj8enLNwFXsUyHsEDyLd36+2gs/FKD4Y0i6bDtri+GkjppTl
 aOsUF3xUzxiVmDIvEtSklka5aVACotzRgUAO97eLRPoMIF0doCc5ldOIqXhoJ+afRquY UA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 388n0gaan6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 13:19:03 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13UH3rrI007989;
        Fri, 30 Apr 2021 17:19:03 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3882p7pq22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 17:19:02 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13UHJ2sa29622636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 17:19:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 639C5B2064;
        Fri, 30 Apr 2021 17:19:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56015B205F;
        Fri, 30 Apr 2021 17:19:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 30 Apr 2021 17:19:02 +0000 (GMT)
Subject: Re: calc_keyid_v2 producing different keyid for non-sha1 SKIDs
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20210426193723.rfar32ft3iptorii@altlinux.org>
 <738bff9b-5cde-4f06-3e54-4d6eebcf9383@linux.ibm.com>
 <20210426220148.nqncx5734dfj5qyx@altlinux.org>
 <20210426221433.mqrtmkpw6fletgmh@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d563ee36-8aad-0497-dc12-f4b06f7f0f6f@linux.ibm.com>
Date:   Fri, 30 Apr 2021 13:19:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210426221433.mqrtmkpw6fletgmh@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kHfaZydCoYgloK2PqbV24HnzMH35lVrR
X-Proofpoint-ORIG-GUID: kHfaZydCoYgloK2PqbV24HnzMH35lVrR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_10:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/26/21 6:14 PM, Vitaly Chikunov wrote:
> On Tue, Apr 27, 2021 at 01:01:48AM +0300, Vitaly Chikunov wrote:
>> Stefan,
>>
>> https://tools.ietf.org/html/rfc7093
>>
>> On Mon, Apr 26, 2021 at 04:21:26PM -0400, Stefan Berger wrote:
>>> On 4/26/21 3:37 PM, Vitaly Chikunov wrote:
>>>> Hi,
>>>>
>>>> I am reported that IMA signatures where SKID is not just sha1 of the
>>>> public key (but something different, for example different hash algo,
>>>> such as Streebog) have "wrong" keyid in the signature. This is because
>>>> a) kernel extracting keyid from the cert's subjectKeyIdentifier (SKID)
>>>> x509 extension, (or if this fails it takes just serial, perhaps, we can
>>>> disregard this corner case), it never does sha1 over the public key).
>>>
>>> Is it wrong for ecrdsa keys? What is the spec?
>> It seems, some CA provide by default certs with Streebog-256 hash as
>> drop-in replacement for SHA1, so their users forced to (re-)request the
>> certs with a compatible SHA1 SKID.
>>
>>> Here's the spec that describes using sha1 for the skid which seems to work
>>> like this for RSA and ECDSA keys from what I can tell:
>>>
>>> https://tools.ietf.org/html/rfc3280#section-4.2.1.2
>> Perhaps, you meant https://tools.ietf.org/html/rfc5280#section-4.2.1.2
>>
>>    "Other methods of generating unique numbers are also acceptable."
>>
>> Also, see https://tools.ietf.org/html/rfc7093
> And, I think all v2 signatures potentially affected.

I have been using evmctl successfully with RSA and ECDSA keys now and 
certificates created by **OpenSSL**. Problems may occur if the 
certificate-generating tool uses something else than a sha1 to calculate 
the subject key identifier (skid) and therefore the key id calculated by 
evmctl (with a sha1) does not match. For the non-working case one could 
pass in a keyidv2 that the user would have to determine from the 
certificate's subject key identifier's last 4 bytes.

It would be interesting to know which tools do not use a sha1 to 
calculate the subject key identifier or what types of keys those are so 
that one could give recommendations for tools to use. GnuTLS's certtool 
for example does not seem to use the same algorithm to calculate the 
skid, so I would not recommend using it for generating the certs to be 
used in conjunction with evmctl and IMA signatures.

Also, evmctl could for example use a different hash if for example tools 
creating certs for ecrdsa keys most often use a streebog hash. This 
would make it easier for the user not having to determine the keyid.

>
>>>> But, b) evmctl, when signing, uses just private key (not even knowing
>>>> certificate where SKID should be) and calculating sha1 of public key.
>>>> Thus, keyids could mismatch each other, and it's even not easy to fix
>>>> evmctl, because there is no cert at the time of signing.
>>>>
>>>> Perhaps, we should fix this somehow. For example, when signing,
>>>> introduce new option --cert, where SKID should be extracted. Does it
>>>> looks reasonable?
> Additionally, we could add `--keyid' option, so users could manually set
> keyid without extracting it from the cert file.


Agreed.

 šš Stefan

