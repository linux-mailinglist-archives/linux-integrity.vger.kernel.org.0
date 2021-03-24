Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EED347D6F
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhCXQPI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 12:15:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231858AbhCXQOi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 12:14:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OG3dIZ191798;
        Wed, 24 Mar 2021 12:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=0t/OKQ36CJXJBLoe5JRLA8HwwJpvzWj+By+MFOaovA4=;
 b=kqxW1qUXJuRuY+TNSLJjQDTZVRcY8hYloi1nEmclepvC0NKn4qXL07sVAtSScwn/EP0r
 l7l1fmb5rjshPeQQ39sLvo2jV0HbVemqecAYUdD/xeAaN8XNhopjm5lzRkv/2ft7Bdk4
 SIS+nStkYnVCoHyjZL82cbewGb5biXCRJjqmMwmPyecLMepu6uGYvTNyuIgu0xokKUvK
 VSbYndLKXzU2YRY8kICqynNsN59yUEIfKchoczq1wUV9PgWaYCAfD05ebcK3kA0WwVmd
 So8fcFoH9nVleCDccfyfyGpijvXfg/7Oiv/TMVQ6U74c42DT659ESwIsGFggrGG+w/7Y 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37g8gkgm08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 12:14:10 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12OG3ii2192402;
        Wed, 24 Mar 2021 12:14:09 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37g8gkgkyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 12:14:09 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12OGDf0I022134;
        Wed, 24 Mar 2021 16:14:08 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 37d9bf6m3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 16:14:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12OGE7QM18022788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 16:14:07 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AA6E78060;
        Wed, 24 Mar 2021 16:14:07 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDD1F78067;
        Wed, 24 Mar 2021 16:14:03 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.147.73])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Mar 2021 16:14:03 +0000 (GMT)
Message-ID: <9ba89168d8c4f1e3d6797a0b3713e152ac6388fd.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
        <linux-security-module@vger.kernel.org>
Date:   Wed, 24 Mar 2021 09:14:02 -0700
In-Reply-To: <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
         <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
         <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
         <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
         <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-03-23 at 14:07 -0400, Mimi Zohar wrote:
> On Tue, 2021-03-23 at 17:35 +0100, Ahmad Fatoum wrote:
> > Hello Horia,
> > 
> > On 21.03.21 21:48, Horia Geantă wrote:
> > > On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
> > > [...]
> > > > +struct trusted_key_ops caam_trusted_key_ops = {
> > > > +	.migratable = 0, /* non-migratable */
> > > > +	.init = trusted_caam_init,
> > > > +	.seal = trusted_caam_seal,
> > > > +	.unseal = trusted_caam_unseal,
> > > > +	.exit = trusted_caam_exit,
> > > > +};
> > > caam has random number generation capabilities, so it's worth
> > > using that
> > > by implementing .get_random.
> > 
> > If the CAAM HWRNG is already seeding the kernel RNG, why not use
> > the kernel's?
> > 
> > Makes for less code duplication IMO.
> 
> Using kernel RNG, in general, for trusted keys has been discussed
> before.   Please refer to Dave Safford's detailed explanation for not
> using it [1].
> 
> thanks,
> 
> Mimi
> 
> [1] 
> https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035F2A38B@ALPMBAPA12.e2k.ad.ge.com/

I still don't think relying on one source of randomness to be
cryptographically secure is a good idea.  The fear of bugs in the
kernel entropy pool is reasonable, but since it's widely used they're
unlikely to persist very long.  Studies have shown that some TPMs
(notably the chinese manufactured ones) have suspicious failures in
their RNGs:

https://www.researchgate.net/publication/45934562_Benchmarking_the_True_Random_Number_Generator_of_TPM_Chips

And most cryptograhpers recommend using a TPM for entropy mixing rather
than directly:

https://blog.cryptographyengineering.com/category/rngs/

The TPMFail paper also shows that in spite of NIST certification
things can go wrong with a TPM:

https://tpm.fail/

James


