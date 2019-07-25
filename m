Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78F74297
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 02:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfGYAg7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 20:36:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbfGYAg7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 20:36:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P0awt5103680
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 20:36:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2txwry112c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 20:36:58 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Jul 2019 01:36:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 01:36:49 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6P0amcY48955488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 00:36:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4238352050;
        Thu, 25 Jul 2019 00:36:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.197])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9A10852051;
        Thu, 25 Jul 2019 00:36:47 +0000 (GMT)
Subject: Re: ima-evm-utils:  library version
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 24 Jul 2019 20:36:36 -0400
In-Reply-To: <20190724180440.GD3726@rhlt>
References: <1563972698.4245.21.camel@linux.ibm.com>
         <20190724172801.y64bs2byyuqfsezf@altlinux.org> <20190724180440.GD3726@rhlt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072500-0016-0000-0000-00000295DABB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072500-0017-0000-0000-000032F3D225
Message-Id: <1564014996.4245.79.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250003
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-24 at 15:04 -0300, Bruno E. O. Meneguele wrote:
> On Wed, Jul 24, 2019 at 08:28:01PM +0300, Vitaly Chikunov wrote:

> > diff --git a/src/Makefile.am b/src/Makefile.am
> > index 9c037e2..b794c50 100644
> > --- a/src/Makefile.am
> > +++ b/src/Makefile.am
> > @@ -4,7 +4,7 @@ libimaevm_la_SOURCES = libimaevm.c
> >  libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
> >  # current[:revision[:age]]
> >  # result: [current-age].age.revision
> > -libimaevm_la_LDFLAGS = -version-info 0:0:0
> > +libimaevm_la_LDFLAGS = -version-info 1:0:0
> >  libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
> > 
> > Thanks,
> 
> And I also agree with his patch, changing -version-info to 1:0:0,
> bumping "current" number, since the interface was indeed changed since
> v1.1 release of ima-evm-utils.
> 
> Thanks for catching that :))

Thanks!  We'll use the libtool versioning.

Mimi

