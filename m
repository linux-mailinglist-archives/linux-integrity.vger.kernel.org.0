Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1521300C
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2019 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfECOZJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 10:25:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727891AbfECOZJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 10:25:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43EMioh109463
        for <linux-integrity@vger.kernel.org>; Fri, 3 May 2019 10:25:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8mtb6y98-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 May 2019 10:25:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 May 2019 15:25:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 15:25:02 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x43EP1Nv40763456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 14:25:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1AAFA4067;
        Fri,  3 May 2019 14:25:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EE52A405B;
        Fri,  3 May 2019 14:25:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.126])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 May 2019 14:25:00 +0000 (GMT)
Subject: Re: [PATCH] kexec_buffer measure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        prakhar srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Date:   Fri, 03 May 2019 10:24:49 -0400
In-Reply-To: <5490e443-b3ea-876e-a6b3-6a91005afe61@I-love.SAKURA.ne.jp>
References: <CAEFn8qKkXgxUKtribbtFwvG9NykGQo10jQ5Du_i9wJz-wKreOA@mail.gmail.com>
         <1555978681.4914.305.camel@linux.ibm.com>
         <1556812101.4134.28.camel@linux.ibm.com>
         <7af61ebe-28a8-799c-fe47-d72f247494ed@schaufler-ca.com>
         <5490e443-b3ea-876e-a6b3-6a91005afe61@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050314-0020-0000-0000-00000338F15E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050314-0021-0000-0000-0000218B7E8A
Message-Id: <1556893489.4754.45.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-05-03 at 09:53 +0900, Tetsuo Handa wrote:
> On 2019/05/03 1:28, Casey Schaufler wrote:
> > On 5/2/2019 8:48 AM, Mimi Zohar wrote:
> >> [Cc'ing Paul, John, Casey]
> >>
> >> On Mon, 2019-04-22 at 20:18 -0400, Mimi Zohar wrote:
> >>> [Cc'ing LSM mailing list]
> >>>
> >>> On Fri, 2019-04-19 at 17:30 -0700, prakhar srivastava wrote:
> >>>
> >>>> 2) Adding a LSM hook
> >>>> We are doing both the command line and kernel version measurement in IMA.
> >>>> Can you please elaborate on how this can be used outside of the scenario?
> >>>> That will help me come back with a better design and code. I am
> >>>> neutral about this.
> >>> As I said previously, initially you might want to only measure the
> >>> kexec boot command line, but will you ever want to verify or audit log
> >>> the boot command line hash? Perhaps LSMs would be interested in the
> >>> boot command line. Should this be an LSM hook?
> >>   From an LSM perspective, is there any interest in the boot command line?
> > 
> > I can imagine an LSM that cares about the command line,
> > but I don't have interest in it for any work I have in progress.
> > 
> 
> Since the kernel command line controls which LSMs to enable, I doubt that
> an LSM which cares about the command line can detect that the kernel command
> line was tampered when the kernel command line was tampered...

As the subject line indicates, this is the kexec boot command line.

This wouldn't be any different than the existing
kernel_read_file_from_fd() and security_kernel_load_data() calls in
kernel/kexec_file.c and  kernel/kexec.c, which provides the LSMs an
opportunity to comment on the kexec image and initramfs.

Mimi

