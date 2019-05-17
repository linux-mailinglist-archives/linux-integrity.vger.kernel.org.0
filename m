Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC03219E5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfEQOmE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 10:42:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728383AbfEQOmE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 10:42:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HEXnDk046730;
        Fri, 17 May 2019 10:41:59 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2shwdqcmfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 10:41:59 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4H8jQA6019723;
        Fri, 17 May 2019 08:46:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2sdp158ktp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 08:46:25 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HEfuOb5636416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 14:41:56 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7021678064;
        Fri, 17 May 2019 14:41:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB16478060;
        Fri, 17 May 2019 14:41:55 +0000 (GMT)
Received: from [9.2.202.76] (unknown [9.2.202.76])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 14:41:55 +0000 (GMT)
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of IMA
 Signature signer in IMA log
To:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
 <750fdb9f-fc9b-24bf-42c3-32156ecdc16f@linux.ibm.com>
 <9c944ba6-f520-96e1-3631-1e21bbc4c327@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <0b5ae493-6564-40e9-343b-e6781c229a25@linux.ibm.com>
Date:   Fri, 17 May 2019 10:41:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9c944ba6-f520-96e1-3631-1e21bbc4c327@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/16/2019 9:29 PM, Lakshmi wrote:
> On 5/16/19 7:34 AM, Ken Goldman wrote:
> 
>>> But outside the client machine this key id is not sufficient to
>>> uniquely determine which key the signature corresponds to.
>>
>> Why is this not sufficient?
>>
>> In my implementation, I create a lookup table at the attestation 
>> service that maps the 4-byte IMA log key identifier to the signing 
>> public key.
>>
>> Are you concerned about collisions?  Something else?
> 
> Yes - the concern is collision.
> 
> The "Subject Key Identifier" (SKI) for no two certificate can be the 
> same. But since we are using only the last 4 bytes of the SKI it can 
> collide. That's mainly the reason I want to log the entire public key.
> 

Since a platform typically uses only a few signing keys, 4 bytes makes 
the chance of a collision quite small.  The collision would have to be 
within the same log, not global.

In that worst case, the verifier would have to try two keys.  It's a
slight performance penalty, but does anything break?

A new template with a larger SKI, perhaps 8 bytes, might be safer.  It 
doesn't expand the log size nearly as much as having a full public key.

>> Are you suggesting that the client supply the verification public key 
>> and that the verifier trust it?  Wouldn't that make the log self signed?
>>
>> How would the verifier determine that the key from the IMA log is 
>> valid / trusted / not revoked from the log itself?
> 
> IMA log is backed by the TPM. So if the public key is added to the IMA 
> log the attestation service can validate the key information.
> I am not sure if that answers your question.

The TPM just ensures that the log has not been altered.  It does nothing 
for signature verification, right?

The verifier can check that the supplied signature matches the supplied 
public key.  However, how could it verify that the public key is trusted 
to sign the code?  Doesn't that have to be out of band?

E.g., an attacker could create a log with their own signatures and 
public keys.  The signature would verify, but it's the attacker's key.

It's essentially a self-signed file.

>> A minor question here.
>>
>> Are you proposing that the IMA log contain a single ima-sigkey entry 
>> per public key followed by ima-sig entries?
>>
>> Or are you proposing that ima-sig be replaced by ima-sigkey, and that 
>> each event would contain both the signature and the public key?
>>
>> If the latter, this could add 25M to a server's 100K log.  Would that 
>> increase in size concern anyone?  Could it be a concern on the other 
>> end, an IoT device with limited memory?
> 
> Mimi had raised the same concern. I will update my implementation to 
> include the certification information in the IMA log only once per key - 
> when that key is added to the IMA or Platform keyring.

If you include the public key only once, don't you have the same 
collision problem?  Two log entries could (in theory) and the same SKI. 
How would the verifier know which public key to use.

However, I think the fundamental question is whether the verifier can 
accept public keys supplied by the untrusted client.  I believe that the 
verifier has to receive the public keys out of band, from a trusted 
source - not the client.


