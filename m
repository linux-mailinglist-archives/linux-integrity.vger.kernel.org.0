Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC314BD1F
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2020 16:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA1Pkz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jan 2020 10:40:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbgA1Pkv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jan 2020 10:40:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SFbkbR037630
        for <linux-integrity@vger.kernel.org>; Tue, 28 Jan 2020 10:40:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjq7muv4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 Jan 2020 10:40:50 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 28 Jan 2020 15:40:48 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 15:40:44 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SFeiUM42467494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 15:40:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0570BA4040;
        Tue, 28 Jan 2020 15:40:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36FCFA4053;
        Tue, 28 Jan 2020 15:40:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.98])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jan 2020 15:40:43 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima: support calculating the boot_aggregate based
 on different TPM banks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Tue, 28 Jan 2020 10:40:42 -0500
In-Reply-To: <465015d0c9ca4e278ed32f78eb3eb4a4@huawei.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
         <465015d0c9ca4e278ed32f78eb3eb4a4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012815-0028-0000-0000-000003D5363D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012815-0029-0000-0000-000024997E80
Message-Id: <1580226042.5088.90.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-28 at 14:19 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > owner@vger.kernel.org] On Behalf Of Mimi Zohar
> > Sent: Monday, January 27, 2020 5:02 PM
> > To: linux-integrity@vger.kernel.org
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>; James Bottomley
> > <James.Bottomley@HansenPartnership.com>; linux-
> > kernel@vger.kernel.org; Mimi Zohar <zohar@linux.ibm.com>
> > Subject: [PATCH 2/2] ima: support calculating the boot_aggregate based on
> > different TPM banks
> > 
> > Calculating the boot_aggregate attempts to read the TPM SHA1 bank,
> > assuming it is always enabled.  With TPM 2.0 hash agility, TPM chips
> > could support multiple TPM PCR banks, allowing firmware to configure and
> > enable different banks.
> > 
> > Instead of hard coding the TPM 2.0 bank hash algorithm used for calculating
> > the boot-aggregate, see if the configured IMA_DEFAULT_HASH algorithm is
> > an allocated TPM bank, otherwise use the first allocated TPM bank.
> > 
> > For TPM 1.2 SHA1 is the only supported hash algorithm.
> > 
> > Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_crypto.c | 37
> > ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_crypto.c
> > b/security/integrity/ima/ima_crypto.c
> > index 7967a6904851..b1b26d61f174 100644
> > --- a/security/integrity/ima/ima_crypto.c
> > +++ b/security/integrity/ima/ima_crypto.c
> > @@ -656,8 +656,25 @@ static void __init ima_pcrread(u32 idx, struct
> > tpm_digest *d)
> >  		pr_err("Error Communicating to TPM chip\n");
> >  }
> > 
> > +/* tpm2_hash_map is the same as defined in tpm2-cmd.c and
> > trusted_tpm2.c */
> > +static struct tpm2_hash tpm2_hash_map[] = {
> > +	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> > +	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> > +	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> > +	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> > +	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> > +};
> > +
> >  /*
> > - * Calculate the boot aggregate hash
> > + * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
> > + * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
> > + * allowing firmware to configure and enable different banks.
> > + *
> > + * Instead of hard coding the TPM bank hash algorithm used for calculating
> > + * the boot-aggregate, see if the configured IMA_DEFAULT_HASH
> > algorithm is
> > + * an allocated TPM bank, otherwise use the first allocated TPM bank.
> > + *
> > + * For TPM 1.2 SHA1 is the only hash algorithm.
> >   */
> >  static int __init ima_calc_boot_aggregate_tfm(char *digest,
> >  					      struct crypto_shash *tfm)
> > @@ -673,6 +690,24 @@ static int __init ima_calc_boot_aggregate_tfm(char
> > *digest,
> >  	if (rc != 0)
> >  		return rc;
> > 
> > +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> > +		if (tpm2_hash_map[i].crypto_id == ima_hash_algo) {
> 
> It is not necessary to define a new map. ima_tpm_chip->allocated_banks
> has a crypto_id field.

Ok, thanks.

> 
> > +			d.alg_id = tpm2_hash_map[i].tpm_id;
> > +			break;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> > +		if (ima_tpm_chip->allocated_banks[i].alg_id == d.alg_id)
> > +			break;
> > +	}
> > +
> > +	if (i == ima_tpm_chip->nr_allocated_banks)
> > +		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;
> 
> This code assumes that the algorithm used to calculate boot_aggregate and
> the algorithm of the PCR bank can be different. I don't know if it is possible to
> communicate to the verifier which bank has been selected (it depends on
> the local configuration).

Agreed, but defaulting to the first bank would only happen if the IMA
default hash algorithm is not a configured TPM algorithm.

> 
> In my opinion the safest approach would be to use the same algorithm for the
> digest and the PCR bank. If you agree to this, then the code above must be
> moved to ima_calc_boot_aggregate() so that the algorithm of the selected
> PCR bank can be passed to ima_alloc_tfm().

Using the same hash algorithm, preferably the IMA hash default
algorithm, for reading the TPM PCR bank and calculating the
boot_aggregate makes sense.

> 
> The selected PCR bank might be not the first, if the algorithm is unknown to
> the crypto subsystem.

It sounds like you're suggesting finding a common configured hash
algorithm between the TPM and the kernel. 

> 
> > +	pr_info("Calculating the boot-aggregregate, reading TPM PCR
> 
> Typo.

thanks

Mimi

