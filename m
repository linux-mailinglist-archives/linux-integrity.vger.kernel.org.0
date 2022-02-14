Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91AC4B5822
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Feb 2022 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356923AbiBNRKt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Feb 2022 12:10:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiBNRKo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Feb 2022 12:10:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0E6517E;
        Mon, 14 Feb 2022 09:10:36 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EGuNxd012523;
        Mon, 14 Feb 2022 17:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=l1qY/KEWmdOMqmt+7QpJnh4JMsoqsWK/gOpMsLH3vhU=;
 b=iOBmuVvF67xHukzHUkqyir7qEu/gzPLzycgcWIzc7esx1oZwqXQy2lYJocb/8IOyCzNJ
 JfmQDr2/AzpfN4sxXg8FoHY1ry1JGbDUMSTQv3uC+1yOt6/VHNKnGReTXRn1YeGynbm6
 YpeFn5+LCzDu0HeXDL+RrFWsmTk/3mH9r0Lgd7X7wROxKnRTXtTnkya3r5P+uDQG+lsn
 vkSHj+xkBczZq6SzMwqxlyUflVXyYuGm98NMk3ZNiDOxC8hs9uw3RZ15Mt+KHBYnp7R/
 keCirXfZuEcoG0F5/Nrh28QOFpukDJjzIKpmMxIl7F/ccChLhk6MkDzGkSdh4OXRGjnM iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4e4aus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 17:09:56 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EH8s3K012602;
        Mon, 14 Feb 2022 17:09:56 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4e4ate-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 17:09:56 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EH3ptd006254;
        Mon, 14 Feb 2022 17:09:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64h9qj1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 17:09:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EH9itQ48103784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 17:09:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B5DBA4059;
        Mon, 14 Feb 2022 17:09:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B65BA404D;
        Mon, 14 Feb 2022 17:09:39 +0000 (GMT)
Received: from sig-9-65-94-151.ibm.com (unknown [9.65.94.151])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 17:09:39 +0000 (GMT)
Message-ID: <f324d8e04e4576d01325a4cfcad939abef29821b.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Date:   Mon, 14 Feb 2022 12:09:39 -0500
In-Reply-To: <20220214155524.GN3113@kunlun.suse.cz>
References: <cover.1641900831.git.msuchanek@suse.de>
         <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
         <cff97dbe262919ff709a5ad2c4af6a702cc72a95.camel@linux.ibm.com>
         <a8d717a44e5e919676e9b1e197cac781db46da87.camel@linux.ibm.com>
         <20220214155524.GN3113@kunlun.suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U1aZDtPbNOEZaiWcjzBgyJkPBcT_272k
X-Proofpoint-ORIG-GUID: EsCqYyegF9IoZXPxKwIORY0TvjlMSVhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=916 priorityscore=1501 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-02-14 at 16:55 +0100, Michal Suchánek wrote:
> Hello,
> 
> On Mon, Feb 14, 2022 at 10:14:16AM -0500, Mimi Zohar wrote:
> > Hi Michal,
> > 
> > On Sun, 2022-02-13 at 21:59 -0500, Mimi Zohar wrote:
> > 
> > > 
> > > On Tue, 2022-01-11 at 12:37 +0100, Michal Suchanek wrote:
> > > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > > index dea74d7717c0..1cde9b6c5987 100644
> > > > --- a/arch/powerpc/Kconfig
> > > > +++ b/arch/powerpc/Kconfig
> > > > @@ -560,6 +560,22 @@ config KEXEC_FILE
> > > >  config ARCH_HAS_KEXEC_PURGATORY
> > > >         def_bool KEXEC_FILE
> > > >  
> > > > +config KEXEC_SIG
> > > > +       bool "Verify kernel signature during kexec_file_load() syscall"
> > > > +       depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > > > +       help
> > > > +         This option makes kernel signature verification mandatory for
> 
> This is actually wrong. KEXEC_SIG makes it mandatory that any signature
> that is appended is valid and made by a key that is part of the platform
> keyiring (which is also wrong, built-in keys should be also accepted).
> KEXEC_SIG_FORCE or an IMA policy makes it mandatory that the signature
> is present.

I'm aware of MODULE_SIG_FORCE, which isn't normally enabled by distros,
but enabling MODULE_SIG allows MODULE_SIG_FORCE to be enabled on the
boot command line.  In the IMA arch policies, if MODULE_SIG is enabled,
it is then enforced, otherwise an IMA "appraise" policy rule is
defined.  This rule would prevent the module_load syscall.

I'm not aware of KEXEC_SIG_FORCE.  If there is such a Kconfig, then I
assume it could work similarly.

> 
> > > > +         the kexec_file_load() syscall.
> > > 
> > > When KEXEC_SIG is enabled on other architectures, IMA does not define a
> > > kexec 'appraise' policy rule.  Refer to the policy rules in
> > > security/ima/ima_efi.c.  Similarly the kexec 'appraise' policy rule in
> 
> I suppose you mean security/integrity/ima/ima_efi.c

Yes

> 
> I also think it's misguided because KEXEC_SIG in itself does not enforce
> the signature. KEXEC_SIG_FORCE does.

Right, which is why the IMA efi policy calls set_module_sig_enforced().

> 
> > > arch/powerpc/kernel/ima_policy.c should not be defined.
> 
> I suppose you mean arch/powerpc/kernel/ima_arch.c - see above.

Sorry, yes.  

> 
> 
> Thanks for taking the time to reseach and summarize the differences.
> 
> > The discussion shouldn't only be about IMA vs. KEXEC_SIG kernel image
> > signature verification.  Let's try and reframe the problem a bit.
> > 
> > 1. Unify and simply the existing kexec signature verification so
> > verifying the KEXEC kernel image signature works irrespective of
> > signature type - PE, appended signature.
> > 
> > solution: enable KEXEC_SIG  (This patch set, with the above powerpc IMA
> > policy changes.)
> > 
> > 2. Measure and include the kexec kernel image in a log for attestation,
> > if desired.
> > 
> > solution: enable IMA_ARCH_POLICY 
> > - Powerpc: requires trusted boot to be enabled.
> > - EFI:   requires  secure boot to be enabled.  The IMA efi policy
> > doesn't differentiate between secure and trusted boot.
> > 
> > 3. Carry the kexec kernel image measurement across kexec, if desired
> > and supported on the architecture.
> > 
> > solution: enable IMA_KEXEC
> > 
> > Comparison: 
> > - Are there any differences between IMA vs. KEXEC_SIG measuring the
> > kexec kernel image?
> > 
> > One of the main differences is "what" is included in the measurement
> > list differs.  In both cases, the 'd-ng' field of the IMA measurement
> > list template (e.g. ima-ng, ima-sig, ima-modsig) is the full file hash
> > including the appended signature.  With IMA and the 'ima-modsig'
> > template, an additional hash without the appended signature is defined,
> > as well as including the appended signature in the 'sig' field.
> > 
> > Including the file hash and appended signature in the measurement list
> > allows an attestation server, for example, to verify the appended
> > signature without having to know the file hash without the signature.
> 
> I don't understand this part. Isn't the hash *with* signature always
> included, and the distinguishing part about IMA is the hash *without*
> signature which is the same irrespective of signature type (PE, appended
> xattr) and irrespective of the keyt used for signoing?

Roberto Sassu added support for IMA templates.  These are the
definitions of 'ima-sig' and 'ima-modsig'.

{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"}

d-ng: is the file hash.  With the proposed IMA support for fs-verity
digests, the 'd-ng' field may also include the fsverity digest, based
on policy.

n-ng: is the file pathname.
sig: is the file signature stored as a 'security.ima' xattr (may be
NULL).
d-modsig: is the file hash without the appended signature (may be
NULL).

FYI, changing from "module signature" to "appended signature", might
impact the template field and name.  :)

modsig: is the appended signature (May be NULL).

I really haven't looked at PE signatures, so I can't comment on them.

> 
> > Other differences are already included in the Kconfig KEXEC_SIG "Notes"
> > section.
> 
> Which besides what is already described above would be blacklisting
> specific binaries, which is much more effective if you have hashes of
> binaries without signature.

Thanks, Nayna will be happy to hear you approve.

FYI, IMA calculates the file hash once, which is then added to the IMA
measurement list, extended into the TPM (when available), used to
verify signatures, and included in the audit log.

With the KEXEC_SIG support, assuming the IMA arch policy is enabled,
the file hash would be calculated twice - once for verifying the file
signature and again for the measurement.

-- 
thanks,

Mimi

