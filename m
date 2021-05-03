Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB33716D7
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 16:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhECOpL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 10:45:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229693AbhECOpK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 10:45:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143Ei4ir067043;
        Mon, 3 May 2021 10:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KlKPUeUH+/aMT9cqHS59VEYY0Z/fktvkHA63y8zs8pc=;
 b=R8Tr3sCNDgtGUS8StdMoebmWyI4ml7Y1xVgfwAGeT6JcUibRfADPrjtZpvbCQMRqraXn
 HrZ3ozNlVEPmXOgYUvcKh2OvXKTANIkZbRmYMjyXgukknyCFQbXBIufd4Y26mZfhDn7w
 Mmb67REEtHB8cmjo1/qcGGjh3fg6MgPQNl25s3JIshz1gcC6oQBJmdoyDXAWgMQXnqVI
 izw2tRzo5k/OkWBmJyUE9Bv5CMJGu0G8YLBr/tSOs57z7dC8SPfq6QS2iiqMLlB4DpWL
 pjUw3nHNY11YGJ+9wXAg3DY9dfwvUmaRQnkQu6I4bC8IoKA70/HzUgmTSw5UkSrxFWGK wA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ak6q803q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 10:44:14 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143EhVEE017560;
        Mon, 3 May 2021 14:44:13 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 388xm8pq3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 14:44:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143EiDTB20250964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 14:44:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ECD2B205F;
        Mon,  3 May 2021 14:44:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31105B2065;
        Mon,  3 May 2021 14:44:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 14:44:13 +0000 (GMT)
Subject: Re: calc_keyid_v2 producing different keyid for non-sha1 SKIDs
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20210426193723.rfar32ft3iptorii@altlinux.org>
 <738bff9b-5cde-4f06-3e54-4d6eebcf9383@linux.ibm.com>
 <20210426220148.nqncx5734dfj5qyx@altlinux.org>
 <20210426221433.mqrtmkpw6fletgmh@altlinux.org>
 <d563ee36-8aad-0497-dc12-f4b06f7f0f6f@linux.ibm.com>
 <20210430183308.mfdffqq2osbrqm5e@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <c34ae010-6287-24c9-da5b-46cce2c41fe7@linux.ibm.com>
Date:   Mon, 3 May 2021 10:44:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430183308.mfdffqq2osbrqm5e@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hm5PKvnHuFezQxrODLbccL9pFC2Ig4Wi
X-Proofpoint-GUID: hm5PKvnHuFezQxrODLbccL9pFC2Ig4Wi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105030101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/30/21 2:33 PM, Vitaly Chikunov wrote:
> Stefan,
> .
>> I have been using evmctl successfully with RSA and ECDSA keys now and
>> certificates created by **OpenSSL**. Problems may occur if the
>> certificate-generating tool uses something else than a sha1 to calculate the
>> subject key identifier (skid) and therefore the key id calculated by evmctl
>> (with a sha1) does not match. For the non-working case one could pass in a
>> keyidv2 that the user would have to determine from the certificate's subject
>> key identifier's last 4 bytes.
>>
>> It would be interesting to know which tools do not use a sha1 to calculate
>> the subject key identifier or what types of keys those are so that one could
>> give recommendations for tools to use. GnuTLS's certtool for example does
>> not seem to use the same algorithm to calculate the skid, so I would not
>> recommend using it for generating the certs to be used in conjunction with
>> evmctl and IMA signatures.
> You can also reproduce non-sha1 skid with openssl using subjectKeyIdentifier=
> config option, see x509v3_config(5).

"Subject Key Identifier.

This is really a string extension and can take two possible values. 
Either the word hash which will automatically follow the guidelines in 
RFC3280 or a hex string giving the extension value to include. The use 
of the hex string is strongly discouraged.

Example:

subjectKeyIdentifier=hash"

 From what I know it offers also the possibility of 'none'. It doesn't 
seem to be all that bad when using OpenSSL.

 šš Stefan


