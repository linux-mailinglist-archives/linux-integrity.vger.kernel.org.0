Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC2C628644
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiKNQ5e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Nov 2022 11:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiKNQ5K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Nov 2022 11:57:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCFDDF5A;
        Mon, 14 Nov 2022 08:56:34 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEGsifX013866;
        Mon, 14 Nov 2022 16:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=NRteUePLdSKj1gSrgcuVkmpBrK3sxPi3psmht/X7EaI=;
 b=JrSG5Kqa8pzOriD7989Zt+/AZhHI9NFTSrPEWM/EkHci55kPwq39f5WDPxB4pVaIXw6j
 MAiPonYJlQAPEwcBtnL/WyACfFqt4U/O2/Fh3eFJyhJpZSYw7PwE3i2BO1UhyDQWcOwK
 3G+976aphlWvwPNJd8Ku56kFXEeFvF0MkFPJR8S9FsLUwWGsias3xDPRPKLVLAAdAk89
 yt3VPl5duKwPQNT6YgLWx78H8chClAaP7ChXf2bGBtC6cc6JbzUp7b81T9CjgUgWsE+Q
 FpTU4eQem1oFNJPKhF6PliIhAxtArKgrNGbe+RZHjuOKZOJ00eLrofrC4nljAdeVIivi DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kusky0143-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 16:56:16 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AEGuFrH018568;
        Mon, 14 Nov 2022 16:56:15 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kusky013n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 16:56:15 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEGqndJ023000;
        Mon, 14 Nov 2022 16:56:14 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3kt349ey55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 16:56:14 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEGuFSM38601386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 16:56:15 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6804B7805E;
        Mon, 14 Nov 2022 17:53:41 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 014E17805C;
        Mon, 14 Nov 2022 17:53:37 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.83.197])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 17:53:37 +0000 (GMT)
Message-ID: <c31d1a3af53515f2a9d3f53eb27ce698e796f9b9.camel@linux.ibm.com>
Subject: Re: [PATCH v5 04/11] security: keys: trusted: Include TPM2 creation
 data
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Evan Green <evgreen@chromium.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        gwendal@chromium.org, dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        linux-pm@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 14 Nov 2022 11:56:08 -0500
In-Reply-To: <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
         <Y3FfhrgvBNey6T7V@sol.localdomain>
         <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
         <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X0GI23TnC1DiaqQAWVSLVNgBi5h3MjkY
X-Proofpoint-ORIG-GUID: KOrFV7fnSm6JwfKjNXfhBc32eNwkHs8o
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-11-14 at 08:32 -0800, Evan Green wrote:
> On Sun, Nov 13, 2022 at 7:32 PM James Bottomley <jejb@linux.ibm.com>
> wrote:
> > 
> > On Sun, 2022-11-13 at 13:20 -0800, Eric Biggers wrote:
> > > On Fri, Nov 11, 2022 at 03:16:29PM -0800, Evan Green wrote:
> > > > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > > > b/security/keys/trusted-keys/tpm2key.asn1
> > > > index f57f869ad60068..608f8d9ca95fa8 100644
> > > > --- a/security/keys/trusted-keys/tpm2key.asn1
> > > > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > > > @@ -7,5 +7,18 @@ TPMKey ::= SEQUENCE {
> > > >         emptyAuth       [0] EXPLICIT BOOLEAN OPTIONAL,
> > > >         parent          INTEGER ({tpm2_key_parent}),
> > > >         pubkey          OCTET STRING ({tpm2_key_pub}),
> > > > -       privkey         OCTET STRING ({tpm2_key_priv})
> > > > +       privkey         OCTET STRING ({tpm2_key_priv}),
> > > > +       ---
> > > > +       --- A TPM2B_CREATION_DATA struct as returned from the
> > > > TPM2_Create command.
> > > > +       ---
> > > > +       creationData    [1] EXPLICIT OCTET STRING OPTIONAL
> > > > ({tpm2_key_creation_data}),
> > > > +       ---
> > > > +       --- A TPM2B_DIGEST of the creationHash as returned from
> > > > the
> > > > TPM2_Create
> > > > +       --- command.
> > > > +       ---
> > > > +       creationHash    [2] EXPLICIT OCTET STRING OPTIONAL
> > > > ({tpm2_key_creation_hash}),
> > > > +       ---
> > > > +       --- A TPMT_TK_CREATION ticket as returned from the
> > > > TPM2_Create command.
> > > > +       ---
> > > > +       creationTk      [3] EXPLICIT OCTET STRING OPTIONAL
> > > > ({tpm2_key_creation_tk})
> > > >         }
> > > 
> > > The commit that added this file claimed:
> > > 
> > >         "The benefit of the ASN.1 format is that it's a standard
> > > and thus the
> > >         exported key can be used by userspace tools
> > > (openssl_tpm2_engine,
> > >         openconnect and tpm2-tss-engine"
> > > 
> > > Are these new fields in compliance with whatever standard that
> > > was referring to?
> > 
> > Not really, no.  The current use case (and draft standard) is
> > already using [1] for policies and [2] for importable keys:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/doc/draft-bottomley-tpm2-keys.xml
> > 
> > I'm actually planning to use [3] for signed policies.  There's no
> > reason why you can't use [4] though.  Since the creation data, hash
> > and ticket are likely used as a job lot, it strikes me they should
> > be a single numbered optional sequence instead of individually
> > numbered, since you're unlikely to have one without the others.
> 
> Thanks, I was hoping James might pipe up and tell me what to do.
> Grouping them as a single numbered optional sequence sounds
> reasonable to me. Is your draft too far along to squeeze this in?

Not at all.  The draft only becomes frozen once I submit it to the IETF
which, so far thanks to lack of any reviewers I haven't done (That's
why I was also thinking of adding signed policies).

>  If it is and I'm on my own to draft up and submit this, I would
> definitely appreciate any pointers on getting started you might have.
> 
> I notice the draft and the code seem to be out of alignment.

The kernel code is out of alignment just because development moves a
bit slowly.  Policy based keys were submitted a long time ago as part
of the original move to interoperable sealed keys based on ASN.1:

https://lore.kernel.org/all/20200616160229.8018-7-James.Bottomley@HansenPartnership.com/

But eventually the policy part was split out and forgotten about.  I
think the only complete implementation of the draft standard is the
openssl_tpm2_engine.

>  I'm unfamiliar with this process, is the idea to get through all the
> iterations and land the standard, then fix up the code? What happens
> to existing data handed out in the old format?

No, it doesn't matter at all.  That's the whole point of using ASN.1
explicit optionals: the ASN.1 is always backwards compatible.  If I
ever submit the draft, there'll have to be a new RFC to add new
explicit optionals, but keys conforming to the old RFC will still be
valid under the new one.

Of course, since openssl_tpm2_engine is the complete reference
implementation that means I'll have to add the creation PCRs
implementation to it ... unless you'd like to do it?

Regards,

James

