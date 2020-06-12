Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D392F1F7C48
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFLROm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 13:14:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgFLROk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 13:14:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CH3xXg028194;
        Fri, 12 Jun 2020 13:14:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mdmf8hrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 13:14:25 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05CH433Z028513;
        Fri, 12 Jun 2020 13:14:25 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mdmf8hr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 13:14:25 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CH0k5F032402;
        Fri, 12 Jun 2020 17:14:24 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 31jqymc0q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 17:14:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CHELGP22675936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 17:14:21 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AED4B7805E;
        Fri, 12 Jun 2020 17:14:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BFDE78064;
        Fri, 12 Jun 2020 17:14:20 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.161.109])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jun 2020 17:14:20 +0000 (GMT)
Message-ID: <1591982059.7235.29.camel@linux.ibm.com>
Subject: Re: [PATCH] extend IMA boot_aggregate with kernel measurements
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Maurizio Drocco <maurizio.drocco@ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Fri, 12 Jun 2020 10:14:19 -0700
In-Reply-To: <380af929b2d2440a9dc35ba0b374247d@huawei.com>
References: <1591921795.11061.12.camel@linux.ibm.com>
         <20200612143812.1609-1-maurizio.drocco@ibm.com>
         <380af929b2d2440a9dc35ba0b374247d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-12 at 15:11 +0000, Roberto Sassu wrote:
> with recent patches, boot_aggregate can be calculated from non-SHA1
> PCR banks. I would replace with:
> 
> Extend cumulative digest over ...
> 
> Given that with this patch boot_aggregate is calculated differently,
> shouldn't we call it boot_aggregate_v2 and enable it with a new
> option?

So here's the problem: if your current grub doesn't do any TPM
extensions (as most don't), then the two boot aggregates are the same
because PCRs 8 and 9 are zero and there's a test that doesn't add them
to the aggregate if they are zero.  For these people its a nop so we
shouldn't force them to choose a different version of the same thing.

If, however, you're on a distribution where grub is automatically
measuring the kernel and command line into PCRs 8 and 9 (I think Fedora
32 does this), your boot aggregate will change.  It strikes me in that
case we can call this a bug fix, since the boot aggregate isn't
properly binding to the previous measurements without PCRs 8 and 9.  In
this case, do we want to allow people to select an option which doesn't
properly bind the IMA log to the boot measurements?  That sounds like a
security hole to me.

However, since it causes a user visible difference in the grub already
measures case, do you have a current use case that would be affected? 
As in are lots of people already running a distro with the TPM grub
updates and relying on the old boot aggregate?

James

