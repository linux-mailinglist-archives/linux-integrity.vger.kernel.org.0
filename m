Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD12D7900
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437717AbgLKPR3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 10:17:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437781AbgLKPRQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 10:17:16 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BBFA19m003243;
        Fri, 11 Dec 2020 10:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tBG/kgmrHwHHCFwPH+IjefqVYj6JhBo89wTlaxA9G4E=;
 b=nf6ejnImxPNjvQujjeQgav9/beOyHHRIiR05c93WvcPr5EXnfDEUqvVBH1tgAKmPR2tO
 jtT2ZHgd0n08yj2JT7eP21BGB2bPUClWMIcTQ+QCGhqYQQK3haE//W03Kq7Zng9q0FVz
 lI1oCl8mgAmbEBQMDNXIcho6KW9Ne5/YHMEij0LfLSNv4aRWK1hH1ZXyvjY2FDyLj5bb
 PAvtJbuGVCbsRYLw0HnHGQUmCdDMzvpMHxXB4nv9cx686iXYOWoeIbLVi2RM4IiINtkA
 P0DSyASMgw0Z/GCNzy3iWtywMSHXHHWCa+mOn8N0GWx3iNSECTMppIRXJwZ25p2AqrEB jg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35cawb0er8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 10:16:33 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BBFCT3U019902;
        Fri, 11 Dec 2020 15:16:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3581fhkre9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 15:16:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BBFGPbo62849458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 15:16:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2CD952067;
        Fri, 11 Dec 2020 15:16:24 +0000 (GMT)
Received: from sig-9-65-201-46.ibm.com (unknown [9.65.201.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BECE352054;
        Fri, 11 Dec 2020 15:16:23 +0000 (GMT)
Message-ID: <289450498f2ff2c8186d6ac72bc94f17d354e96d.camel@linux.ibm.com>
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>, sumit.garg@linaro.org,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Date:   Fri, 11 Dec 2020 10:16:22 -0500
In-Reply-To: <20201211081454.GA5262@kernel.org>
References: <20201209164249.715178-1-zohar@linux.ibm.com>
         <20201211081454.GA5262@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_03:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110099
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Response from Zohargshu Gu <zgu@us.ibm.com>, Elaine Palmer <
erpalmer@us.ibm.com>]

On Fri, 2020-12-11 at 10:14 +0200, Jarkko Sakkinen wrote:
> On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> > From: Elaine Palmer <erpalmer@us.ibm.com>
> > 
> > Update trusted key documentation with additional comparisons between
> > discrete TPMs and TEE.
> > 
> > Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
> 
> Right, so OP-TEE is not the same as TEE. I did not know this and the
> patch set does not underline this.
> 
> I re-checked the patches and none of them say explicitly that OP-TEE
> is an application living inside TEE.
> 
> This essentially means that the backend needs to be renamed as "op_tee".
> 
> All patches need to be rewritten according to this.
> 
> 
> > ---
> >  .../security/keys/trusted-encrypted.rst       | 73 +++++++++++++++++--
> >  1 file changed, 65 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> > index 16042c8ff8ae..90c02105ab89 100644
> > --- a/Documentation/security/keys/trusted-encrypted.rst
> > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > @@ -14,12 +14,14 @@ convenience, and are integrity verified.
> >  Trust Source
> >  ============
> >  
> > -Trust Source provides the source of security for the Trusted Keys, on which
> > -basis Trusted Keys establishes a Trust model with its user. A Trust Source could
> > -differ from one system to another depending on its security requirements. It
> > -could be either an off-chip device or an on-chip device. Following section
> > -demostrates a list of supported devices along with their security properties/
> > -guarantees:
> > +A trust source provides the source of security for Trusted Keys.  This
> > +section lists currently supported trust sources, along with their security
> > +considerations.  Whether or not a trust source is sufficiently safe depends
> > +on the strength and correctness of its implementation, as well as the threat
> > +environment for a specific use case.  Since the kernel doesn't know what the
> > +environment is, and there is no metric of trust, it is dependent on the
> > +consumer of the Trusted Keys to determine if the trust source is sufficiently
> > +safe.
> >  
> >    *  Root of trust for storage
> >  
> > @@ -116,6 +118,59 @@ guarantees:
> >           Provides no protection by itself, relies on the underlying platform for
> >           features such as tamper resistance.
> >  
> > +  *  Provisioning - the trust source's unique and verifiable cryptographic
> > +     identity is provisioned during manufacturing
> > +
> > +     (1) TPM
> > +
> > +         The unique and verifiable cryptographic identity is the endorsement
> > +         key (EK) or its primary seed.  A review of the generation of the EK
> > +         and its accompanying certificate is part of the Common Criteria
> > +         evaluation of the product's lifecycle processes (ALC_*).  See "TCG
> > +         Protection Profile for PC Client Specific TPM 2"
> > +
> > +     (2) TEE
> > +
> > +         A protection profile for TEEs does not yet exist.  Therefore, the
> > +         provisioning process that generates the Hardware Unique Key is not
> > +         evaluated by an independent third party and is highly dependent on
> > +         the manufacturing environment.
> 
> Comparing TPM and TEE does not make logically any sense given that TPM
> is application and TEE a platfrom.

Thanks Jarkko for the response.  The other suggestion we have is with
regard to the "on-chip versus off-chip" section.  TPM can have
different implementations. That section only covers the traditional
discrete TPMs.  However, TPM can also be an independent chip packaged
with processor, e.g., Microsoft Pluton.  TPM can also be implemented in
system firmware, e.g., Intel Platform Trust Technology (PTT).  We
suggest renaming this section "Packaging and integration" to cover
multiple chips, removable daughter cards, multi-chip modules, discrete
TPMs, fTPMs, exposed buses, etc.

Thank you. 

Zhongshu, Elaine

