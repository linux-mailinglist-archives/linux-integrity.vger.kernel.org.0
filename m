Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1033506C5
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 20:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhCaSuw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Mar 2021 14:50:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234940AbhCaSul (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Mar 2021 14:50:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VIXpKR137286;
        Wed, 31 Mar 2021 14:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=IF3IiH3eNpZCIpfkSSlQ6TOuOkAH1IoZShm66G4xJ9o=;
 b=HtSg2viGN4HhXpD8Pb7nFH9aLMJhHf/rbii1zrnp/ZWkUpZHL+kfaBLqnqTSohmGc1ZT
 Nfx/WUWcKPK6aJa8dFbtkO6HcmtsmZv/9mBssEZXR1Q/5TeLdhQR9Dg5572jakK14o6i
 qJDRH7ZTiS1kFZeJ1xVPGPkQVY1MkO9anRM5IlIxThn9AzSXcXd+lnwEP7ws4KHl+aXQ
 mch5UtIjEpT7Nm0Yo1iLKzjcmUNdE36FvBSd6xTgK4M67NmTuLCrIAmjdvCvDH+BRYTl
 OlNTw37LjLsdZ29bxIqAFUamY6bHVr/a/8m1ueEklCAwc4253E1KGrD2CBi6BDQoYG3E gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mu4ufsmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 14:49:55 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12VIZiM5002018;
        Wed, 31 Mar 2021 14:49:54 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mu4ufsm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 14:49:54 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12VIkwsj026100;
        Wed, 31 Mar 2021 18:49:53 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 37mac6s5bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 18:49:53 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12VInqAr23658852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 18:49:52 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B35878066;
        Wed, 31 Mar 2021 18:49:52 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 901B278063;
        Wed, 31 Mar 2021 18:49:48 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.239.180])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 31 Mar 2021 18:49:48 +0000 (GMT)
Message-ID: <a57192d9d9a5a9a66d11b38d054a5a3a70466a4b.camel@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Richard Weinberger <richard@nod.at>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Date:   Wed, 31 Mar 2021 11:49:47 -0700
In-Reply-To: <1777909690.136833.1617215767704.JavaMail.zimbra@nod.at>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
         <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
         <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
         <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
         <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com>
         <1777909690.136833.1617215767704.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w9mQblNyBlR2u66JMdk6J6LtjJp5pYk-
X-Proofpoint-GUID: KWy2U-TPE39PNjAEcBgmqPjaOezKRBzV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_10:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-31 at 20:36 +0200, Richard Weinberger wrote:
> James,
> 
> ----- Ursprüngliche Mail -----
> > Von: "James Bottomley" <jejb@linux.ibm.com>
> > > On Wed, Mar 17, 2021 at 3:08 PM Ahmad Fatoum <
> > > a.fatoum@pengutronix.de wrote:
> > > >     keyctl add trusted $KEYNAME "load $(cat ~/kmk.blob)" @s
> > > 
> > > Is there a reason why we can't pass the desired backend name in
> > > the
> > > trusted key parameters?
> > > e.g.
> > > keyctl add trusted $KEYNAME "backendtype caam load $(cat
> > > ~/kmk.blob)"
> > > @s
> > 
> > Why would you want to in the load?  The blob should be type
> > specific, so a TPM key shouldn't load as a CAAM key and vice versa
> > ... and if they're not they need to be made so before the patches
> > go upstream.
> 
> I fear right now there is no good way to detect whether a blob is
> desired for CAAM or TPM.

At least for the TPM the old format is two TPM2B structures, and the
new one is ASN.1 so either should be completely distinguishable over
what CAAM does.

> > I could possibly see that you might want to be type specific in the
> > create, but once you're simply loading an already created key, the
> > trusted key subsystem should be able to figure what to do on its
> > own.
> 
> So you have some kind of container format in mind which denotes the
> type of the blob?

Well, yes.  For the TPM, there's a defined ASN.1 format for the keys:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/tpm2-asn.h

and part of the design of the file is that it's distinguishable either
in DER or PEM (by the guards) format so any crypto application can know
it's dealing with a TPM key simply by inspecting the file.  I think you
need the same thing for CAAM and any other format.

We're encouraging new ASN.1 formats to be of the form

SEQUENCE {
    type   OBJECT IDENTIFIER
    ... key specific fields ...
}

Where you choose a defined OID to represent the key and that means
every key even in DER form begins with a unique binary signature.

James


