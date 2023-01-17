Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A5670D59
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 00:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjAQX1Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Jan 2023 18:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAQX0a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Jan 2023 18:26:30 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188C5084F;
        Tue, 17 Jan 2023 13:26:34 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HJtLUg006414;
        Tue, 17 Jan 2023 21:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=mTIgEIUb70Uqc/ceSLL8F8lZ4X68bD+rbf2CA97c87Y=;
 b=ghuDgZrzZ0zZNIyGR2nch+erl/pUAHrW3aZzjjSkVjjebgEhw+HB4F7gZXYnmLn0hKqd
 FwGmlfZdFXMvjK6ah7xfKVWdMT3oaT/eNC7oVKg0ja6PMFcPVehCR84E4czpBr0J5cws
 osZoqEZq6sVQzzXeXBdPV0vK82L7+upb1eTOrrL2wn8RJOIg4qhWml06uDlHJUGPT7L0
 y6SwM1phJac22ZvKmJHIiGRZtfv4EX1n0jrHazEguTxXSEvLl/E0GCGJwxPpEh+qx0OG
 u694DEi5MU46hnWRHW3D/AoQFXFhApWBg2JGYuE2/yrNiPYfoU44J017vcRoSabzPby/ Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5pehc5rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:26:20 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30HKwBiX029439;
        Tue, 17 Jan 2023 21:26:19 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5pehc5qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:26:19 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HK2HaN019324;
        Tue, 17 Jan 2023 21:26:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n3m17g612-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:26:18 +0000
Received: from b03ledav004.gho.boulder.ibm.com ([9.17.130.235])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30HLQH8K21692882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 21:26:17 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47E3A78060;
        Tue, 17 Jan 2023 23:08:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B8A37805F;
        Tue, 17 Jan 2023 23:08:25 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.128.24])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jan 2023 23:08:25 +0000 (GMT)
Message-ID: <8ef12c81acf42ea87dde8f500485412f0b9f29a2.camel@linux.ibm.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Matthew Garrett <mgarrett@aurora.tech>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Date:   Tue, 17 Jan 2023 16:26:11 -0500
In-Reply-To: <CAHSSk058UoBY2nDx8U7-siG_dbjNSKZaPukZVjSnq=f=CBSKsw@mail.gmail.com>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
         <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
         <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
         <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
         <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
         <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
         <CAHSSk058UoBY2nDx8U7-siG_dbjNSKZaPukZVjSnq=f=CBSKsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mMMNlrVlyvpgz9k2WwVb_-8pq86gj_9d
X-Proofpoint-ORIG-GUID: Q89gwD3oNzvjTTM2_it6RY4oWwj9BaT6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=421 lowpriorityscore=0 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170168
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2023-01-14 at 19:05 -0800, Matthew Garrett wrote:
> On Sat, Jan 14, 2023 at 6:55 AM James Bottomley <jejb@linux.ibm.com>
> wrote:
> > Can we go back again to why you can't use locality?  It's exactly
> > designed for this since locality is part of creation data. 
> > Currently everything only uses locality 0, so it's impossible for
> > anyone on Linux to produce a key with anything other than 0 in the
> > creation data for locality.  However, the dynamic launch people are
> > proposing that the Kernel should use Locality 2 for all its
> > operations, which would allow you to distinguish a key created by
> > the kernel from one created by a user by locality.
> > 
> > I think the previous objection was that not all TPMs implement
> > locality, but then not all laptops have TPMs either, so if you ever
> > come across one which has a TPM but no locality, it's in a very
> > similar security boat to one which has no TPM.
> 
> It's not a question of TPM support, it's a question of platform
> support. Intel chipsets that don't support TXT simply don't forward
> requests with non-0 locality. Every Windows-sticker laptop since 2014
> has shipped with a TPM, but the number that ship with TXT support is
> a very small percentage of that. I agree that locality is the obvious
> solution for a whole bunch of problems, but it's just not usable in
> the generic case.

How sure are you of this statement?  Of all the Laptops I have with
TPM2 (a sample size of 2), my old Dell XPS-13 (a 9350 bought in 2016
with a TPM 1.2 that was firmware upgraded to 2.0) has a Nuvoton TIS TPM
that doesn't respond on any locality other than 0.  However, my more
modern Inspiron 13 2-in-1 (a 7391 from 2019 recently bought
refurbished) has an Intel PTT TPM using the CRB interface and responds
fine on locality 1 and also indicates that locality in the creation
data.  Neither of these laptops has TXT nor the SMX extensions, so that
would seem to indicate your statement above isn't universal.

James

