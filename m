Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D103477B2
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCXLuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 07:50:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhCXLtl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 07:49:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OBWhpK113204;
        Wed, 24 Mar 2021 07:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=lBxmDA7MuKweF3JwhXrTSJHf/f7JzzygdAsAv7FV0W0=;
 b=rYaIQPEkyNRZUu9z8ZlR9oCkZIGY2US7JF3eDg6AO4+wLou4gzBMrtbLQ8j3Jre2p7+P
 JEp7TMI1p1r8f902CUSAgbNzzFMlpc+1fcvNq57rPNOZFb9XYBDYopZjRJSCFSpS1bXa
 ApodXB3CbMTjvBr2l2vBzze79wXnXqtXC9hxONTDidAc9lbziwOEu02BlUiEMbk+YE/h
 zVcOtiGIIO8kCNlLnJkV2fmofB2vNN0lIy7f3q/yuwudKdPtTQp/hae8cHu3oRPK7pLg
 6VzQkWymH8sNxZfVQV8KNWrqsRjNFbkhuTMtBHUyfIcROlJSzzr2GedecTKA5ZSj+a55 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fuu9e2gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 07:49:34 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12OBY7nS116427;
        Wed, 24 Mar 2021 07:49:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fuu9e2g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 07:49:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12OBl3Kx019177;
        Wed, 24 Mar 2021 11:49:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 37d9bmm9r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 11:49:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12OBnTUg39321964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 11:49:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6345AA4054;
        Wed, 24 Mar 2021 11:49:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB2F1A405C;
        Wed, 24 Mar 2021 11:49:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.72.148])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Mar 2021 11:49:25 +0000 (GMT)
Message-ID: <ca2b63a47c2910072397d41448c46293750456f7.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Wed, 24 Mar 2021 07:49:17 -0400
In-Reply-To: <CACT4Y+Y+wzPytH7hMAn3O6zT0p2D4UyQwDbuKbUqc4REzPECkw@mail.gmail.com>
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
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_08:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=907 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-24 at 12:37 +0100, Dmitry Vyukov wrote:
> On Wed, Mar 24, 2021 at 12:21 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2021/03/24 20:10, Mimi Zohar wrote:
> > > On Wed, 2021-03-24 at 19:10 +0900, Tetsuo Handa wrote:
> > >> On 2021/03/24 1:13, Mimi Zohar wrote:
> > >>> On Wed, 2021-03-24 at 00:14 +0900, Tetsuo Handa wrote:
> > >>>> On 2021/03/23 23:47, Mimi Zohar wrote:
> > >>>>> Initially I also questioned making "integrity" an LSM.  Perhaps it's
> > >>>>> time to reconsider.   For now, it makes sense to just fix the NULL
> > >>>>> pointer dereferencing.
> > >>>>
> > >>>> Do we think calling panic() as "fix the NULL pointer dereferencing" ?
> > >>>
> > >>> Not supplying "integrity" as an "lsm=" option is a user error.  There
> > >>> are only two options - allow or deny the caller to proceed.   If the
> > >>> user is expecting the integrity subsystem to be properly working,
> > >>> returning a NULL and allowing the system to boot (RFC patch version)
> > >>> does not make sense.   Better to fail early.
> > >>
> > >> What does the "user" mean? Those who load the vmlinux?
> > >> Only the "root" user (so called administrators)?
> > >> Any users including other than "root" user?
> > >>
> > >> If the user means those who load the vmlinux, that user is explicitly asking
> > >> for disabling "integrity" for some reason. In that case, it is a bug if
> > >> booting with "integrity" disabled is impossible.
> > >>
> > >> If the user means something other than those who load the vmlinux,
> > >> is there a possibility that that user (especially non "root" users) is
> > >> allowed to try to use "integrity" ? If processes other than global init
> > >> process can try to use "integrity", wouldn't it be a DoS attack vector?
> > >> Please explain in the descripotion why calling panic() does not cause
> > >> DoS attack vector.
> > >
> > > User in this case, is anyone rebooting the system and is intentionally
> > > changing the default values, dropping the "integrity" option on the
> > > boot command line.
> >
> > OK. Then, I expect that the system boots instead of calling panic().
> > That user is explicitly asking for disabling "integrity" for some reason.
> 
> That was actually my intention. The prebuilt kernel that I use for
> things has all LSMs enabled, but then I needed to try some workload
> with only 1 specific LSM, so I gave a different lsm= argument.

IMA/EVM is dependent on "integrity".  Was your intention to also
disable IMA and EVM?  If so, when disabling "integrity", don't load an
IMA policy.

Mimi

