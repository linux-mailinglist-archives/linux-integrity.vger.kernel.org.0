Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588C9172984
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 21:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgB0Ugo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 15:36:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729351AbgB0Ugn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 15:36:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RKTtZh098790
        for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2020 15:36:42 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yedd8tkt2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2020 15:36:42 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Feb 2020 20:36:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 20:36:39 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RKacNF51970288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 20:36:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73871A4054;
        Thu, 27 Feb 2020 20:36:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD637A4062;
        Thu, 27 Feb 2020 20:36:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.166.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 20:36:37 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Date:   Thu, 27 Feb 2020 15:36:37 -0500
In-Reply-To: <20200227153825.ywas4clc3qa76rhc@altlinux.org>
References: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
         <1582638298.10443.196.camel@linux.ibm.com>
         <fac0bebb-22ce-77f9-bac9-7ca5f76d1ca1@rosalinux.ru>
         <1582777694.10443.286.camel@linux.ibm.com>
         <20200227153825.ywas4clc3qa76rhc@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022720-0016-0000-0000-000002EAED60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022720-0017-0000-0000-0000334E238D
Message-Id: <1582835797.10443.318.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_07:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Thu, 2020-02-27 at 18:38 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Wed, Feb 26, 2020 at 11:28:14PM -0500, Mimi Zohar wrote:
> > On Wed, 2020-02-26 at 12:51 +0300, Mikhail Novosyolov wrote:
> > > Hello Mimi, thanks for feedback.
> > > 25.02.2020 16:44, Mimi Zohar пишет:
> > > > On Sun, 2020-02-16 at 14:10 +0300, Mikhail Novosyolov wrote:
> > > >> LibreSSL in most cases can be used as a drop-in replacement of OpenSSL.
> > > >> Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engine' option"
> > > >> added OpenSSL-specific functions: "engines" were removed from LibreSSL long ago.
> > > >> Instead of requiring to attach GOST support via an external library ("engine"),
> > > >> LibreSSL has build-in implementation of GOST.
> > > >
> > > > OpenSSL had a builtin support for GOST, which was dropped.  From the
> > > > OpenSSL news "Changes between 1.0.2h and 1.1.0":
> > > >
> > > >     The GOST engine was out of date and therefore it has been removed. An up
> > > >     to date GOST engine is now being maintained in an external repository.
> > > >     See:     https://wiki.openssl.org/index.php/Binaries    .  Libssl still retains
> > > >     support for GOST ciphersuites (these are only activated if a GOST engine
> > > >     is present).
> > > >
> > > > Please update the patch description to reflect the reason for OpenSSL
> > > > dropping GOST builtin support, while LibreSSL continues to build it
> > > > in.
> > 
> > > The reasons why OpenSSL decided to do it are out of my scope, I can
> > > just write that OpenSSL had GOST, then dropped it, then gost-engine
> > > appeared as an OpenSSL plugin and that LibreSSL has GOST built in
> > > and dropped engines API after forking from OpenSSL. Will it be OK?
> > 
> > The question is whether LibreSSL is using the back level version of
> > GOST that OpenSSL dropped or has it been updated?  The patch
> > description should be updated accordingly.
> 
> AFAIK, LibreSSL is using independent implementation of Streebog. It
> wasn't exist in OpenSSL before split and different from what is in
> gost-engine (also having different authors).

Thank you for the explanation.

> 
> I don't really understand reason to know implementation history, if,
> as library users, we should be enough to know they have compatible APIs.

The OpenSSL crypto team is way more experienced than me.  If LibreSSL
was using the crypto version that OpenSSL deemed too old, why should
ima-evm-utils support it?

Last year you added OpenSSL "Engine" support.  Now I'm being asked to
conditionally compile it out based on ifdefs.  As much as possible, I
prefer avoiding ifdefs.

Mimi

