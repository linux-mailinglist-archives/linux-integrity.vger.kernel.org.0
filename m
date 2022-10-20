Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58C605FFF
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJTMS3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 08:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJTMS2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 08:18:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B791843EE;
        Thu, 20 Oct 2022 05:18:28 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KC9DiV004673;
        Thu, 20 Oct 2022 12:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HilN0jkjDLsmNvszQyx6RX3zBM7i9SRGWjKB/R0VMbw=;
 b=GD4C3dGaC14a+5cY/iiUFZk2XMCxcNbIzCW4N5/DnGPClUkxmPTcJIXi2jgSDaNLOja6
 zWe+6ALJJJzZUmYup2KmHY9ygLcP20zKhmntcWJ94bJDXTVIDFF/7KG4OQIlRw+N+wh/
 qZlRdSnhCPdUBQ3mSkM/vgwp7ebxvCrJB1b/57aJcm2ugIR0/fuqTBSJ/9yi0LM3u5Fm
 KpX3yN/AJpYwp4UqcE6YlJYFB9VxcPV1dMU5pi8c4p0jr0PIVZH6tZu+LjLAo1rQwr22
 xrLgzWIqx+qvBI/xKJYgvum95xGaIfcr7CzUybF82RAFWXGbdjG4LTHFFI0r/zxa2hqV IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb4t5a4cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 12:17:56 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29KCAg2B009462;
        Thu, 20 Oct 2022 12:17:56 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb4t5a4bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 12:17:56 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29KC5RYS010331;
        Thu, 20 Oct 2022 12:17:55 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3k7mgbmhw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 12:17:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com ([9.208.128.131])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29KCHtwT5636620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 12:17:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 998D758063;
        Thu, 20 Oct 2022 12:17:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 689535804E;
        Thu, 20 Oct 2022 12:17:52 +0000 (GMT)
Received: from sig-9-65-203-47.ibm.com (unknown [9.65.203.47])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 12:17:52 +0000 (GMT)
Message-ID: <3eaa7e1fd74c2cdd4efe63ea8c8249666d046003.camel@linux.ibm.com>
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
Date:   Thu, 20 Oct 2022 08:17:52 -0400
In-Reply-To: <202210191639.58F18F1AA@keescook>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-2-keescook@chromium.org>
         <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com>
         <202210191134.FC646AFC71@keescook>
         <ffa58bb09df15a9debc45aaf0ed51f2b34f5c225.camel@linux.ibm.com>
         <202210191639.58F18F1AA@keescook>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X4qCPi94kqbixVxmCFCIOsrVDiK-E7aq
X-Proofpoint-ORIG-GUID: lhEivODYjn0tjV0PPqiNgpIi9cz847UW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-10-19 at 16:41 -0700, Kees Cook wrote:
> On Wed, Oct 19, 2022 at 04:45:41PM -0400, Mimi Zohar wrote:
> > On Wed, 2022-10-19 at 11:59 -0700, Kees Cook wrote:
> > > On Wed, Oct 19, 2022 at 10:34:48AM -0400, Mimi Zohar wrote:
> > > > On Thu, 2022-10-13 at 15:36 -0700, Kees Cook wrote:
> > > > > This moves the trivial hard-coded stacking of IMA LSM hooks into the
> > > > > existing LSM infrastructure.
> > > > 
> > > > The only thing trivial about making IMA and EVM LSMs is moving them to
> > > > LSM hooks.  Although static files may be signed and the signatures
> > > > distributed with the file data through the normal distribution
> > > > mechanisms (e.g. RPM), other files cannot be signed remotely (e.g.
> > > > configuration files).  For these files, both IMA and EVM may be
> > > > configured to maintain persistent file state stored as security xattrs
> > > > in the form of security.ima file hashes or security.evm HMACs.  The LSM
> > > > flexibility of enabling/disabling IMA or EVM on a per boot basis breaks
> > > > this usage, potentially preventing subsequent boots.
> > > 
> > > I'm not suggesting IMA and EVM don't have specific behaviors that need to
> > > be correctly integrated into the LSM infrastructure. In fact, I spent a
> > > lot of time designing that infrastructure to be flexible enough to deal
> > > with these kinds of things. (e.g. plumbing "enablement", etc.) As I
> > > mentioned, this was more of trying to provide a head-start on the
> > > conversion. I don't intend to drive this -- please take whatever is
> > > useful from this example and use it. :) I'm happy to help construct any
> > > missing infrastructure needed (e.g. LSM_ORDER_LAST, etc).
> > > 
> > > As for preventing subsequent boots, this is already true with other LSMs
> > > that save state that affects system behavior (like SELinux tags, AppArmor
> > > policy). IMA and EVM are not special in that regard conceptually.
> > 
> > > Besides, it also looks like it's already possible to boot with IMA or EVM
> > > disabled ("ima_appraise=off", or "evm=fix"), so there's no regression
> > > conceptually for having "integrity" get dropped from the lsm= list at
> > > boot. And if you want it not to be silent disabling, that's fine --
> > > just panic during initialization if "integrity" is disabled, as is
> > > already happening.
> > 
> > Being able to specify "ima_appraise=" on the boot command line requires
> > IMA_APPRAISE_BOOTPARAM to be configured.  Even when specified, if the
> > system is booted with secure-boot mode enabled, it also cannot be
> > modified.   With the ability of randomly enabling/disabling LSMs, these
> > protections are useless.
> 
> Sure, so let's get lsm= added to the lockdown list, etc.

I thought the move to "lsm=" was to allow different LSMs to be
enabled/disabled at run time.  Adding "lsm=" to the lockdown list
doesn't seem like the correct solution to limiting which LSMs can be
enabled/disabled at runtime.  As I recall, lockdown needs to be enabled
by userspace.

> My point is for
> us to work through each of these concerns and address them. I am not an
> IMA/EVM expert, but I do understand the LSM infrastructure deeply, so
> I'd like to help you get these changes made.

Sure

-- 
thanks,

Mimi

