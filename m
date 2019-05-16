Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976ED209D5
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2019 16:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfEPOeV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 May 2019 10:34:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbfEPOeV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 May 2019 10:34:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GEXeJI004460
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 10:34:20 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sh8hrup12-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 10:34:19 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Thu, 16 May 2019 15:34:18 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 15:34:13 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GEYC0s26673236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 14:34:12 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC94A112065;
        Thu, 16 May 2019 14:34:11 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90AD8112072;
        Thu, 16 May 2019 14:34:11 +0000 (GMT)
Received: from [9.2.202.76] (unknown [9.2.202.76])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 May 2019 14:34:11 +0000 (GMT)
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
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Thu, 16 May 2019 10:34:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051614-0060-0000-0000-00000341228C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011105; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01204175; UDB=6.00632130; IPR=6.00985105;
 MB=3.00026918; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-16 14:34:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051614-0061-0000-0000-0000495F0973
Message-Id: <750fdb9f-fc9b-24bf-42c3-32156ecdc16f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160094
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/14/2019 1:14 PM, Lakshmi wrote:
> The motive behind this patch series is to measure the public key
> of the IMA signature signer in the IMA log.

I have some questions about the rationale for the design ...

> > The IMA signature of the file, logged using ima-sig template, contains
> the key identifier of the key that was used to generate the signature.
> But outside the client machine this key id is not sufficient to
> uniquely determine which key the signature corresponds to.

Why is this not sufficient?

In my implementation, I create a lookup table at the attestation service 
that maps the 4-byte IMA log key identifier to the signing public key.

Are you concerned about collisions?  Something else?

> Providing the public key of the signer in the IMA log would
> allow, for example, an attestation service to securely verify
> if the key used to generate the IMA signature is a valid and
> trusted one, and that the key has not been revoked or expired.

Are you suggesting that the client supply the verification public key 
and that the verifier trust it?  Wouldn't that make the log self signed?

How would the verifier determine that the key from the IMA log is valid 
/ trusted / not revoked from the log itself?

> An attestation service would just need to maintain a list of
> valid public keys and using the data from the IMA log can attest
> the system files loaded on the client machine.

If the verifier has the list of valid keys, why must they also come with 
the IMA log?

> 
> To achieve the above the patch series does the following:
>    - Adds a new method in asymmetric_key_subtype to query
>      the public key of the given key
>    - Adds a new IMA template namely "ima-sigkey" to store\read
>      the public key of the IMA signature signer. This template
>      extends the existing template "ima-sig"

A minor question here.

Are you proposing that the IMA log contain a single ima-sigkey entry per 
public key followed by ima-sig entries?

Or are you proposing that ima-sig be replaced by ima-sigkey, and that 
each event would contain both the signature and the public key?

If the latter, this could add 25M to a server's 100K log.  Would that 
increase in size concern anyone?  Could it be a concern on the other 
end, an IoT device with limited memory?

