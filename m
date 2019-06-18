Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1E4AA5C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfFRSxv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 14:53:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729642AbfFRSxv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 14:53:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IIm2sd113927
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jun 2019 14:53:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t75gw0e9h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jun 2019 14:53:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Jun 2019 19:53:48 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 19:53:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5IIrZ1s37093632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 18:53:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E6B542059;
        Tue, 18 Jun 2019 18:53:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 274E442057;
        Tue, 18 Jun 2019 18:53:42 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 18:53:42 +0000 (GMT)
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
Date:   Tue, 18 Jun 2019 14:53:41 -0400
In-Reply-To: <CAK8P3a0_7ocqJZHA5Zbkd4yvhQnczKJxiSrBjOUDCmzO4gAb2Q@mail.gmail.com>
References: <20190617115838.2397872-1-arnd@arndb.de>
         <1560786951.4072.103.camel@linux.ibm.com>
         <1560794826.4072.169.camel@linux.ibm.com>
         <CAK8P3a1Q2JG3KBYNYgWg0_XtGUufNc6zuqcUBqiGSaBRp+au-w@mail.gmail.com>
         <1560861878.9530.17.camel@linux.ibm.com>
         <CAK8P3a0_7ocqJZHA5Zbkd4yvhQnczKJxiSrBjOUDCmzO4gAb2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061818-0028-0000-0000-0000037B67D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061818-0029-0000-0000-0000243B72C5
Message-Id: <1560884021.9530.39.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-18 at 20:06 +0200, Arnd Bergmann wrote:
> On Tue, Jun 18, 2019 at 3:55 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Mon, 2019-06-17 at 22:08 +0200, Arnd Bergmann wrote:
> > > On Mon, Jun 17, 2019 at 8:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >
> > > > On Mon, 2019-06-17 at 11:55 -0400, Mimi Zohar wrote:
> > > > > On Mon, 2019-06-17 at 13:20 +0200, Arnd Bergmann wrote:
> > > > > > On 32-bit ARM, we get a warning about excessive stack usage when
> > > > > > building with clang.
> > > > > >
> > > > > > security/integrity/ima/ima_crypto.c:504:5: error: stack frame size
> > > > > > of 1152 bytes in function 'ima_calc_field_array_hash' [-Werror,-
> > > > > > Wframe-larger-than=]
> > > > >
> > > > > I'm definitely not seeing this.  Is this problem a result of non
> > > > > upstreamed patches?  For sha1, currently the only possible hash
> > > > > algorithm, I'm seeing 664.
> > >
> > > You won't see it with gcc, only with clang in some randconfig builds,
> > > I suppose only when KASAN is enabled.
> > >
> > > > Every time a measurement is added to the measurement list, the memory
> > > > would be allocated/freed.  The frequency of new measurements is policy
> > > > dependent.  For performance reasons, I'd prefer if the allocation
> > > > remains on the stack.
> > >
> > > Is there a way to preallocate the shash_desc instead? That would
> > > avoid the overhead.
> >
> > There are 3 other SHASH_DESC_ON_STACK definitions in just
> > ima_crypto.c, with a total of ~55 other places in the kernel.  Before
> > fixing this particular function, I'd like to know if the "excessive
> > stack usage" warning is limited to ima_calc_field_array_hash_tfm().
> >  If so, what is so special about its usage of SHASH_DESC_ON_STACK?
> 
> SHASH_DESC_ON_STACK() uses at least 512 bytes of stack
> everywhere, which is half of the warning limit for a function on
> 32 bit kernels.
> 
> With KASAN, a small redzone is put around it so we can detect out
> of bounds access to a variable that is passed by reference.
> clang makes that buffer larger than gcc, so we end up with something
> like 768 bytes for each instance of SHASH_DESC_ON_STACK().
> 
> Most other users still stay below the 1024 byte warning level though,
> because typical functions only use a few bytes of stack space.
> In case of ima_calc_field_array_hash_tfm(), the is also the buffer[]
> array of 255 bytes that gets another large redzone.
> 
> I fixed up all the (randconfig) warnings I get for arm32, arm64 and
> x86 kernels, and I think there were four to five that were because of
> SHASH_DESC_ON_STACK(). It might make sense to convert all
> three instances in ima to preallocate the descriptor if we do it for
> one of them, even when it's not actually needed.

"buffer" is only used for the original "ima" template format, which is
limited to sha1.  Rather than allocating shash, I would prefer
"buffer" be allocated, if needed, and only the first time.

Mimi

