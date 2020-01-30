Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC37614DFEC
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 18:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgA3Rcx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 12:32:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727158AbgA3Rcw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 12:32:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UHWZVs094547
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 12:32:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xubctmk6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 12:32:51 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 30 Jan 2020 17:32:49 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 17:32:47 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UHVs6333292588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 17:31:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3250842047;
        Thu, 30 Jan 2020 17:32:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43FDB4203F;
        Thu, 30 Jan 2020 17:32:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.199.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 17:32:45 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] ima: support calculating the boot_aggregate
 based on different TPM banks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Thu, 30 Jan 2020 12:32:44 -0500
In-Reply-To: <1065c502840c4f66baed9a771f3f2409@huawei.com>
References: <1580401363-5593-1-git-send-email-zohar@linux.ibm.com>
         <1580401363-5593-2-git-send-email-zohar@linux.ibm.com>
         <1065c502840c4f66baed9a771f3f2409@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20013017-0020-0000-0000-000003A592C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013017-0021-0000-0000-000021FD494D
Message-Id: <1580405564.5228.6.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_05:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-30 at 16:54 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > owner@vger.kernel.org] On Behalf Of Mimi Zohar
> > Sent: Thursday, January 30, 2020 5:23 PM
> > To: linux-integrity@vger.kernel.org
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>; James Bottomley
> > <James.Bottomley@HansenPartnership.com>; linux-
> > kernel@vger.kernel.org; Mimi Zohar <zohar@linux.ibm.com>
> > Subject: [PATCH v3 2/2] ima: support calculating the boot_aggregate based
> > on different TPM banks
> > 
> > Calculating the boot_aggregate attempts to read the TPM SHA1 bank,
> > assuming it is always enabled.  With TPM 2.0 hash agility, TPM chips
> > could support multiple TPM PCR banks, allowing firmware to configure and
> > enable different banks.
> > 
> > Instead of hard coding the TPM 2.0 bank hash algorithm used for calculating
> > the boot-aggregate, use the same hash algorithm for reading the TPM PCRs
> > as
> > for calculating the boot aggregate digest.  Preference is given to the
> > configured IMA default hash algorithm.
> > 
> > For TPM 1.2 SHA1 is the only supported hash algorithm.
> > 
> > Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_crypto.c | 45
> > ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_crypto.c
> > b/security/integrity/ima/ima_crypto.c
> > index 7967a6904851..a020aaefdea8 100644
> > --- a/security/integrity/ima/ima_crypto.c
> > +++ b/security/integrity/ima/ima_crypto.c
> > @@ -656,13 +656,34 @@ static void __init ima_pcrread(u32 idx, struct
> > tpm_digest *d)
> >  		pr_err("Error Communicating to TPM chip\n");
> >  }
> > 
> > +static enum hash_algo get_hash_algo(const char *algname)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < HASH_ALGO__LAST; i++) {
> > +		if (strcmp(algname, hash_algo_name[i]) == 0)
> > +			break;
> > +	}
> > +
> > +	return i;
> > +}
> > +
> >  /*
> > - * Calculate the boot aggregate hash
> > + * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
> > + * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but
> > with
> > + * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
> > + * allowing firmware to configure and enable different banks.
> > + *
> > + * Knowing which TPM bank is read to calculate the boot_aggregate digest
> > + * needs to be conveyed to a verifier.  For this reason, use the same
> > + * hash algorithm for reading the TPM PCRs as for calculating the boot
> > + * aggregate digest as stored in the measurement list.
> >   */
> >  static int __init ima_calc_boot_aggregate_tfm(char *digest,
> >  					      struct crypto_shash *tfm)
> >  {
> >  	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };
> > +	enum hash_algo crypto_id;
> >  	int rc;
> >  	u32 i;
> >  	SHASH_DESC_ON_STACK(shash, tfm);
> > @@ -673,6 +694,28 @@ static int __init ima_calc_boot_aggregate_tfm(char
> > *digest,
> >  	if (rc != 0)
> >  		return rc;
> > 
> > +	crypto_id = get_hash_algo(crypto_shash_alg_name(tfm));
> 
> Wouldn't be better to determine the index of ima_tpm_chip->allocated_banks
> in patch 1/2 and pass that index here, to avoid another search?

Both your suggestion and Lakshmi's suggestion change the parameters to
ima_calc_boot_aggregate_tfm(), which I was trying to avoid for now.  I
want it to be as easy as possible to backport.

Going forward, you might be correct.

Mimi

