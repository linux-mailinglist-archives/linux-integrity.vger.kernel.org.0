Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAD24A1DE
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHSOhh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 10:37:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbgHSOhf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 10:37:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JEWp4m133679;
        Wed, 19 Aug 2020 10:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cV6R0AbLrEU9TnQ12pP2TH02VPgzbldwX+P4BGWJMTY=;
 b=oEQ8WJWsmk6PkPsO6E8IhwikBntFPSrim2J1EZWED6JSOxVIjDztKSED2h6ZPeRylUQf
 +UCDnFnu69iejLvyCU0lJOlodD1RsV/K1Kc9MzN1rm3CQ4vFhLF8255w1C5JNHgwXV5O
 itS0X+E1E6JpBwIgwazlBe59v0CQDxe17kqNygbRMxRwhKDOnA1xzml6Yl/4llHt/ZFf
 hV+rWCjGrGltrYyVfLjGbMKXgkh9njUYEOjlZfZf7qLNfl6ddv5whgw4ugXpE/e9tlNG
 jPIImUq4CzcEjBLTmlVbCYu0k3iXPgkpFRWMlYlpUi9XOyISD55o3yqCRwg3lWDOr+Sv DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3311ydgjj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 10:37:30 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07JEZNTE142457;
        Wed, 19 Aug 2020 10:37:30 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3311ydgjgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 10:37:30 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JETuvD010060;
        Wed, 19 Aug 2020 14:37:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3313xbg31k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 14:37:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JEZuNN197288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 14:35:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 720F84204C;
        Wed, 19 Aug 2020 14:37:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BF242049;
        Wed, 19 Aug 2020 14:37:24 +0000 (GMT)
Received: from sig-9-65-250-194.ibm.com (unknown [9.65.250.194])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Aug 2020 14:37:24 +0000 (GMT)
Message-ID: <1d6df12128a37ae6ae15b430ebd21edc372ee174.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/9] Docker based Travis CI builds
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Date:   Wed, 19 Aug 2020 10:37:23 -0400
In-Reply-To: <20200819051420.GA4455@dell5510>
References: <20200813182532.6931-1-pvorel@suse.cz>
         <4f205c34d7b41325c3c46e485f07bc716c917d83.camel@linux.ibm.com>
         <20200819051420.GA4455@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_07:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=4
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 07:14 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > Hi Petr,
> > On Thu, 2020-08-13 at 20:25 +0200, Petr Vorel wrote:
> > > Hi,
> > > we talked about Docker based Travis CI builds.
> > > Here they are [1]. Working on it revealed few bugs, that's why they're
> > > included.
> > > I've resent 2 commits ("man:" prefix).
> > > I haven't addressed Mimi's suggestion to replace ibmswtpm2 with libtmps/swtpm [2].
> > To summarize:
> > - Add libtpms/swtpm support
> > - Remove debugging from travis/fedora.sh 
> > - CentOS tss & tss2-devel issues
> > - Petr todo's comment:
> >   * add pgrep and pkill to _require (fix of a different commit)
> >   * add magic constant 114 to exit codes (in tests/functions.sh)
> >   * I'd like reuse exit codes in build.sh. I could source tests/functions.sh (they
> >     look to be general enough, just I didn't like script in root directory depending
> >     on it, as it's general enough for build without testing) have these constants in
> >     separate file.
> > swtpm: patch was posted, reviewed, and fixed.
> Great.
> 
> > CentOS: Our internal Travis on ppc64 is installing both tpm2-tss-2.0.0-
> > 4.el8.x86_64.rpm and tpm2-tss-devel-2.0.0-4.el8.x86_64.rpm on CentOS. 
> > In general, the "boot_aggregate.test" is only run if both a software
> > TPM and the tsseventextend exist.  If either one of them are missing,
> > the test is skipped.  For CentOS on x86, the "boot_aggregate" would be
> > skipped.
> Great. BTW it'd be nice to have native non-intel builds instead of
> cross-compilation. But, they're constantly broken on Travis CI, that's why I
> didn't implement it (I've been testing ppc64le and s390x for several months).

Thank you!

> 
> > Left is Petr's "todo's" comment.  Petr, would these be additional
> > patches on top of the existing ones or were you planning on re-posting
> > them?   If these are additional patches, I can remove the debugging
> > from travis/fedora.sh in patch 9/9.  Please let me know how you want to
> > go forward.
> Please, remove the debugging from travis/fedora.sh, I'll send additional patch.

Done.  The travis branch is now in next-testing.

thanks!

Mimi



