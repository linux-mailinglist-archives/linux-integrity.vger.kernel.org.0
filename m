Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C62D2DCD
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 16:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgLHPEV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 10:04:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48521 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730046AbgLHPEU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 10:04:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Ewa1E035969;
        Tue, 8 Dec 2020 10:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=b2XJgiYDL+gYwfvrLP1nQ3SWXHe3EAzumbytpHb1NY8=;
 b=b1i8VkAvyKLhi4cQqHKIbu9zHFmt8WEF4DEy6WIppqsyIDgRP+3tleHlUpEkInxKBpbD
 H1QvbE9ex+u2kahDPpInmd8CMeirzriyN2dBKqjjZKEdkl+FHbs6WVs7ivuB6aarjlf3
 YUFgQ0TJL6sWny4ePm/DIk+aWTFO9Kb/pB6hOeOv1CbKLeDxo6phEOVJ/f7Jx87lwGNu
 yvO75Yie0oB/mfSPQOZFzJsD1E60TcToFN/uJHUMRco1u724rj/HfyF36UmGpewQLFAb
 uw+AF73gVTQMc8B96kno7LW7suQwGu18Y3tfib6462Z55pZuqS0y1AEAgOJ1/2Pcs+IM sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a6272wwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:03:10 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8EweGt036233;
        Tue, 8 Dec 2020 10:03:10 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a6272wt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:03:10 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8F2TTu015011;
        Tue, 8 Dec 2020 15:03:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u83npt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 15:03:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8F33TC60817676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 15:03:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A7885204F;
        Tue,  8 Dec 2020 15:03:03 +0000 (GMT)
Received: from sig-9-65-221-14.ibm.com (unknown [9.65.221.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 004A75208A;
        Tue,  8 Dec 2020 15:02:57 +0000 (GMT)
Message-ID: <ba6cd934bf7460cf6e9fc101a759a63fdd4e6e9b.camel@linux.ibm.com>
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a
 new trust source
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Elaine Palmer <erpalmerny@gmail.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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
        zgu@us.ibm.com, stefanb@us.ibm.com, NAYNA JAIN1 <naynjain@ibm.com>
Date:   Tue, 08 Dec 2020 10:02:57 -0500
In-Reply-To: <20201204153037.GC4922@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
         <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
         <81A6B61D-3811-4957-B270-52AE5FA6DE4F@gmail.com>
         <20201204153037.GC4922@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Fri, 2020-12-04 at 17:30 +0200, Jarkko Sakkinen wrote:
> On Wed, Dec 02, 2020 at 02:34:07PM -0500, gmail Elaine Palmer wrote:
> > Hi Sumit,  
> > 
> > Thank you for the detailed descriptions and examples of trust sources
> > for Trusted Keys.   A group of us in IBM (Stefan Berger, Ken Goldman,
> > Zhongshu Gu, Nayna Jain, Elaine Palmer, George Wilson, Mimi Zohar)
> > have been doing related work for quite some time, and we have one
> > primary concern and some suggested changes to the document. 
> > 
> > Our primary concern is that describing a TEE as a Trust Source needs
> > to be more specific.   For example, "ARM TrustZone" is not sufficient,
> > but "wolfSSL embedded SSL/TLS library with ARM TrustZone
> > CryptoCell-310" is.  Just because a key is protected by software
> > running in a TEE is not enough to establish trust.  Just like
> > cryptographic modules, a Trust Source should be defined as a specific
> > implementation on specific hardware with well-documented environmental
> > assumptions, dependencies, and threats.
> > 
> > In addition to the above concern, our suggested changes are inline
> > below.
> 
> In order to give a decent review comment it should have two ingredients:
> 
> - Where the existing line of code / text / whatever goes wrong.
> - How it should modified and why that makes sense. And use as plain
>   English and non-academic terms as possible, if it is documentation.
>   Further, scope is only the kernel implementation, no more or no
>   less.
> 
> "do this" is not unfortunately an argument. Feedback is welcome when
> it is supported by something common sensse.

Even after the code is fully debugged, reviewed and tested, our concern
is that people will assume the security guarantees of TEE based trusted
keys to be equivalent to that of a discrete TPM.

> 
> Some meta suggestion of related to email:
> 
> Please also use a proper email client and split your paragraphs into
> at most 80 character lines with new line characters when writing email.
> I prefer to use 72 character line length so that there's some space
> for longer email threads.

Sure, we'll re-post the suggested documentation changes/additions.

Mimi

