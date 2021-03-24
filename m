Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3534831B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbhCXUuH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 16:50:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42388 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238108AbhCXUtk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 16:49:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OKWpqh157879;
        Wed, 24 Mar 2021 16:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oSk4ZvpIFfpvGW9vz/hLhm3l5dMxtXS4oNfyPDLD3r8=;
 b=X9C83N0V6kwHaDns3tPOXthGbKVrxbHgyJjF4T8Oz1lzzyv0C8n0N0yOrfSmAGhvUytg
 ZMshhOamMXbkMAiZRw9ceA/zcNsbum0UBtI1OlCaLWrf+xF+HdpzSAQWSohskcFZedLs
 WlyyCAOkzPV5ThH+ku1bEIFXl9nnlmLE+qnSViMaTiJ+51kGyge3X8RRHFVhGefWQenG
 LhCYm33xF52xUJxKQkUwhVBpn1ur6HVotFQXa4LrOnOeD5wvwnB6uxhNPkGzHqe7UuN6
 QGG8peL7VJLzWibEZ78gWlB91IJj+qR+2/CzO18IoCGRxnHsl46h/4bimUwy0BKHimQt jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37g865gaw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 16:49:17 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12OKXi6w161283;
        Wed, 24 Mar 2021 16:49:17 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37g865gavk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 16:49:17 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12OKnF15028449;
        Wed, 24 Mar 2021 20:49:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 37d9a62fn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 20:49:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12OKnCc942860938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 20:49:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD3C7A404D;
        Wed, 24 Mar 2021 20:49:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54DF0A4059;
        Wed, 24 Mar 2021 20:49:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.11.141])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Mar 2021 20:49:07 +0000 (GMT)
Message-ID: <df118419f28a04d2e711a55678c0149115606071.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     jejb@linux.ibm.com, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Date:   Wed, 24 Mar 2021 16:49:05 -0400
In-Reply-To: <9ba89168d8c4f1e3d6797a0b3713e152ac6388fd.camel@linux.ibm.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
         <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
         <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
         <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
         <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
         <9ba89168d8c4f1e3d6797a0b3713e152ac6388fd.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240150
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-24 at 09:14 -0700, James Bottomley wrote:
> On Tue, 2021-03-23 at 14:07 -0400, Mimi Zohar wrote:
> > On Tue, 2021-03-23 at 17:35 +0100, Ahmad Fatoum wrote:
> > > Hello Horia,
> > > 
> > > On 21.03.21 21:48, Horia Geantă wrote:
> > > > On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
> > > > [...]
> > > > > +struct trusted_key_ops caam_trusted_key_ops = {
> > > > > +	.migratable = 0, /* non-migratable */
> > > > > +	.init = trusted_caam_init,
> > > > > +	.seal = trusted_caam_seal,
> > > > > +	.unseal = trusted_caam_unseal,
> > > > > +	.exit = trusted_caam_exit,
> > > > > +};
> > > > caam has random number generation capabilities, so it's worth
> > > > using that
> > > > by implementing .get_random.
> > > 
> > > If the CAAM HWRNG is already seeding the kernel RNG, why not use
> > > the kernel's?
> > > 
> > > Makes for less code duplication IMO.
> > 
> > Using kernel RNG, in general, for trusted keys has been discussed
> > before.   Please refer to Dave Safford's detailed explanation for not
> > using it [1].
> > 
> > [1] 
> > https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com/
> 
> I still don't think relying on one source of randomness to be
> cryptographically secure is a good idea.  The fear of bugs in the
> kernel entropy pool is reasonable, but since it's widely used they're
> unlikely to persist very long.  Studies have shown that some TPMs
> (notably the chinese manufactured ones) have suspicious failures in
> their RNGs:
> 
> https://www.researchgate.net/publication/45934562_Benchmarking_the_True_Random_Number_Generator_of_TPM_Chips
> 
> And most cryptograhpers recommend using a TPM for entropy mixing rather
> than directly:
> 
> https://blog.cryptographyengineering.com/category/rngs/
> 
> The TPMFail paper also shows that in spite of NIST certification
> things can go wrong with a TPM:
> 
> https://tpm.fail/

We already had a lengthy discussion on replacing the TPM RNG with the
kernel RNG for trusted keys, when TEE was being introduced [2,3].  I'm
not interested in re-hashing that discussion here.   The only
difference now is that CAAM is a new trust source.  I suspect the same
concerns/issues persist, but at least in this case using the kernel RNG
would not be a regression.

[2] Pascal Van Leeuwen on mixing different sources of entropy and certification -
 https://lore.kernel.org/linux-integrity/MN2PR20MB29732A856A40131A671F949FCA950@MN2PR20MB2973.namprd20.prod.outlook.com/
[3] Jarrko on "regression" and tpm_asym.c - 
https://lore.kernel.org/linux-integrity/20191014190033.GA15552@linux.intel.com/ 

Mimi

