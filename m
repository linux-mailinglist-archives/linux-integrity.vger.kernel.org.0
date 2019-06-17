Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA94899A
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 19:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFQRE4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 13:04:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbfFQRE4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 13:04:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HH1lS2130596
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 13:04:55 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t6d4yd8c5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 13:04:54 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Mon, 17 Jun 2019 18:04:54 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 18:04:50 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HH4nXY33751368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 17:04:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6D5278069;
        Mon, 17 Jun 2019 17:04:49 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FEC078064;
        Mon, 17 Jun 2019 17:04:48 +0000 (GMT)
Received: from [9.2.202.76] (unknown [9.2.202.76])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 17:04:48 +0000 (GMT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
 <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Mon, 17 Jun 2019 13:04:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061717-8235-0000-0000-00000EA9454F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011279; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01219345; UDB=6.00641360; IPR=6.01000486;
 MB=3.00027346; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-17 17:04:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061717-8236-0000-0000-0000460D2200
Message-Id: <7da97815-a09a-de6f-dbf2-7d2c96a077bb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/7/2019 1:15 PM, Lakshmi wrote:
> On 6/7/19 7:14 AM, Ken Goldman wrote:
> 
>>
>> Why is this important?  What is gained by measuring the keys on the
>> built-in keyring?  The IMA log already measures [a pointer to] the
>> IMA keys used for signature verification.  Why does the service care 
>> what keys were used to install the IMA keys?
> 
> By measuring the built-in keyring, the service knows whether or not the 
> key(s) in "IMA keyring" are indeed trusted or not. So while the IMA key 
> validates the file signatures on the client, the built-in key validates 
> the IMA key(s).

How will it know that?  It will know about the keys in the built-in 
keyring, but how does that say whether an IMA key is trusted?

> 
> By knowing what keys were used to install the IMA key(s) the service 
> knows whether or not to trust the signature validation performed by IMA 
> on the client.

How does that happen?

In order to trust the IMA validation, it has to attest to the code doing 
the validation, and to the IMA keys.

It already knows which IMA keys were used from the IMA log, assuming the 
IMA code is attested.

> The service will receive the entire IMA log - the entries that show what 
> system files were loaded, the IMA signature, etc. My change additionally 
> provides measurement on the signer (which key(s) were used to install 
> the keys in IMA keyring). Together this data enables the service to 
> determine whether the files on the client were signed and who the signer 
> is. The service can then decide whether the client is running files that 
> are trusted.

How does knowing the keys on the built-in keyring tell which files were 
signed?  How does it tell who the signer is?

That information (whether signed and what signed it) comes from the IMA 
log, right?

How would your design help to know whether the files being run are 
trusted?  I think that has to come out-of-band.

E.g., I can know that libfoo.so.1.2.3 is signed and who the signer is, 
but I may not trust anything older than libfoo.2.0.0.


> Like I have stated above, the change I am making is adding more data 
> (information on built-in keys) to what IMA log already provides".

Understood.  I'm trying to learn the usefulness of that data.

> 
> My proposal is not to replace the current IMA log with just data on 
> "built-in keys".
> 
> Also, want to clarify that we do not want the service to also locally 
> verify the signatures. To do that the service needs to maintain the 
> signed file hashes of all the files and all the versions of each of 
> those files - That is an high overhead approach.

Doesn't it needs those hashes anyway, to determine whether the file is 
trusted.  To me "signed with a trusted key" does not equal "trusted".

> The proposal enables the service to validate that the file signature of 
> the files on the client were created by "trusted signer". So it provides 
> additional security benefit and at the same time reduces the maintenance 
> overhead in the service - by enabling it to just keep track of "Known 
> good trusted keys" which change less frequently.

We already know who signed from the IMA keys in the IMA log.

How does knowing who was authorized to install IMA keys help?  The 
attestor still has to know out of band which IMA keys to trust, and 
which files to trust.

