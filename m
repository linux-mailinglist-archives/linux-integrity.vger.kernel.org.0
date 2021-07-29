Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECD3DA47A
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhG2NkK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 09:40:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237641AbhG2NkK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 09:40:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TDd3w0096040;
        Thu, 29 Jul 2021 09:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GsgaupwAABcdAtoh97UGD0HsZlUsJJoMziZ1dnOIJ9s=;
 b=QWk6YrU0viQTS3vCPgo49s7Jtwqfq+3TbxH9se8EdXEPdGNSGylEbs1u8/e50KYcDium
 R8vl6nqs7u1ZCLJCUjabkvDMJUBl9a/1DX1BHpgrZ30DtxXKgWorp1L2RD9KySM8BFef
 cPj27tS2MY0W1JURWaypGRpG0981pmlwSEfe6fu6bo5GSWX9INtpubPsGVLT9DGFibJ+
 v8ThNdssp9KcWvML9zEmWlkiUX0tHjyiDBdI+0zbfqWAmpICsD9KFeTBys03MnLnQKFP
 fhRpSwyFi7RmgvDC6Yn5PgVA+7G/oLGP1Ce/01WkcjFhpHJxmW9bYFQkAbHnSgIt5/0D Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3vp9sb25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 09:40:03 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TDdF9Q096937;
        Thu, 29 Jul 2021 09:39:42 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3vp9s9g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 09:39:40 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TDZFGB012109;
        Thu, 29 Jul 2021 13:39:21 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3a3w9g00tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 13:39:21 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TDdKPA47317264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 13:39:20 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0BB97809C;
        Thu, 29 Jul 2021 13:39:19 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68E907809E;
        Thu, 29 Jul 2021 13:39:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jul 2021 13:39:19 +0000 (GMT)
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
References: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
 <20210727024225.swqy5ypcytsngpd6@kernel.org>
 <ad4011fb-fc1f-4019-9856-7d171db3255c@linux.ibm.com>
 <20210728215033.dhnekvksekalhcrn@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <2add3eac-916e-5072-f62d-23c65e23fb17@linux.ibm.com>
Date:   Thu, 29 Jul 2021 09:39:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728215033.dhnekvksekalhcrn@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ghnNcxYyXnbzGRmOD8bHyCh1pB8OZ3Hf
X-Proofpoint-GUID: GecJ6_p029p9eqr1BbXj-3oZFijWj_vU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/28/21 5:50 PM, Jarkko Sakkinen wrote:
> On Mon, Jul 26, 2021 at 11:00:51PM -0400, Stefan Berger wrote:
>> On 7/26/21 10:42 PM, Jarkko Sakkinen wrote:
>>> On Mon, Jul 12, 2021 at 12:25:05PM -0400, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> When rngd is run as root then lots of these types of message will appear
>>>> in the kernel log if the TPM has been configure to provide random bytes:
>>>>
>>>> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
>>>>
>>>> The issue is caused by the following call that is interrupted while
>>>> waiting for the TPM's response.
>>>>
>>>> sig = wait_event_interruptible(ibmvtpm->wq,
>>>>                                  !ibmvtpm->tpm_processing_cmd);
>>>>
>>>> The solution is to use wait_event() instead.
>>> Why?
>> So it becomes uninterruptible and these error messages go away.
> We do not want to make a process uninterruptible. That would prevent
> killing it.

I guess we'll have to go back to this one then: 
https://www.spinics.net/lists/linux-integrity/msg16741.html

    Stefan


>
> /Jarkko
