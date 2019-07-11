Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9FB65FF7
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 21:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfGKT0B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 15:26:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728102AbfGKT0B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 15:26:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BJMHUS019830
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 15:25:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp9vfkj83-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 15:25:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Jul 2019 20:25:56 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Jul 2019 20:25:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6BJPq1W35324208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 19:25:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 302B311C05B;
        Thu, 11 Jul 2019 19:25:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4290411C054;
        Thu, 11 Jul 2019 19:25:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.74])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jul 2019 19:25:51 +0000 (GMT)
Subject: Re: [PATCH v1 0/5] ima-evm-utils: Assorted fixes and improvements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Date:   Thu, 11 Jul 2019 15:25:40 -0400
In-Reply-To: <20190709154333.33345iepccstscpv@altlinux.org>
References: <20190707234837.4866-1-vt@altlinux.org>
         <1562599850.11461.43.camel@linux.ibm.com>
         <20190709154333.33345iepccstscpv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071119-0028-0000-0000-000003838A64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071119-0029-0000-0000-00002443A000
Message-Id: <1562873140.4014.90.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110212
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-07-09 at 18:43 +0300, Vitaly Chikunov wrote:
> On Mon, Jul 08, 2019 at 11:30:50AM -0400, Mimi Zohar wrote:
> > [Cc'ing Roberto, Petr, Thiago, Prakhar]
> > Now that we're including ALL the kernel exported hash_info algorithms,
> > a colleague suggested defining a list of deprecated hash algorithms.
> >  Instead of preventing the usage of these deprecated hash algorithms,
> > initially I would start out with a warning.  It would be helpful to
> > indicate which standard deprecated the hash algorithm and year.  At
> > some point, we might want to prevent their usage in signing files, but
> > not verifying file signatures.
> 
> I think this is not a problem, because user explicitly states which hash
> algorithm he wants to use. Except for SHA1, which is also silent
> fallback algorithm. I think this fallback mechanism should be removed.

I don't see a problem with informing whoever is using ima-evm-utils,
that the requested hash algorithm has been deprecated.  Just as NIST
has deprecated the use of sha1 for most usecases, certain versions of
the gost standard have also been deprecated.

Someone verifying the measurement list or the filesystem signatures
should be informed that although the verification succeeded, or not,
some of the signatures verified were based on deprecated hash
algorithms.  Maybe something along the lines of "<algorithm> hash
algorithm was deprecated (<year> - <standard>)"?  In verbose mode, the
message could include the filename.

The EVM hmac is still sha1 based, but that shouldn't affect ima-evm-
utils.  So yes we should explicitly require a valid hash algorithm and
not fall back to using sha1.

> 
> Also, return values of sign_hash/ima_calc_hash/etc are not defined
> clearly and callers have weird checks such as `if (len <= 1)`. I think
> this should be conceptually simplified and made them `return -1` on any
> error.

Agreed.  Mostly these functions are returning "-1" on error.  There
are a few places returning 1 instead.

> 
> 
> > evmctl "ima_measurement" doesn't support custom template definitions.
> > Also missing is support for verifying the "ima-buf" kexec command boot
> > command line and the "ima-modsig" template appended signature.
> > 
> > David Jacobson started writing a regression framework and posted a v2
> > version.  I'd really appreciate help with cleaning up that code. 
> 
> Maybe tests should be integrated into ima-evm-utils too.

Including regression tests in ima-evm-utils is the plan. :)

Mimi

