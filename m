Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72B23A867
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHCOaD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 10:30:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgHCOaD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 10:30:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073E3XLq158955;
        Mon, 3 Aug 2020 10:29:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32pkeuj17k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 10:29:57 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 073E3pN3160931;
        Mon, 3 Aug 2020 10:29:57 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32pkeuj16t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 10:29:57 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 073EKJOe009524;
        Mon, 3 Aug 2020 14:29:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32n0182985-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 14:29:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073ETq1X27001098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 14:29:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3FD11C04A;
        Mon,  3 Aug 2020 14:29:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53A8011C050;
        Mon,  3 Aug 2020 14:29:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.52.50])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Aug 2020 14:29:51 +0000 (GMT)
Message-ID: <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Mon, 03 Aug 2020 10:29:50 -0400
In-Reply-To: <20200803130755.GA30440@dell5510>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
         <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
         <20200731201808.GA27841@dell5510>
         <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
         <20200731210653.p5m4efy52melqwgs@altlinux.org>
         <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
         <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
         <20200803130755.GA30440@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_13:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030106
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-03 at 15:07 +0200, Petr Vorel wrote:
> Hi all,
> 
> > On Fri, 2020-07-31 at 18:32 -0400, Mimi Zohar wrote:
> > > > - Or even better, Bionic (which is supported by Travis) should have
> > > >   gost-engine already in the libengine-gost-openssl1.1 package.
> > > >   In that case `.travis.yml` should have `dist: bionic`.
> > > >     https://docs.travis-ci.com/user/reference/bionic/
> > > Yes, for the internal git repo I made this change.   The internal
> > > travis support for bionic is different than the external
> > > travis.   I'll post what I have as an RFC.
> > The internal travis support on ppc defaults to using Bionic, but the
> > way of specifying it is different.
> > +os: linux-ppc64le
> >  language: C
> >  addons:
> >   apt:
> 
> @Mimi: As I wrote, I'd suggest moving to docker based travis. I can do it once
> other issues are addressed, if this setup work for your internal travis support
> as well. See examples .travis.yml [1] [2], builds: [3] [4].
> 
> Advantages are more realistic builds for distro maintainers (different libc and
> libraries versions, you can test old and new distro releases, etc), but maybe
> that's not what you want/need.
> 
> Disadvantage is that sometimes docker releases have temporary packaging related
> issues (first build in [3]; failure in first build [4] is a bug in LTP, corner
> case, which would be otherwise undiscovered a long time).

Nice!  I definitely want to move to a docker based travis.   How should
we move forward?   Should there be a 1.3.1 release now with just the
few changes in the next branch and include the existing travis branch
with changes to address Vitaly's comments?

Mimi

> 
> [1] https://github.com/linux-test-project/ltp/blob/master/.travis.yml
> [2] https://github.com/iputils/iputils/blob/master/.travis.yml
> [3] https://travis-ci.org/github/iputils/iputils/builds/714445071
> [4] https://travis-ci.org/github/linux-test-project/ltp/builds/714400199

