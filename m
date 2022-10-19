Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE3360517E
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJSUqL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJSUqK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 16:46:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08ED1BBECB;
        Wed, 19 Oct 2022 13:46:08 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JKiL18025835;
        Wed, 19 Oct 2022 20:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OZYYmXwAAaTJcs67j3sz5woVZgrkwg3DHIfuoQsaoTY=;
 b=mUqoDuCBW5FCaH3Ye8TSP91kqv35u2Gt8EGPJ7bIkniCHXo3fkaJ5ZDWXAAt7N6E5nwl
 g/8cAsf3unbFl2fdry+75P6Q1ltt7nITxd5RP21eNISOeleWauDUeT8Hle30bVlfIOOl
 an8Lp3a1pZWSbE8Mlzgi2ruy/H0LBo34w+upkIs7RKx24pxO2T0GSASoCfdvsJid9z+8
 JeJv2YrZg/rB/mcgnKWa/ULVB9drKCHRC2UxyrEUjaBGphEsiU/BYYgBkbCtnYubyn8R
 U9WJBnPHemf+UJY1cTNECOaGpo/zYHfcwy4HuBmlKO2RGNJ6obKjTOT4dAqSsyS9VsaR nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3karhf00pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 20:45:46 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29JKjk2t028743;
        Wed, 19 Oct 2022 20:45:46 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3karhf00p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 20:45:46 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JKaHmQ019808;
        Wed, 19 Oct 2022 20:45:45 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3k7mgae3x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 20:45:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JKjhZ24915882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 20:45:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AB7E5805A;
        Wed, 19 Oct 2022 20:45:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6A9A58062;
        Wed, 19 Oct 2022 20:45:41 +0000 (GMT)
Received: from sig-9-65-252-68.ibm.com (unknown [9.65.252.68])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 20:45:41 +0000 (GMT)
Message-ID: <ffa58bb09df15a9debc45aaf0ed51f2b34f5c225.camel@linux.ibm.com>
Subject: Re: [PATCH 2/9] security: Move trivial IMA hooks into LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Petr Vorel <pvorel@suse.cz>, Borislav Petkov <bp@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 19 Oct 2022 16:45:41 -0400
In-Reply-To: <202210191134.FC646AFC71@keescook>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-2-keescook@chromium.org>
         <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com>
         <202210191134.FC646AFC71@keescook>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yc9wwnH8LHfvfIzfDgr0U6yQxHdwWzvL
X-Proofpoint-ORIG-GUID: sUzXrkXA6kmj3CCcXLZ_bhEP7tQy_BZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_12,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-10-19 at 11:59 -0700, Kees Cook wrote:
> On Wed, Oct 19, 2022 at 10:34:48AM -0400, Mimi Zohar wrote:
> > On Thu, 2022-10-13 at 15:36 -0700, Kees Cook wrote:
> > > This moves the trivial hard-coded stacking of IMA LSM hooks into the
> > > existing LSM infrastructure.
> > 
> > The only thing trivial about making IMA and EVM LSMs is moving them to
> > LSM hooks.  Although static files may be signed and the signatures
> > distributed with the file data through the normal distribution
> > mechanisms (e.g. RPM), other files cannot be signed remotely (e.g.
> > configuration files).  For these files, both IMA and EVM may be
> > configured to maintain persistent file state stored as security xattrs
> > in the form of security.ima file hashes or security.evm HMACs.  The LSM
> > flexibility of enabling/disabling IMA or EVM on a per boot basis breaks
> > this usage, potentially preventing subsequent boots.
> 
> I'm not suggesting IMA and EVM don't have specific behaviors that need to
> be correctly integrated into the LSM infrastructure. In fact, I spent a
> lot of time designing that infrastructure to be flexible enough to deal
> with these kinds of things. (e.g. plumbing "enablement", etc.) As I
> mentioned, this was more of trying to provide a head-start on the
> conversion. I don't intend to drive this -- please take whatever is
> useful from this example and use it. :) I'm happy to help construct any
> missing infrastructure needed (e.g. LSM_ORDER_LAST, etc).
> 
> As for preventing subsequent boots, this is already true with other LSMs
> that save state that affects system behavior (like SELinux tags, AppArmor
> policy). IMA and EVM are not special in that regard conceptually.

> Besides, it also looks like it's already possible to boot with IMA or EVM
> disabled ("ima_appraise=off", or "evm=fix"), so there's no regression
> conceptually for having "integrity" get dropped from the lsm= list at
> boot. And if you want it not to be silent disabling, that's fine --
> just panic during initialization if "integrity" is disabled, as is
> already happening.

Being able to specify "ima_appraise=" on the boot command line requires
IMA_APPRAISE_BOOTPARAM to be configured.  Even when specified, if the
system is booted with secure-boot mode enabled, it also cannot be
modified.   With the ability of randomly enabling/disabling LSMs, these
protections are useless.

> 
> Note that, generally speaking, LSMs have three initialization points:
> LSM init, fs_initcall, and late_initcall:

IMA initialization is deferred to late_initcall to allow the TPM to
finish initializing.  It doesn't make a difference when the iint_cache
is initialized.  It just needs to be prior to IMA/EVM initializiation.

> 
> $ grep -R _initcall security/*/ | wc -l
> 31
> 
> This, again, isn't different for IMA or EVM. The LSM infrastructure is
> about gathering and standardizing the requirements needed to run security
> hooks in a common way. The goal isn't to break IMA/EVM -- anything
> needed can be created for it. The goal is to remove _exceptions_ to the
> common hook mechanism.
> 
> BTW, are there examples of how to test an IMA/EVM system? I couldn't
> find any pre-existing test images one can boot in QEMU, or instructions
> on how to create such an image, but I could have missed it.

There are specific tests in LTP, kselftests, and ima-evm-utils, but
they are incomplete.

