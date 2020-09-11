Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BD82668EA
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKTfX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 15:35:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgIKTfV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 15:35:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BJWtXN084347
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 15:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LzFhy3UkrEinZfXJyG1UQGmxA+06c2McsDi27SPlgK8=;
 b=G8/UjsOVJ/sHZW1UqkX/qr/IOe+vyKQC3IgnObMb4ln2hSlOxEZoxlRe+4vaIkpLmo6f
 t0lv2xxrehWKj5K/5XVq3/rBAeqG6sDwCqSdDr7n/urIGrVGBBi0sre6jU0EsVhCVPXH
 frUwb04XxwK2Uh2H+r1pEDGf0HeR/9xgxE4WSJam1ZurnAQgBbjFGleqo/sDX2uToQid
 EQkE3Y6CD9a9SzIDs2qRi/evT0EJHpCLV5tLfDc8LLWgVHN9M31IK8daS+ip8vopipwa
 5Xb0qIOurq0z38nYUHIh6LV0k9gBYUg8SLyROzrTPq5hZ1kJEyHkm8IfSvY5QYXOTOHX PA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gerjh4p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 15:35:20 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BJWVpn006177
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 19:35:19 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 33c2aa6n42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 19:35:19 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BJZI0448693616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 19:35:18 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 722E0112062
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 19:35:18 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5431B112061
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 19:35:18 +0000 (GMT)
Received: from [9.85.179.93] (unknown [9.85.179.93])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri, 11 Sep 2020 19:35:18 +0000 (GMT)
Subject: Re: [Bug Report] Kernel 4.14+ TPM Driver Bug for Atmel TPM Chip
Cc:     linux-integrity@vger.kernel.org
References: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
 <20200911041800.GA541925@kroah.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <5518aa6e-a10f-9e07-e885-2ab43a0906e9@linux.ibm.com>
Date:   Fri, 11 Sep 2020 15:35:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911041800.GA541925@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_10:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110152
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/11/2020 12:18 AM, Greg KH wrote:
> Thus the TPM get queried more frequently than before, which is likely the root cause of the atmel chip crash. We fix it by bumping up the TPM_TIMEOUT to 15ms.
> 
> 
> Rubrik Patch
> ```
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 72d3ce4..9b8f3f8 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -49,7 +49,15 @@ enum tpm_const {
>   };
> 
>   enum tpm_timeout {
> -       TPM_TIMEOUT = 5,        /* msecs */
> +       TPM_TIMEOUT = 15,       /* msecs */
>          TPM_TIMEOUT_RETRY = 100, /* msecs */
>          TPM_TIMEOUT_RANGE_US = 300      /* usecs */
>   };
> ```
> With the patch, the atmel TPM chip crash is fixed.
> 
> Proposal
> We want the kernel upstream to adopt the fix or have a better fix for the atmel chip while not bring performance regression for other TPM chips. We understand thathttps://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3  <https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3>  was intended to shorten the TPM

Is this the poll time, which was reduced at one point?  If so ...

Be careful about making this a global change.  It could reduce the TPM 
performance by 3x. We don't want to affect all TPMs to fix a bug in an 
old TPM 1.2 chip from one vendor.
