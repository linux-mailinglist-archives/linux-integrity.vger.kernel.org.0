Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6BC47B6E9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 02:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhLUBhs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Dec 2021 20:37:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231151AbhLUBhr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Dec 2021 20:37:47 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKN0Fum032274;
        Tue, 21 Dec 2021 01:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vAJMULVGi8WaTYbSRYEoDY2Vsw7HqOBaMDSREXIkSG4=;
 b=OKNjO4NIr9xhb4x8tY9IA/xbyMdqpkIUyJtON2n1S/FLphBoLb5TSTFQSpEcAJpZ9BU/
 LHlWvsJX8s0Xvrwc1XlrQMOZqJxhbzqK9yvowk5vumwbPIkCCii6eSbb/TOV/JW/ND8O
 5efsg1PPjtEjuAMWXaUGpj7P2+52dBDjrwWtAsSuCRPEg4o6DjfL6UxpTelojGNLsmpi
 eNMFZTK4DumxnSfBGUcNCPF+QYw59PLjeRV9591SEZmHQfwZekMxLbGSrIrC2ywGR75n
 ACJqoFr5+LAiJ8HUpGlpThTY01JNeRO2Nbw0cc2Jz5ie5rWnHBEMs+2lLMM8LYL11rp2 eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s3y1sb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 01:37:43 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BL1E7M8040440;
        Tue, 21 Dec 2021 01:37:43 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s3y1sb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 01:37:43 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BL1YVTi013356;
        Tue, 21 Dec 2021 01:37:41 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3d179hqxt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 01:37:41 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BL1bdQ531588740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 01:37:39 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A95678081;
        Tue, 21 Dec 2021 01:37:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E97147808F;
        Tue, 21 Dec 2021 01:37:37 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.65.210.85])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 01:37:37 +0000 (GMT)
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     jarkko@kernel.org, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org, Korrapati.Likhitha@ibm.com,
        pavrampu@in.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, gcwilson@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
 <1052cd36-1b85-5d36-045f-5c5bf9f0fc4e@linux.ibm.com>
 <d9eafa8f-4006-4bc2-c09b-6b02a14c6ef3@linux.ibm.com>
 <20211221011320.GM6467@ziepe.ca>
 <f80e33d2-948d-f885-b063-245eb37de8c1@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <bad84f8a-9e07-0920-5c07-475e30e710e9@linux.ibm.com>
Date:   Mon, 20 Dec 2021 17:37:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f80e33d2-948d-f885-b063-245eb37de8c1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uksTC0_AMmmKfuVY-UAZnxy4ozK4GVxq
X-Proofpoint-GUID: 5S80dxjSxipysCG2cdF2ATh9tqjk9l8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_11,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=991 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/20/21 5:31 PM, Stefan Berger wrote:
> 
> On 12/20/21 20:13, Jason Gunthorpe wrote:
>> On Mon, Dec 20, 2021 at 08:05:58PM -0500, Stefan Berger wrote:
>>
>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>> index ddaeceb7e109..4cb908349b31 100644
>>> +++ b/drivers/char/tpm/tpm-chip.c
>>> @@ -473,15 +473,8 @@ static void tpm_del_char_device(struct tpm_chip *chip)
>>>          mutex_unlock(&idr_lock);
>>>
>>>          /* Make the driver uncallable. */
>>> -       down_write(&chip->ops_sem);
>>> -       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>>> -               if (!tpm_chip_start(chip)) {
>>> -                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
>>> -                       tpm_chip_stop(chip);
>>> -               }
>>> -       }
>>> -       chip->ops = NULL;
>>> -       up_write(&chip->ops_sem);
>>> +       if (chip->ops)
>> ops cannot be read without locking
> 
> This here could be an alternative:

I still think code de-duplication is a good thing. Maybe combine the two
approaches. Call tpm_class_shutdown from tpm_del_char_device and add a chip->ops
check in tpm_class_shutdown to ensure we only do the shutdown when chip->ops is
valid.

-Tyrel

> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..7772b475ebc0 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -474,7 +474,7 @@ static void tpm_del_char_device(struct tpm_chip *chip)
> 
>         /* Make the driver uncallable. */
>         down_write(&chip->ops_sem);
> -       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +       if (chip->ops && chip->flags & TPM_CHIP_FLAG_TPM2) {
>                 if (!tpm_chip_start(chip)) {
>                         tpm2_shutdown(chip, TPM2_SU_CLEAR);
>                         tpm_chip_stop(chip);
> 
>    Stefan
> 
> 
>>
>> Jason

