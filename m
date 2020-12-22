Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C62E0AF2
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 14:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgLVNjE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 08:39:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16777 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726868AbgLVNjE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 08:39:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMDVBIY156317;
        Tue, 22 Dec 2020 08:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D6vtW50GF09SkKvl5eAQ7a5bT1OSo29IRm07x6CtvX0=;
 b=P3Vwben1I9HMFJWfYkCFSAHb6YMhe5HCxsaOZiqdxVj0zjD1jTMJ8czRV/dE9KXADdeD
 wRzlIIW4UvFFkUlRPrNEQP8XamzrdjEiGlDfYk6vejU+4CgxCjhdl8DX/SrW3V456ljk
 335ckIPRlZDpefU9KUWBfhFfSOKxW04Wm7Bosx5B439WEGTrtMEYy7uqQaLRIGX9nwf8
 dSHLPw95xV5867L9+PVnkhKF5dN4l07STv8JUr4v6A43UQTsXM/jWBWT7X3QEhY/Wqp4
 IGeWbxsVp+TpTQsSx0S7Wx9fYNWwn4ssiWXpRdQsGAe4MRG76nbIS/E2fVmxWjr4moJt KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kfh7v5ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 08:36:49 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMDWSfx162001;
        Tue, 22 Dec 2020 08:36:48 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kfh7v5kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 08:36:48 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMDRA4t009728;
        Tue, 22 Dec 2020 13:36:48 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 35kakyb93v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 13:36:48 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMDala727001284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 13:36:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F7F9112063;
        Tue, 22 Dec 2020 13:36:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E902112061;
        Tue, 22 Dec 2020 13:36:47 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 22 Dec 2020 13:36:47 +0000 (GMT)
Subject: Re: [PATCH] tpm: ibmvtpm: fix error return code in
 tpm_ibmvtpm_probe()
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Wang Hai <wanghai38@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, nayna@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201124135244.31932-1-wanghai38@huawei.com>
 <4192b5a07ebd0539dd8244afe9e065b4996f4f4a.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8d764ed2-f1e7-2c03-2b78-a7301cc8b9f4@linux.ibm.com>
Date:   Tue, 22 Dec 2020 08:36:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4192b5a07ebd0539dd8244afe9e065b4996f4f4a.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_06:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/25/20 10:35 PM, Jarkko Sakkinen wrote:
> On Tue, 2020-11-24 at 21:52 +0800, Wang Hai wrote:
>> Fix to return a negative error code from the error handling
>> case instead of 0, as done elsewhere in this function.
>>
>> Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before
>> proceeding")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Provide a reasoning for -ETIMEOUT in the commit message.
>
> /Jarkko


Was this patch ever applied? I don't seem to find the infradead git tree ...


