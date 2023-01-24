Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5367982D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 13:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjAXMiq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 07:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjAXMip (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 07:38:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2237B7D;
        Tue, 24 Jan 2023 04:38:29 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OC1lmh001235;
        Tue, 24 Jan 2023 12:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=la4YFSxXOheE6TzxwQqP3ufcbSsJu2d3J+0QKvARdUA=;
 b=Wm5oAfHgvTjJqjhG2IwBuOz/c2q+xWwpchqHD3qZfCjwaFWhMy+7o91tiGMuXZ8Ov4ty
 rKpYlVUT8s6u0C6K1BK1fR9qumKy6BoSQ0XC/YsPXNuplMn/Tvtj9qUZf4erEB0+icNh
 +0iOKdYgobjic1x1NHeun7AqAvwpWnR5ErISYAiGPCqamUf7pYysTw95z3fZYMb4D0F1
 WAE7LcMjoCobuYBSYS6MERH8VMpy2d2tBMFAG9b4ZrV3/h52YdAb8k1la4xGRbglxnX5
 SjQqZ5F68AvjnRCF2hQIiFS5W0E2V37iQNzkKCvV9GmGBq7QJNotr84RAxQzeKs6ktNl ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg0mec8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:38:13 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30OBuxcG000304;
        Tue, 24 Jan 2023 12:38:12 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg0meba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:38:12 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBfIqt006849;
        Tue, 24 Jan 2023 12:38:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7a1vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:38:10 +0000
Received: from b03ledav004.gho.boulder.ibm.com ([9.17.130.235])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OCc9tJ10486320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:38:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1AC97805E;
        Tue, 24 Jan 2023 14:24:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1B0F7805C;
        Tue, 24 Jan 2023 14:24:56 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.163.35.100])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 14:24:56 +0000 (GMT)
Message-ID: <5fb9193be57d22131feecf8b39dffbb03af3f60a.camel@linux.ibm.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     William Roberts <bill.c.roberts@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, linux-pm@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Date:   Tue, 24 Jan 2023 07:38:04 -0500
In-Reply-To: <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
         <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
         <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
         <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
         <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
         <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
         <Y8tcEtr8Kl3p4qtA@kernel.org>
         <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W6lhHVrCJEXLOG1WcinsU_3DsgBdNAVC
X-Proofpoint-GUID: TTPoKd1_ay6imEY8KQ5opjuTd2SWTtph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-23 at 11:48 -0600, William Roberts wrote:
> On Fri, Jan 20, 2023 at 9:29 PM Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> > 
> > On Sat, Jan 14, 2023 at 09:55:37AM -0500, James Bottomley wrote:
> > > On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > > > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > > > <bill.c.roberts@gmail.com> wrote:
> > > > 
> > > > > What's the use case of using the creation data and ticket in
> > > > > this context? Who gets the creationData and the ticket?
> > > > > Could a user supplied outsideInfo work? IIRC I saw some
> > > > > patches flying around where the sessions will get encrypted
> > > > > and presumably correctly as well. This would allow the
> > > > > transfer of that outsideInfo, like the NV Index PCR value to
> > > > > be included and integrity protected by the session HMAC.
> > > > 
> > > > The goal is to ensure that the key was generated by the kernel.
> > > > In the absence of the creation data, an attacker could generate
> > > > a hibernation image using their own key and trick the kernel
> > > > into resuming arbitrary code. We don't have any way to pass
> > > > secret data from the hibernate kernel to the resume kernel, so
> > > > I don't think there's any easy way to do it with outsideinfo.
> > > 
> > > Can we go back again to why you can't use locality?  It's exactly
> > > designed for this since locality is part of creation data. 
> > > Currently everything only uses locality 0, so it's impossible for
> > > anyone on Linux to produce a key with anything other than 0 in
> > > the creation data for locality.  However, the dynamic launch
> > > people are proposing that the Kernel should use Locality 2 for
> > > all its operations, which would allow you to distinguish a key
> > > created by the kernel from one created by a user by locality.
> > > 
> > > I think the previous objection was that not all TPMs implement
> > > locality, but then not all laptops have TPMs either, so if you
> > > ever come across one which has a TPM but no locality, it's in a
> > > very similar security boat to one which has no TPM.
> > 
> > Kernel could try to use locality 2 and use locality 0 as fallback.
> 
> I don't think that would work for Matthew, they need something
> reliable to indicate key provenance.

No, I think it would be good enough: locality 0 means anyone (including
the kernel on a machine which doesn't function correctly) could have
created this key.  Locality 2 would mean only the kernel could have
created this key.

By the time the kernel boots and before it loads the hibernation image
it will know the answer to the question "does my TPM support locality
2", so it can use that in its security assessment: if the kernel
supports locality 2 and the key wasn't created in locality 2 then
assume an attack.  Obviously, if the kernel doesn't support locality 2
then the hibernation resume has to accept any old key, but that's the
same as the situation today.

> I was informed that all 5 localities should be supported starting
> with Gen 7 Kaby Lake launched in 2016. Don't know if this is
> still "too new".

It's probably good enough.  Current laptops which can't use locality 2
are in the same position as now, but newer ones can provide more
security guarantees.

There is, however, another wrinkle: can Kaby Lake be persuaded, though
bios settings perhaps, to shut off the non zero localities?  This would
allow for a downgrade attack where you shut off locality 2 then present
a forged locality 0 key and hibernation image; the kernel will think,
because it can't access locality 2, that it's in a reduced security
environment so the key might be OK.  We could fix this by requiring
Kaby Lake and beyond to have locality 2 and refusing to hibernate if it
can't be accessed and building "is this Kaby lake or beyond" into the
check for should I have locality 2, but this is getting complex and
error prone.

James

