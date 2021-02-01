Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2F130ACE3
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBAQqK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 11:46:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhBAQqH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 11:46:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111Gglek185560;
        Mon, 1 Feb 2021 11:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AcO6AiELQYVzU/NtbPhwlafqcsadvk236o3R/X784Ic=;
 b=Zyi2lmuL8zX1+xhRtZJ6JVIOIDUgsVhZjH9IXP+OxGzwVebqa/Y4mXWMwl1+ywUW4wrP
 OQNT66ew7p9D+tXq4PTM7MlCvF3bd+eNyFPx4q8tnZGFzS1bT9ADYGP3MAnDc6HSFgIR
 HgS+1jrrB13gLRcvXiOzUJiee/tVXFb9K063zNDuQCCwgaVwjJX6JfaxDnBSip2QnuZ5
 T/T4ig5IwpiS276mz0INUVbpt2R9EowPo3ehNU/Rdj2sLR4u5dfbMG0M2If9AV3I4DLn
 IhjeHxyA6uU2ygTZc1XVKI85gfLQiP9tC+MkDBPuDvDK/iYaAjhRdpcqN46IXxUKuRPU 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36enae097p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:45:21 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111Gh8v5187594;
        Mon, 1 Feb 2021 11:45:20 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36enae096k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:45:20 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111GJLc9009785;
        Mon, 1 Feb 2021 16:45:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 36cy38ywrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 16:45:18 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111GjI4x7275104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 16:45:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C214AC068;
        Mon,  1 Feb 2021 16:45:18 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11256AC05B;
        Mon,  1 Feb 2021 16:45:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 16:45:16 +0000 (GMT)
Subject: Re: [PATCH v7 0/4] Add support for x509 certs with NIST p256 and p192
 keys
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        patrick@puiterwijk.org, linux-integrity@vger.kernel.org
References: <7836898a-0a42-5c9b-3a42-7ff4c7a03ea4@linux.ibm.com>
 <20210201151910.1465705-1-stefanb@linux.ibm.com>
 <32177.1612196003@warthog.procyon.org.uk>
 <33903.1612197412@warthog.procyon.org.uk>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <ab3f4f96-6aec-4586-21fa-318fcee997a5@linux.ibm.com>
Date:   Mon, 1 Feb 2021 11:45:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <33903.1612197412@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/1/21 11:36 AM, David Howells wrote:
> Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>> 1) the whole series goes through the crypto tree
>>
>> 2) I make the OIDs addition patch 1 that both keyrings and crypto take
>> separately?
> The first might be easiest, but 2 is okay also.  You'll just need to give
> myself and Herbert separate branches to pull, rooted on the same commit.
>
> Btw, what do patches 2-4 do if patch 1 isn't applied?

With the crypto module missing in the kernel you will get an error 
trying to load an x509 certificate that needs the algorithm to verify 
the self-signed signature.

Before I post yet another series I hope that Herbert can say whether 
option 1) would work for him.

    Stefan


>
>
> David
>

