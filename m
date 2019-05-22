Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61426A4D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfEVS5h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 14:57:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728734AbfEVS5h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 14:57:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MIuqLB142834
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 14:57:35 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2snbb8a1n3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 14:57:35 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Wed, 22 May 2019 19:57:34 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 19:57:31 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MIvUDL38338724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 18:57:30 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D5DB6A054;
        Wed, 22 May 2019 18:57:30 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC0596A04F;
        Wed, 22 May 2019 18:57:29 +0000 (GMT)
Received: from [9.2.202.76] (unknown [9.2.202.76])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 May 2019 18:57:29 +0000 (GMT)
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of IMA
 Signature signer in IMA log
To:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        jorhand@linux.microsoft.com
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
 <750fdb9f-fc9b-24bf-42c3-32156ecdc16f@linux.ibm.com>
 <9c944ba6-f520-96e1-3631-1e21bbc4c327@linux.microsoft.com>
 <0b5ae493-6564-40e9-343b-e6781c229a25@linux.ibm.com>
 <54663a75-a601-ae6c-8068-bc2c3923a948@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Wed, 22 May 2019 14:57:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <54663a75-a601-ae6c-8068-bc2c3923a948@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052218-0020-0000-0000-00000EEECF45
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011144; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01207093; UDB=6.00633905; IPR=6.00988068;
 MB=3.00027007; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-22 18:57:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052218-0021-0000-0000-000065ED7215
Message-Id: <b1a2edc1-45c7-7a9f-7a77-e252b2f85a64@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220132
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/20/2019 7:15 PM, Lakshmi wrote:
> On 5/17/19 7:41 AM, Ken Goldman wrote:
> 
> Hi Ken,
> 
> Apologize for the delay in responding.
> 
>> Since a platform typically uses only a few signing keys, 4 bytes makes 
>> the chance of a collision quite small.  The collision would have to be 
>> within the same log, not global.
>>
>> In that worst case, the verifier would have to try two keys.  It's a
>> slight performance penalty, but does anything break?
> 
> Problem Statement:
> - If the attestation service has to re-validate the signature reported 
> in the IMA log, the service has to maintain the hash\signature of all 
> the binaries deployed on all the client nodes. This approach will not 
> scale for large cloud deployments.

1 - How is your solution - including a public key with each event - 
related to this issue?

2 - I don't understand how a large cloud affects scale.  Wouldn't the 
verifier would typically be checking known machines - those of their 
enterprise - not every machine on the cloud?

Can't we assume a typical attestation use case has a fairly locked down 
OS with a limited number of applications.

> - Possibility of collision of "Key Ids" is non-zero
> - In the service if the "Key Id" alone is used to verify using a map of
> "Key Id" to "Signing Key(s)", the service cannot determine if the 
> trusted signing key was indeed used by the client for signature 
> validation (Due to "Key Id" collision issue or malicious signature).

Like I said, it should be rare.  In the worst case, can't the service 
tell by trying both keys?

> 
> Proposed Solution:
> - The service receives known\trusted signing key(s) from a trusted 
> source (that is different from the client machines)
> - The clients measure the keys in key rings such as IMA, Platform, 
> BuiltIn Trusted, etc. as early as possible in the boot sequence.
> - Leave all IMA measurements the same - i.e., we don't log public keys 
> in the IMA log for each file, but just use what is currently available 
> in IMA.

I thought your solution was to change the IMA measurements, adding the 
public key to each entry with a new template?  Did I misunderstand, or 
do you have a new proposal?

> 
> Impact:
> - The service can verify that the keyrings have only known\trusted keys.

If the service already has trusted keys from a trusted source, why do 
they have to come from the client at all?

> - The service can cross check the "key id" with the key rings measured.
> - The look up of keys using the key id would be simpler and faster on 
> the service side.
> - It can also handle collision of Key Ids.

How does this solve the collision issue?  If there are two keys with the 
same key ID, isn't there still a collision?

> 
> Note that the following is a key assumption:
> 
> - Only keys signed by a key in the "BuiltIn Trusted Keyring" can be 
> added to IMA\Platform keyrings.

I understand how the client keyring is used in IMA to check file
signatures, but how is that related to the attestation service?

> 
> 
> Thanks,
>   -lakshmi
> 

