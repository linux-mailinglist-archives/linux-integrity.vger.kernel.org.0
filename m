Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03E94B3CA4
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Feb 2022 18:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiBMRvq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Feb 2022 12:51:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiBMRvp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Feb 2022 12:51:45 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC15A0B8;
        Sun, 13 Feb 2022 09:51:39 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21DEvUKg032201;
        Sun, 13 Feb 2022 17:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ljGnu5uOYQaHl1nPo2n2pEFc0He+WiMjy0EB3bb4xVY=;
 b=CYAeo3soE6RuStkIaHmKMpNiai5cihSKV2bk3EVB+NYbRnDfew2ymWWXc204VTaFIHP5
 kofuTuaqbxmTTFucnK/su1TFMXWXkxERF6JcpmBCsm5d+76cVn7ZjuNM+zwYJ7XXq67E
 GnPERhytl/LMYAJLK6L37O4rXgKGWCcNca70huxJxH8BVyVmoEoURN4z0RH+wpEKXNSM
 syZTBzKMgA9JV1R/hmN5KV+KuOVSv1WQI0+mHivArh1+7cwsfMaLC5AfV74RWltOyEQH
 kyTHhsEm24UMi59Q9uXSLnm47Gp2gEwdJNt6v2vu3tcSUKYmvrciW/IXzlLbAPk92fUN zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7475t1x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Feb 2022 17:50:45 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21DHoi2i029058;
        Sun, 13 Feb 2022 17:50:44 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7475t1wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Feb 2022 17:50:44 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21DHlebI015751;
        Sun, 13 Feb 2022 17:50:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3e64h9et2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Feb 2022 17:50:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21DHoaW147317488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Feb 2022 17:50:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D00B4C04E;
        Sun, 13 Feb 2022 17:50:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D52074C044;
        Sun, 13 Feb 2022 17:50:31 +0000 (GMT)
Received: from sig-9-65-82-84.ibm.com (unknown [9.65.82.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 13 Feb 2022 17:50:31 +0000 (GMT)
Message-ID: <b49cb41873655f4fc1269faab5729111d55ce9da.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
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
Date:   Sun, 13 Feb 2022 12:50:31 -0500
In-Reply-To: <20220209120154.GC3113@kunlun.suse.cz>
References: <cover.1641900831.git.msuchanek@suse.de>
         <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
         <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
         <20220209120154.GC3113@kunlun.suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fz9cM9T58h_IIyXjwjjaFhI_FECO2xCo
X-Proofpoint-ORIG-GUID: Pc1fQeK8JagJOLRcr98_--QyPz-FtBn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-13_07,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202130120
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michal,

On Wed, 2022-02-09 at 13:01 +0100, Michal Suchánek wrote:
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index dea74d7717c0..1cde9b6c5987 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -560,6 +560,22 @@ config KEXEC_FILE
> > >   config ARCH_HAS_KEXEC_PURGATORY
> > >     def_bool KEXEC_FILE
> > > +config KEXEC_SIG
> > > +   bool "Verify kernel signature during kexec_file_load() syscall"
> > > +   depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > > +   help
> > > +     This option makes kernel signature verification mandatory for
> > > +     the kexec_file_load() syscall.
> > > +
> > > +     In addition to that option, you need to enable signature
> > > +     verification for the corresponding kernel image type being
> > > +     loaded in order for this to work.
> > > +
> > > +     Note: on powerpc IMA_ARCH_POLICY also implements kexec'ed kernel
> > > +     verification. In addition IMA adds kernel hashes to the measurement
> > > +     list, extends IMA PCR in the TPM, and implements kernel image
> > > +     blacklist by hash.
> > 
> > So, what is the takeaway for the user? IMA_ARCH_POLICY is preferred? What is
> > the disadvantage, and two implementations(?) needed then? More overhead?
> 
> IMA_KEXEC does more than KEXEC_SIG. The overhead is probably not big
> unless you are trying to really minimize the kernel code size.
> 
> Arguably the simpler implementation hass less potential for bugs, too.
> Both in code and in user configuration required to enable the feature.
> 
> Interestingly IMA_ARCH_POLICY depends on KEXEC_SIG rather than
> IMA_KEXEC. Just mind-boggling.

FYI, a soft boot doesn't clear the TPM PCRs.  To be able to verify the
IMA measurement list after a kexec against a TPM quote, requires
carrying the measurement list across kexec.

The "IMA_KEXEC" config enables carrying the IMA measurement list across
kexec.  It has nothing to do with verifying the appended signature. 
That is based on kernel module appended signature code.

> 
> The main problem with IMA_KEXEC from my point of view is it is not portable.
> To record the measurements TPM support is requireed which is not available on
> all platforms.

Measuring the kexec kernel image and extending the TPM with the
measurement is required for trusted boot.  Boot loaders extend the
TPM's BIOS measurements. Similarly, IMA does not require a TPM, but if
one is available the kexec kernel image measurement is extended into
the IMA measurement list.  Otherwise, IMA goes into "TPM by-pass" mode.

> It does not support PE so it cannot be used on platforms
> that use PE kernel signature format.

True.  However, a kernel image with an appended signature may be
kexec'ed, regardless of the architecture.  Because some boot loaders
don't support appended signatures, from my point of view does not make
IMA kexec support not portable.

-- 
thanks,

Mimi

