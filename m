Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26724A4C6
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgHSRTb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 13:19:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726715AbgHSRT3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 13:19:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JH1tE6096237;
        Wed, 19 Aug 2020 13:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ETl1k4PkNPUUDtug5qEoPpaWTzLOA0df1Hj+KXmXxkg=;
 b=QD4HqGhbzXuSF+t4D17p7V9brMfnoxpHh83Os2TdwfWN6z6lxZoapxaOUr35FrKSDODO
 iCvruZRgOwohMYHSR2ZHGFPSl+TEDpfOL4+u+ClqRnUOdI4BNSFFWExF/fSxss2i8sx6
 tw/8Jw96k/XhzE4StAUqQrBOI2pKT8cBpKM54CzpYQ0vXar7uobfySFI9RhBR2m8erbo
 lN+o2VaAiAKfsFhMb8AccYBJksEmy+XRJg66TqKem6SuLt24V8uTnpAbiR2LeQlVOPOQ
 bD4PCrqwO7UGovXq9abMvKvlx0gBIbfZlltlKb2j/udc8GV8LzrSrZrvuPxiIvPGVt65 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3313kxtf2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 13:19:21 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07JH1tNG096211;
        Wed, 19 Aug 2020 13:19:21 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3313kxtf2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 13:19:21 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JHBU1d023077;
        Wed, 19 Aug 2020 17:19:20 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3304uqrxjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 17:19:20 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JHJJ8T42271008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 17:19:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 721CD124054;
        Wed, 19 Aug 2020 17:19:19 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B4CC124052;
        Wed, 19 Aug 2020 17:19:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.65.228.167])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Aug 2020 17:19:19 +0000 (GMT)
Received: (from gcwilson@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 07JHJG4G039024;
        Wed, 19 Aug 2020 13:19:16 -0400
X-Authentication-Warning: localhost.localdomain: gcwilson set sender to gcwilson@linux.ibm.com using -f
Date:   Wed, 19 Aug 2020 13:19:16 -0400
From:   George Wilson <gcwilson@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH ima-evm-utils 0/9] Docker based Travis CI builds
Message-ID: <20200819165043.GA4717@us.ibm.com>
References: <20200813182532.6931-1-pvorel@suse.cz>
 <4f205c34d7b41325c3c46e485f07bc716c917d83.camel@linux.ibm.com>
 <20200819051420.GA4455@dell5510>
 <1d6df12128a37ae6ae15b430ebd21edc372ee174.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6df12128a37ae6ae15b430ebd21edc372ee174.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_09:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 malwarescore=0 suspectscore=2 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 10:37:23AM -0400, Mimi Zohar wrote:
> On Wed, 2020-08-19 at 07:14 +0200, Petr Vorel wrote:
> > Hi Mimi,
> > 
> > > Hi Petr,
> > > On Thu, 2020-08-13 at 20:25 +0200, Petr Vorel wrote:
> > > > Hi,
> > > > we talked about Docker based Travis CI builds.
> > > > Here they are [1]. Working on it revealed few bugs, that's why they're
> > > > included.
> > > > I've resent 2 commits ("man:" prefix).
> > > > I haven't addressed Mimi's suggestion to replace ibmswtpm2 with libtmps/swtpm [2].
> > > To summarize:
> > > - Add libtpms/swtpm support
> > > - Remove debugging from travis/fedora.sh 
> > > - CentOS tss & tss2-devel issues
> > > - Petr todo's comment:
> > >   * add pgrep and pkill to _require (fix of a different commit)
> > >   * add magic constant 114 to exit codes (in tests/functions.sh)
> > >   * I'd like reuse exit codes in build.sh. I could source tests/functions.sh (they
> > >     look to be general enough, just I didn't like script in root directory depending
> > >     on it, as it's general enough for build without testing) have these constants in
> > >     separate file.
> > > swtpm: patch was posted, reviewed, and fixed.
> > Great.
> > 
> > > CentOS: Our internal Travis on ppc64 is installing both tpm2-tss-2.0.0-
> > > 4.el8.x86_64.rpm and tpm2-tss-devel-2.0.0-4.el8.x86_64.rpm on CentOS. 
> > > In general, the "boot_aggregate.test" is only run if both a software
> > > TPM and the tsseventextend exist.  If either one of them are missing,
> > > the test is skipped.  For CentOS on x86, the "boot_aggregate" would be
> > > skipped.
> > Great. BTW it'd be nice to have native non-intel builds instead of
> > cross-compilation. But, they're constantly broken on Travis CI, that's why I
> > didn't implement it (I've been testing ppc64le and s390x for several months).
> 
> Thank you!

Hi Petr,

Being under the IBM Power organization, I'd like to add my thanks for testing on
ppc64!

> 
> > 
> > > Left is Petr's "todo's" comment.  Petr, would these be additional
> > > patches on top of the existing ones or were you planning on re-posting
> > > them?   If these are additional patches, I can remove the debugging
> > > from travis/fedora.sh in patch 9/9.  Please let me know how you want to
> > > go forward.
> > Please, remove the debugging from travis/fedora.sh, I'll send additional patch.
> 
> Done.  The travis branch is now in next-testing.
> 
> thanks!
> 
> Mimi
> 
> 
> 

-- 
George Wilson
IBM Linux Technology Center
Security Development
