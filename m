Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A528964FEDA
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Dec 2022 13:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiLRMXa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Dec 2022 07:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiLRMX3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Dec 2022 07:23:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4571EB1EF;
        Sun, 18 Dec 2022 04:23:27 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BIBjpUR031124;
        Sun, 18 Dec 2022 12:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type : mime-version :
 date : content-transfer-encoding; s=pp1;
 bh=WxTmQAcu65HvZSfDdjLU4w7Z21Y7RIeLQOxcGzy0fO8=;
 b=U2YJgyi8Zgjm6PDc2OBJaqpEUQhrsEZFBKckO9IOiJ62R3g1BBsKoCKifhikZIezJlbK
 Bk6W4qHcauHgkKkGZk6rlRttCryDvUoVoin+7FsleXj8zF+cXqfoI8YIuJ06W2CtdfjZ
 6VJE/kKeRl881RCunRcqZ59IfdQYhNPT9Iy4WPf2BXbEUow06kI6rqVBgf6ZI8AwAoZk
 EIZ3vfnwSnnfBaqD6g0cGT5d7Goi1Fp1zbbaphJH8e1oqCTvhSoN+OuKDh6KDh/5/2v4
 mSFFTzT7ihAad8zz0/n8NQ6b5sgi0lnuS1l9GBV1WpvJrTIaDX5ZsN6LxTbRGVtELp7p rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mj29a8exp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Dec 2022 12:22:49 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BICMmmY009188;
        Sun, 18 Dec 2022 12:22:48 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mj29a8exd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Dec 2022 12:22:48 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BIB2SXA032709;
        Sun, 18 Dec 2022 12:22:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3mh6yy946f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Dec 2022 12:22:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BICMkbU48628026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Dec 2022 12:22:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECC355805E;
        Sun, 18 Dec 2022 12:22:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E4CC58052;
        Sun, 18 Dec 2022 12:22:44 +0000 (GMT)
Received: from sig-9-65-200-126.ibm.com (unknown [9.65.200.126])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 18 Dec 2022 12:22:44 +0000 (GMT)
Message-ID: <2d75dfd105f8558ecd1074d64e4252ddd63b698b.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
In-Reply-To: <20221216140648.h32gn5qf3igorpzi@Rk>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
         <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
         <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
         <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
         <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
         <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
         <20221216140648.h32gn5qf3igorpzi@Rk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Date:   Sun, 18 Dec 2022 07:21:33 -0500
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CgykJuAjHJKV3cQtZgITuWlpnXVrL2vc
X-Proofpoint-GUID: Zmjte6GnxXnxz1MaK9VlLUvWvnrfsDGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-18_02,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212180114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-12-16 at 22:06 +0800, Coiby Xu wrote:
> Hi Eric and Mimi,
> 
> On Thu, Dec 15, 2022 at 09:45:37PM +0000, Eric Snowberg wrote:
> >
> >
> >>>>>>> A CA cert shall be defined as any X509 certificate that contains the
> >>>>>>> keyCertSign key usage and has the CA bit set to true.
> >>>>>>
> >>>>>> Hi Eric,
> >>>>>>
> >>>>>> Allowing CA certificates with the digitalSignature key usage flag
> >>>>>> enabled defeats the purpose of the new Kconfig.  Please update the
> >>>>>> above definition to exclude the digitalSignature key usage flag and
> >>>>>> modify the code accordingly.
> >>>>>
> >>>>> Within v2, the request was made to allow Intermediate CA certificates to be
> >>>>> loaded directly.  The Intermediate CA referenced was the one used by kernel.org.
> >>>>> This Intermediate CA contains both digitalSignature and keyCertSign.  If the code
> >>>>> is changed to exclude this certificate, now the root CA has to be loaded again.  Is that
> >>>>> the intent?
> >>>>
> >>>> That definitely was not the intent.  Nor would it address the issue of
> >>>> a particular intermediate CA certificate having both keyCertSign and
> >>>> digitalSignature.
> >>>
> >>> Sorry, I’m not following.  Why is it an issue that an intermediate CA certificate contains
> >>> both keyCertSign and digitalSignature? Why would we want to exclude an Intermediate
> >>> CA cert like the one used on kernel.org?
> >>
> >> I must be missing something.  Isn't the purpose of "keyUsage" to
> >> minimize how a certificate may be used?   Why would we want the same
> >> certificate to be used for both certificate signing and code signing?
> >
> >Every 3rd party intermediate CA I have looked at so far contains both set. Most have CRLSign set.
> >Typically the root CA contains keyCertSign and CRLSign, but some also have digitalSignature
> >set.  Finding a 3rd party Intermediate CA without digitalSignature set is probably going to be
> >challenging and will severely limit usage.
> 
> How about allowing both keyCertSign and digitalSignature asserted but
> issuing a warning for this case?
> 
> Here's my rationale for this proposal.
> 
> I assume we should conform to some X.509 specifications. So I checked
> "RFC 5280: Internet X.509 Public Key Infrastructure Certificate and
> Certificate Revocation List (CRL) Profile" [1] and ITU-T X.509 (2012-10)
> [2].
> 
> [1] states in 4.2.1.3. Key Usage,
>     "If the keyUsage extension is present, then the subject public key
>     MUST NOT be used to verify signatures on certificates or CRLs unless
>     the corresponding keyCertSign or cRLSign bit is set.  If the subject
>     public key is only to be used for verifying signatures on
>     certificates and/or CRLs, then the digitalSignature and
>     nonRepudiation bits SHOULD NOT be set.  However, the digitalSignature
>     and/or nonRepudiation bits MAY be set in addition to the keyCertSign
>     and/or cRLSign bits if the subject public key is to be used to verify
>     signatures on certificates and/or CRLs as well as other objects."
> 
> and [2] states in 8.2.2.3 Key usage extension that,
>    "More than one bit may be set in an instance of the keyUsage extension.
>    The setting of multiple bits shall not change the meaning of each
>    individual bit but shall indicate that the certificate may be used for
>    all of the purposes indicated by the set bits. There may be risks
>    incurred when setting multiple bits. A review of those risks is
>    documented in Annex I."
> 
> I interpret the above texts as we should allow both keyCertSign and
> digitalSignature. However [2] warns about the risks of setting multiple
> bits. Quoting Annex I,
> 
>    "Combining the contentCommitment bit in the keyUsage certificate
>    extension with other keyUsage bits may have security implications
>    depending on the security environment in which the certificate is to be
>    used. If the subject's environment can be fully controlled and trusted,
>    then there are no specific security implications. For example, in cases
>    where the subject is fully confident about exactly which data is signed
>    or cases where the subject is fully confident about the security
>    characteristics of the authentication protocol being used. If the
>    subject's environment is not fully controlled or not fully trusted, then
>    unintentional signing of commitments is possible. Examples include the
>    use of badly formed authentication exchanges and the use of a rogue
>    software component. If untrusted environments are used by a subject,
>    these security implications can be limited through use of the following
>    measures:   
>     – to not combine the contentCommitment key usage setting in
>       certificates with any other key usage setting and to use the
>       corresponding private key only with this certificate;   
>       
>     – to limit the use of private keys associated with certificates that
>       have the contentCommitment key usage bit set, to environments which
>       are considered adequately controlled and trustworthy"
> 
> So maybe it's useful to add a warning if both keyCertSign and
> digitalSignature are asserted.

Coiby, thank you for adding these details.  I was hoping others would
chime in as well.  I agree at minimum there should be a warning.

Perhaps instead of making INTEGRITY_CA_MACHINE_KEYRING dependent on
INTEGRITY_MACHINE_KEYRING, make them a Kconfig "choice" to support the
more restrictive certificate use case requirements:  all certificates,
CA certificate signing and digital signature, only CA certificate
signing.

-- 
thanks,

Mimi

