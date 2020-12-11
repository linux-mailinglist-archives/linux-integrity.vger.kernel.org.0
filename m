Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2352D796A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgLKPbx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 10:31:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392580AbgLKPbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 10:31:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BBF1lBh032965;
        Fri, 11 Dec 2020 10:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dE77lBifutitPgjNq+uJQtv07f69I9KMEub6+IAdnRE=;
 b=pbBH/5aHPByyVd73OZfxHOGPzCGuoL3RAF6Tw3fy/0I72vTWENfSuNhDocYek2jJhnmI
 VkeYSZc31BgQaVDMk1Td2oPtU9+go5C7RXyA0xddPNxPT85qV0kl57plxBxBesGTfIqS
 sz7lVH8Cj4sqyXF4DexvatUl4BovS2VRGrlM/Ys/Xh2+80gesrZlMjpJ2eQYUXEJwK4w
 o2mzKLmz87j8xfHx4NZARdpD8rVKj72K9+H3QtpyRtveGPWU9l8qGQbH/hpoif10JVHX
 NIXXqs9Q3M4KiwRcC75Us9Y6Bk0+SijmcJUnhQ13QCky6Tp5iLdi8m4LkSAQ/i3J9AtY /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35catw9ahq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 10:29:18 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BBF2fWP038032;
        Fri, 11 Dec 2020 10:29:18 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35catw9afx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 10:29:18 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BBFSfN8006184;
        Fri, 11 Dec 2020 15:29:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhq6wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 15:29:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BBFTCGL16646498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 15:29:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B4E24C052;
        Fri, 11 Dec 2020 15:29:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C991C4C046;
        Fri, 11 Dec 2020 15:29:06 +0000 (GMT)
Received: from sig-9-65-201-46.ibm.com (unknown [9.65.201.46])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Dec 2020 15:29:06 +0000 (GMT)
Message-ID: <16a279eaf2c209345044c3b4e1e57e2878798940.camel@linux.ibm.com>
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a
 new trust source
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     sumit.garg@linaro.org, Elaine Palmer <erpalmerny@gmail.com>,
        jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Kenneth Goldman <kgoldman@us.ibm.com>, gcwilson@linux.ibm.com,
        zgu@us.ibm.com, stefanb@us.ibm.com, NAYNA JAIN1 <naynjain@ibm.com>,
        Zohargshu Gu <zgu@us.ibm.com>
Date:   Fri, 11 Dec 2020 10:29:05 -0500
In-Reply-To: <20201211103627.GB12091@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
         <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
         <81A6B61D-3811-4957-B270-52AE5FA6DE4F@gmail.com>
         <20201204153037.GC4922@kernel.org>
         <ba6cd934bf7460cf6e9fc101a759a63fdd4e6e9b.camel@linux.ibm.com>
         <20201208174906.GA58572@kernel.org>
         <b2465d27f3683331019c5a9b6d0856304d992a0a.camel@linux.ibm.com>
         <20201211103627.GB12091@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_02:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-12-11 at 12:36 +0200, Jarkko Sakkinen wrote:
> On Wed, Dec 09, 2020 at 11:50:19AM -0500, Mimi Zohar wrote:
> > On Tue, 2020-12-08 at 19:49 +0200, Jarkko Sakkinen wrote:
> > > On Tue, Dec 08, 2020 at 10:02:57AM -0500, Mimi Zohar wrote:
> > 
> > > > > Please also use a proper email client and split your paragraphs into
> > > > > at most 80 character lines with new line characters when writing email.
> > > > > I prefer to use 72 character line length so that there's some space
> > > > > for longer email threads.
> > > > 
> > > > Sure, we'll re-post the suggested documentation changes/additions.
> > > > 
> > > 
> > > So. Wouldn't it be a better idea to post a patch that Sumit could
> > > squash to his (and add co-developed-by tag)?
> > 
> > I just posted it on Elaine's behalf.
> >   
> 
> I responded. It's good that this feedback came as I think the whole
> thing does not have the correct label for it.

Every HW is going to want to add "trusted keys" support.   We've seen
this with Udit Agarwal's "secure keys" proposal for NXP CAAM crypto HW
accelerator.  If we go down this route to extend "trusted keys" to
support specific implementations like this one, I strongly recommend
requiring an accompaying high-level threat model.  This is similar to
how new LSMs need to comply with Documentation/security/lsm-
development.rst.

Based on Elaine's work with OCP, an example of a high-level threat
model is "Common Security Threats v1.0” (
https://www.opencompute.org/documents/common-security-threats-notes-1-pdf
 ).

thanks,

Mimi

