Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F6A3D0370
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhGTUJR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 16:09:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236896AbhGTTpQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 15:45:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KK4bK2023434;
        Tue, 20 Jul 2021 16:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6d0AvtuBA/mdM+Xm+jajpNkrlEgOYj7D9PlUbi2xZB4=;
 b=V4zOHp+W0kVwdjd25UFD8InNd5+irwbyCnzI9y3RmjFPUQ12T41Kpwozn5isTwnh7pQq
 +ra/ibOqCusdT8/wYLkkUMjdk1cAOuBfLcuD6F+q7iS/Mwpr9alu4WiMU7QmFVH5Cjpx
 V8Vc9lCAQ/gkzrB3regmEONyJjMZVbeAMpyAK7jBq1hCbWWEpdjesgO9C2KqZRHx2uik
 oacNlYSIedCv5ldJqIqOIE3C72zhbuCy/hfm4/Zn0nEowT+iKHg6d4XPWcW/duPwUQcz
 3Bbt1pHc/Cvo4bJIBsnxHu0udqNeYNW/tdB3o3X7JvAD2JjrquSAoKWJ3Yc6994l+mRT 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wy71wjmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 16:24:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16KK6Adj032512;
        Tue, 20 Jul 2021 16:24:58 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wy71wjkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 16:24:58 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16KKCqSp012806;
        Tue, 20 Jul 2021 20:24:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng714qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 20:24:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16KKOrF527066780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 20:24:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F24BA42047;
        Tue, 20 Jul 2021 20:24:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1E5D42042;
        Tue, 20 Jul 2021 20:24:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.68.252])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Jul 2021 20:24:47 +0000 (GMT)
Message-ID: <40e167cca7b59fc4e11f45ba807486e11eade419.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        kernel <kernel@pengutronix.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        horia geanta <horia.geanta@nxp.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>, Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Date:   Tue, 20 Jul 2021 16:24:46 -0400
In-Reply-To: <CAFLxGvxr94apP2jaT0tB6JRDtv_ivrguXK2Ykd3zer_4xtJ+2w@mail.gmail.com>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
         <39e6d65ca5d2a0a35fb71d6c1f85add8ee489a19.1624364386.git-series.a.fatoum@pengutronix.de>
         <1850833581.13438.1625172175436.JavaMail.zimbra@nod.at>
         <2f608e5a-5a12-6db1-b9bd-a2cd9e3e3671@pengutronix.de>
         <783613027.15909.1625223222889.JavaMail.zimbra@nod.at>
         <ac8ef66f-4d57-ead0-d1b3-e97220463241@pengutronix.de>
         <CAFLxGvxr94apP2jaT0tB6JRDtv_ivrguXK2Ykd3zer_4xtJ+2w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IEFJRJOHfvwOngpKt1XIsPonFtReajLI
X-Proofpoint-ORIG-GUID: wkYED_fW-_xDkCD6flgnu-e43ZxxTkI5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_13:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107200128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

HI -

On Tue, 2021-07-20 at 21:19 +0200, Richard Weinberger wrote:
> On Fri, Jul 2, 2021 at 2:37 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> > > Both is possible. If the string starts with "0x" it needs to be decoded to a
> > > 128 bit key. Otherwise it has to be a up to 16 byte string.
> >
> > Fine by me. Looking forward to your patches. :-)
> 
> I'm not sure how to proceed.  Should I base my changes on this series
> or do you plan to send an updated
> version soon?
> Maybe it makes also sense to base my DCP patch set on yours.
> 
> Trusted Keys maintainers, what do you prefer?

Jarkko sent an email saying he is on vacation for 2 weeks.   James was
on vacation as well.   If there is something that needs immediate
attention, please let me know.

thanks,

Mimi

