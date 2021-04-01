Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0ED351E3C
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 20:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhDASgm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 14:36:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235887AbhDAS1S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 14:27:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131I3vUX105386;
        Thu, 1 Apr 2021 14:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=T4fnw2TRi67LEfpdXplN06AKuUVnvjkqgYiFc9IZrMc=;
 b=FOuKJG5g+2U13uazzqdu1BcuiyuYo4Cj75yLBrKdqL5QOB4BzwC/GDwCpBBN4ImNUXRP
 XI5hd8Nn4wKk7EolYNGfNuIihiU8qVeysxYUFSGqSPk6fYZqEaiX48Kr2CjocT2L6Kri
 wjEBbOAbKuGmx1cR0Juz8+kjAaEQf2TQYYAbyzQjLLx6MwpKBd20TuTFtC1IUrISV4hS
 ahmSLVjVAh0T1kB/M9Pe7DU66OdgYCt1ZreirwFowAcmUIJDCtetTwkwAv6AhD8+Fq/h
 CxBaGYC7i21hM8+9fVUtb8iFbBsUf0SBaF4o5l9YJ3m1DgyRHwPY/F3yYpb4SJ2Ooy3n cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ng71qjfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 14:26:47 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 131I5CDw112885;
        Thu, 1 Apr 2021 14:26:47 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ng71qjfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 14:26:46 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 131ICMAZ008896;
        Thu, 1 Apr 2021 18:26:45 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 37n28vqkjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 18:26:45 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 131IQiiU21889324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Apr 2021 18:26:44 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71EBC7805F;
        Thu,  1 Apr 2021 18:26:44 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D629F78063;
        Thu,  1 Apr 2021 18:26:40 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.239.180])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Apr 2021 18:26:40 +0000 (GMT)
Message-ID: <3a5f19008b11730816143ba5d7e87e7c7605e08a.camel@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Sumit Garg <sumit.garg@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        horia geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>, kernel <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Date:   Thu, 01 Apr 2021 11:26:39 -0700
In-Reply-To: <CAFA6WYNd7PEcZheSYPbEmFbkkMx4dmafeYcSpMBSdNZgqz=TyQ@mail.gmail.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
         <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
         <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
         <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
         <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com>
         <1777909690.136833.1617215767704.JavaMail.zimbra@nod.at>
         <a57192d9d9a5a9a66d11b38d054a5a3a70466a4b.camel@linux.ibm.com>
         <2034693332.137003.1617219379831.JavaMail.zimbra@nod.at>
         <f3399480-020e-e3ca-7e7c-eec641fe5afc@pengutronix.de>
         <CAFA6WYNd7PEcZheSYPbEmFbkkMx4dmafeYcSpMBSdNZgqz=TyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oZsApjl-rSYCxLO7wJFji72D7oQKevCZ
X-Proofpoint-ORIG-GUID: _wmv2nFeFhh6NXJegczUjdX5lixyB8TD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_09:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=818
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-04-01 at 18:50 +0530, Sumit Garg wrote:
> On Thu, 1 Apr 2021 at 15:36, Ahmad Fatoum <a.fatoum@pengutronix.de>
> wrote:
> > Hello Richard,
> > 
> > On 31.03.21 21:36, Richard Weinberger wrote:
> > > James,
> > > 
> > > ----- Ursprüngliche Mail -----
> > > > Von: "James Bottomley" <jejb@linux.ibm.com>
> > > > Well, yes.  For the TPM, there's a defined ASN.1 format for the
> > > > keys:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/tpm2-asn.h
> > > > 
> > > > and part of the design of the file is that it's distinguishable
> > > > either
> > > > in DER or PEM (by the guards) format so any crypto application
> > > > can know
> > > > it's dealing with a TPM key simply by inspecting the file.  I
> > > > think you
> > > > need the same thing for CAAM and any other format.
> > > > 
> > > > We're encouraging new ASN.1 formats to be of the form
> > > > 
> > > > SEQUENCE {
> > > >    type   OBJECT IDENTIFIER
> > > >    ... key specific fields ...
> > > > }
> > > > 
> > > > Where you choose a defined OID to represent the key and that
> > > > means
> > > > every key even in DER form begins with a unique binary
> > > > signature.
> > > 
> > > I like this idea.
> > > Ahmad, what do you think?
> > > 
> > > That way we could also get rid off the kernel parameter and all
> > > the fall back logic,
> > > given that we find a way to reliable detect TEE blobs too...
> > 
> > Sounds good to me. Sumit, your thoughts on doing this for TEE as
> > well?
> > 
> 
> AFAIU, ASN.1 formating should be independent of trusted keys backends
> which could be abstracted to trusted keys core layer so that every
> backend could be plugged in seamlessly.
> 
> James,
> 
> Would it be possible to achieve this?

I'm not quite sure what you're asking.  The saved format of the keys is
particular to the underlying hardware.  The ASN.1 wraps this so we have
an identifier, some useful information to help load the key (like the
policy systemements) and then the blobs the hardware expects.

This makes the ASN.1 specific to the backend but having a
distinguishing OID that allows anyone to tell which backend it needs
from the file.

So you can call the ASN.1 format that begins with the type OID, the
"universal" format, but if you mean there should be a standard ASN.1
format for all keys that defines all the fields then that's not
possible because the fields after type are very specific to the
underlying hardware.

James


