Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693283E9046
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhHKMQU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 08:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237552AbhHKMPo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 08:15:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BC43xD171699;
        Wed, 11 Aug 2021 08:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vz/JF6D9et2ylMltouH3zrYLZOET3avHkTYyvpC8n10=;
 b=OyhfMP9AB6greSlwzUK/SjRTLCoo/7cXGUMiJgFkF+4Bg23+F1aR4i/7xKbuLqKYb3J8
 +gIrcHKrgbOKnUvB517PMfwwx85mMpO6A6uTiIgEjFTiBwHGK86Xem4pNOwOxLTUxT/G
 cs5C1J34mYaUV6uUb8rVbRlt4b4fjR/hA1bf7Nzjqn31RBaNb/sJSl7knm+9e9MPNF4A
 3RuPcVbhODJCByXMO2HkCcIuHCgGwFg2a5a6EhvQ/Jj224SWM+Lz6orXM2jPOeO8HUsr
 lNM81WvF2KTa0IU5RtGvPXAM3jGnEXClYLkDxu8kRDa0nv4nVNQsyNypzsqqDDc/T/NJ Ng== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3accthaeae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 08:15:17 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BCCoTJ011035;
        Wed, 11 Aug 2021 12:15:16 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3a9hte6tse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 12:15:16 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BCFE0H38011302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 12:15:14 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3FE1112061;
        Wed, 11 Aug 2021 12:15:14 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83C88112062;
        Wed, 11 Aug 2021 12:15:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 12:15:14 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] tpm: ibmvtpm: Rename tpm_process_cmd to tpm_status
 and define flag
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, nasastry@in.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
 <20210809192159.2176580-3-stefanb@linux.vnet.ibm.com>
 <20210810175855.fixtw5jks4gbmkua@kernel.org>
 <86f6a6c8-87cc-a397-35b3-a30220f12aed@linux.ibm.com>
 <20210811021030.5meaty2zxf253nfl@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <4eff0296-78da-52b6-322d-56e0f9d78dc2@linux.ibm.com>
Date:   Wed, 11 Aug 2021 08:15:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811021030.5meaty2zxf253nfl@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XxohQtRH4nD48N9kbmsjsJOLPSV0YN2o
X-Proofpoint-ORIG-GUID: XxohQtRH4nD48N9kbmsjsJOLPSV0YN2o
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_04:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/10/21 10:10 PM, Jarkko Sakkinen wrote:
> On Tue, Aug 10, 2021 at 09:50:55PM -0400, Stefan Berger wrote:
>> On 8/10/21 1:58 PM, Jarkko Sakkinen wrote:
>>> On Mon, Aug 09, 2021 at 03:21:59PM -0400, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
>>>> the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
>>>>
>>>>
>>>>    		default:
>>>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
>>>> index 51198b137461..252f1cccdfc5 100644
>>>> --- a/drivers/char/tpm/tpm_ibmvtpm.h
>>>> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
>>>> @@ -41,7 +41,8 @@ struct ibmvtpm_dev {
>>>>    	wait_queue_head_t wq;
>>>>    	u16 res_len;
>>>>    	u32 vtpm_version;
>>>> -	u8 tpm_processing_cmd;
>>>> +	u8 tpm_status;
>>>> +#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
>>> Declare this already in the fix, and just leave the rename here.
>> You mean the fix patch does not use 'true' anymore but uses the
>> TPM_STATUS_BUSY flag already but the name is still tpm_processing_cmd? And
>> literally only the renaming of this field is done in the 2nd patch?
> I can fixup these patches, and use '1', instead of true. No need to send
> new ones.
>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

THANKS!

   Stefan

>
> /Jarkko
