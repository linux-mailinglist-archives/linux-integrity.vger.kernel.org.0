Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0378347820
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhCXMRs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 08:17:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233178AbhCXMRZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 08:17:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OC5M5B025409;
        Wed, 24 Mar 2021 08:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bPHeblJeSyCsQWtTH0OyaMsEht+pO1aUqrLDmYceQxw=;
 b=KS6YgQXfWRlWujqbCymaQ/c9oLpHgP+HG6wPXy7fHw8gXDlrQHdP4N3HaZBnLojPFzh4
 nojrUwCRMyv1zab4Q/AEcIxmPc3Rt1UTtLDzecFD5IJJn5XZYh/quDLwjCijTcog/7on
 rKv98nvwix/l2Npb8SEDt+S95qxroKBNwqYa3g7W7CQEOup1+gKjKPv/0sTe2zyUTrNG
 wp1Tzm2sTBS+Aln1vsV4eIL3hWlxSBXGQGxZQqyCJfU7SFrU90xhkTMaPG+A5HkOKcCf
 P3K7xR2WpkKmvFfVCgqUExtR05M63QHmEeyo5J03QaNLWV4cOS1hyAtj7z1UhoUK9eWm kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37g32kv81a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 08:17:19 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12OC5btU026858;
        Wed, 24 Mar 2021 08:17:19 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37g32kv80r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 08:17:18 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12OC7o3m028118;
        Wed, 24 Mar 2021 12:17:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rcajv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 12:17:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12OCHEWc33816888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 12:17:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E6C64204D;
        Wed, 24 Mar 2021 12:17:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28EA44204F;
        Wed, 24 Mar 2021 12:17:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.72.148])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Mar 2021 12:17:11 +0000 (GMT)
Message-ID: <f370fed01e9d341ae6e4265785ad85b83dbc889c.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Wed, 24 Mar 2021 08:17:10 -0400
In-Reply-To: <CACT4Y+YatH2MHMh5s1KJtb-5w-RvmZPtQyRZqpVk=YP=HJYMkg@mail.gmail.com>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
         <20210319200358.22816-2-zohar@linux.ibm.com>
         <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
         <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
         <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
         <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
         <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
         <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
         <3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com>
         <cc01e7b7-d685-289c-a792-fc76fabba807@i-love.sakura.ne.jp>
         <721b4f8d38b014babb0f4ae829d76014bbf7734e.camel@linux.ibm.com>
         <0a0c5cc5-0e1b-ef01-60c4-5247af2124f4@i-love.sakura.ne.jp>
         <37aeaf361bfbd800e29db761f5160f2ce1869298.camel@linux.ibm.com>
         <05ca20d0-9596-152e-4da2-1ffe28c52055@i-love.sakura.ne.jp>
         <CACT4Y+Y+wzPytH7hMAn3O6zT0p2D4UyQwDbuKbUqc4REzPECkw@mail.gmail.com>
         <ca2b63a47c2910072397d41448c46293750456f7.camel@linux.ibm.com>
         <CACT4Y+YatH2MHMh5s1KJtb-5w-RvmZPtQyRZqpVk=YP=HJYMkg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_10:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=828
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-24 at 12:58 +0100, Dmitry Vyukov wrote:
> On Wed, Mar 24, 2021 at 12:49 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Wed, 2021-03-24 at 12:37 +0100, Dmitry Vyukov wrote:
> > > On Wed, Mar 24, 2021 at 12:21 PM Tetsuo Handa
> > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > >
> > > > On 2021/03/24 20:10, Mimi Zohar wrote:
> > > > > On Wed, 2021-03-24 at 19:10 +0900, Tetsuo Handa wrote:
> > > > >> On 2021/03/24 1:13, Mimi Zohar wrote:
> > > > >>> On Wed, 2021-03-24 at 00:14 +0900, Tetsuo Handa wrote:
> > > > >>>> On 2021/03/23 23:47, Mimi Zohar wrote:
> > > > >>>>> Initially I also questioned making "integrity" an LSM.  Perhaps it's
> > > > >>>>> time to reconsider.   For now, it makes sense to just fix the NULL
> > > > >>>>> pointer dereferencing.
> > > > >>>>
> > > > >>>> Do we think calling panic() as "fix the NULL pointer dereferencing" ?
> > > > >>>
> > > > >>> Not supplying "integrity" as an "lsm=" option is a user error.  There
> > > > >>> are only two options - allow or deny the caller to proceed.   If the
> > > > >>> user is expecting the integrity subsystem to be properly working,
> > > > >>> returning a NULL and allowing the system to boot (RFC patch version)
> > > > >>> does not make sense.   Better to fail early.
> > > > >>
> > > > >> What does the "user" mean? Those who load the vmlinux?
> > > > >> Only the "root" user (so called administrators)?
> > > > >> Any users including other than "root" user?
> > > > >>
> > > > >> If the user means those who load the vmlinux, that user is explicitly asking
> > > > >> for disabling "integrity" for some reason. In that case, it is a bug if
> > > > >> booting with "integrity" disabled is impossible.
> > > > >>
> > > > >> If the user means something other than those who load the vmlinux,
> > > > >> is there a possibility that that user (especially non "root" users) is
> > > > >> allowed to try to use "integrity" ? If processes other than global init
> > > > >> process can try to use "integrity", wouldn't it be a DoS attack vector?
> > > > >> Please explain in the descripotion why calling panic() does not cause
> > > > >> DoS attack vector.
> > > > >
> > > > > User in this case, is anyone rebooting the system and is intentionally
> > > > > changing the default values, dropping the "integrity" option on the
> > > > > boot command line.
> > > >
> > > > OK. Then, I expect that the system boots instead of calling panic().
> > > > That user is explicitly asking for disabling "integrity" for some reason.
> > >
> > > That was actually my intention. The prebuilt kernel that I use for
> > > things has all LSMs enabled, but then I needed to try some workload
> > > with only 1 specific LSM, so I gave a different lsm= argument.
> >
> > IMA/EVM is dependent on "integrity".  Was your intention to also
> > disable IMA and EVM?
> 
> I think, yes... or not sure. I was trying to test a bug that requires
> a different major LSM and all minor LSMs are presumably irrelevant. I
> dropped existing lsm= arg and added something like lsm=apparmor.
> 
> > If so, when disabling "integrity", don't load an
> > IMA policy.
> 
> I don't really know what this means. I guess it simply comes from the
> image? If so, there was no easy way to avoid loading.

There are a couple of builtin IMA policies, which may be loaded on boot
by specifying on the boot command line "ima_policy=".   Unless the boot
command line "ima_policy=" option is specified, no policy will loaded.

A custom IMA policy may subsequently be loaded, normally in the
initramfs, by echo'ing the file pathname to
/sys/kernel/security/ima/policy.

Mimi

