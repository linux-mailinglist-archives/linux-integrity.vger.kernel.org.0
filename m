Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB728D3A6
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgJMSaa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 14:30:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40731 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726899AbgJMSaa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 14:30:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DIC1Ye139402;
        Tue, 13 Oct 2020 14:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Buh8WEZ9Dyz6fZ1LSDCfXSEw1N58NvngHV+01AkzBjU=;
 b=WQpTATVRtNzec5+Vy+9gNhXRbBzn23h/ilrFJT10UkMYJ4+wVhTV9/PzBjNWp4dTDON3
 sj7W+xiNUDoS20NqeL3Exkj28mzKm29GzqJch+IMb4jDIFtKqMbemN5u6ifethbsmJJP
 RK2uW7qYNgK5YtQxknHDrwvNFFE/nUKP5BgvSzTC1cg+ubKgbSwAlrkOvrUUV8+i5Tij
 PLnbjbelfHjyCl9/shIhRIyJTD8+f7rjAo7mUcXrAz2Tw1Jw8dbSY/X+QhAY2l3iydN5
 UkCCQ3Zos00J5ap8xwLgCp/dT8UeT2aYI7izLK1iFVwBkNtXYUC6QZh2+7yVzECm6377 xQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 345ha48eu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 14:30:24 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09DIHM9p008353;
        Tue, 13 Oct 2020 18:30:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 34347gucna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 18:30:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09DIUKlG26608088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 18:30:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B12FBA4069;
        Tue, 13 Oct 2020 18:30:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD24FA406B;
        Tue, 13 Oct 2020 18:30:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.65.195])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Oct 2020 18:30:19 +0000 (GMT)
Message-ID: <27c0f78160e29076d078dfcfe22ad020a245b182.camel@linux.ibm.com>
Subject: Re: [integrity:next-integrity-testing 13/13]
 security/integrity/ima/ima_appraise.c:21:62: error: expected ')' before
 numeric constant
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Tue, 13 Oct 2020 14:30:18 -0400
In-Reply-To: <CAMj1kXH2tM5WD5Hg5ThZ5_v8MyztBCN=wQ0_H6We018jgg1RHw@mail.gmail.com>
References: <202010140256.feiUaqBx-lkp@intel.com>
         <CAMj1kXH2tM5WD5Hg5ThZ5_v8MyztBCN=wQ0_H6We018jgg1RHw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_10:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-10-13 at 20:28 +0200, Ard Biesheuvel wrote:
> On Tue, 13 Oct 2020 at 20:09, kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
> > head:   bfa46be051c194a941641c128f5e6f315f1ec232
> > commit: bfa46be051c194a941641c128f5e6f315f1ec232 [13/13] ima: defer arch_ima_get_secureboot() call to IMA init time
> > config: xtensa-allyesconfig (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?id=bfa46be051c194a941641c128f5e6f315f1ec232
> >         git remote add integrity https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> >         git fetch --no-tags integrity next-integrity-testing
> >         git checkout bfa46be051c194a941641c128f5e6f315f1ec232
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> security/integrity/ima/ima_appraise.c:21:62: error: expected ')' before numeric constant
> >       21 | core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
> >          |                                                              ^~
> >          |                                                              )
> >
> > vim +21 security/integrity/ima/ima_appraise.c
> >
> >     18
> >     19  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
> >     20  static char *ima_appraise_cmdline_default __initdata;
> >   > 21  core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
> >     22
> >
> 
> The error message is a bit misleading here, but this can be fixed by adding
> 
> #include <linux/module.h>
> 
> at the top. Let me know if I need to respin for this.

No, that's ok.  I'll just add it.

thanks!

Mimi


