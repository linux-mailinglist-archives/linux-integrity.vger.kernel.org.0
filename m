Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5CC4A2DE
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfFRNzq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:55:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729161AbfFRNzp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:55:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IDoqjN095771
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jun 2019 09:55:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t6xs6f9cs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jun 2019 09:55:43 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Jun 2019 14:55:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 14:55:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5IDtaKP49086586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 13:55:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8B35A4054;
        Tue, 18 Jun 2019 13:55:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F244DA405B;
        Tue, 18 Jun 2019 13:55:34 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 13:55:34 +0000 (GMT)
Subject: Re: [PATCH] ima: dynamically allocate shash_desc
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAK8P3a1Q2JG3KBYNYgWg0_XtGUufNc6zuqcUBqiGSaBRp+au-w@mail.gmail.com>
References: <20190617115838.2397872-1-arnd@arndb.de>
         <1560786951.4072.103.camel@linux.ibm.com>
         <1560794826.4072.169.camel@linux.ibm.com>
         <CAK8P3a1Q2JG3KBYNYgWg0_XtGUufNc6zuqcUBqiGSaBRp+au-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 18 Jun 2019 08:44:38 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061813-0008-0000-0000-000002F4CB64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061813-0009-0000-0000-00002261E300
Message-Id: <1560861878.9530.17.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180113
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-17 at 22:08 +0200, Arnd Bergmann wrote:
> On Mon, Jun 17, 2019 at 8:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Mon, 2019-06-17 at 11:55 -0400, Mimi Zohar wrote:
> > > On Mon, 2019-06-17 at 13:20 +0200, Arnd Bergmann wrote:
> > > > On 32-bit ARM, we get a warning about excessive stack usage when
> > > > building with clang.
> > > >
> > > > security/integrity/ima/ima_crypto.c:504:5: error: stack frame size
> > > > of 1152 bytes in function 'ima_calc_field_array_hash' [-Werror,-
> > > > Wframe-larger-than=]
> > >
> > > I'm definitely not seeing this.  Is this problem a result of non
> > > upstreamed patches?  For sha1, currently the only possible hash
> > > algorithm, I'm seeing 664.
> 
> You won't see it with gcc, only with clang in some randconfig builds,
> I suppose only when KASAN is enabled.
> 
> > Every time a measurement is added to the measurement list, the memory
> > would be allocated/freed.  The frequency of new measurements is policy
> > dependent.  For performance reasons, I'd prefer if the allocation
> > remains on the stack.
> 
> Is there a way to preallocate the shash_desc instead? That would
> avoid the overhead.

There are 3 other SHASH_DESC_ON_STACK definitions in just
ima_crypto.c, with a total of ~55 other places in the kernel.  Before
fixing this particular function, I'd like to know if the "excessive
stack usage" warning is limited to ima_calc_field_array_hash_tfm().
 If so, what is so special about its usage of SHASH_DESC_ON_STACK?

thanks,

Mimi

