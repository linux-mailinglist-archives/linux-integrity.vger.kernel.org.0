Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458871EFC8A
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgFEPdq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 11:33:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgFEPdq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 11:33:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055FWedb096598;
        Fri, 5 Jun 2020 11:33:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31fhr9xbry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 11:33:18 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 055FXDlc100023;
        Fri, 5 Jun 2020 11:33:16 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31fhr9xbqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 11:33:15 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055FKqLA018391;
        Fri, 5 Jun 2020 15:33:14 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 31bf4axv19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 15:33:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055FXDOt55050728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 15:33:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE9AEB206C;
        Fri,  5 Jun 2020 15:33:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6A27B206A;
        Fri,  5 Jun 2020 15:33:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 15:33:12 +0000 (GMT)
Subject: Re: [PATCH] tpm: ibmvtpm: Wait for ready buffer before probing for
 TPM2 attributes
To:     David Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200605063719.456277-1-david@gibson.dropbear.id.au>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <fe79d427-359e-7c6a-6e39-8a6ea345cbd9@linux.ibm.com>
Date:   Fri, 5 Jun 2020 11:33:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200605063719.456277-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_04:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 cotscore=-2147483648 impostorscore=0 spamscore=0
 clxscore=1011 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050113
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/20 2:37 AM, David Gibson wrote:
> The tpm2_get_cc_attrs_tbl() call will result in TPM commands being issued,
> which will need the use of the internal command/response buffer.  But,
> we're issuing this *before* we've waited to make sure that buffer is
> allocated.
>
> This can result in intermittent failures to probe if the hypervisor / TPM
> implementation doesn't respond quickly enough.  I find it fails almost
> every time with an 8 vcpu guest under KVM with software emulated TPM.

Uuuh. Thanks!


> Fixes: 18b3670d79ae9 "tpm: ibmvtpm: Add support for TPM2"
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 09fe45246b8c..994385bf37c0 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -683,13 +683,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   	if (rc)
>   		goto init_irq_cleanup;
>   
> -	if (!strcmp(id->compat, "IBM,vtpm20")) {
> -		chip->flags |= TPM_CHIP_FLAG_TPM2;
> -		rc = tpm2_get_cc_attrs_tbl(chip);
> -		if (rc)
> -			goto init_irq_cleanup;
> -	}
> -
>   	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
>   				ibmvtpm->rtce_buf != NULL,
>   				HZ)) {
> @@ -697,6 +690,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   		goto init_irq_cleanup;
>   	}
>   
> +	if (!strcmp(id->compat, "IBM,vtpm20")) {
> +		chip->flags |= TPM_CHIP_FLAG_TPM2;
> +		rc = tpm2_get_cc_attrs_tbl(chip);
> +		if (rc)
> +			goto init_irq_cleanup;
> +	}
> +
>   	return tpm_chip_register(chip);
>   init_irq_cleanup:
>   	do {



