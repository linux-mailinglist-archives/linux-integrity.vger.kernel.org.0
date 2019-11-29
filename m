Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0099110DA62
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Nov 2019 21:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfK2UF3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Nov 2019 15:05:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727040AbfK2UF3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Nov 2019 15:05:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATK23gC007032;
        Fri, 29 Nov 2019 15:05:20 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wjym5bx1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 15:05:20 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xATK5CCg004672;
        Fri, 29 Nov 2019 20:05:19 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 2wevd7pgmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 20:05:19 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xATK5Imu30671340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Nov 2019 20:05:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CFF5B2066;
        Fri, 29 Nov 2019 20:05:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CC21B2064;
        Fri, 29 Nov 2019 20:05:17 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.134.245])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Nov 2019 20:05:16 +0000 (GMT)
Message-ID: <1575057916.6220.7.camel@linux.ibm.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.
From:   James Bottomley <jejb@linux.ibm.com>
To:     "Zhao, Shirley" <shirley.zhao@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Date:   Fri, 29 Nov 2019 12:05:16 -0800
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_07:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-11-29 at 01:40 +0000, Zhao, Shirley wrote:
> Hi, James, 
> 
> Maybe the TPM command confused you. 

Well you did seem to be saying we had a problem in the TPM sealed key
subsystem.

> The question is I use keyctl command sealed a trusted key with PCR
> policy, but load it failed after reboot. 
> I don't know why it was loaded failed. I use TPM command to help find
> it, it report policy check failed. 

Right, so your question seems to be why after a reboot, the TPM policy
no longer works to authorize the key even from user space?  My best
guess would be the PCR value you've sealed it to changed over the
reboot for some reason.

> So my question is how to load the PCR policy sealed trusted key
> correctly?

You have to set the sealing release policy to something you know will
be invariant across reboots for an unseal to happen reliably.  However,
usually you also want the unseal to fail if something you don't like
changes, so you set the policy to be something that's invariant unless
that happens.  Not really knowing what your conditions are we can't
really tell you what your policy should look like.

> How to use policydigest and policyhandle correctly. 

I've no real idea how the tpm2_ commands work, but the tsspolicy
commands all have man pages which do a pretty good explanation.  If I
infer how your tpm2_ commands seem to be working, I think
you're sealing to a pcr7 hash?  pcr7 is the one that's supposed to
measure the secure boot path and properties and as such shouldn't
change across reboots, so I think your problem becomes finding out why
it changed.

James

