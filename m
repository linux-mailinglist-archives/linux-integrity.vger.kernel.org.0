Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81AE6552DC
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Dec 2022 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiLWQfW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Dec 2022 11:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiLWQfV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Dec 2022 11:35:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903997665;
        Fri, 23 Dec 2022 08:35:19 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNGBmpR032063;
        Fri, 23 Dec 2022 16:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PfQSkw6LKfTK+fTmuS94j+ceGqqKRN0iidwhRw+9kDc=;
 b=LOufLniM6nrAZWmnU8TttAKGrg/VqYTv2cNxoT7/GGDwiMumQFsoEBYxsf3u26kj+qk4
 LW2r9C6CFV/brVlPEFKJgJZIFpWs21kgZuzcUDDmapN4/nzIez6EtEB7IDLwBqiOjsTo
 XI/B93tl9rj4mOOpZcRCzBEyS683BaXGpFYyQqCsYpvfCx8nI868iMfmN+R6ZAkpdnX2
 kR0Eto92fEUwDfW4uzypzxjY0lf0eT7FKs3vPPLNkZ3jKNjGteUPSM09kcfrtssFubAI
 poKo84RPK/g3pIB3x8h77dXFobUiDPv3ziKEq3FBuGKXpU5fj+SyriUOTtcNP6Wb1XDu yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mnfmu0h9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 16:34:41 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BNGCGJ8002512;
        Fri, 23 Dec 2022 16:34:40 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mnfmu0h5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 16:34:40 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNFKYmA026646;
        Fri, 23 Dec 2022 16:34:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3mh6ywjgpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 16:34:36 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BNGYZsD59834854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 16:34:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4ABB58052;
        Fri, 23 Dec 2022 16:34:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82D275804E;
        Fri, 23 Dec 2022 16:34:34 +0000 (GMT)
Received: from sig-9-65-251-3.ibm.com (unknown [9.65.251.3])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Dec 2022 16:34:34 +0000 (GMT)
Message-ID: <c2b4054c32a24e83186a953ef6e1e3e85aec603b.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Coiby Xu <coxu@redhat.com>,
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
Date:   Fri, 23 Dec 2022 11:34:34 -0500
In-Reply-To: <D1BF8D7B-F9E4-4C87-9288-534F3AE38ECF@oracle.com>
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
         <0fb737ab42ef093f7031a80c8a73f582b1d5c1ae.camel@linux.ibm.com>
         <6AAEC343-E581-4355-ABD8-FE32A1BD16D8@oracle.com>
         <4ac6b5bd1b57bfc0c548e5711e46b341fd5cfe39.camel@linux.ibm.com>
         <D1BF8D7B-F9E4-4C87-9288-534F3AE38ECF@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mIL0NngRIhnhHafVEhsuG5Qoq8oSvlc6
X-Proofpoint-ORIG-GUID: cKH-IdIeF_f79rREGCcp2cbA7X51oQpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_06,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212230138
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-12-23 at 16:13 +0000, Eric Snowberg wrote:
> 
> > On Dec 22, 2022, at 8:41 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2022-12-22 at 15:15 +0000, Eric Snowberg wrote:
> >> 
> >>> On Dec 21, 2022, at 12:01 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Wed, 2022-12-21 at 18:27 +0000, Eric Snowberg wrote:
> >>>> 
> >>>>> On Dec 18, 2022, at 5:21 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>> 
> >>>>> On Fri, 2022-12-16 at 22:06 +0800, Coiby Xu wrote:
> >>>>>> Hi Eric and Mimi,
> >>>>>> 
> >>>>>> On Thu, Dec 15, 2022 at 09:45:37PM +0000, Eric Snowberg wrote:
> >>>>>>> 
> >>>>>>> 
> >>>>>>>>>>>>> A CA cert shall be defined as any X509 certificate that contains the
> >>>>>>>>>>>>> keyCertSign key usage and has the CA bit set to true.
> >>>>>>>>>>>> 
> >>>>>>>>>>>> Hi Eric,
> >>>>>>>>>>>> 
> >>>>>>>>>>>> Allowing CA certificates with the digitalSignature key usage flag
> >>>>>>>>>>>> enabled defeats the purpose of the new Kconfig.  Please update the
> >>>>>>>>>>>> above definition to exclude the digitalSignature key usage flag and
> >>>>>>>>>>>> modify the code accordingly.
> >>>>>>>>>>> 
> >>>>>>>>>>> Within v2, the request was made to allow Intermediate CA certificates to be
> >>>>>>>>>>> loaded directly.  The Intermediate CA referenced was the one used by kernel.org.
> >>>>>>>>>>> This Intermediate CA contains both digitalSignature and keyCertSign.  If the code
> >>>>>>>>>>> is changed to exclude this certificate, now the root CA has to be loaded again.  Is that
> >>>>>>>>>>> the intent?
> >>>>>>>>>> 
> >>>>>>>>>> That definitely was not the intent.  Nor would it address the issue of
> >>>>>>>>>> a particular intermediate CA certificate having both keyCertSign and
> >>>>>>>>>> digitalSignature.
> >>>>>>>>> 
> >>>>>>>>> Sorry, I’m not following.  Why is it an issue that an intermediate CA certificate contains
> >>>>>>>>> both keyCertSign and digitalSignature? Why would we want to exclude an Intermediate
> >>>>>>>>> CA cert like the one used on kernel.org?
> >>>>>>>> 
> >>>>>>>> I must be missing something.  Isn't the purpose of "keyUsage" to
> >>>>>>>> minimize how a certificate may be used?   Why would we want the same
> >>>>>>>> certificate to be used for both certificate signing and code signing?
> >>>>>>> 
> >>>>>>> Every 3rd party intermediate CA I have looked at so far contains both set. Most have CRLSign set.
> >>>>>>> Typically the root CA contains keyCertSign and CRLSign, but some also have digitalSignature
> >>>>>>> set.  Finding a 3rd party Intermediate CA without digitalSignature set is probably going to be
> >>>>>>> challenging and will severely limit usage.
> >>>>>> 
> >>>>>> How about allowing both keyCertSign and digitalSignature asserted but
> >>>>>> issuing a warning for this case?
> >>>>>> 
> >>>>>> Here's my rationale for this proposal.
> >>>>>> 
> >>>>>> I assume we should conform to some X.509 specifications. So I checked
> >>>>>> "RFC 5280: Internet X.509 Public Key Infrastructure Certificate and
> >>>>>> Certificate Revocation List (CRL) Profile" [1] and ITU-T X.509 (2012-10)
> >>>>>> [2].
> >>>>>> 
> >>>>>> [1] states in 4.2.1.3. Key Usage,
> >>>>>>  "If the keyUsage extension is present, then the subject public key
> >>>>>>  MUST NOT be used to verify signatures on certificates or CRLs unless
> >>>>>>  the corresponding keyCertSign or cRLSign bit is set.  If the subject
> >>>>>>  public key is only to be used for verifying signatures on
> >>>>>>  certificates and/or CRLs, then the digitalSignature and
> >>>>>>  nonRepudiation bits SHOULD NOT be set.  However, the digitalSignature
> >>>>>>  and/or nonRepudiation bits MAY be set in addition to the keyCertSign
> >>>>>>  and/or cRLSign bits if the subject public key is to be used to verify
> >>>>>>  signatures on certificates and/or CRLs as well as other objects."
> >>>>>> 
> >>>>>> and [2] states in 8.2.2.3 Key usage extension that,
> >>>>>> "More than one bit may be set in an instance of the keyUsage extension.
> >>>>>> The setting of multiple bits shall not change the meaning of each
> >>>>>> individual bit but shall indicate that the certificate may be used for
> >>>>>> all of the purposes indicated by the set bits. There may be risks
> >>>>>> incurred when setting multiple bits. A review of those risks is
> >>>>>> documented in Annex I."
> >>>>>> 
> >>>>>> I interpret the above texts as we should allow both keyCertSign and
> >>>>>> digitalSignature. However [2] warns about the risks of setting multiple
> >>>>>> bits. Quoting Annex I,
> >>>>>> 
> >>>>>> "Combining the contentCommitment bit in the keyUsage certificate
> >>>>>> extension with other keyUsage bits may have security implications
> >>>>>> depending on the security environment in which the certificate is to be
> >>>>>> used. If the subject's environment can be fully controlled and trusted,
> >>>>>> then there are no specific security implications. For example, in cases
> >>>>>> where the subject is fully confident about exactly which data is signed
> >>>>>> or cases where the subject is fully confident about the security
> >>>>>> characteristics of the authentication protocol being used. If the
> >>>>>> subject's environment is not fully controlled or not fully trusted, then
> >>>>>> unintentional signing of commitments is possible. Examples include the
> >>>>>> use of badly formed authentication exchanges and the use of a rogue
> >>>>>> software component. If untrusted environments are used by a subject,
> >>>>>> these security implications can be limited through use of the following
> >>>>>> measures:   
> >>>>>>  – to not combine the contentCommitment key usage setting in
> >>>>>>    certificates with any other key usage setting and to use the
> >>>>>>    corresponding private key only with this certificate;   
> >>>>>> 
> >>>>>>  – to limit the use of private keys associated with certificates that
> >>>>>>    have the contentCommitment key usage bit set, to environments which
> >>>>>>    are considered adequately controlled and trustworthy"
> >>>>>> 
> >>>>>> So maybe it's useful to add a warning if both keyCertSign and
> >>>>>> digitalSignature are asserted.
> >>>>> 
> >>>>> Coiby, thank you for adding these details.  I was hoping others would
> >>>>> chime in as well.  I agree at minimum there should be a warning.
> >>>> 
> >>>> A warning could be added.
> >>>> 
> >>>>> Perhaps instead of making INTEGRITY_CA_MACHINE_KEYRING dependent on
> >>>>> INTEGRITY_MACHINE_KEYRING, make them a Kconfig "choice" to support the
> >>>>> more restrictive certificate use case requirements:  all certificates,
> >>>>> CA certificate signing and digital signature, only CA certificate
> >>>>> signing.
> >>>> 
> >>>> As could support for additional restrictions.
> >>>> 
> >>>> Would these additions be required within this series? What is missing from this 
> >>>> discussion is why would these additions be necessary?  Why should the kernel 
> >>>> enforce a restriction that is beyond the scope of the X.509 spec?  If a warning was 
> >>>> to be added, what would be the justification for adding this additional code?  From 
> >>>> my research every single 3rd party code signing intermediate CA would be flagged 
> >>>> with the warning.  Isn’t this just going to cause confusion?  Or is there a benefit that 
> >>>> I am missing that needs to be stated?
> >>> 
> >>> You're focusing on third party kernel modules and forgetting about the
> >>> simple use case of allowing an end user (or business) to sign their own
> >>> code.  True they could use the less restrictive CA certificates, but it
> >>> is unnecessary.
> >> 
> >> My focus is on signing user-space applications, as outlined in the cover letter.  This 
> >> series has nothing to do with kernel modules.  Most end-users and businesses rely on 
> >> a third party to deal with code signing.  All third party code signing services I have 
> >> found use an intermediate CA containing more than just the keyCertSign usage set.  
> >> It seems to be an industry accepted practice that does not violate the spec. Before writing
> >> new code to either warn or exclude a third party intermediate CA,  I would like to understand 
> >> the motivation behind this request.
> > 
> > In older discussions there are comments like, "Any CA certificate, no
> > matter if it's a root or an intermediate, must have the keyCertSign
> > extension. If you want to sign a revocation list (CRL) with the CA
> > certificate as well (you usually do want that), than you have to add
> > cRLSign as well. Any other keyUsages can and should be avoided for CA
> > certificates."
> > 
> > The question as to "why" this changed to include "digitalSignature" was
> > posed here [2] with the response being for "OCSP".   It also includes a
> > link to Entrusts root and intermediate CAs with just keyCertSign and
> > cRLSign keyUsages.
> > 
> > The matchine keyring is a means of establishing a new root of trust. 
> > The motivation for further restricting CA certificates to just
> > keyCertSign and cRLSign keyUsages is to limit how the CA certificates
> > may be used.  They should not be used for code signing.
> 
> Fair enough.  If this will be viewed as justification for adding the additional 
> code, I can work on adding it.  Above you mentioned a warning would be needed 
> at a minimum and a restriction could be placed behind a Kconfig.  How about for 
> the default case I add the warning and when compiling with 
> INTEGRITY_CA_MACHINE_KEYRING the restriction will be enforced.

Sounds good to me.  To avoid misunderstandings, will there be a Kconfig
menu with 3 options?   There were a couple of other comments having to
do with variable names.  Will you address them as well?

-- 
thanks,

Mimi

