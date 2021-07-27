Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3A3D6C3C
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 05:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhG0CU2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:20:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234410AbhG0CU1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:20:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16R2tlY4002435;
        Mon, 26 Jul 2021 23:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oI27GRcxHJWr9lqkg06esei3b3YBwK++/04PQ2lt97c=;
 b=Hoz6mM9+dGgUL36mYXTbRWvllJ7C4lF6DtfLyOqWcTTXXZW1D5iEDPSpp+5Pb+XiV6LH
 G4iHVX7j992KVMaYUFtEgdAiBNWpIMQg5DQHZBCOyjsVuTDSDUqvcGD001uYq/kp34ps
 vOwQ1LKoWvcwvbebO0wsqPfgTmna0yXsl5QpU8aBraiB6dX/FxhUR0PwIu9FDeh4xBM9
 XA2I7dtk9TOKZwse3hB/lmFRq/jk6x29D+OMRm3NjFbsL3PCIKvcOj+LMP/1UnHQDnve
 f8tnirNQS187iE8EQLwDZpotJiEdebtIjzEVre7epapmATju39gPJvlBnyI6KWAbwLNM QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a29sug4t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 23:00:54 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16R2u1dI002764;
        Mon, 26 Jul 2021 23:00:54 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a29sug4sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 23:00:54 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16R2se5M005523;
        Tue, 27 Jul 2021 03:00:53 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 3a235m402m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 03:00:53 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16R30q4A34865508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 03:00:52 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D42B12406E;
        Tue, 27 Jul 2021 03:00:52 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DABCC124064;
        Tue, 27 Jul 2021 03:00:51 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 03:00:51 +0000 (GMT)
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
References: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
 <20210727024225.swqy5ypcytsngpd6@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <ad4011fb-fc1f-4019-9856-7d171db3255c@linux.ibm.com>
Date:   Mon, 26 Jul 2021 23:00:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727024225.swqy5ypcytsngpd6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VJbV6m6T0GeKRpUPKwe0Zecz4zTjEfdT
X-Proofpoint-GUID: PYlAmXy-Ag_0xi3ZfDfGKXecBOUH1eui
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_14:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/26/21 10:42 PM, Jarkko Sakkinen wrote:
> On Mon, Jul 12, 2021 at 12:25:05PM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> When rngd is run as root then lots of these types of message will appear
>> in the kernel log if the TPM has been configure to provide random bytes:
>>
>> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
>>
>> The issue is caused by the following call that is interrupted while
>> waiting for the TPM's response.
>>
>> sig = wait_event_interruptible(ibmvtpm->wq,
>>                                 !ibmvtpm->tpm_processing_cmd);
>>
>> The solution is to use wait_event() instead.
> Why?

So it becomes uninterruptible and these error messages go away.

     Stefan

>
> /Jarkko
