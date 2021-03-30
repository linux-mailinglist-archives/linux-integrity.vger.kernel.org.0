Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC634F420
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhC3WRV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 18:17:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16918 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232793AbhC3WRR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 18:17:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UM3Bc7194303;
        Tue, 30 Mar 2021 18:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=BhpGLgUt1La+bKVw6w2gIvv2jd1E5v6HSf1GpyShzCE=;
 b=ZC7yUeykLc+JpTIVM41cp1jupon6iVO35WHo5OxrWCEDZsvFLocIVTORWVTU3QUVlpFh
 4JWlDrkhloxqcD/XZLElS/DGQ9DjK1uQoiMZhUygele3y6b2SObDsC/QKPQxKd98gRsX
 cBE9UPWrMcX7Os2pgu+giaZxyaCVpQtQfEuWHc0IAVWR39gtADoB0/tss6DtA2pFRFwx
 LEki2MfofjadHvhs7m2povb27b24F6yBS3oowhZiFq4pg5xzwU3zAd9dDtFMUj+lwD20
 bhvt5iq7eVDHau7XPp4Tpe0oCfiUa4y1KoHntdQe+DqgHAbULgaxCVWZ+het/3jx+jKP qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mapw3d1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 18:16:52 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12UMAeea032547;
        Tue, 30 Mar 2021 18:16:51 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mapw3d11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 18:16:51 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UME54q023992;
        Tue, 30 Mar 2021 22:16:50 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 37maaw90ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 22:16:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UMGnrc21430640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 22:16:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7D867805E;
        Tue, 30 Mar 2021 22:16:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AF607805C;
        Tue, 30 Mar 2021 22:16:44 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.239.180])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 22:16:44 +0000 (GMT)
Message-ID: <f01c80a0da7cffd3115ce4e16a793a2db5cbe2ed.camel@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Date:   Tue, 30 Mar 2021 15:16:43 -0700
In-Reply-To: <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
         <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
         <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
         <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JsLbPWjnVGd1OeQP1YnB2j5nXPSJBfyN
X-Proofpoint-GUID: 0boKCNAbJXwc4xC4QI87leHiPMfAmHmF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_12:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300160
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-31 at 00:04 +0200, Richard Weinberger wrote:
> Ahmad,
> 
> On Wed, Mar 17, 2021 at 3:08 PM Ahmad Fatoum <a.fatoum@pengutronix.de
> > wrote:
> >     keyctl add trusted $KEYNAME "load $(cat ~/kmk.blob)" @s
> 
> Is there a reason why we can't pass the desired backend name in the
> trusted key parameters?
> e.g.
> keyctl add trusted $KEYNAME "backendtype caam load $(cat ~/kmk.blob)"
> @s

Why would you want to in the load?  The blob should be type specific,
so a TPM key shouldn't load as a CAAM key and vice versa ... and if
they're not they need to be made so before the patches go upstream.

I could possibly see that you might want to be type specific in the
create, but once you're simply loading an already created key, the
trusted key subsystem should be able to figure what to do on its own.

James


