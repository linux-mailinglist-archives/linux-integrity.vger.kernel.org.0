Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA674D6E
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGYLsT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 07:48:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbfGYLsT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 07:48:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PBbqlT117633
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 07:48:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tyabwkwnf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 07:48:17 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Jul 2019 12:48:15 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 12:48:14 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6PBlwOV37159368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 11:47:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C03BAE055;
        Thu, 25 Jul 2019 11:48:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8777AE045;
        Thu, 25 Jul 2019 11:48:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.197])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 11:48:12 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Namespace some too generic function names
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 25 Jul 2019 07:48:01 -0400
In-Reply-To: <20190725015329.q6cu7vxtzjpfve4m@altlinux.org>
References: <20190724204204.25383-1-vt@altlinux.org>
         <1564010660.4245.76.camel@linux.ibm.com>
         <20190725015329.q6cu7vxtzjpfve4m@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072511-0028-0000-0000-00000387B774
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072511-0029-0000-0000-00002447F6C8
Message-Id: <1564055281.4245.108.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-07-25 at 04:53 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Wed, Jul 24, 2019 at 07:24:20PM -0400, Mimi Zohar wrote:
> > On Wed, 2019-07-24 at 23:42 +0300, Vitaly Chikunov wrote:
> > > Prefix `dump', `do_dump', and `params' with `ima_' to avoid colliding
> > > with other global symbols.
> > 
> > The package is named ima-evm-utils, the tool is named evmctl, and now
> > we're prefixing the global symbols with "ima".  Some of the functions,
> > like dump(), are used by both "ima" and "evm".  Aiming for some sort
> > of consistency, maybe it should be prefixed with "ima_evm", not just
> > "ima_"? 
> 
> Just ima_ is OK with me. EVM could be thought as IMA extension.

At least in the kernel, I've tried really hard to keep them as two
independent subsystems.  Does it make sense to use EVM without IMA,
probably not.  The EVM design allows for other subsystems, not only
IMA, to verify the file metdata integrity.  In fact, I heard about
some plans, relatively recently, to do so.

> Or we can use evm_ like in evmctl. Or imaevm_ (without underscore, like
> in libimaevm or imaevm.h).

There's already a lot of confusion as to what is "IMA".  Not only can
IMA be configured to store measurements, but can also be configured to
verify file signatures/hashes and audit file hashes.  Not that anyone
is looking at the naming details in this code, but I don't think we
should add to the confusion.  Could we use "imaevm_" as you suggested?

struct libimaevm_params {
        int verbose;
        int x509;
        const char *hash_algo;
        const char *keyfile;
        const char *keypass;
};

extern struct libimaevm_params ima_params;

imaevm_params?

> 
> > dump() should never have been named just "dump".  It should have at
> > least been named "hexdump".
> >  
> > > `params' is prefixed with a #define trick to avoid change in half
> > > hundred places.
> > 
> > Perhaps separate this change from the other change?
> 
> I agree to Bruno E. O. Meneguele it's better to actually rename `params'
> like other functions instead of redefining. Then all renames can go in
> one commit?

Sure.

"get_hash_algo()" can't be made static as it is being called from
hash_ima().  Could you also include renaming "get_hash_algo()" as
well?

Thanks!

Mimi

