Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547B578EF43
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Aug 2023 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbjHaOHP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Aug 2023 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjHaOHP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Aug 2023 10:07:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0BCC;
        Thu, 31 Aug 2023 07:07:11 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDb8Cs005930;
        Thu, 31 Aug 2023 14:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yPlMJ5m42wyobi+UPGvdq34cYd52eYMn8ZtY+zIptkc=;
 b=j4M8ep3mYvbfHrJz/VbMI3ASBcLIp8z+sX4GxyVCnzO9IidPtrjlhnV0kOabamv5FLpB
 qSfb3wysTZPVVcsW7isfrWknJCOQoLyW35zLujiOHcAYw5WHqU+NzMJ9Pw6qepTjyY02
 5vFHI4GWgc4JD85YpOS+GP+Xo6ZAE5AaJPx20FeV0lPgWc5Zgm5WnOo2hn8XuwCoZEqv
 7hK/cTxubfiDP6W7kGM7q/mEmYIdhHhoVOnQIKya7gwYEhq62swz5SDHAXzMaM4+AXzs
 /LAz/RBrBz0X8dYTdwWCRwCoNr67NYB5z1SAfSoXQ8KIPCLNiURcuZTdX7pGxa1Up+2H Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sttrskg3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 14:06:56 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37VDbaV9009021;
        Thu, 31 Aug 2023 14:06:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sttrskg33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 14:06:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37VC0s90009907;
        Thu, 31 Aug 2023 14:01:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kvqx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 14:01:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37VE1rTd23790084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 14:01:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08D75803F;
        Thu, 31 Aug 2023 14:01:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C703758056;
        Thu, 31 Aug 2023 14:01:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.247])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 31 Aug 2023 14:01:52 +0000 (GMT)
Message-ID: <99ff7c12dec73209a0a20464f3010c4c61d6c5f5.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Date:   Thu, 31 Aug 2023 10:01:52 -0400
In-Reply-To: <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
         <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
         <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
         <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
         <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
         <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
         <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
         <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
         <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
         <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
         <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
         <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
         <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
         <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
         <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
         <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
         <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y_dPvWk7cK-VwW_pFcDardfWI8sl5Byw
X-Proofpoint-ORIG-GUID: BjoB18Al30Pu10eemIYL939wCB-z5HBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-08-30 at 19:22 -0400, Paul Moore wrote:
> On Wed, Aug 30, 2023 at 7:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Wed, 2023-08-30 at 18:23 -0400, Paul Moore wrote:
> > > On Wed, Aug 30, 2023 at 6:21 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Aug 30, 2023 at 5:50 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> > > > > > On Wed, Aug 30, 2023 at 4:25 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > > Your initial question was "what happens if the file/filesystem becomes
> > > > > > > inaccessible at some point and an attestation client attempts to read
> > > > > > > the entire log?".  For what reason would it be inaccessible?  For the
> > > > > > > original single tmpfs file, what would make it inaccessible?
> > > > > >
> > > > > > In your reply that I had responded to you had mentioned that the
> > > > > > kernel was simply being passed a fd and taking ownership of it, the fd
> > > > > > could either be a tmpfs backed file or some form of persistent storage
> > > > > > as both were discussed in this thread.  I imagine a tmpfs filesystem
> > > > > > could still be forcibly unmounted, resulting in problems, but I can't
> > > > > > say that for certain.  However, there are definitely cases where a fd
> > > > > > backed against an arbitrary filesystem could run into problems:
> > > > > > storage device issues for local filesystems, networking issues for
> > > > > > network filesystems, and good old fashioned user/admin intervention in
> > > > > > both cases.
> > > > >
> > > > > "I imagine tmpfs filesystem could still be forcibly unmounted" sounds
> > > > > like an attack. Not being able to verify the measurement list against a
> > > > > quote is probably a good thing.
> > > >
> > > > Okay, can you answer the question for an arbitrary persistent
> > > > filesystem?  That was always the more important question, ...
> >
> > The original proposal, not mine, suggested using a tmpfs file.   The
> > idea of writing the measurements to a file on a persistent filesystem
> > wasn't mine either.  Sush/Tushar were pushing for writing to a
> > persistent file(s).  No argument from me that writing to a file on an
> > arbitrary persistent filesystem is not a good idea.
> 
> ...  Okay, so we all now agree that the kernel writing to an
> arbitrary filesystem is not a good idea, and using tmpfs doesn't solve
> the problem of general memory pressure (from previously in this
> thread), that's all helpful and good to clarify.

Do we also agree that the "tmpfs" solution would address the existing
design motivation - kernel memory pressure?

> 
> Assuming Sush and Tushar rework the document to clarify the
> motivation/purpose for the work, as you suggested earlier, I'm
> assuming we can revisit this problem and solutions?

In addition to the mismatch between the motivation and the design, the
design has some major flaws that first need to be addressed.

Assuming the design issues are addressed, please make sure the document
is written clearly and concisely.

-- 
thanks,

Mimi

