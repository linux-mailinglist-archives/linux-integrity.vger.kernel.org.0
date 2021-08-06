Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034603E2A5B
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbhHFMJr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 08:09:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243761AbhHFMJr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 08:09:47 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176C3JsU040130;
        Fri, 6 Aug 2021 08:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gp7o6nsUz02cEmUbe1aDvwX7ROQjyHwgHhxzlCBJ8iw=;
 b=ng1OBnph6HoyGSZT22pXtF+vHuITdsWlju0jNsFEsyTBjT25DBULjHIdKaFV40oPsY+a
 ogFS8NfbWdJq0k9J6y7t7sIoaoWxuMSheQO87Cdlnd7bsez//YyA4zFGwq8L49DOs7rf
 gX1c0wl9nHV5NxlkFZKHuJvbWIp1VXglzsf1odLoG5gaKTAq/uWLjmbB7oWfSNp1xkL8
 gqa/UQ5OIardZk5kh7JVRU4zCOmbG+Vu7rGJwjAgEQrx412P8dlRaEgAPKbBILpylziT
 QMCt/rwuFXs2wZQ1kicc+kX6CloMvn5IP7PrBNuFlLbDUaheEvAHkzgeIgIe+me+CoBm Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a9356u1ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 08:09:30 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 176C3cUK042272;
        Fri, 6 Aug 2021 08:09:30 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a9356u1j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 08:09:30 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 176C7HHm019801;
        Fri, 6 Aug 2021 12:09:29 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 3a8gwu6cwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 12:09:28 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 176C8SOX34210146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 12:08:28 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A71124058;
        Fri,  6 Aug 2021 12:08:28 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C70F012405A;
        Fri,  6 Aug 2021 12:08:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Aug 2021 12:08:27 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] tpm: ibmvtpm: Rename tpm_process_cmd to tpm_status
 and define flag
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
 <20210805215256.1293987-2-stefanb@linux.vnet.ibm.com>
 <20210806112557.y7q2av6pk7r4xorm@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <cddf0b42-c69f-c110-9543-e16d30c9927a@linux.ibm.com>
Date:   Fri, 6 Aug 2021 08:08:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806112557.y7q2av6pk7r4xorm@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: npSS4fNHEm-p9shLGVI87GjUlCCjE5o8
X-Proofpoint-GUID: UhUePdO4yOSxS7z4ffmMHClSqeZDp5IZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_04:2021-08-05,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108060085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/6/21 7:25 AM, Jarkko Sakkinen wrote:
> On Thu, Aug 05, 2021 at 05:52:55PM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
>> the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
>>
>> Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: Nayna Jain <nayna@linux.ibm.com>
>> Cc: George Wilson <gcwilson@linux.ibm.com>
> Please put the bug fix first because otherwise it will be dependent of this
> patch, which is bad thing when it comes to backporting.

Yes, and that's why I have this one here also with a Fix tag. I 
basically don't want to logically '&' with the 'true' flag but want this 
TPM_STATUS_BUSY flag first.

    Stefan

>
> /Jarkko
