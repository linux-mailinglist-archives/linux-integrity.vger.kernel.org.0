Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E80365830C
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF0NCe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 09:02:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbfF0NCe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 09:02:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RCwvS7120983
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 09:02:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcx3agtpg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 09:02:32 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Jun 2019 14:02:30 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 14:02:26 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RD2PTH58589308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 13:02:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5EF6A4064;
        Thu, 27 Jun 2019 13:02:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5D16A406D;
        Thu, 27 Jun 2019 13:02:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.20])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 13:02:24 +0000 (GMT)
Subject: Re: linux-next: Tree for Jun 26 (security/integrity/ima/)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Thu, 27 Jun 2019 09:02:14 -0400
In-Reply-To: <ee503bc1-a588-81f5-47e0-1762f590662f@infradead.org>
References: <20190626231617.1e858da3@canb.auug.org.au>
         <ee503bc1-a588-81f5-47e0-1762f590662f@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062713-0012-0000-0000-0000032CEC7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062713-0013-0000-0000-000021662A98
Message-Id: <1561640534.4101.124.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing David Howells]

On Wed, 2019-06-26 at 11:35 -0700, Randy Dunlap wrote:
> On 6/26/19 6:16 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The sparc64 builds are broken in this tree, sorry.
> > 
> > Changes since 20190625:
> > 
> 
> on x86_64:
> 
> 11 warnings like this one (in a randconfig build):
> 
>   CC      security/integrity/ima/ima_fs.o
> In file included from ../security/integrity/ima/ima.h:25:0,
>                  from ../security/integrity/ima/ima_fs.c:26:
> ../security/integrity/ima/../integrity.h:170:18: warning: ‘struct key_acl’ declared inside parameter list [enabled by default]
>            struct key_acl *acl)
>                   ^
> ../security/integrity/ima/../integrity.h:170:18: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

David, CONFIG_INTEGRITY_SIGNATURE is dependent on KEYS being enabled,
but the stub functions are not.  There's now a dependency on
key_acl().

Mimi

