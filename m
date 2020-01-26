Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9E149DE3
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 00:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgAZXxk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jan 2020 18:53:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbgAZXxj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jan 2020 18:53:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00QNnA2v090474
        for <linux-integrity@vger.kernel.org>; Sun, 26 Jan 2020 18:53:38 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrffxwbwj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 26 Jan 2020 18:53:38 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 26 Jan 2020 23:53:36 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 26 Jan 2020 23:53:32 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00QNrWhA58720486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jan 2020 23:53:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 000274C044;
        Sun, 26 Jan 2020 23:53:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 315DE4C040;
        Sun, 26 Jan 2020 23:53:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.204])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jan 2020 23:53:31 +0000 (GMT)
Subject: Re: [PATCH] ima: fix calculating the boot_aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Jan 2020 18:53:30 -0500
In-Reply-To: <1580060759.4964.12.camel@HansenPartnership.com>
References: <1580044434-9132-1-git-send-email-zohar@linux.ibm.com>
         <1580060759.4964.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012623-0008-0000-0000-0000034CE2C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012623-0009-0000-0000-00004A6D5638
Message-Id: <1580082810.5990.75.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-26_07:2020-01-24,2020-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001260208
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On Sun, 2020-01-26 at 09:45 -0800, James Bottomley wrote:
> On Sun, 2020-01-26 at 08:13 -0500, Mimi Zohar wrote:
> > Calculating the boot_aggregate assumes that the TPM SHA1 bank is
> > enabled.  Before trying to read the TPM SHA1 bank, ensure it is
> > enabled. If it isn't enabled, calculate the boot_aggregate using the
> > first bank enabled.
> 
> Isn't it about time we shifted IMA away from SHA1 as a NIST deprecated
> algorithm especially as in this case if someone can manufacture a sha1
> hash collision, they can fake the TCB?  I think we should always try
> use SHA256 if we have a TPM2, then fall back to whatever bank0 is if
> SHA256 can't be found (that will cope with DELLs that violate the TPM2
> spec by disabling the sha256 bank if the bios setting is sha1).  This
> should also cope with other ODMs who violate the spec in other ways,
> like not updating the sha1 bank but still leaving it allocated.
> 
> Mechanically, also, you don't need the found variable, you can see if i
> reaches the max value.

Agreed, in general we should be moving away from SHA1, but this change
only addresses calculating the boot_aggregate hash, not the bigger
issue of calculating multiple file hashes and extending the TPM banks
with the appropriate file hash values.  The boot_aggregate is the hash
of PCRs 0 - 7, which links the pre-boot event log with the IMA
measurement list.  I would think manufacturing a SHA1 hash collision
in this specific use case scenario would be more difficult.

Assuming changing the boot_aggregate hash algorithm doesn't break
userspace, instead of hard coding the algorithm, we probably should
use the Kconfig IMA_DEFAULT_HASH algorithm.

Mimi



> 
> ---
> 
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 73044fc6a952..f5f7a3aec826 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -665,12 +665,29 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
>  	u32 i;
>  	SHASH_DESC_ON_STACK(shash, tfm);
>  
> +	if (ima_tpm_chip->flags & TPM_CHIP_FLAG_TPM2)
> +		/* TPM2 default should be sha256 */
> +		d.alg_id = TPM_ALG_SHA256;
> +
>  	shash->tfm = tfm;
>  
>  	rc = crypto_shash_init(shash);
>  	if (rc != 0)
>  		return rc;
>  
> +	/*
> +	 * Check the TPM default bank is allocated otherwise use the first one
> +	 */
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> +		if (ima_tpm_chip->allocated_banks[i].alg_id == d.alg_id)
> +			break;
> +
> +	if (i == ima_tpm_chip->nr_allocated_banks) {
> +		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;
> +		pr_info("Calculating the boot-aggregregate (TPM algorithm: %d)",
> +			d.alg_id);
> +	}
> +
>  	/* cumulative sha1 over tpm registers 0-7 */
>  	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
>  		ima_pcrread(i, &d);

