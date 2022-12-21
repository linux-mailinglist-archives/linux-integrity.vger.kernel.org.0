Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF73B6536C7
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Dec 2022 20:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLUTDg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Dec 2022 14:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUTDf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Dec 2022 14:03:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0223BD0;
        Wed, 21 Dec 2022 11:03:33 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLIrMu2013873;
        Wed, 21 Dec 2022 19:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6Nz8pF7gXI0gvupMhFpBmhUvXlXnNi1ResNt+nevO6g=;
 b=dJlEqbKm92T8Y4uVHRnF16BT0TwlDYKD4f4/rh7dC2lzemrfuyshBZ5gkUvb8iQTYxZf
 YWOzPFUVmeq9lY6CBnbcBjLESIVWGHGV72f+i0rTRzuUrz/q8V72EpoCEpjH8/lMO2Gp
 1PAn9h6gJGJuZpddaIrwbv2YLL0bMOmtfoiQWbib37WauL1gePFxVY6K+PA0zW9iGl6h
 pS5np00etQ7KJ/4sMK3LSksGU8vgniEFB/edm3d9DRm91i4dNSjLo/HF5PIwSC4d1ofZ
 HhWbR9OxXjRqha0qNfgUfU3g4tuGVM2eZsnA0Ffxk2H2zJOhHcSBFh5hLC8VeR/ooY9v kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mm7tr0596-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 19:01:51 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BLIrXnh015265;
        Wed, 21 Dec 2022 19:01:50 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mm7tr058x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 19:01:50 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLIaQTL032666;
        Wed, 21 Dec 2022 19:01:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3mh7004621-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 19:01:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BLJ1mRG61079990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 19:01:48 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E3CB58060;
        Wed, 21 Dec 2022 19:01:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84F9C5803F;
        Wed, 21 Dec 2022 19:01:46 +0000 (GMT)
Received: from sig-9-65-212-99.ibm.com (unknown [9.65.212.99])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Dec 2022 19:01:46 +0000 (GMT)
Message-ID: <0fb737ab42ef093f7031a80c8a73f582b1d5c1ae.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, Coiby Xu <coxu@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
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
Date:   Wed, 21 Dec 2022 14:01:46 -0500
In-Reply-To: <0DAFCFC7-29EB-4481-8FF7-616336383378@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
         <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
         <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
         <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
         <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
         <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
         <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
         <20221216140648.h32gn5qf3igorpzi@Rk>
         <2d75dfd105f8558ecd1074d64e4252ddd63b698b.camel@linux.ibm.com>
         <0DAFCFC7-29EB-4481-8FF7-616336383378@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7SxveNIS44uCRAj57-0T7fEWi0FnOrdX
X-Proofpoint-ORIG-GUID: sMeiCweWgXfOVBJ_1YVXO9jf1A1xcUkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_11,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-12-21 at 18:27 +0000, Eric Snowberg wrote:
> 
> > On Dec 18, 2022, at 5:21 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Fri, 2022-12-16 at 22:06 +0800, Coiby Xu wrote:
> >> Hi Eric and Mimi,
> >> 
> >> On Thu, Dec 15, 2022 at 09:45:37PM +0000, Eric Snowberg wrote:
> >>> 
> >>> 
> >>>>>>>>> A CA cert shall be defined as any X509 certificate that contains the
> >>>>>>>>> keyCertSign key usage and has the CA bit set to true.
> >>>>>>>> 
> >>>>>>>> Hi Eric,
> >>>>>>>> 
> >>>>>>>> Allowing CA certificates with the digitalSignature key usage flag
> >>>>>>>> enabled defeats the purpose of the new Kconfig.  Please update the
> >>>>>>>> above definition to exclude the digitalSignature key usage flag and
> >>>>>>>> modify the code accordingly.
> >>>>>>> 
> >>>>>>> Within v2, the request was made to allow Intermediate CA certificates to be
> >>>>>>> loaded directly.  The Intermediate CA referenced was the one used by kernel.org.
> >>>>>>> This Intermediate CA contains both digitalSignature and keyCertSign.  If the code
> >>>>>>> is changed to exclude this certificate, now the root CA has to be loaded again.  Is that
> >>>>>>> the intent?
> >>>>>> 
> >>>>>> That definitely was not the intent.  Nor would it address the issue of
> >>>>>> a particular intermediate CA certificate having both keyCertSign and
> >>>>>> digitalSignature.
> >>>>> 
> >>>>> Sorry, I’m not following.  Why is it an issue that an intermediate CA certificate contains
> >>>>> both keyCertSign and digitalSignature? Why would we want to exclude an Intermediate
> >>>>> CA cert like the one used on kernel.org?
> >>>> 
> >>>> I must be missing something.  Isn't the purpose of "keyUsage" to
> >>>> minimize how a certificate may be used?   Why would we want the same
> >>>> certificate to be used for both certificate signing and code signing?
> >>> 
> >>> Every 3rd party intermediate CA I have looked at so far contains both set. Most have CRLSign set.
> >>> Typically the root CA contains keyCertSign and CRLSign, but some also have digitalSignature
> >>> set.  Finding a 3rd party Intermediate CA without digitalSignature set is probably going to be
> >>> challenging and will severely limit usage.
> >> 
> >> How about allowing both keyCertSign and digitalSignature asserted but
> >> issuing a warning for this case?
> >> 
> >> Here's my rationale for this proposal.
> >> 
> >> I assume we should conform to some X.509 specifications. So I checked
> >> "RFC 5280: Internet X.509 Public Key Infrastructure Certificate and
> >> Certificate Revocation List (CRL) Profile" [1] and ITU-T X.509 (2012-10)
> >> [2].
> >> 
> >> [1] states in 4.2.1.3. Key Usage,
> >>    "If the keyUsage extension is present, then the subject public key
> >>    MUST NOT be used to verify signatures on certificates or CRLs unless
> >>    the corresponding keyCertSign or cRLSign bit is set.  If the subject
> >>    public key is only to be used for verifying signatures on
> >>    certificates and/or CRLs, then the digitalSignature and
> >>    nonRepudiation bits SHOULD NOT be set.  However, the digitalSignature
> >>    and/or nonRepudiation bits MAY be set in addition to the keyCertSign
> >>    and/or cRLSign bits if the subject public key is to be used to verify
> >>    signatures on certificates and/or CRLs as well as other objects."
> >> 
> >> and [2] states in 8.2.2.3 Key usage extension that,
> >>   "More than one bit may be set in an instance of the keyUsage extension.
> >>   The setting of multiple bits shall not change the meaning of each
> >>   individual bit but shall indicate that the certificate may be used for
> >>   all of the purposes indicated by the set bits. There may be risks
> >>   incurred when setting multiple bits. A review of those risks is
> >>   documented in Annex I."
> >> 
> >> I interpret the above texts as we should allow both keyCertSign and
> >> digitalSignature. However [2] warns about the risks of setting multiple
> >> bits. Quoting Annex I,
> >> 
> >>   "Combining the contentCommitment bit in the keyUsage certificate
> >>   extension with other keyUsage bits may have security implications
> >>   depending on the security environment in which the certificate is to be
> >>   used. If the subject's environment can be fully controlled and trusted,
> >>   then there are no specific security implications. For example, in cases
> >>   where the subject is fully confident about exactly which data is signed
> >>   or cases where the subject is fully confident about the security
> >>   characteristics of the authentication protocol being used. If the
> >>   subject's environment is not fully controlled or not fully trusted, then
> >>   unintentional signing of commitments is possible. Examples include the
> >>   use of badly formed authentication exchanges and the use of a rogue
> >>   software component. If untrusted environments are used by a subject,
> >>   these security implications can be limited through use of the following
> >>   measures:   
> >>    – to not combine the contentCommitment key usage setting in
> >>      certificates with any other key usage setting and to use the
> >>      corresponding private key only with this certificate;   
> >> 
> >>    – to limit the use of private keys associated with certificates that
> >>      have the contentCommitment key usage bit set, to environments which
> >>      are considered adequately controlled and trustworthy"
> >> 
> >> So maybe it's useful to add a warning if both keyCertSign and
> >> digitalSignature are asserted.
> > 
> > Coiby, thank you for adding these details.  I was hoping others would
> > chime in as well.  I agree at minimum there should be a warning.
> 
> A warning could be added.
> 
> > Perhaps instead of making INTEGRITY_CA_MACHINE_KEYRING dependent on
> > INTEGRITY_MACHINE_KEYRING, make them a Kconfig "choice" to support the
> > more restrictive certificate use case requirements:  all certificates,
> > CA certificate signing and digital signature, only CA certificate
> > signing.
> 
> As could support for additional restrictions.
> 
> Would these additions be required within this series? What is missing from this 
> discussion is why would these additions be necessary?  Why should the kernel 
> enforce a restriction that is beyond the scope of the X.509 spec?  If a warning was 
> to be added, what would be the justification for adding this additional code?  From 
> my research every single 3rd party code signing intermediate CA would be flagged 
> with the warning.  Isn’t this just going to cause confusion?  Or is there a benefit that 
> I am missing that needs to be stated?

You're focusing on third party kernel modules and forgetting about the
simple use case of allowing an end user (or business) to sign their own
code.  True they could use the less restrictive CA certificates, but it
is unnecessary.

-- 
thanks,

Mimi





