Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059EF443AB7
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Nov 2021 02:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhKCBMB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 21:12:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhKCBMA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 21:12:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2Nqd80015165;
        Wed, 3 Nov 2021 01:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wC/XDAEIFlRB2c9Jn4fazMJtTSp9OnxnKPv/Pg/96UE=;
 b=WtEtNwyH6MgBRRRGPWVqDS10tHprHDYp6N6pwZsXGfe0hNvCdhlveVzrZDIfOeY/1sD0
 2l0KyYy+RxhOESIQO4ZLwpuQXC9XxfQHcgUGlWBQjg8I1ywv/BXFplrmRGWv+H+hvz5T
 Cs827UalZpXWonkDfLDXo9wSvrXn+qoGm56FD9qkFwXrxsaU5kbZdthIdGOJB8dD3aLY
 yo1mMGiZZedJwpZsqUEwGtW8RSgd1micE6OYxZOKjPuDR/9KCMSEv3ctCEQWu9x6glTa
 gTTT3OPYRAu2oUva1P93Gc+FEqfNvx7pj3B8oHvu1nLuPTG7Uw4mF6Sh9E1jwyzdBQmF qg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c3fd1137q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 01:09:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A316xwv024229;
        Wed, 3 Nov 2021 01:09:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3c0wajgdjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 01:09:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A319FI853084652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Nov 2021 01:09:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B61145204E;
        Wed,  3 Nov 2021 01:09:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.118])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 35FF252051;
        Wed,  3 Nov 2021 01:09:15 +0000 (GMT)
Message-ID: <0d393b10f0d4f273500d49a51fa5fb726a07c022.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] travis: use alt:sisyphus from docker.io
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Date:   Tue, 02 Nov 2021 21:09:14 -0400
In-Reply-To: <50ed73cbfd1def4ee94b810f6194a633bbdebb31.camel@linux.ibm.com>
References: <20211102231742.191215-1-zohar@linux.ibm.com>
         <20211102232354.a7y64ogsjs23beja@altlinux.org>
         <50ed73cbfd1def4ee94b810f6194a633bbdebb31.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PAXC64wzfivOTQFp4aq9GEGUQqaD11tt
X-Proofpoint-ORIG-GUID: PAXC64wzfivOTQFp4aq9GEGUQqaD11tt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Tue, 2021-11-02 at 20:32 -0400, Mimi Zohar wrote:
> On Wed, 2021-11-03 at 02:23 +0300, Vitaly Chikunov wrote:
> > Mimi,
> > 
> > On Tue, Nov 02, 2021 at 07:17:42PM -0400, Mimi Zohar wrote:
> > > Instead of returning an image, it prompts for a response.  Hardcode
> > > to use docker.io.
> > > 
> > >  Please select an image:
> > >   ▸ docker.io/library/alt:sisyphus
> > >     quay.io/alt:sisyphus
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  .travis.yml | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/.travis.yml b/.travis.yml
> > > index 42853e16bfee..3836befe0bae 100644
> > > --- a/.travis.yml
> > > +++ b/.travis.yml
> > > @@ -68,7 +68,7 @@ matrix:
> > >            compiler: gcc
> > >  
> > >          - os: linux
> > > -          env: DISTRO=alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
> > > +          env: REPO="docker.io/library" DISTRO=${REPO}/alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
> > 
> > I wonder why podman is used in this case.
> 
> We were seeing issues on Alpine, Fedora, and Alt. Changing to podman
> fixed them.  For example on Alt, we started seeing the following, but
> openssl-gost was installed. [1] 
> 
> + control openssl-gost
> control: No such facility: openssl-gost 
> 
> I've reverted the commit, but I don't have access to the public travis.
> I've asked Stefan to trigger travis and am waiting for the results.

All three are still failing, but differently than before [2].

Mimi

> 
> [1] 
> https://app.travis-ci.com/github/stefanberger/ima-evm-utils/jobs/545999661
[2] 
https://app.travis-ci.com/github/stefanberger/ima-evm-utils/builds/241072887


