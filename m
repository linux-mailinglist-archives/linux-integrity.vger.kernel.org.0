Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8110E23AB79
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHCRRK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 13:17:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbgHCRRJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 13:17:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073H3Xmg130762;
        Mon, 3 Aug 2020 13:16:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32pnn326rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:16:40 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 073H3e6c131598;
        Mon, 3 Aug 2020 13:16:40 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32pnn326ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:16:39 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 073H6frY002431;
        Mon, 3 Aug 2020 17:16:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 32n0189f41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 17:16:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073HGZbV26083630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 17:16:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB0094C04A;
        Mon,  3 Aug 2020 17:16:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F3AF4C046;
        Mon,  3 Aug 2020 17:16:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.52.50])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Aug 2020 17:16:34 +0000 (GMT)
Message-ID: <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Mon, 03 Aug 2020 13:16:32 -0400
In-Reply-To: <20200803164635.GB4914@dell5510>
References: <20200731182408.696931-6-zohar@linux.ibm.com>
         <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
         <20200731201808.GA27841@dell5510>
         <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
         <20200731210653.p5m4efy52melqwgs@altlinux.org>
         <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
         <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
         <20200803130755.GA30440@dell5510>
         <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
         <20200803164635.GB4914@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-03 at 18:46 +0200, Petr Vorel wrote:
> Hi all,
> 
> ...
> > > @Mimi: As I wrote, I'd suggest moving to docker based travis. I can do it once
> > > other issues are addressed, if this setup work for your internal travis support
> > > as well. See examples .travis.yml [1] [2], builds: [3] [4].
> > > Advantages are more realistic builds for distro maintainers (different libc and
> > > libraries versions, you can test old and new distro releases, etc), but maybe
> > > that's not what you want/need.
> > > Disadvantage is that sometimes docker releases have temporary packaging related
> > > issues (first build in [3]; failure in first build [4] is a bug in LTP, corner
> > > case, which would be otherwise undiscovered a long time).
> > Nice!  I definitely want to move to a docker based travis.   How should
> > we move forward?   Should there be a 1.3.1 release now with just the
> > few changes in the next branch and include the existing travis branch
> > with changes to address Vitaly's comments?

I left off the list TPM 2.0 --pcr support, but the kernel code for
exporting the sysfs TPM 2.0 pcrs hasn't been upstreamed yet.   I guess
we should wait for that to be upstreamed or at least queued to be
upstreamed.

> Yes, that would work for me. Travis changes aren't related to the release
> (it just needs to be published in git), let's give users the fixes.

Ok. 

> 
> Docker based setup shouldn't take long It's all about to find the dependencies
> for used distros (I usually keep them in travis/ directory [5] [6]) and agree on the
> variants (which distros, how many jobs are still meaningful, which crypto and
> TPM libraries, whether use also: clang, non-intel archs and cross-compilation).

Great!

Mimi

