Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B961E99ED
	for <lists+linux-integrity@lfdr.de>; Sun, 31 May 2020 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgEaSvJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 May 2020 14:51:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbgEaSvJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 May 2020 14:51:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04VIWdjG092282;
        Sun, 31 May 2020 14:51:02 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bkjk94fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 14:51:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04VIjfIw014617;
        Sun, 31 May 2020 18:50:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 31bf47tq3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 18:50:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04VIovKt63635696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 May 2020 18:50:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB5A11C050;
        Sun, 31 May 2020 18:50:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFA3B11C04C;
        Sun, 31 May 2020 18:50:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.218.60])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 31 May 2020 18:50:56 +0000 (GMT)
Message-ID: <1590951055.4457.104.camel@linux.ibm.com>
Subject: Re: Oops at boot with linux-next kernel with IMA boot options
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Sun, 31 May 2020 14:50:55 -0400
In-Reply-To: <s5h367jmbfe.wl-tiwai@suse.de>
References: <s5htv00m5sb.wl-tiwai@suse.de> <s5hk10wm2x3.wl-tiwai@suse.de>
         <4de686af78e94893b3578f6970d783d5@huawei.com>
         <s5hblm8lyz0.wl-tiwai@suse.de>
         <22f1132ebc9d4c2e8fc354efb1845984@huawei.com>
         <s5h367jmbfe.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_11:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 cotscore=-2147483648 clxscore=1011 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005310150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-29 at 09:45 +0200, Takashi Iwai wrote:
> On Fri, 29 May 2020 09:33:34 +0200,
> Roberto Sassu wrote:
> > 
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > On Thu, 28 May 2020 19:36:55 +0200,
> > > Roberto Sassu wrote:
> > > >
> > > > > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > > > > owner@vger.kernel.org] On Behalf Of Takashi Iwai
> > > > > On Thu, 28 May 2020 17:35:16 +0200,
> > > > > Takashi Iwai wrote:
> > > > > >
> > > > > > Hi Roberto,
> > > > > >
> > > > > > it seems that the recent changes in IMA in linux-next caused a
> > > > > > regression: namely it triggers an Oops when booting with the options
> > > > > >   ima_policy=tcb ima_template_fmt='d-ng|n-ng|d|ng'
> > > > >
> > > > > And further experiment revealed that passing only
> > > ima_template_fmt=d
> > > > > is enough for triggering the bug.  Other formats don't matter.
> > > > >
> > > > > (snip)
> > > > > > It's a KVM instance without any TPM stuff, just passed the options
> > > > > > above.  I could trigger the same bug on a bare metal, too.
> > > > > >
> > > > > > Then I performed bisection and it spotted the commit:
> > > > > > 6f1a1d103b48b1533a9c804e7a069e2c8e937ce7
> > > > > >   ima: Switch to ima_hash_algo for boot aggregate
> > > > > >
> > > > > > Actually reverting this commit fixed the Oops again.
> > > > >
> > > > > So, looking at the fact above (triggered by "d") and this bisection
> > > > > result, it seems that the issue is specific to ima_eventdigest_init().
> > > > > The difference from others is that this has a check by
> > > > > ima_template_hash_algo_allowed(), and currently the check allows only
> > > > > SHA1 and MD5, while now SHA256 is assigned as default.  So I tested
> > > > > adding SHA256 there like below, and it seems working.
> > > > >
> > > > > Hopefully I'm heading to a right direction...
> > > >
> > > > Hi Takashi
> > > >
> > > > boot_aggregate is the only entry for which there is no file descriptor.
> > > > The file descriptor is used to recalculate the digest if it is not SHA1
> > > > or MD5. For boot_aggregate, we should use instead
> > > > ima_calc_boot_aggregate(). I will provide a patch.
> > > >
> > > > I see that the .file member of event_data in
> > > > ima_add_boot_aggregate() is not initialized. Can you please try
> > > > to set .file to NULL?
> > > 
> > > Tested and it didn't help.  The field was already zero-initialized via
> > > C99-style initialization, I believe.
> > 
> > Found the issue.
> > 
> > ima_evendigest_init() returns an error and after that IMA is not
> > initialized.  Unfortunately, ima_must_appraise() does not check
> > ima_policy_flag, so the kernel crashes when ima_match_policy()
> > tries to evaluate the policy which is not loaded (ima_rules = NULL).
> > 
> > if you add at the beginning of ima_must_appraise()
> > 
> > if (!ima_policy_flag)
> > 	return 0;
> > 
> > the kernel should not crash.
> 
> Confirmed.  The patch below fixed the Oops.
> When you cook up a proper patch with that change, feel free to put my
> tested-by tag
>   Reported-and-tested-by: Takashi Iwai <tiwai@suse.de>

Thank you for finding this bug.  In this case, the "d" field has to be
limited to md5 or sha1 as the field is not large enough for other
algorithms.  Just as the IMA Kconfig and the "ima_template=" boot
command line option prevent enabling a sha256 hash with the original
"ima" template, the "ima_template_fmt=" boot command line option
similarly needs to prevent a 'd' field being defined with a larger
digest.  Failing to set the new template format should revert to using
the builtin default definition.

thanks,

Mimi
