Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC72E443A68
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Nov 2021 01:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKCAfR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 20:35:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhKCAfQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 20:35:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A30Lh2M016070;
        Wed, 3 Nov 2021 00:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H1Ue9uXgYDBGx0VOePwq7GTS3v2uq6B/XZEfRI/rlMI=;
 b=gDK2oNVGt0saskZuvOFkjyspm0Z3ESAhsamofad+IpQCB/1hyEu0J2b9AiaT8OcOv+kg
 i3WN9qiiPSmNsgZg4p/+Dy8hhNmMeVfsZdWK37xkxvtoEwaUYm2ThyGYdnalUnW3CpsJ
 riyrHi8OBnOv7u8lTGPBRhQIBydNTCdGQP0JRViaaenyHeJafHKGH/EgokeRI7UBxd9a
 il8FPx5YsXxVjFp0bjkCYX3N7SWp+Vp4NfNt3eyn2KnpmsuM5q/SVL9IBoKE7Yp88Jy9
 lHqiBJXrTCCtq5Si1+ZuZsRGPRZhgjh+FHjXIQbOU6tYTgty+O1yc5xsMpCiibxkXtBJ Kg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c3ftk84ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 00:32:36 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A30HXh6020782;
        Wed, 3 Nov 2021 00:32:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3c0wajppta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 00:32:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A30Q73L65995172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Nov 2021 00:26:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6F5442042;
        Wed,  3 Nov 2021 00:32:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19BD24204B;
        Wed,  3 Nov 2021 00:32:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.118])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Nov 2021 00:32:30 +0000 (GMT)
Message-ID: <50ed73cbfd1def4ee94b810f6194a633bbdebb31.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] travis: use alt:sisyphus from docker.io
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Date:   Tue, 02 Nov 2021 20:32:30 -0400
In-Reply-To: <20211102232354.a7y64ogsjs23beja@altlinux.org>
References: <20211102231742.191215-1-zohar@linux.ibm.com>
         <20211102232354.a7y64ogsjs23beja@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RhdR-S1uhDePVZFa5ofrcT9dt1qIsQzu
X-Proofpoint-ORIG-GUID: RhdR-S1uhDePVZFa5ofrcT9dt1qIsQzu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-11-03 at 02:23 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Nov 02, 2021 at 07:17:42PM -0400, Mimi Zohar wrote:
> > Instead of returning an image, it prompts for a response.  Hardcode
> > to use docker.io.
> > 
> >  Please select an image:
> >   ▸ docker.io/library/alt:sisyphus
> >     quay.io/alt:sisyphus
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  .travis.yml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/.travis.yml b/.travis.yml
> > index 42853e16bfee..3836befe0bae 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -68,7 +68,7 @@ matrix:
> >            compiler: gcc
> >  
> >          - os: linux
> > -          env: DISTRO=alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
> > +          env: REPO="docker.io/library" DISTRO=${REPO}/alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
> 
> I wonder why podman is used in this case.

We were seeing issues on Alpine, Fedora, and Alt. Changing to podman
fixed them.  For example on Alt, we started seeing the following, but
openssl-gost was installed. [1] 

+ control openssl-gost
control: No such facility: openssl-gost 

I've reverted the commit, but I don't have access to the public travis.
I've asked Stefan to trigger travis and am waiting for the results.

Mimi

[1] 
https://app.travis-ci.com/github/stefanberger/ima-evm-utils/jobs/545999661

