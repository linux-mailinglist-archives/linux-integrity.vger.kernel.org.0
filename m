Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A268618A4
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 02:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfGHA0K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 20:26:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727384AbfGHA0K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 20:26:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x680MUKp049237;
        Sun, 7 Jul 2019 20:25:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tkmsn8hf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Jul 2019 20:25:58 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x680Pvpo056350;
        Sun, 7 Jul 2019 20:25:57 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tkmsn8hex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Jul 2019 20:25:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x680JCoE022202;
        Mon, 8 Jul 2019 00:25:56 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2tjk96tuch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 00:25:56 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x680PtFt53150166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 00:25:55 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B112D124052;
        Mon,  8 Jul 2019 00:25:55 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 839B9124053;
        Mon,  8 Jul 2019 00:25:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 00:25:55 +0000 (GMT)
Subject: Re: [PATCH v2] tpm: tpm_ibm_vtpm: Fix unallocated banks
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <510c30d0-34f4-1937-7882-1880eb9241ed@linux.ibm.com>
Date:   Sun, 7 Jul 2019 20:25:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080003
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/6/19 8:18 PM, Nayna Jain wrote:
> The nr_allocated_banks and allocated banks are initialized as part of
> tpm_chip_register. Currently, this is done as part of auto startup
> function. However, some drivers, like the ibm vtpm driver, do not run
> auto startup during initialization. This results in uninitialized memory
> issue and causes a kernel panic during boot.
>
> This patch moves the pcr allocation outside the auto startup function
> into tpm_chip_register. This ensures that allocated banks are initialized
> in any case.
>
> Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> PCR read")
> Reported-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Michal Suchánek <msuchanek@suse.de>
> ---
> Changelog:
>
> v2:
> * Includes Jarkko's feedbacks
>    * fixes the function name to tpm_get_pcr_allocation()
>    * adds new function tpm1_get_pcr_allocation()
>    * updates patch summary line
>    * fixes alignment
>    * adds Reported-by: Michal Suchanek <msuchanek@suse.de>
> * Includes Stefan's feedbacks
>    * Fixes overwriting of return code
>    * Fixes misplacing of tpm_chip_stop()
> * Adds Reviewed-by, Tested-by
>
>   drivers/char/tpm/tpm-chip.c | 22 ++++++++++++++++++++++
>   drivers/char/tpm/tpm.h      |  2 ++
>   drivers/char/tpm/tpm1-cmd.c | 36 ++++++++++++++++++++++++------------
>   drivers/char/tpm/tpm2-cmd.c |  6 +-----
>   4 files changed, 49 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8804c9e916fd..6589291df355 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -550,6 +550,22 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>   	return hwrng_register(&chip->hwrng);
>   }
>
> +/*
> + * tpm_get_pcr_allocation() - initialize the chip allocated banks for PCRs
> + * @chip: TPM chip to use.
> + */
> +static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> +{
> +	int rc;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		rc = tpm2_get_pcr_allocation(chip);


For tpm2 case you need:

if (rc > 0)

     rc = -ENODEV;

Because tpm2_get_pcr_allocation(chip) returns ssize_t with return values 
from tpm_transmit_cmd > 0 indicating a TPM 2 error code...


    Stefan

